From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 08:18:16 -0700
Subject: [PATCH V4 08/11] clk: imx: scu: add scu clock gpr mux
In-Reply-To: <AM0PR04MB42111EE950D372B8D330164780FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-9-git-send-email-aisheng.dong@nxp.com>
 <153972544065.5275.2030080128764662219@swboyd.mtv.corp.google.com>
 <AM0PR04MB42111EE950D372B8D330164780FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <153978949677.5275.18324073004650149491@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-17 02:07:00)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd at kernel.org]
> > Sent: Wednesday, October 17, 2018 5:31 AM
> > Quoting A.s. Dong (2018-10-14 01:08:06)
> > > diff --git a/drivers/clk/imx/scu/clk-mux-gpr-scu.c
> > > b/drivers/clk/imx/scu/clk-mux-gpr-scu.c
> > > new file mode 100644
> > > index 0000000..2ad7a80
> > > --- /dev/null
> > > +++ b/drivers/clk/imx/scu/clk-mux-gpr-scu.c
> > > @@ -0,0 +1,90 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > > + * Copyright 2017~2018 NXP
> > > + *     Dong Aisheng <aisheng.dong@nxp.com>
> > > + */
> > > +
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include "clk-scu.h"
> > > +
> > > +struct clk_mux_gpr_scu {
> > > +       struct clk_hw hw;
> > > +       u32     rsrc_id;
> > > +       u8      gpr_id;
> > > +};
> > > +
> > > +#define to_clk_mux_gpr_scu(_hw) container_of(_hw, struct
> > > +clk_mux_gpr_scu, hw)
> > > +
> > > +static u8 clk_mux_gpr_scu_get_parent(struct clk_hw *hw) {
> > > +       struct clk_mux_gpr_scu *gpr_mux = to_clk_mux_gpr_scu(hw);
> > > +       u32 val = 0;
> > > +       int ret;
> > > +
> > > +       ret = imx_sc_misc_get_control(ccm_ipc_handle, gpr_mux->rsrc_id,
> > > +                                     gpr_mux->gpr_id, &val);
> > > +       if (ret) {
> > > +               pr_err("%s: failed to get clock parent %d\n",
> > > +                       clk_hw_get_name(hw), ret);
> > > +               return 0;
> > > +       }
> > > +
> > > +       return (u8)val;
> > 
> > Nitpick: Please drop explicit casts.
> > 
> 
> Compiler does it for us already, right?
> Will drop it.

Yes and my brain is a tired compiler :)
