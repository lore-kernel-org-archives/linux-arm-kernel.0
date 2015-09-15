From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 14 Sep 2015 18:28:49 -0700
Subject: [PATCH] spmi-pmic-arb: support configurable number of peripherals
In-Reply-To: <1442267672-11287-1-git-send-email-sboyd@codeaurora.org>
References: <1442267672-11287-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <55F77451.9070900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2015 02:54 PM, Stephen Boyd wrote:
> The current driver implementation supports only 128 peripherals.
> Add support for more than 128 peripherals by taking a lazy
> caching approach to the mapping tables. Instead of reading the
> tables at boot given some fixed size, read them on an as needed
> basis and cache the results. We still assume a max number of 512
> peripherals, trading off some space for simplicity.
>
> Based on a patch by Gilad Avidov <gavidov@codeaurora.org> and
> Sagar Dharia <sdharia@codeaurora.org>.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Hi Ivan,

This patch causes 8916 to crash, because there isn't a mapping for ppid
257 in the ppid to channel table. It seems that we're reading the revid
from the slave id 1 pmic by going through channel 0, which seems to be
setup for ppid 9 (slave id 0 and the peripheral starting at 0x900). Can
we stop reading the revid registers from non-zero slave id pmic devices?
That would be one solution to fix this problem. Or maybe we need to
special case this in the pmic arbiter code to fold ppid 0xN01 (slave id
N and address 0x100) onto channel 0 all the time?

-Stephen

> This replaces a previous patch from Gilad and Sagar. I've 
> added some commit text and made it into a proper patch.
>
>  drivers/spmi/spmi-pmic-arb.c | 101 +++++++++++++++++++++++++++++--------------
>  1 file changed, 68 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index c7aa6f1a898e..0cd86d96bb7d 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -10,6 +10,7 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   */
> +#include <linux/bitmap.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> @@ -47,9 +48,9 @@
>  #define SPMI_MAPPING_BIT_IS_1_FLAG(X)	(((X) >> 8) & 0x1)
>  #define SPMI_MAPPING_BIT_IS_1_RESULT(X)	(((X) >> 0) & 0xFF)
>  
> -#define SPMI_MAPPING_TABLE_LEN		255
>  #define SPMI_MAPPING_TABLE_TREE_DEPTH	16	/* Maximum of 16-bits */
> -#define PPID_TO_CHAN_TABLE_SZ		BIT(12)	/* PPID is 12bit chan is 1byte*/
> +#define PMIC_ARB_MAX_PPID		BIT(12) /* PPID is 12bit */
> +#define PMIC_ARB_CHAN_VALID		BIT(15)
>  
>  /* Ownership Table */
>  #define SPMI_OWNERSHIP_TABLE_REG(N)	(0x0700 + (4 * (N)))
> @@ -85,9 +86,7 @@ enum pmic_arb_cmd_op_code {
>  };
>  
>  /* Maximum number of support PMIC peripherals */
> -#define PMIC_ARB_MAX_PERIPHS		256
> -#define PMIC_ARB_MAX_CHNL		128
> -#define PMIC_ARB_PERIPH_ID_VALID	(1 << 15)
> +#define PMIC_ARB_MAX_PERIPHS		512
>  #define PMIC_ARB_TIMEOUT_US		100
>  #define PMIC_ARB_MAX_TRANS_BYTES	(8)
>  
> @@ -125,18 +124,21 @@ struct spmi_pmic_arb_dev {
>  	void __iomem		*wr_base;
>  	void __iomem		*intr;
>  	void __iomem		*cnfg;
> +	void __iomem		*core;
>  	raw_spinlock_t		lock;
>  	u8			channel;
>  	int			irq;
>  	u8			ee;
> -	u8			min_apid;
> -	u8			max_apid;
> -	u32			mapping_table[SPMI_MAPPING_TABLE_LEN];
> +	u16			min_apid;
> +	u16			max_apid;
> +	u32			*mapping_table;
> +	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
>  	struct irq_domain	*domain;
>  	struct spmi_controller	*spmic;
> -	u16			apid_to_ppid[256];
> +	u16			*apid_to_ppid;
>  	const struct pmic_arb_ver_ops *ver_ops;
> -	u8			*ppid_to_chan;
> +	u16			*ppid_to_chan;
> +	u16			last_channel;
>  };
>  
>  /**
> @@ -614,6 +616,10 @@ static int search_mapping_table(struct spmi_pmic_arb_dev *pa,
>  	u32 data;
>  
>  	for (i = 0; i < SPMI_MAPPING_TABLE_TREE_DEPTH; ++i) {
> +		if (!test_and_set_bit(index, pa->mapping_table_valid))
> +			mapping_table[index] = readl_relaxed(pa->cnfg +
> +						SPMI_MAPPING_TABLE_REG(index));
> +
>  		data = mapping_table[index];
>  
>  		if (ppid & (1 << SPMI_MAPPING_BIT_INDEX(data))) {
> @@ -706,11 +712,42 @@ static u32 pmic_arb_offset_v1(struct spmi_pmic_arb_dev *pa, u8 sid, u16 addr)
>  	return 0x800 + 0x80 * pa->channel;
>  }
>  
> +static u16 pmic_arb_find_chan(struct spmi_pmic_arb_dev *pa, u16 ppid)
> +{
> +	u32 regval;
> +	u16 chan;
> +	u16 id;
> +
> +	/*
> +	 * PMIC_ARB_REG_CHNL is a table in HW mapping channel to ppid.
> +	 * ppid_to_chan is an in-memory invert of that table.
> +	 */
> +	for (chan = pa->last_channel; ; chan++) {
> +		regval = readl_relaxed(pa->core + PMIC_ARB_REG_CHNL(chan));
> +		if (!regval)
> +			continue;
> +
> +		id = (regval >> 8) & PMIC_ARB_PPID_MASK;
> +		pa->ppid_to_chan[id] = chan | PMIC_ARB_CHAN_VALID;
> +		if (id == ppid)
> +			break;
> +	}
> +	pa->last_channel = chan;
> +
> +	return chan;
> +}
> +
> +
>  /* v2 offset per ppid (chan) and per ee */
>  static u32 pmic_arb_offset_v2(struct spmi_pmic_arb_dev *pa, u8 sid, u16 addr)
>  {
>  	u16 ppid = (sid << 8) | (addr >> 8);
> -	u8  chan = pa->ppid_to_chan[ppid];
> +	u16 chan;
> +
> +	chan = pa->ppid_to_chan[ppid];
> +	if (!(chan & PMIC_ARB_CHAN_VALID))
> +		chan = pmic_arb_find_chan(pa, ppid);
> +	chan &= ~PMIC_ARB_CHAN_VALID;
>  
>  	return 0x1000 * pa->ee + 0x8000 * chan;
>  }
> @@ -797,7 +834,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	void __iomem *core;
>  	u32 channel, ee, hw_ver;
> -	int err, i;
> +	int err;
>  	bool is_v1;
>  
>  	ctrl = spmi_controller_alloc(&pdev->dev, sizeof(*pa));
> @@ -825,10 +862,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>  		pa->wr_base = core;
>  		pa->rd_base = core;
>  	} else {
> -		u8  chan;
> -		u16 ppid;
> -		u32 regval;
> -
> +		pa->core = core;
>  		pa->ver_ops = &pmic_arb_v2;
>  
>  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> @@ -847,24 +881,14 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>  			goto err_put_ctrl;
>  		}
>  
> -		pa->ppid_to_chan = devm_kzalloc(&ctrl->dev,
> -					PPID_TO_CHAN_TABLE_SZ, GFP_KERNEL);
> +		pa->ppid_to_chan = devm_kcalloc(&ctrl->dev,
> +						PMIC_ARB_MAX_PPID,
> +						sizeof(*pa->ppid_to_chan),
> +						GFP_KERNEL);
>  		if (!pa->ppid_to_chan) {
>  			err = -ENOMEM;
>  			goto err_put_ctrl;
>  		}
> -		/*
> -		 * PMIC_ARB_REG_CHNL is a table in HW mapping channel to ppid.
> -		 * ppid_to_chan is an in-memory invert of that table.
> -		 */
> -		for (chan = 0; chan < PMIC_ARB_MAX_CHNL; ++chan) {
> -			regval = readl_relaxed(core + PMIC_ARB_REG_CHNL(chan));
> -			if (!regval)
> -				continue;
> -
> -			ppid = (regval >> 8) & 0xFFF;
> -			pa->ppid_to_chan[ppid] = chan;
> -		}
>  	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr");
> @@ -915,9 +939,20 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>  
>  	pa->ee = ee;
>  
> -	for (i = 0; i < ARRAY_SIZE(pa->mapping_table); ++i)
> -		pa->mapping_table[i] = readl_relaxed(
> -				pa->cnfg + SPMI_MAPPING_TABLE_REG(i));
> +	pa->apid_to_ppid = devm_kcalloc(&ctrl->dev, PMIC_ARB_MAX_PERIPHS,
> +					    sizeof(*pa->apid_to_ppid),
> +					    GFP_KERNEL);
> +	if (!pa->apid_to_ppid) {
> +		err = -ENOMEM;
> +		goto err_put_ctrl;
> +	}
> +
> +	pa->mapping_table = devm_kcalloc(&ctrl->dev, PMIC_ARB_MAX_PERIPHS - 1,
> +					sizeof(*pa->mapping_table), GFP_KERNEL);
> +	if (!pa->mapping_table) {
> +		err = -ENOMEM;
> +		goto err_put_ctrl;
> +	}
>  
>  	/* Initialize max_apid/min_apid to the opposite bounds, during
>  	 * the irq domain translation, we are sure to update these */


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
