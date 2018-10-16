From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 16 Oct 2018 17:23:11 +0000
Subject: [PATCH v3 2/4] crypto: mxs-dcp - Add support for dcp clk
In-Reply-To: <CAOMZO5Ck846zd_Xo=9sVK0EAxNLsUsWiC59H2Ms6x8xoD8iwWw@mail.gmail.com>
References: <cover.1539705285.git.leonard.crestez@nxp.com>
 <dcbcaf888bbd0a35dcf34228df2d9eb4fd762ea7.1539705286.git.leonard.crestez@nxp.com>
 <CAOMZO5Ck846zd_Xo=9sVK0EAxNLsUsWiC59H2Ms6x8xoD8iwWw@mail.gmail.com>
Message-ID: <f88233e6a76e99f95f6611bccdf234681e84f7ce.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-10-16 at 13:03 -0300, Fabio Estevam wrote:
> > +       /* DCP clock is optional, only used on some SOCs */
> > +       sdcp->dcp_clk = devm_clk_get(dev, "dcp");
> > +       if (IS_ERR(sdcp->dcp_clk)) {
> > +               if (sdcp->dcp_clk != ERR_PTR(-ENOENT))
> > +                       return PTR_ERR(sdcp->dcp_clk);
> > +               sdcp->dcp_clk = NULL;
> 
> This dcp_clk assignment to NULL does not seem to be necessary.

The clk API ignores all calls if clk == NULL (which is very nice) but
not if IS_ERR(clk). Setting dcp_clk to NULL avoids sprinkling other
checks.

> > +       ret = clk_prepare_enable(sdcp->dcp_clk);
> > +       if (ret)
> > +               return ret;
> > 
> >         ret = devm_request_irq(dev, dcp_vmi_irq, mxs_dcp_irq, 0,
> >                                "dcp-vmi-irq", sdcp);
> >         if (ret) {
> >                 dev_err(dev, "Failed to claim DCP VMI IRQ!\n");
> 
> In case of subsequent errors you should call
> clk_disable_unprepare(sdcp->dcp_clk).

Yes, will resend. Maybe some day clk consumer will automatically undo
pending prepare/enables on release?
