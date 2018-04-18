From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 18 Apr 2018 17:06:52 +0200
Subject: [PATCH v1 3/7] soc: mediatek: reuse read[l,x]_poll_timeout helpers
In-Reply-To: <2c0d233c658fa6093a18a54e82a3e51340251bc9.1522736996.git.sean.wang@mediatek.com>
References: <cover.1522736996.git.sean.wang@mediatek.com>
 <2c0d233c658fa6093a18a54e82a3e51340251bc9.1522736996.git.sean.wang@mediatek.com>
Message-ID: <549e6adc-73c1-aa03-93dc-578138729750@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/03/2018 09:15 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Reuse the common helpers read[l,x]_poll_timeout provided by Linux core
> instead of an open-coded handling. The name of the local variable
> sram_pdn_ack in scpsys_power_on is renamed to pdn_ack in order to be
> consistent with the one used in scpsys_power_off.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

pushed to v4.17-next/soc

Thanks!

>  drivers/soc/mediatek/mtk-scpsys.c | 91 ++++++++++-----------------------------
>  1 file changed, 23 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index d762a46..f9b7248 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -13,6 +13,7 @@
>  #include <linux/clk.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -27,6 +28,9 @@
>  #include <dt-bindings/power/mt7623a-power.h>
>  #include <dt-bindings/power/mt8173-power.h>
>  
> +#define MTK_POLL_DELAY_US   10
> +#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> +
>  #define SPM_VDE_PWR_CON			0x0210
>  #define SPM_MFG_PWR_CON			0x0214
>  #define SPM_VEN_PWR_CON			0x0230
> @@ -184,12 +188,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  {
>  	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
>  	struct scp *scp = scpd->scp;
> -	unsigned long timeout;
> -	bool expired;
>  	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> -	u32 sram_pdn_ack = scpd->data->sram_pdn_ack_bits;
> +	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>  	u32 val;
> -	int ret;
> +	int ret, tmp;
>  	int i;
>  
>  	if (scpd->supply) {
> @@ -215,23 +217,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  	writel(val, ctl_addr);
>  
>  	/* wait until PWR_ACK = 1 */
> -	timeout = jiffies + HZ;
> -	expired = false;
> -	while (1) {
> -		ret = scpsys_domain_is_on(scpd);
> -		if (ret > 0)
> -			break;
> -
> -		if (expired) {
> -			ret = -ETIMEDOUT;
> -			goto err_pwr_ack;
> -		}
> -
> -		cpu_relax();
> -
> -		if (time_after(jiffies, timeout))
> -			expired = true;
> -	}
> +	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp > 0,
> +				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		goto err_pwr_ack;
>  
>  	val &= ~PWR_CLK_DIS_BIT;
>  	writel(val, ctl_addr);
> @@ -246,20 +235,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  	writel(val, ctl_addr);
>  
>  	/* wait until SRAM_PDN_ACK all 0 */
> -	timeout = jiffies + HZ;
> -	expired = false;
> -	while (sram_pdn_ack && (readl(ctl_addr) & sram_pdn_ack)) {
> -
> -		if (expired) {
> -			ret = -ETIMEDOUT;
> -			goto err_pwr_ack;
> -		}
> -
> -		cpu_relax();
> -
> -		if (time_after(jiffies, timeout))
> -			expired = true;
> -	}
> +	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> +				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		goto err_pwr_ack;
>  
>  	if (scpd->data->bus_prot_mask) {
>  		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> @@ -289,12 +268,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  {
>  	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
>  	struct scp *scp = scpd->scp;
> -	unsigned long timeout;
> -	bool expired;
>  	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
>  	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>  	u32 val;
> -	int ret;
> +	int ret, tmp;
>  	int i;
>  
>  	if (scpd->data->bus_prot_mask) {
> @@ -310,19 +287,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  	writel(val, ctl_addr);
>  
>  	/* wait until SRAM_PDN_ACK all 1 */
> -	timeout = jiffies + HZ;
> -	expired = false;
> -	while (pdn_ack && (readl(ctl_addr) & pdn_ack) != pdn_ack) {
> -		if (expired) {
> -			ret = -ETIMEDOUT;
> -			goto out;
> -		}
> -
> -		cpu_relax();
> -
> -		if (time_after(jiffies, timeout))
> -			expired = true;
> -	}
> +	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack,
> +				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		goto out;
>  
>  	val |= PWR_ISO_BIT;
>  	writel(val, ctl_addr);
> @@ -340,23 +308,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  	writel(val, ctl_addr);
>  
>  	/* wait until PWR_ACK = 0 */
> -	timeout = jiffies + HZ;
> -	expired = false;
> -	while (1) {
> -		ret = scpsys_domain_is_on(scpd);
> -		if (ret == 0)
> -			break;
> -
> -		if (expired) {
> -			ret = -ETIMEDOUT;
> -			goto out;
> -		}
> -
> -		cpu_relax();
> -
> -		if (time_after(jiffies, timeout))
> -			expired = true;
> -	}
> +	ret = readx_poll_timeout(scpsys_domain_is_on, scpd, tmp, tmp == 0,
> +				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +	if (ret < 0)
> +		goto out;
>  
>  	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
>  		clk_disable_unprepare(scpd->clk[i]);
> 
