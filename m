From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 17 Oct 2018 09:21:57 +0000
Subject: [PATCH V4 09/11] clk: imx: add common imx_clk_hw_fixed functions
In-Reply-To: <153972556312.5275.17225594568267875356@swboyd.mtv.corp.google.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-10-git-send-email-aisheng.dong@nxp.com>
 <153972556312.5275.17225594568267875356@swboyd.mtv.corp.google.com>
Message-ID: <AM0PR04MB4211AC4095A29F4C49FF7E0180FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Wednesday, October 17, 2018 5:33 AM
> Quoting A.s. Dong (2018-10-14 01:08:09)
> > This may be used by both mmio and scu clks. So let's put it into a
> > common file.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/clk/imx/clk-common.h  | 16 ++++++++++++++++
> > drivers/clk/imx/scu/clk-scu.h |  2 ++
> >  2 files changed, 18 insertions(+)
> >  create mode 100644 drivers/clk/imx/clk-common.h
> >
> > diff --git a/drivers/clk/imx/clk-common.h
> > b/drivers/clk/imx/clk-common.h new file mode 100644 index
> > 0000000..e3634a5
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-common.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2018 NXP
> > + */
> > +
> > +#ifndef __IMX_CLK_COMMON_H
> > +#define __IMX_CLK_COMMON_H
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int
> > +rate) {
> > +       return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
> > +}
> 
> Why do we need this wrapper file? 

This file clk-common.h is used to put the common bits between legacy clocks and scu clocks.
Only imx_clk_hw_fixed() is added in this patch.

> Just call the registration function directly
> with the right arguments instead of wrapping them in another function please.

That's legacy way and widely used before in order to save unnecessary parameters
for imx clocks.
e.g.
drivers/clk/imx/clk.h
static inline struct clk *imx_clk_fixed(const char *name, int rate)
{
        return clk_register_fixed_rate(NULL, name, NULL, 0, rate);
}

static inline struct clk *imx_clk_divider(const char *name, const char *parent,
                void __iomem *reg, u8 shift, u8 width)
{
        return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
                        reg, shift, width, 0, &imx_ccm_lock);
}

I can remove it if you dislike it.

Just one question, in later patch, another common function will also be added here:
static inline void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count)
{
        unsigned int i;

        for (i = 0; i < count; i++) {
                if (IS_ERR(clks[i]))
                        pr_err("i.MX clk %u: register failed with %ld\n",
                                i, PTR_ERR(clks[i])); 
        }
}

Should we remove it as well?

Regards
Dong Aisheng
