From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 17 Oct 2018 08:56:35 +0000
Subject: [PATCH V4 03/11] clk: imx: scu: add scu clock divider
In-Reply-To: <153972518358.5275.8551722631185725008@swboyd.mtv.corp.google.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-4-git-send-email-aisheng.dong@nxp.com>
 <153972518358.5275.8551722631185725008@swboyd.mtv.corp.google.com>
Message-ID: <AM0PR04MB42111D180BE6D7557F71D15380FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Wednesday, October 17, 2018 5:26 AM
> Quoting A.s. Dong (2018-10-14 01:07:49)
> > diff --git a/drivers/clk/imx/scu/clk-divider-scu.c
> > b/drivers/clk/imx/scu/clk-divider-scu.c
> > new file mode 100644
> > index 0000000..51cb816
> > --- /dev/null
> > +++ b/drivers/clk/imx/scu/clk-divider-scu.c
> > @@ -0,0 +1,176 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017~2018 NXP
> > + *     Dong Aisheng <aisheng.dong@nxp.com>
> > + *
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/jiffies.h>
> 
> Is this used?
> 

Good catch, it's introduced by test code and should be removed.

> > +#include <linux/slab.h>
> > +
> > +#include "clk-scu.h"
> > +
> > +struct clk_divider_scu {
> > +       struct clk_hw   hw;
> 
> Nitpick: No idea why this is spaced out from clk_hw.
> 

Yes, better aligned.

> > +       u32 rsrc_id;
> > +       u8 clk_type;
> > +};
> > +
> > +/* SCU Clock Protocol definitions */
> > +struct imx_sc_msg_req_set_clock_rate {
> > +       struct imx_sc_rpc_msg hdr;
> > +       u32 rate;
> > +       u16 resource;
> > +       u8 clk;
> > +} __packed;
> > +
> > +struct imx_sc_msg_req_get_clock_rate {
> > +       struct imx_sc_rpc_msg hdr;
> > +       u16 resource;
> > +       u8 clk;
> > +} __packed;
> > +
> > +struct imx_sc_msg_resp_get_clock_rate {
> > +       struct imx_sc_rpc_msg hdr;
> > +       u32 rate;
> > +} __packed;
> > +
> > +
> > +static inline struct clk_divider_scu *to_clk_divider_scu(struct
> > +clk_hw *hw) {
> > +       return container_of(hw, struct clk_divider_scu, hw); }
> > +
> > +/*
> > + * clk_divider_scu_recalc_rate - Get clock rate for a SCU clock
> > + * @hw: clock to get rate for
> > + * @parent_rate: parent rate provided by common clock framework, not
> > +used
> > + *
> > + * Gets the current clock rate of a SCU clock. Returns the current
> > + * clock rate, or zero in failure.
> > + */
> > +static unsigned long clk_divider_scu_recalc_rate(struct clk_hw *hw,
> > +                                                 unsigned long
> > +parent_rate) {
> > +       struct clk_divider_scu *div = to_clk_divider_scu(hw);
> > +       struct imx_sc_msg_req_get_clock_rate msg;
> > +       struct imx_sc_msg_resp_get_clock_rate *resp;
> > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > +       int ret;
> > +
> > +       hdr->ver = IMX_SC_RPC_VERSION;
> > +       hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
> > +       hdr->func = (uint8_t)IMX_SC_PM_FUNC_GET_CLOCK_RATE;
> > +       hdr->size = 2;
> > +
> > +       msg.resource = div->rsrc_id;
> > +       msg.clk = div->clk_type;
> > +
> > +       ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
> > +       if (ret) {
> > +               pr_err("%s: failed to get clock rate %d\n",
> > +                       clk_hw_get_name(hw), ret);
> > +               return 0;
> > +       }
> > +
> > +       resp = (struct imx_sc_msg_resp_get_clock_rate *)&msg;
> 
> Does the response get written to the same place that the message is written? If

Yes

> so, it would be better to combine the different structs into a union that's
> always large enough to handle this? For example, it looks like there are only 16
> + 8 bytes for the get_clock_rate structure, but then the response is returning
> the rate in 32 bytes. When we cast that here we're now getting an extra 8
> bytes of stack, aren't we? Combining the different structures into one bigger
> structure would alleviate this and avoid the need for casting.
> 

Good catch.
Thanks for the professional explanation.

How about do something like below?
struct req_get_clock_rate {
        u16 resource;
        u8 clk;
} __packed;

struct resp_get_clock_rate {
        u32 rate;
} __packed;

struct imx_sc_msg_get_clock_rate {
        struct imx_sc_rpc_msg hdr;
        union {
                struct req_get_clock_rate req;
                struct resp_get_clock_rate resp;
        } data;
} __packed;

> > +
> > +       return resp->rate;
> > +}
> > +
> > +/*
> > + * clk_divider_scu_round_rate - Round clock rate for a SCU clock
> > + * @hw: clock to round rate for
> > + * @rate: rate to round
> > + * @parent_rate: parent rate provided by common clock framework, not
> > +used
> > + *
> > + * Gets the current clock rate of a SCU clock. Returns the current
> > + * clock rate, or zero in failure.
> > + */
> > +static long clk_divider_scu_round_rate(struct clk_hw *hw, unsigned long
> rate,
> > +                                      unsigned long *parent_rate) {
> > +       /*
> > +        * Assume we support all the requested rate and let the SCU
> firmware
> > +        * to handle the left work
> > +        */
> > +       return rate;
> > +}
> > +
> > +/*
> > + * clk_divider_scu_set_rate - Set rate for a SCU clock
> > + * @hw: clock to change rate for
> > + * @rate: target rate for the clock
> > + * @parent_rate: rate of the clock parent, not used for SCU clocks
> > + *
> > + * Sets a clock frequency for a SCU clock. Returns the SCU
> > + * protocol status.
> > + */
> > +static int clk_divider_scu_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                                   unsigned long parent_rate) {
> > +       struct clk_divider_scu *div = to_clk_divider_scu(hw);
> > +       struct imx_sc_msg_req_set_clock_rate msg;
> > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > +       int ret;
> > +
> > +       hdr->ver = IMX_SC_RPC_VERSION;
> > +       hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
> > +       hdr->func = (uint8_t)IMX_SC_PM_FUNC_SET_CLOCK_RATE;
> 
> Are these casts necessary?
> 

I guess the explicit case may not need. Will double check.

> > +       hdr->size = 3;
> > +
> > +       msg.rate = rate;
> > +       msg.resource = div->rsrc_id;
> > +       msg.clk = div->clk_type;
> > +
> > +       ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
> > +       if (ret)
> > +               pr_err("%s: failed to set clock rate %ld : ret %d\n",
> > +                       clk_hw_get_name(hw), rate, ret);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct clk_ops clk_divider_scu_ops = {
> > +       .recalc_rate = clk_divider_scu_recalc_rate,
> > +       .round_rate = clk_divider_scu_round_rate,
> > +       .set_rate = clk_divider_scu_set_rate, };
> > +
> > +struct clk_hw *imx_clk_register_divider_scu(const char *name,
> > +                                           const char
> *parent_name,
> > +                                           u32 rsrc_id,
> > +                                           u8 clk_type) {
> > +       struct clk_divider_scu *div;
> > +       struct clk_init_data init;
> > +       struct clk_hw *hw;
> > +       int ret;
> > +
> > +       div = kzalloc(sizeof(*div), GFP_KERNEL);
> > +       if (!div)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       div->rsrc_id = rsrc_id;
> > +       div->clk_type = clk_type;
> > +
> > +       init.name = name;
> > +       init.ops = &clk_divider_scu_ops;
> > +       init.flags = CLK_GET_RATE_NOCACHE;
> 
> Why nocache? Please have a good reason and add a comment indicating why.
> 

Because on MX8, the clocks are tightly couple with power domain that
once the power domain is off, the clock status will be lost.
Making it NOCACHE helps user to retrieve the real clock status from HW
Instead of using the possible invalid cached rate.

Is that reasonable enough to specify it?

Regards
Dong Aisheng

> > +       init.parent_names = parent_name ? &parent_name : NULL;
> > +       init.num_parents = parent_name ? 1 : 0;
> > +       div->hw.init = &init;
> > +
> > +       hw = &div->hw;
> > +       ret = clk_hw_register(NULL, hw);
> > +       if (ret) {
> > +               kfree(div);
> > +               hw = ERR_PTR(ret);
> > +       }
> > +
> > +       return hw;
> > +}
