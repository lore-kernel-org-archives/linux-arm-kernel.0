From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 21 Dec 2012 15:28:10 +0000
Subject: [PATCH 4/4] clk: zynq: Use of_init_clk_data()
In-Reply-To: <20121219205330.GE1005@beefymiracle.amer.corp.natinst.com>
References: <1355778135-32458-1-git-send-email-sboyd@codeaurora.org>
 <1355778135-32458-5-git-send-email-sboyd@codeaurora.org>
 <b11edd0b-27ff-48b3-9f2a-1e7ab293cc34@CO9EHSMHS019.ehs.local>
 <50D223DD.8070208@codeaurora.org>
 <20121219205330.GE1005@beefymiracle.amer.corp.natinst.com>
Message-ID: <296b6ceb-f248-4add-9b4e-bceddcc1613c@CO1EHSMHS028.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Wednesday, December 19, 2012 9:54 PM
> To: Stephen Boyd; Michal Simek
> Cc: Soren Brinkmann; Mike Turquette; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 4/4] clk: zynq: Use of_init_clk_data()
> 
> On Wed, Dec 19, 2012 at 12:30:21PM -0800, Stephen Boyd wrote:
> > On 12/19/12 11:22, Soren Brinkmann wrote:
> [..]
> > >
> > > A probably unique thing I do is, I set the status of uart0 to
> > > disabled. This way I can reuse my rootfs which does not run getty on
> > > ttyPS1. And this worked fine before.
> > >
> >
> > Thanks for testing. It seems that clocks are failing to register.
> > Please try this patch.
> >
> > --->8-----
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index 2be22a2..2734715 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -948,9 +948,9 @@ static int xuartps_probe(struct platform_device *pdev)
> >         struct clk *clk;
> >
> >         clk = of_clk_get(pdev->dev.of_node, 0);
> > -       if (!clk) {
> > -               dev_err(&pdev->dev, "no clock specified\n");
> > -               return -ENODEV;
> > +       if (IS_ERR(clk)) {
> > +               dev_err(&pdev->dev, "failed to get clock\n");
> > +               return PTR_ERR(clk);
> >         }
> >
> >         rc = clk_prepare_enable(clk);
> 
> Yes, indeed.
> 
> As a side note, this is introduced in my patch "serial: xilinx_uartps:
> get clock rate info from dts", which is in xilinx/arm-next (and thus in linux-next),
> but as far as I can tell, didn't ever make it into the arm-soc tree.
> 
> Michal, did you have plans for pushing this through arm-soc?

I have had this patch in my devel branch for a while. 
It is in arm-next tree right now and I will provide path to mainline.

Thanks for reminder,
Michal
