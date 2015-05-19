From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 May 2015 12:30:10 +0200
Subject: [PATCH 3/5] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <CAGS+omDJ-7+L_46vwMyewHMkMNj69odhp=JY5i6Xj3-Loe6UNA@mail.gmail.com>
References: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
 <1431372206-1237-4-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omDJ-7+L_46vwMyewHMkMNj69odhp=JY5i6Xj3-Loe6UNA@mail.gmail.com>
Message-ID: <20150519103010.GA6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 10:17:21PM +0800, Daniel Kurtz wrote:
> On Tue, May 12, 2015 at 3:23 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > This adds a power domain driver for the Mediatek SCPSYS unit.
> >
> > The System Control Processor System (SCPSYS) has several power
> > management related tasks in the system. The tasks include thermal
> > measurement, dynamic voltage frequency scaling (DVFS), interrupt
> > filter and lowlevel sleep control. The System Power Manager (SPM)
> > inside the SCPSYS is for the MTCMOS power domain control.
> >
> > For now this driver only adds power domain support, the more
> > advanced features are not yet supported. The driver implements
> > the generic PM domain device tree bindings, the first user will
> > most likely be the Mediatek AFE audio driver.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  .../devicetree/bindings/soc/mediatek/scpsys.txt    |   2 +
> >  drivers/soc/mediatek/Kconfig                       |   8 +
> >  drivers/soc/mediatek/Makefile                      |   1 +
> >  drivers/soc/mediatek/mtk-scpsys.c                  | 416 +++++++++++++++++++++
> >  include/dt-bindings/power/mt8173-power.h           |  15 +
> >  5 files changed, 442 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
> >  create mode 100644 include/dt-bindings/power/mt8173-power.h
> >
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> > index 4764a03..87f2091 100644
> > --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> > @@ -15,6 +15,7 @@ Required properties:
> >  - compatible: Must be "mediatek,mt8173-scpsys"
> >  - #power-domain-cells: Must be 1
> >  - reg: Address range of the SCPSYS unit
> > +- infracfg: must contain a phandle to the infracfg controller
> >
> >  Example:
> >
> > @@ -22,6 +23,7 @@ Example:
> >                 #power-domain-cells = <1>;
> >                 compatible = "mediatek,mt8173-scpsys";
> >                 reg = <0 0x10006000 0 0x1000>;
> > +               infracfg = <&infracfg>;
> >         };
> >
> >  Example consumer:
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index 6fae66f..1386c79 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -18,3 +18,11 @@ config MTK_INFRACFG
> >           Say yes here to add support for the MediaTek INFRACFG controller. The
> >           INFRACFG controller contains various infrastructure registers not
> >           directly associated to any device.
> > +
> > +config MTK_SCPSYS
> > +       tristate "MediaTek SCPSYS Support"
> > +       depends on MTK_INFRACFG
> 
> Should this be:
>   depends on ARCH_MEDIATEK || COMPILE_TEST
>   selects MTK_INFRACFG
> 
> > +       select REGMAP
> > +       help
> > +         Say yes here to add support for the MediaTek SCPSYS power domain
> > +         driver.
> > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > index ce39119..f8eebab 100644
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> > @@ -1,2 +1,3 @@
> >  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> >  obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> > +obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > new file mode 100644
> > index 0000000..c42c7f1
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -0,0 +1,416 @@
> > +/*
> > + * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/delay.h>
> > +#include <linux/soc/mediatek/infracfg.h>
> > +#include <dt-bindings/power/mt8173-power.h>
> > +#include <linux/mfd/syscon.h>
> > +
> > +#define SPM_VDE_PWR_CON                        0x0210
> > +#define SPM_MFG_PWR_CON                        0x0214
> > +#define SPM_VEN_PWR_CON                        0x0230
> > +#define SPM_ISP_PWR_CON                        0x0238
> > +#define SPM_DIS_PWR_CON                        0x023c
> > +#define SPM_VEN2_PWR_CON               0x0298
> > +#define SPM_AUDIO_PWR_CON              0x029c
> > +#define SPM_MFG_2D_PWR_CON             0x02c0
> > +#define SPM_MFG_ASYNC_PWR_CON          0x02c4
> > +#define SPM_USB_PWR_CON                        0x02cc
> > +#define SPM_PWR_STATUS                 0x060c
> > +#define SPM_PWR_STATUS_2ND             0x0610
> > +
> > +#define PWR_RST_B_BIT                  BIT(0)
> > +#define PWR_ISO_BIT                    BIT(1)
> > +#define PWR_ON_BIT                     BIT(2)
> > +#define PWR_ON_2ND_BIT                 BIT(3)
> > +#define PWR_CLK_DIS_BIT                        BIT(4)
> > +
> > +#define DIS_PWR_STA_MASK               BIT(3)
> > +#define MFG_PWR_STA_MASK               BIT(4)
> > +#define ISP_PWR_STA_MASK               BIT(5)
> > +#define VDE_PWR_STA_MASK               BIT(7)
> > +#define VEN2_PWR_STA_MASK              BIT(20)
> > +#define VEN_PWR_STA_MASK               BIT(21)
> > +#define MFG_2D_PWR_STA_MASK            BIT(22)
> > +#define MFG_ASYNC_PWR_STA_MASK         BIT(23)
> > +#define AUDIO_PWR_STA_MASK             BIT(24)
> > +#define USB_PWR_STA_MASK               BIT(25)
> > +
> > +struct scp_domain_data {
> > +       const char *name;
> > +       u32 sta_mask;
> > +       int ctl_offs;
> > +       u32 sram_pdn_bits;
> > +       u32 sram_pdn_ack_bits;
> > +       u32 bus_prot_mask;
> > +       int id;
> > +       const char *clk_name;
> > +};
> 
> These fields are only used at init time:
>  name (the pointer, the actual string is pointed to by genpd->name)
>  id
>  clk_name
> 
> You could split those off into a separate __initconst struct.

Is this really worth it?

> 
> > +
> > +static const struct scp_domain_data scp_domain_data[] = {
> > +       {
> > +               .id = MT8173_POWER_DOMAIN_VDE,
> > +               .name = "vde",
> > +               .sta_mask = VDE_PWR_STA_MASK,
> > +               .ctl_offs = SPM_VDE_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +               .clk_name = "vdec",
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_VEN,
> 
> Is there any reason you do not keep these in ".id" order:
> VDE,  MFG, VEN, ISP, DIS, VEN2, AUDIO, MFG_2D, MFG_ASYNC, USB

The reason is simply that with CONFIG_PM disabled we have to turn on the
domains in the correct order, otherwise the system hangs. I can renumber
the defines though if you like.

> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_ISP,
> > +               .name = "isp",
> > +               .sta_mask = ISP_PWR_STA_MASK,
> > +               .ctl_offs = SPM_ISP_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(13, 12),
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_DIS,
> > +               .name = "disp",
> 
> Perhaps .id/.name/.clk should be "MM" to match the corresponding clock
> define (CLK_TOP_MM_SEL) & prot bits.


> 
> > +               .sta_mask = DIS_PWR_STA_MASK,
> > +               .ctl_offs = SPM_DIS_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +               .clk_name = "disp",
> > +               .bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
> > +                       MT8173_TOP_AXI_PROT_EN_MM_M1,
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_VEN2,
> > +               .name = "ven2",
> 
> Perhaps .id/.name/.clk should be "VENC_LT"/"venc_lt" to match the
> corresponding clock define (CLK_TOP_VENC_LT_SEL).
> 
> > +               .sta_mask = VEN2_PWR_STA_MASK,
> > +               .ctl_offs = SPM_VEN2_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(15, 12),
> > +               .clk_name = "ven2",
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_AUDIO,
> > +               .name = "audio",
> > +               .sta_mask = AUDIO_PWR_STA_MASK,
> > +               .ctl_offs = SPM_AUDIO_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(15, 12),
> > +       },  {
> > +               .id = MT8173_POWER_DOMAIN_MFG_ASYNC,
> > +               .name = "mfg_async",
> > +               .sta_mask = MFG_ASYNC_PWR_STA_MASK,
> > +               .ctl_offs = SPM_MFG_ASYNC_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = 0,
> > +               .clk_name = "mfg",
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_MFG_2D,
> > +               .name = "mfg_2d",
> > +               .sta_mask = MFG_2D_PWR_STA_MASK,
> > +               .ctl_offs = SPM_MFG_2D_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(13, 12),
> > +               .clk_name = "mfg",
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_MFG,
> > +               .name = "mfg",
> > +               .sta_mask = MFG_PWR_STA_MASK,
> > +               .ctl_offs = SPM_MFG_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(13, 8),
> > +               .sram_pdn_ack_bits = GENMASK(21, 16),
> > +               .clk_name = "mfg",
> > +               .bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
> > +                       MT8173_TOP_AXI_PROT_EN_MFG_M0 |
> > +                       MT8173_TOP_AXI_PROT_EN_MFG_M1 |
> > +                       MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_USB,
> > +               .name = "usb",
> > +               .sta_mask = USB_PWR_STA_MASK,
> > +               .ctl_offs = SPM_USB_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(15, 12),
> > +       },
> > +};
> > +
> > +#define NUM_DOMAINS    ARRAY_SIZE(scp_domain_data)
> > +
> > +struct scp;
> > +
> > +struct scp_domain {
> > +       struct generic_pm_domain pmd;
> 
> Could you name this "genpd"... that seems to be what most other drivers use.

ok

> 
> > +       const struct scp_domain_data *data;
> > +       struct scp *scp;
> > +       struct clk *clk;
> > +};
> > +
> > +struct scp {
> > +       struct scp_domain domains[NUM_DOMAINS];
> > +       struct genpd_onecell_data pd_data;
> 
> After probe() you don't use pd_data.
> Why do we need it in this struct?

Just to save another extra allocation for it.

> 
> > +       struct device *dev;
> > +       void __iomem *base;
> > +       struct regmap *infracfg;
> > +};
> > +
> > +static int scpsys_power_on(struct generic_pm_domain *genpd)
> > +{
> > +       struct scp_domain *scpd = container_of(genpd, struct scp_domain, pmd);
> > +       struct scp *scp = scpd->scp;
> > +       const struct scp_domain_data *data = scpd->data;
> > +       unsigned long expired;
> > +       void __iomem *ctl_addr = scpd->scp->base + data->ctl_offs;
> > +       u32 sram_pdn_ack = data->sram_pdn_ack_bits;
> > +       u32 val;
> > +       int ret;
> > +
> > +       if (scpd->clk) {
> > +               ret = clk_prepare_enable(scpd->clk);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       val = readl(ctl_addr);
> > +       val |= PWR_ON_BIT;
> > +       writel(val, ctl_addr);
> > +       val |= PWR_ON_2ND_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       /* wait until PWR_ACK = 1 */
> > +       expired = jiffies + HZ;
> > +       while (!(readl(scp->base + SPM_PWR_STATUS) & data->sta_mask) ||
> > +                       !(readl(scp->base + SPM_PWR_STATUS_2ND) & data->sta_mask)) {
> > +               cpu_relax();
> > +               if (time_after(jiffies, expired)) {
> > +                       ret = -EIO;
> > +                       goto out;
> > +               }
> > +       }
> > +
> > +       val &= ~PWR_CLK_DIS_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       val &= ~PWR_ISO_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       val |= PWR_RST_B_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       val &= ~data->sram_pdn_bits;
> > +       writel(val, ctl_addr);
> > +
> > +       /* wait until SRAM_PDN_ACK all 0 */
> > +       expired = jiffies + HZ;
> > +       while (sram_pdn_ack && (readl(ctl_addr) & sram_pdn_ack)) {
> > +               cpu_relax();
> > +               if (time_after(jiffies, expired)) {
> > +                       ret = -EIO;
> > +                       goto out;
> > +               }
> > +       }
> > +
> > +       if (data->bus_prot_mask) {
> > +               ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> > +                               data->bus_prot_mask);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return 0;
> > +out:
> > +       dev_err(scp->dev, "Failed to power on domain %s\n", scpd->data->name);
> 
> genpd->name should be sufficient

ok

> 
> > +
> > +       return ret;
> > +}
> > +
> > +static int scpsys_power_off(struct generic_pm_domain *genpd)
> > +{
> > +       struct scp_domain *scpd = container_of(genpd, struct scp_domain, pmd);
> > +       struct scp *scp = scpd->scp;
> > +       const struct scp_domain_data *data = scpd->data;
> > +       unsigned long expired;
> > +       void __iomem *ctl_addr = scpd->scp->base + data->ctl_offs;
> > +       u32 sram_pdn_ack = data->sram_pdn_ack_bits;
> > +       u32 val;
> > +       int ret;
> > +
> > +       if (data->bus_prot_mask) {
> > +               ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> > +                               data->bus_prot_mask);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       val = readl(ctl_addr);
> > +       val |= data->sram_pdn_bits;
> > +       writel(val, ctl_addr);
> > +
> > +       /* wait until SRAM_PDN_ACK all 1 */
> > +       expired = jiffies + HZ;
> > +       while ((readl(ctl_addr) & sram_pdn_ack) != sram_pdn_ack) {
> > +               cpu_relax();
> > +               if (time_after(jiffies, expired)) {
> > +                       ret = -EIO;
> > +                       goto out;
> > +               }
> > +       }
> > +
> > +       val |= PWR_ISO_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       val &= ~PWR_RST_B_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       val |= PWR_CLK_DIS_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       val &= ~PWR_ON_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       val &= ~PWR_ON_2ND_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       /* wait until PWR_ACK = 0 */
> > +       expired = jiffies + HZ;
> > +       while ((readl(scp->base + SPM_PWR_STATUS) & data->sta_mask) ||
> > +                       (readl(scp->base + SPM_PWR_STATUS_2ND) & data->sta_mask)) {
> > +               cpu_relax();
> > +               if (time_after(jiffies, expired)) {
> > +                       ret = -EIO;
> > +                       goto out;
> > +               }
> > +       }
> > +
> > +       if (scpd->clk)
> > +               clk_disable_unprepare(scpd->clk);
> > +
> > +       return 0;
> > +
> > +out:
> > +       dev_err(scp->dev, "Failed to power off domain %s\n", scpd->data->name);
> > +
> > +       return ret;
> > +}
> > +
> > +static int scpsys_probe(struct platform_device *pdev)
> > +{
> > +       struct genpd_onecell_data *pd_data;
> > +       struct resource *res;
> > +       int i;
> > +       struct scp *scp;
> > +
> > +       scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
> > +       if (!scp)
> > +               return -ENOMEM;
> > +
> > +       scp->dev = &pdev->dev;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       scp->base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(scp->base))
> > +               return PTR_ERR(scp->base);
> > +
> > +       pd_data = &scp->pd_data;
> > +
> > +       pd_data->domains = devm_kzalloc(&pdev->dev,
> > +                       sizeof(*pd_data->domains) * NUM_DOMAINS, GFP_KERNEL);
> > +       if (!pd_data->domains)
> > +               return -ENOMEM;
> > +
> > +       scp->infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> > +                       "infracfg");
> > +       if (IS_ERR(scp->infracfg)) {
> > +               dev_err(&pdev->dev, "Cannot find infracfg controller: %ld\n",
> > +                               PTR_ERR(scp->infracfg));
> > +               return PTR_ERR(scp->infracfg);
> > +       }
> > +
> > +       pd_data->num_domains = NUM_DOMAINS;
> > +
> > +       for (i = 0; i < NUM_DOMAINS; i++) {
> > +               struct scp_domain *scpd = &scp->domains[i];
> > +
> > +               if (scp_domain_data[i].clk_name) {
> > +                       const char *name = scp_domain_data[i].clk_name;
> > +
> > +                       scpd->clk = devm_clk_get(&pdev->dev, name);
> > +                       if (IS_ERR(scpd->clk)) {
> > +                               dev_err(&pdev->dev, "Failed to get %s clk: %ld\n",
> > +                                               name, PTR_ERR(scpd->clk));
> > +                               return PTR_ERR(scpd->clk);
> > +                       }
> > +               }
> > +       }
> > +
> > +       for (i = 0; i < NUM_DOMAINS; i++) {
> > +               struct scp_domain *scpd = &scp->domains[i];
> > +               struct generic_pm_domain *pmd = &scpd->pmd;
> > +
> > +               pd_data->domains[scp_domain_data[i].id] = pmd;
> > +               scpd->data = &scp_domain_data[i];
> > +               scpd->scp = scp;
> > +
> > +               pmd->name = scp_domain_data[i].name;
> > +               pmd->power_off = scpsys_power_off;
> > +               pmd->power_on = scpsys_power_on;
> > +               pmd->power_off_latency_ns = 20000;
> > +               pmd->power_on_latency_ns = 20000;
> 
> Where did these latency values come from?

>From reducing them to 0 and seeing where the end results end up being.
The power domain code increases the times automatically when the values
are exceeded.

> 
> > +
> > +               pm_genpd_init(pmd, NULL, true);
> 
> I'm not sure how this works...  does this mean that all power domains
> initially off?

Some are off, others are on. I'll change that to:

- call scpsys_power_on for all domains so I know they are turned on
- call pm_genpd_init(pmd, NULL, false);
- Let the pm core disable the unused domains in the late_initcall

That's the only way I found to properly sync the hardware state with the
software state also with regard to the clocks.

> 
> > +
> > +               /*
> > +                * If PM is disabled turn on all domains by default so that
> > +                * consumers can work.
> > +                */
> > +               if (!IS_ENABLED(CONFIG_PM))
> > +                       pmd->power_on(pmd);
> > +       }
> > +
> > +       pm_genpd_add_subdomain(&scp->domains[MT8173_POWER_DOMAIN_MFG_ASYNC].pmd,
> > +               &scp->domains[MT8173_POWER_DOMAIN_MFG_2D].pmd);
> > +       pm_genpd_add_subdomain(&scp->domains[MT8173_POWER_DOMAIN_MFG_2D].pmd,
> > +               &scp->domains[MT8173_POWER_DOMAIN_MFG].pmd);
> > +
> 
> (1) nit: the continuation lines needs 1 more indent.
> 
> (2) Why aren't you checking for errors?

I'll check for errors next round. However, I cannot bail out in this
case since once pm_genpd_init() is called the domain cannot be
unregistered anymore.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
