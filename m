From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 14 Jan 2016 12:50:29 +0800
Subject: [PATCH v3 4/4] soc: mediatek: Add MT2701 scpsys driver
In-Reply-To: <56967171.2070007@gmail.com>
References: <1452676288-62711-1-git-send-email-jamesjj.liao@mediatek.com>
 <1452676288-62711-5-git-send-email-jamesjj.liao@mediatek.com>
 <56967171.2070007@gmail.com>
Message-ID: <1452747029.5384.13.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Wed, 2016-01-13 at 16:46 +0100, Matthias Brugger wrote:
> 
> On 13/01/16 10:11, James Liao wrote:
> > From: Shunli Wang <shunli.wang@mediatek.com>
> >
> > Add scpsys driver for MT2701.
> >
> > Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > ---
> 
> NAK, same as in v1. Please don't split up the driver in several code 
> files, but find a a way to share the common code elegantly.
> Comments below.

Do you mean we should support MT8173 and MT2701 scpsys in a single file
(such as mtk-scpsys.c)?

We have lots of SoC with different power domain support. It means we
need to add a different power domain table for a SoC, and may need to
organize power domains (such as subdomains) for each SoC. It may not
easy to maintain if we integrate all SoC's power domain into the same
file.

> >   drivers/soc/mediatek/Makefile            |   1 +
> >   drivers/soc/mediatek/mtk-scpsys-mt2701.c | 170 +++++++++++++++++++++++++++++++
> >   2 files changed, 171 insertions(+)
> >   create mode 100644 drivers/soc/mediatek/mtk-scpsys-mt2701.c
> >
> > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > index 13f7d21..d693f7d 100644
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> > @@ -2,3 +2,4 @@ obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> >   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> >   obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> >   obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys-mt8173.o
> > +obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys-mt2701.o
> > diff --git a/drivers/soc/mediatek/mtk-scpsys-mt2701.c b/drivers/soc/mediatek/mtk-scpsys-mt2701.c
> > new file mode 100644
> > index 0000000..82c00ed
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-scpsys-mt2701.c
> > @@ -0,0 +1,170 @@
> > +/*
> > + * Copyright (c) 2015 Mediatek, Shunli Wang <shunli.wang@mediatek.com>
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
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/soc/mediatek/infracfg.h>
> > +#include <dt-bindings/power/mt2701-power.h>
> > +
> > +#include "mtk-scpsys.h"
> > +
> > +#define SPM_VDE_PWR_CON			0x0210
> > +#define SPM_MFG_PWR_CON			0x0214
> > +#define SPM_ISP_PWR_CON			0x0238
> > +#define SPM_DIS_PWR_CON			0x023C
> > +#define SPM_CONN_PWR_CON		0x0280
> > +#define SPM_BDP_PWR_CON			0x029C
> > +#define SPM_ETH_PWR_CON			0x02A0
> > +#define SPM_HIF_PWR_CON			0x02A4
> > +#define SPM_IFR_MSC_PWR_CON		0x02A8
> > +#define SPM_PWR_STATUS			0x060c
> > +#define SPM_PWR_STATUS_2ND		0x0610
> > +
> > +#define CONN_PWR_STA_MASK		BIT(1)
> > +#define DIS_PWR_STA_MASK		BIT(3)
> > +#define MFG_PWR_STA_MASK		BIT(4)
> > +#define ISP_PWR_STA_MASK		BIT(5)
> > +#define VDE_PWR_STA_MASK		BIT(7)
> > +#define BDP_PWR_STA_MASK		BIT(14)
> > +#define ETH_PWR_STA_MASK		BIT(15)
> > +#define HIF_PWR_STA_MASK		BIT(16)
> > +#define IFR_MSC_PWR_STA_MASK		BIT(17)
> 
> Apart from SPM_BDP_PWR_CON and BDP_PWR_STA_MASK this are compatible with 
> mt8173. So please avoid code duplication.
> Apart you changed the define names from PWR_STATUS_* to *_STA_MASK, 
> please keep a uniform naming across the driver.

OK, I'll unify the register naming or remove some register names in next
patch.

Some duplicated code can be reduced by moving them into the internal
head file (mtk-scpsys.h). But some init code, such as driver init
functions, may not easy to eliminate because the probe functions need to
customize subdomains.


Best regards,

James
