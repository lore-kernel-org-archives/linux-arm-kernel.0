From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 23 Jun 2015 08:04:09 +0200
Subject: [PATCH 3/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <CAGS+omA5STFAG7nrcXj=DnTuLJQfhx2xJyVF+gWqsUjSaVMi_w@mail.gmail.com>
References: <1434954942-30179-1-git-send-email-s.hauer@pengutronix.de>
 <1434954942-30179-4-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omA5STFAG7nrcXj=DnTuLJQfhx2xJyVF+gWqsUjSaVMi_w@mail.gmail.com>
Message-ID: <20150623060409.GL6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 09:53:59PM +0800, Daniel Kurtz wrote:
> On Mon, Jun 22, 2015 at 2:35 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
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
> >  drivers/soc/mediatek/Kconfig             |  10 +
> >  drivers/soc/mediatek/Makefile            |   1 +
> >  drivers/soc/mediatek/mtk-scpsys.c        | 487 +++++++++++++++++++++++++++++++
> >  include/dt-bindings/power/mt8173-power.h |  15 +
> >  4 files changed, 513 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
> >  create mode 100644 include/dt-bindings/power/mt8173-power.h
> >
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index e4f37a3..32eff1b 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -18,3 +18,13 @@ config MTK_PMIC_WRAP
> >           Say yes here to add support for MediaTek PMIC Wrapper found
> >           on different MediaTek SoCs. The PMIC wrapper is a proprietary
> >           hardware to connect the PMIC.
> > +
> > +config MTK_SCPSYS
> > +       bool "MediaTek SCPSYS Support"
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +       select REGMAP
> > +       select MTK_INFRACFG
> > +       select PM_GENERIC_DOMAINS if PM
> > +       help
> > +         Say yes here to add support for the MediaTek SCPSYS power domain
> > +         driver.
> > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > index 3fa940f..12998b0 100644
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> > @@ -1,2 +1,3 @@
> >  obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> >  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> > +obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > new file mode 100644
> > index 0000000..84c306a
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -0,0 +1,487 @@
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
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/regmap.h>
> > +#include <linux/soc/mediatek/infracfg.h>
> > +#include <dt-bindings/power/mt8173-power.h>
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
> > +#define PWR_STATUS_DISP                        BIT(3)
> > +#define PWR_STATUS_MFG                 BIT(4)
> > +#define PWR_STATUS_ISP                 BIT(5)
> > +#define PWR_STATUS_VDEC                        BIT(7)
> > +#define PWR_STATUS_VENC_LT             BIT(20)
> > +#define PWR_STATUS_VENC                        BIT(21)
> > +#define PWR_STATUS_MFG_2D              BIT(22)
> > +#define PWR_STATUS_MFG_ASYNC           BIT(23)
> > +#define PWR_STATUS_AUDIO               BIT(24)
> > +#define PWR_STATUS_USB                 BIT(25)
> > +
> > +enum clk_id {
> > +       MT8173_CLK_NONE,
> > +       MT8173_CLK_MM,
> > +       MT8173_CLK_MFG,
> > +       MT8173_CLK_MAX = MT8173_CLK_MFG,
> 
> This sets MT8173_CLK_MAX = 2 ...
> 
> > +static int __init scpsys_probe(struct platform_device *pdev)
> > +{
> > +       struct genpd_onecell_data *pd_data;
> > +       struct resource *res;
> > +       int i, ret;
> > +       struct scp *scp;
> > +       struct clk *clk[MT8173_CLK_MAX];
> 
> So ARRAY_SIZE(clk) == 2 ...
> 
> > +       clk[MT8173_CLK_MFG] = devm_clk_get(&pdev->dev, "mfg");
> 
> and here...
>    clk[MT8173_CLK_MFG] == clk[2]

Oh, damn. I can fix that by reordering the enum to:

enum clk_id {
	MT8173_CLK_MM,
	MT8173_CLK_MFG,
	MT8173_CLK_NONE,
	MT8173_CLK_MAX = MT8173_CLK_NONE,
};

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
