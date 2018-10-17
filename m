From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 08:17:05 -0700
Subject: [PATCH V4 03/11] clk: imx: scu: add scu clock divider
In-Reply-To: <AM0PR04MB42111D180BE6D7557F71D15380FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-4-git-send-email-aisheng.dong@nxp.com>
 <153972518358.5275.8551722631185725008@swboyd.mtv.corp.google.com>
 <AM0PR04MB42111D180BE6D7557F71D15380FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <153978942538.5275.15892434593141965554@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-17 01:56:35)
> > From: Stephen Boyd [mailto:sboyd at kernel.org]
> > Sent: Wednesday, October 17, 2018 5:26 AM
> > Quoting A.s. Dong (2018-10-14 01:07:49)
> > > diff --git a/drivers/clk/imx/scu/clk-divider-scu.c
> > > b/drivers/clk/imx/scu/clk-divider-scu.c
> > > new file mode 100644
> > > index 0000000..51cb816
> > > --- /dev/null
> > > +++ b/drivers/clk/imx/scu/clk-divider-scu.c
> > > @@ -0,0 +1,176 @@
> > > +       msg.clk = div->clk_type;
> > > +
> > > +       ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
> > > +       if (ret) {
> > > +               pr_err("%s: failed to get clock rate %d\n",
> > > +                       clk_hw_get_name(hw), ret);
> > > +               return 0;
> > > +       }
> > > +
> > > +       resp = (struct imx_sc_msg_resp_get_clock_rate *)&msg;
> > 
> > Does the response get written to the same place that the message is written? If
> 
> Yes
> 
> > so, it would be better to combine the different structs into a union that's
> > always large enough to handle this? For example, it looks like there are only 16
> > + 8 bytes for the get_clock_rate structure, but then the response is returning
> > the rate in 32 bytes. When we cast that here we're now getting an extra 8
> > bytes of stack, aren't we? Combining the different structures into one bigger
> > structure would alleviate this and avoid the need for casting.
> > 
> 
> Good catch.
> Thanks for the professional explanation.
> 
> How about do something like below?
> struct req_get_clock_rate {
>         u16 resource;
>         u8 clk;
> } __packed;
> 
> struct resp_get_clock_rate {
>         u32 rate;
> } __packed;

This doesn't need __packed because it's a single u32.

> 
> struct imx_sc_msg_get_clock_rate {
>         struct imx_sc_rpc_msg hdr;
>         union {
>                 struct req_get_clock_rate req;
>                 struct resp_get_clock_rate resp;
>         } data;
> } __packed;
> 

Yes something like this would be best. And now I wonder if
imx_scu_call_rpc() is doing endianness swapping? Or does it copy data
into these response structures? I'm saying that the u32/16/8 may need to
be __le32/16/8 and then have the proper accessors.

> 
> > > +       hdr->size = 3;
> > > +
> > > +       msg.rate = rate;
> > > +       msg.resource = div->rsrc_id;
> > > +       msg.clk = div->clk_type;
> > > +
> > > +       ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
> > > +       if (ret)
> > > +               pr_err("%s: failed to set clock rate %ld : ret %d\n",
> > > +                       clk_hw_get_name(hw), rate, ret);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct clk_ops clk_divider_scu_ops = {
> > > +       .recalc_rate = clk_divider_scu_recalc_rate,
> > > +       .round_rate = clk_divider_scu_round_rate,
> > > +       .set_rate = clk_divider_scu_set_rate, };
> > > +
> > > +struct clk_hw *imx_clk_register_divider_scu(const char *name,
> > > +                                           const char
> > *parent_name,
> > > +                                           u32 rsrc_id,
> > > +                                           u8 clk_type) {
> > > +       struct clk_divider_scu *div;
> > > +       struct clk_init_data init;
> > > +       struct clk_hw *hw;
> > > +       int ret;
> > > +
> > > +       div = kzalloc(sizeof(*div), GFP_KERNEL);
> > > +       if (!div)
> > > +               return ERR_PTR(-ENOMEM);
> > > +
> > > +       div->rsrc_id = rsrc_id;
> > > +       div->clk_type = clk_type;
> > > +
> > > +       init.name = name;
> > > +       init.ops = &clk_divider_scu_ops;
> > > +       init.flags = CLK_GET_RATE_NOCACHE;
> > 
> > Why nocache? Please have a good reason and add a comment indicating why.
> > 
> 
> Because on MX8, the clocks are tightly couple with power domain that
> once the power domain is off, the clock status will be lost.
> Making it NOCACHE helps user to retrieve the real clock status from HW
> Instead of using the possible invalid cached rate.
> 
> Is that reasonable enough to specify it?

Yes, you can add a comment like that. Or the clk rate can be restored
when the power domain is enabled again?
