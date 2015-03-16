From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Mar 2015 06:33:18 +0100
Subject: [PATCH 3/5] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <CAGS+omBrJObfif2aRWYwpqEstfv0gFESXSubAbG7dcQGfnVvxg@mail.gmail.com>
References: <1424605765-19751-1-git-send-email-s.hauer@pengutronix.de>
 <1424605765-19751-4-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omBrJObfif2aRWYwpqEstfv0gFESXSubAbG7dcQGfnVvxg@mail.gmail.com>
Message-ID: <20150316053318.GC24798@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 12:27:20AM +0800, Daniel Kurtz wrote:
> Hi Sascha,
> 
> Drive-by review...
> 
> On Sun, Feb 22, 2015 at 7:49 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > From: James Liao <jamesjj.liao@mediatek.com>
> >
> > This patch adds basic clocks for MT8135, including TOPCKGEN, PLLs,
> > INFRA and PERI clocks.
> >
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/clk/mediatek/Makefile                      |   1 +
> >  drivers/clk/mediatek/clk-mt8135.c                  | 634 +++++++++++++++++++++
> >  include/dt-bindings/clock/mt8135-clk.h             | 190 ++++++
> >  .../dt-bindings/reset-controller/mt8135-resets.h   |  64 +++
> >  4 files changed, 889 insertions(+)
> >  create mode 100644 drivers/clk/mediatek/clk-mt8135.c
> >  create mode 100644 include/dt-bindings/clock/mt8135-clk.h
> >  create mode 100644 include/dt-bindings/reset-controller/mt8135-resets.h
> >
> > diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> > index 0b6f1c3..12ce576 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -1,2 +1,3 @@
> >  obj-y += clk-mtk.o clk-pll.o clk-gate.o
> >  obj-$(CONFIG_RESET_CONTROLLER) += reset.o
> > +obj-y += clk-mt8135.o
> > diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
> > new file mode 100644
> > index 0000000..6157447
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8135.c
> > @@ -0,0 +1,634 @@
> > +/*
> > + * Copyright (c) 2014 MediaTek Inc.
> > + * Author: James Liao <jamesjj.liao@mediatek.com>
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
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/slab.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <dt-bindings/clock/mt8135-clk.h>
> > +
> > +#include "clk-mtk.h"
> > +#include "clk-gate.h"
> > +
> > +static DEFINE_SPINLOCK(lock);
> > +
> 
> > +static struct mtk_fixed_factor root_clk_alias[] __initdata = {
> 
> Any reason you can't use "static const" here, and on all of the other
> static constant structures/arrays throughout this patch.

No, there is no reason. Changed it. Thanks

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
