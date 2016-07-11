From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 11 Jul 2016 16:56:30 +0800
Subject: [PATCH v7 1/4] soc: mediatek: Refine scpsys to support multiple
 platform
In-Reply-To: <577E3AE9.5080202@gmail.com>
References: <1463390894-32062-1-git-send-email-jamesjj.liao@mediatek.com>
 <1463390894-32062-2-git-send-email-jamesjj.liao@mediatek.com>
 <6762e420-0d68-0376-b584-bfc878b5e95f@gmail.com>
 <1467783564.26485.22.camel@mtksdaap41> <577E3AE9.5080202@gmail.com>
Message-ID: <1468227390.31247.20.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Thu, 2016-07-07 at 13:20 +0200, Matthias Brugger wrote:
> 
> On 06/07/16 07:39, James Liao wrote:
> > Hi Matthias,
> >
> > On Sat, 2016-07-02 at 18:33 +0200, Matthias Brugger wrote:
> >>
> >> On 05/16/2016 11:28 AM, James Liao wrote:
> >>> Refine scpsys driver common code to support multiple SoC / platform.
> >>>
> >>> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> >>> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> >>> ---
> >>>   drivers/soc/mediatek/mtk-scpsys.c | 363 +++++++++++++++++++++++---------------
> >>>   1 file changed, 220 insertions(+), 143 deletions(-)
> >>>
> >>> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> >>> index 57e781c..5870a24 100644
> >>> --- a/drivers/soc/mediatek/mtk-scpsys.c
> >>> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> >>> @@ -11,17 +11,15 @@
> >>>    * GNU General Public License for more details.
> >>>    */
> >>>   #include <linux/clk.h>
> >>> -#include <linux/delay.h>
> >>> +#include <linux/init.h>
> >>>   #include <linux/io.h>
> >>> -#include <linux/kernel.h>
> >>>   #include <linux/mfd/syscon.h>
> >>> -#include <linux/init.h>
> >>>   #include <linux/of_device.h>
> >>>   #include <linux/platform_device.h>
> >>>   #include <linux/pm_domain.h>
> >>> -#include <linux/regmap.h>
> >>> -#include <linux/soc/mediatek/infracfg.h>
> >>>   #include <linux/regulator/consumer.h>
> >>> +#include <linux/soc/mediatek/infracfg.h>
> >>> +
> >>>   #include <dt-bindings/power/mt8173-power.h>
> >>>
> >>>   #define SPM_VDE_PWR_CON			0x0210
> >>> @@ -34,6 +32,7 @@
> >>>   #define SPM_MFG_2D_PWR_CON		0x02c0
> >>>   #define SPM_MFG_ASYNC_PWR_CON		0x02c4
> >>>   #define SPM_USB_PWR_CON			0x02cc
> >>> +
> >>>   #define SPM_PWR_STATUS			0x060c
> >>>   #define SPM_PWR_STATUS_2ND		0x0610
> >>>
> >>> @@ -55,12 +54,12 @@
> >>>   #define PWR_STATUS_USB			BIT(25)
> >>>
> >>>   enum clk_id {
> >>> -	MT8173_CLK_NONE,
> >>> -	MT8173_CLK_MM,
> >>> -	MT8173_CLK_MFG,
> >>> -	MT8173_CLK_VENC,
> >>> -	MT8173_CLK_VENC_LT,
> >>> -	MT8173_CLK_MAX,
> >>> +	CLK_NONE,
> >>> +	CLK_MM,
> >>> +	CLK_MFG,
> >>> +	CLK_VENC,
> >>> +	CLK_VENC_LT,
> >>> +	CLK_MAX,
> >>>   };
> >>>
> >>>   #define MAX_CLKS	2
> >>> @@ -76,98 +75,6 @@ struct scp_domain_data {
> >>>   	bool active_wakeup;
> >>>   };
> >>>
> >>> -static const struct scp_domain_data scp_domain_data[] = {
> >>> -	[MT8173_POWER_DOMAIN_VDEC] = {
> >>> -		.name = "vdec",
> >>> -		.sta_mask = PWR_STATUS_VDEC,
> >>> -		.ctl_offs = SPM_VDE_PWR_CON,
> >>> -		.sram_pdn_bits = GENMASK(11, 8),
> >>> -		.sram_pdn_ack_bits = GENMASK(12, 12),
> >>> -		.clk_id = {MT8173_CLK_MM},
> >>> -	},
> >>> -	[MT8173_POWER_DOMAIN_VENC] = {
> >>> -		.name = "venc",
> >>> -		.sta_mask = PWR_STATUS_VENC,
> >>> -		.ctl_offs = SPM_VEN_PWR_CON,
> >>> -		.sram_pdn_bits = GENMASK(11, 8),
> >>> -		.sram_pdn_ack_bits = GENMASK(15, 12),
> >>> -		.clk_id = {MT8173_CLK_MM, MT8173_CLK_VENC},
> >>> -	},
> >>> -	[MT8173_POWER_DOMAIN_ISP] = {
> >>> -		.name = "isp",
> >>> -		.sta_mask = PWR_STATUS_ISP,
> >>> -		.ctl_offs = SPM_ISP_PWR_CON,
> >>> -		.sram_pdn_bits = GENMASK(11, 8),
> >>> -		.sram_pdn_ack_bits = GENMASK(13, 12),
> >>> -		.clk_id = {MT8173_CLK_MM},
> >>> -	},
> >>> -	[MT8173_POWER_DOMAIN_MM] = {
> >>> -		.name = "mm",
> >>> -		.sta_mask = PWR_STATUS_DISP,
> >>> -		.ctl_offs = SPM_DIS_PWR_CON,
> >>> -		.sram_pdn_bits = GENMASK(11, 8),
> >>> -		.sram_pdn_ack_bits = GENMASK(12, 12),
> >>> -		.clk_id = {MT8173_CLK_MM},
> >>> -		.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
> >>> -			MT8173_TOP_AXI_PROT_EN_MM_M1,
> >>> -	},
> >>> -	[MT8173_POWER_DOMAIN_VENC_LT] = {
> >>> -		.name = "venc_lt",
> >>> -		.sta_mask = PWR_STATUS_VENC_LT,
> >>> -		.ctl_offs = SPM_VEN2_PWR_CON,
> >>> -		.sram_pdn_bits = GENMASK(11, 8),
> >>> -		.sram_pdn_ack_bits = GENMASK(15, 12),
> >>> -		.clk_id = {MT8173_CLK_MM, MT8173_CLK_VENC_LT},
> >>> -	},
> >>> -	[MT8173_POWER_DOMAIN_AUDIO] = {
> >>> -		.name = "audio",
> >>> -		.sta_mask = PWR_STATUS_AUDIO,
> >>> -		.ctl_offs = SPM_AUDIO_PWR_CON,
> >>> -		.sram_pdn_bits = GENMASK(11, 8),
> >>> -		.sram_pdn_ack_bits = GENMASK(15, 12),
> >>> -		.clk_id = {MT8173_CLK_NONE},
> >>> -	},
> >>> -	[MT8173_POWER_DOMAIN_USB] = {
> >>> -		.name = "usb",
> >>> -		.sta_mask = PWR_STATUS_USB,
> >>> -		.ctl_offs = SPM_USB_PWR_CON,
> >>> -		.sram_pdn_bits = GENMASK(11, 8),
> >>> -		.sram_pdn_ack_bits = GENMASK(15, 12),
> >>> -		.clk_id = {MT8173_CLK_NONE},
> >>> -		.active_wakeup = true,
> >>> -	},
> >>> -	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
> >>> -		.name = "mfg_async",
> >>> -		.sta_mask = PWR_STATUS_MFG_ASYNC,
> >>> -		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
> >>> -		.sram_pdn_bits = GENMASK(11, 8),
> >>> -		.sram_pdn_ack_bits = 0,
> >>> -		.clk_id = {MT8173_CLK_MFG},
> >>> -	},
> >>> -	[MT8173_POWER_DOMAIN_MFG_2D] = {
> >>> -		.name = "mfg_2d",
> >>> -		.sta_mask = PWR_STATUS_MFG_2D,
> >>> -		.ctl_offs = SPM_MFG_2D_PWR_CON,
> >>> -		.sram_pdn_bits = GENMASK(11, 8),
> >>> -		.sram_pdn_ack_bits = GENMASK(13, 12),
> >>> -		.clk_id = {MT8173_CLK_NONE},
> >>> -	},
> >>> -	[MT8173_POWER_DOMAIN_MFG] = {
> >>> -		.name = "mfg",
> >>> -		.sta_mask = PWR_STATUS_MFG,
> >>> -		.ctl_offs = SPM_MFG_PWR_CON,
> >>> -		.sram_pdn_bits = GENMASK(13, 8),
> >>> -		.sram_pdn_ack_bits = GENMASK(21, 16),
> >>> -		.clk_id = {MT8173_CLK_NONE},
> >>> -		.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
> >>> -			MT8173_TOP_AXI_PROT_EN_MFG_M0 |
> >>> -			MT8173_TOP_AXI_PROT_EN_MFG_M1 |
> >>> -			MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
> >>> -	},
> >>> -};
> >>> -
> >>> -#define NUM_DOMAINS	ARRAY_SIZE(scp_domain_data)
> >>> -
> >>>   struct scp;
> >>>
> >>>   struct scp_domain {
> >>> @@ -179,7 +86,7 @@ struct scp_domain {
> >>>   };
> >>>
> >>>   struct scp {
> >>> -	struct scp_domain domains[NUM_DOMAINS];
> >>> +	struct scp_domain *domains;
> >>>   	struct genpd_onecell_data pd_data;
> >>>   	struct device *dev;
> >>>   	void __iomem *base;
> >>> @@ -408,57 +315,69 @@ static bool scpsys_active_wakeup(struct device *dev)
> >>>   	return scpd->data->active_wakeup;
> >>>   }
> >>>
> >>> -static int scpsys_probe(struct platform_device *pdev)
> >>> +static void init_clks(struct platform_device *pdev, struct clk *clk[CLK_MAX])
> >>> +{
> >>> +	enum clk_id clk_ids[] = {
> >>> +		CLK_MM,
> >>> +		CLK_MFG,
> >>> +		CLK_VENC,
> >>> +		CLK_VENC_LT
> >>> +	};
> >>> +
> >>> +	static const char * const clk_names[] = {
> >>> +		"mm",
> >>> +		"mfg",
> >>> +		"venc",
> >>> +		"venc_lt",
> >>> +	};
> >>> +
> >>> +	int i;
> >>> +
> >>> +	for (i = 0; i < ARRAY_SIZE(clk_ids); i++)
> >>> +		clk[clk_ids[i]] = devm_clk_get(&pdev->dev, clk_names[i]);
> >>
> >> We can use the global enum clk_id and stat with i = 1, right?
> >
> > You are right. I'll change the start value with i = CLK_NONE + 1 in next
> > patch.
> >
> >>> +}
> >>> +
> >>> +static struct scp *init_scp(struct platform_device *pdev,
> >>> +			const struct scp_domain_data *scp_domain_data, int num)
> >>>   {
> >>>   	struct genpd_onecell_data *pd_data;
> >>>   	struct resource *res;
> >>> -	int i, j, ret;
> >>> +	int i, j;
> >>>   	struct scp *scp;
> >>> -	struct clk *clk[MT8173_CLK_MAX];
> >>> +	struct clk *clk[CLK_MAX];
> >>>
> >>>   	scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
> >>>   	if (!scp)
> >>> -		return -ENOMEM;
> >>> +		return ERR_PTR(-ENOMEM);
> >>>
> >>>   	scp->dev = &pdev->dev;
> >>>
> >>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>   	scp->base = devm_ioremap_resource(&pdev->dev, res);
> >>>   	if (IS_ERR(scp->base))
> >>> -		return PTR_ERR(scp->base);
> >>> -
> >>> -	pd_data = &scp->pd_data;
> >>> -
> >>> -	pd_data->domains = devm_kzalloc(&pdev->dev,
> >>> -			sizeof(*pd_data->domains) * NUM_DOMAINS, GFP_KERNEL);
> >>> -	if (!pd_data->domains)
> >>> -		return -ENOMEM;
> >>> -
> >>> -	clk[MT8173_CLK_MM] = devm_clk_get(&pdev->dev, "mm");
> >>> -	if (IS_ERR(clk[MT8173_CLK_MM]))
> >>> -		return PTR_ERR(clk[MT8173_CLK_MM]);
> >>> -
> >>> -	clk[MT8173_CLK_MFG] = devm_clk_get(&pdev->dev, "mfg");
> >>> -	if (IS_ERR(clk[MT8173_CLK_MFG]))
> >>> -		return PTR_ERR(clk[MT8173_CLK_MFG]);
> >>> -
> >>> -	clk[MT8173_CLK_VENC] = devm_clk_get(&pdev->dev, "venc");
> >>> -	if (IS_ERR(clk[MT8173_CLK_VENC]))
> >>> -		return PTR_ERR(clk[MT8173_CLK_VENC]);
> >>> -
> >>> -	clk[MT8173_CLK_VENC_LT] = devm_clk_get(&pdev->dev, "venc_lt");
> >>> -	if (IS_ERR(clk[MT8173_CLK_VENC_LT]))
> >>> -		return PTR_ERR(clk[MT8173_CLK_VENC_LT]);
> >>> +		return ERR_CAST(scp->base);
> >>>
> >>>   	scp->infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> >>>   			"infracfg");
> >>>   	if (IS_ERR(scp->infracfg)) {
> >>>   		dev_err(&pdev->dev, "Cannot find infracfg controller: %ld\n",
> >>>   				PTR_ERR(scp->infracfg));
> >>> -		return PTR_ERR(scp->infracfg);
> >>> +		return ERR_CAST(scp->infracfg);
> >>>   	}
> >>>
> >>> -	for (i = 0; i < NUM_DOMAINS; i++) {
> >>> +	scp->domains = devm_kzalloc(&pdev->dev,
> >>> +				sizeof(*scp->domains) * num, GFP_KERNEL);
> >>> +	if (!scp->domains)
> >>> +		return ERR_PTR(-ENOMEM);
> >>> +
> >>> +	pd_data = &scp->pd_data;
> >>> +
> >>> +	pd_data->domains = devm_kzalloc(&pdev->dev,
> >>> +			sizeof(*pd_data->domains) * num, GFP_KERNEL);
> >>> +	if (!pd_data->domains)
> >>> +		return ERR_PTR(-ENOMEM);
> >>> +
> >>> +	for (i = 0; i < num; i++) {
> >>>   		struct scp_domain *scpd = &scp->domains[i];
> >>>   		const struct scp_domain_data *data = &scp_domain_data[i];
> >>>
> >>> @@ -467,28 +386,54 @@ static int scpsys_probe(struct platform_device *pdev)
> >>>   			if (PTR_ERR(scpd->supply) == -ENODEV)
> >>>   				scpd->supply = NULL;
> >>>   			else
> >>> -				return PTR_ERR(scpd->supply);
> >>> +				return ERR_CAST(scpd->supply);
> >>>   		}
> >>>   	}
> >>>
> >>> -	pd_data->num_domains = NUM_DOMAINS;
> >>> +	pd_data->num_domains = num;
> >>>
> >>> -	for (i = 0; i < NUM_DOMAINS; i++) {
> >>> +	init_clks(pdev, clk);
> >>> +
> >>> +	for (i = 0; i < num; i++) {
> >>>   		struct scp_domain *scpd = &scp->domains[i];
> >>>   		struct generic_pm_domain *genpd = &scpd->genpd;
> >>>   		const struct scp_domain_data *data = &scp_domain_data[i];
> >>>
> >>> +		for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> >>> +			struct clk *c = clk[data->clk_id[j]];
> >>> +
> >>> +			if (IS_ERR(c)) {
> >>> +				dev_err(&pdev->dev, "%s: clk unavailable\n",
> >>> +					data->name);
> >>> +				return ERR_CAST(c);
> >>> +			}
> >>> +
> >>> +			scpd->clk[j] = c;
> >>
> >> Put this in the else branch. Apart from that is there any reason you
> >
> > Do you mean to change like this?
> >
> > 	if (IS_ERR(c)) {
> > 		...
> > 		return ERR_CAST(c);
> > 	} else {
> > 		scpd->clk[j] = c;
> > 	}
> >
> > checkpatch.pl will warn for above code due to it returns in 'if' branch.
> >
> 
> I tried that on top of next-20160706 and it checkpatch didn't throw any 
> warning. Which kernel version are based on?

I don't remember which version of checkpatch warn on this pattern. This
patch series develop across several kernel versions.

So do you prefer to put "scpd->clk[j] = c;" into 'else' branch?

> >> moved the for up in the function? If not, I would prefer not to move it,
> >> to make it easier to read the diff.
> >
> > The new 'for' block are far different from original one. And I think
> > it's easy to read if we keep simple assign statements in the same block.
> >
> 
> It's different in the sense that it checks if struct clk *c is an error.
> I don't see the reason why we need to move it up in the file.
> It's not too important but I would prefer not to move it if there is no 
> reason.

I think I may misunderstand your comments. Which 'for' block did you
mention for? 'for (i = 0; i < num ...' or 'for (j = 0; j < MAX_CLKS
&& ...' ?

The 'for(i)' exists in original code, this patch just change its counter
from 'NUM_DOMAINS' to 'num'. The 'for(j)' is a new for-block, so it was
not moved from other blocks.


Best regards,

James
