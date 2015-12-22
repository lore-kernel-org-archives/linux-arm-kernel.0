From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 22 Dec 2015 21:31:51 +0800
Subject: [PATCH] soc: mediatek: SCPSYS: use builtin_platform_driver
In-Reply-To: <1450437573-32079-1-git-send-email-matthias.bgg@gmail.com>
References: <1450437573-32079-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <CAGS+omA822+-srskZ08pa72xVTMFbWLkaZD0za=3MCBryS6PRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

This actually ended up in my Spam folder.
Not sure if anybody else saw this either...

On Fri, Dec 18, 2015 at 7:19 PM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> SCPSYS can't be built as module. Use builtin_platform_driver instead.
> For this probe must not be __init and the data accessed can't be
> __initconst. Remove this macros. To make the impact as small as possible,
> fold scp_domain_data into scp_domain via a pointer.
>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Take your pick:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Tested-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 48 ++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 0221387..049ccd0 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -76,7 +76,7 @@ struct scp_domain_data {
>         bool active_wakeup;
>  };
>
> -static const struct scp_domain_data scp_domain_data[] __initconst = {
> +static const struct scp_domain_data scp_domain_data[] = {
>         [MT8173_POWER_DOMAIN_VDEC] = {
>                 .name = "vdec",
>                 .sta_mask = PWR_STATUS_VDEC,
> @@ -174,12 +174,7 @@ struct scp_domain {
>         struct generic_pm_domain genpd;
>         struct scp *scp;
>         struct clk *clk[MAX_CLKS];
> -       u32 sta_mask;
> -       void __iomem *ctl_addr;
> -       u32 sram_pdn_bits;
> -       u32 sram_pdn_ack_bits;
> -       u32 bus_prot_mask;
> -       bool active_wakeup;
> +       const struct scp_domain_data *data;
>         struct regulator *supply;
>  };
>
> @@ -195,8 +190,9 @@ static int scpsys_domain_is_on(struct scp_domain *scpd)
>  {
>         struct scp *scp = scpd->scp;
>
> -       u32 status = readl(scp->base + SPM_PWR_STATUS) & scpd->sta_mask;
> -       u32 status2 = readl(scp->base + SPM_PWR_STATUS_2ND) & scpd->sta_mask;
> +       u32 status = readl(scp->base + SPM_PWR_STATUS) & scpd->data->sta_mask;
> +       u32 status2 = readl(scp->base + SPM_PWR_STATUS_2ND) &
> +                               scpd->data->sta_mask;
>
>         /*
>          * A domain is on when both status bits are set. If only one is set
> @@ -217,8 +213,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         struct scp *scp = scpd->scp;
>         unsigned long timeout;
>         bool expired;
> -       void __iomem *ctl_addr = scpd->ctl_addr;
> -       u32 sram_pdn_ack = scpd->sram_pdn_ack_bits;
> +       void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> +       u32 sram_pdn_ack = scpd->data->sram_pdn_ack_bits;
>         u32 val;
>         int ret;
>         int i;
> @@ -273,7 +269,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         val |= PWR_RST_B_BIT;
>         writel(val, ctl_addr);
>
> -       val &= ~scpd->sram_pdn_bits;
> +       val &= ~scpd->data->sram_pdn_bits;
>         writel(val, ctl_addr);
>
>         /* wait until SRAM_PDN_ACK all 0 */
> @@ -292,9 +288,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>                         expired = true;
>         }
>
> -       if (scpd->bus_prot_mask) {
> +       if (scpd->data->bus_prot_mask) {
>                 ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> -                               scpd->bus_prot_mask);
> +                               scpd->data->bus_prot_mask);
>                 if (ret)
>                         goto err_pwr_ack;
>         }
> @@ -321,21 +317,21 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         struct scp *scp = scpd->scp;
>         unsigned long timeout;
>         bool expired;
> -       void __iomem *ctl_addr = scpd->ctl_addr;
> -       u32 pdn_ack = scpd->sram_pdn_ack_bits;
> +       void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> +       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>         u32 val;
>         int ret;
>         int i;
>
> -       if (scpd->bus_prot_mask) {
> +       if (scpd->data->bus_prot_mask) {
>                 ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> -                               scpd->bus_prot_mask);
> +                               scpd->data->bus_prot_mask);
>                 if (ret)
>                         goto out;
>         }
>
>         val = readl(ctl_addr);
> -       val |= scpd->sram_pdn_bits;
> +       val |= scpd->data->sram_pdn_bits;
>         writel(val, ctl_addr);
>
>         /* wait until SRAM_PDN_ACK all 1 */
> @@ -409,10 +405,10 @@ static bool scpsys_active_wakeup(struct device *dev)
>         genpd = pd_to_genpd(dev->pm_domain);
>         scpd = container_of(genpd, struct scp_domain, genpd);
>
> -       return scpd->active_wakeup;
> +       return scpd->data->active_wakeup;
>  }
>
> -static int __init scpsys_probe(struct platform_device *pdev)
> +static int scpsys_probe(struct platform_device *pdev)
>  {
>         struct genpd_onecell_data *pd_data;
>         struct resource *res;
> @@ -485,12 +481,7 @@ static int __init scpsys_probe(struct platform_device *pdev)
>                 pd_data->domains[i] = genpd;
>                 scpd->scp = scp;
>
> -               scpd->sta_mask = data->sta_mask;
> -               scpd->ctl_addr = scp->base + data->ctl_offs;
> -               scpd->sram_pdn_bits = data->sram_pdn_bits;
> -               scpd->sram_pdn_ack_bits = data->sram_pdn_ack_bits;
> -               scpd->bus_prot_mask = data->bus_prot_mask;
> -               scpd->active_wakeup = data->active_wakeup;
> +               scpd->data = data;
>                 for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++)
>                         scpd->clk[j] = clk[data->clk_id[j]];
>
> @@ -542,10 +533,11 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
>  };
>
>  static struct platform_driver scpsys_drv = {
> +       .probe = scpsys_probe,
>         .driver = {
>                 .name = "mtk-scpsys",
>                 .owner = THIS_MODULE,
>                 .of_match_table = of_match_ptr(of_scpsys_match_tbl),
>         },
>  };
> -builtin_platform_driver_probe(scpsys_drv, scpsys_probe);
> +builtin_platform_driver(scpsys_drv);
> --
> 2.6.2
>
