From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 8 May 2015 14:19:44 +0200
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <CABuKBeLvBfeXw+b+SxAEjGA2dzPhYBs-SiJUyP5dUA28R=Rjkg@mail.gmail.com>
References: <1426002063-25713-1-git-send-email-s.hauer@pengutronix.de>
 <1426002063-25713-3-git-send-email-s.hauer@pengutronix.de>
 <CABuKBeLvBfeXw+b+SxAEjGA2dzPhYBs-SiJUyP5dUA28R=Rjkg@mail.gmail.com>
Message-ID: <20150508121944.GD6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 02:16:06PM +0200, Matthias Brugger wrote:
> 2015-03-10 16:41 GMT+01:00 Sascha Hauer <s.hauer@pengutronix.de>:
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
> >  drivers/soc/mediatek/Kconfig             |   6 +
> >  drivers/soc/mediatek/Makefile            |   1 +
> >  drivers/soc/mediatek/mtk-scpsys.c        | 345 +++++++++++++++++++++++++++++++
> >  include/dt-bindings/power/mt8173-power.h |  15 ++
> >  4 files changed, 367 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
> >  create mode 100644 include/dt-bindings/power/mt8173-power.h
> >
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index bcdb22d..1d34819 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -9,3 +9,9 @@ config MTK_PMIC_WRAP
> >           Say yes here to add support for MediaTek PMIC Wrapper found
> >           on different MediaTek SoCs. The PMIC wrapper is a proprietary
> >           hardware to connect the PMIC.
> > +
> > +config MTK_SCPSYS
> > +       tristate "MediaTek SCPSYS Support"
> > +       help
> > +         Say yes here to add support for the MediaTek SCPSYS power domain
> > +         driver.
> > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > index ecaf4de..ce88693 100644
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> > @@ -1 +1,2 @@
> >  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> > +obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > new file mode 100644
> > index 0000000..a72ac51
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -0,0 +1,345 @@
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
> > +       int id;
> > +};
> > +
> > +static struct scp_domain_data scp_domain_data[] = {
> > +       {
> > +               .id = MT8173_POWER_DOMAIN_VDE,
> > +               .name = "vde",
> > +               .sta_mask = VDE_PWR_STA_MASK,
> > +               .ctl_offs = SPM_VDE_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_MFG,
> > +               .name = "mfg",
> > +               .sta_mask = MFG_PWR_STA_MASK,
> > +               .ctl_offs = SPM_MFG_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(13, 8),
> > +               .sram_pdn_ack_bits = GENMASK(21, 16),
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_VEN,
> > +               .name = "ven",
> > +               .sta_mask = VEN_PWR_STA_MASK,
> > +               .ctl_offs = SPM_VEN_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(15, 12),
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_ISP,
> > +               .name = "isp",
> > +               .sta_mask = ISP_PWR_STA_MASK,
> > +               .ctl_offs = SPM_ISP_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(13, 12),
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_DIS,
> > +               .name = "dis",
> > +               .sta_mask = DIS_PWR_STA_MASK,
> > +               .ctl_offs = SPM_DIS_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(12, 12),
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_VEN2,
> > +               .name = "ven2",
> > +               .sta_mask = VEN2_PWR_STA_MASK,
> > +               .ctl_offs = SPM_VEN2_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(15, 12),
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_AUDIO,
> > +               .name = "audio",
> > +               .sta_mask = AUDIO_PWR_STA_MASK,
> > +               .ctl_offs = SPM_AUDIO_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(15, 12),
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_MFG_2D,
> > +               .name = "mfg_2d",
> > +               .sta_mask = MFG_2D_PWR_STA_MASK,
> > +               .ctl_offs = SPM_MFG_2D_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = GENMASK(13, 12),
> > +       }, {
> > +               .id = MT8173_POWER_DOMAIN_MFG_ASYNC,
> > +               .name = "mfg_async",
> > +               .sta_mask = MFG_ASYNC_PWR_STA_MASK,
> > +               .ctl_offs = SPM_MFG_ASYNC_PWR_CON,
> > +               .sram_pdn_bits = GENMASK(11, 8),
> > +               .sram_pdn_ack_bits = 0,
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
> > +       struct scp_domain_data *data;
> > +       struct scp *scp;
> > +};
> > +
> > +struct scp {
> > +       struct scp_domain domains[NUM_DOMAINS];
> > +       struct generic_pm_domain *pmd[NUM_DOMAINS];
> > +       struct genpd_onecell_data pd_data;
> > +       struct device *dev;
> > +       void __iomem *base;
> > +};
> > +
> > +static int scpsys_power_on(struct generic_pm_domain *genpd)
> > +{
> > +       struct scp_domain *scpd = container_of(genpd, struct scp_domain, pmd);
> > +       struct scp *scp = scpd->scp;
> > +       struct scp_domain_data *data = scpd->data;
> > +       unsigned long expired;
> > +       void __iomem *ctl_addr = scpd->scp->base + data->ctl_offs;
> > +       u32 sram_pdn_ack = data->sram_pdn_ack_bits;
> > +       u32 val;
> > +       int ret;
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
> 
> I think "sram_pdn_ack &&" was added accidently here. It is always
> bigger then zero.

Nope, it's zero for MT8173_POWER_DOMAIN_MFG_ASYNC.

> > +
> > +out:
> > +       dev_err(scp->dev, "Failed to power on domain %s\n", scpd->data->name);
> 
> typo, this shoudl be "power off domain"

Fixed, thanks

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
