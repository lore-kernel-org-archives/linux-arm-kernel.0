From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 4 Jul 2012 10:35:38 +0200
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CACKLOr3OmhHJM0jNJm0UgO7=-DPrOzYcSYZ-iuT2hVEyQstevw@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
 <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
 <CACKLOr1oeci84Fs7HTRD2Myie8zjKExA15mxM3z7dkq8QfvDmg@mail.gmail.com>
 <CACKLOr3OmhHJM0jNJm0UgO7=-DPrOzYcSYZ-iuT2hVEyQstevw@mail.gmail.com>
Message-ID: <20120704083538.GA30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 10:30:40AM +0200, javier Martin wrote:
> On 4 July 2012 09:48, javier Martin <javier.martin@vista-silicon.com> wrote:
> > Hi,
> >
> > On 3 July 2012 15:13, Fabio Estevam <festevam@gmail.com> wrote:
> >> Hi Javier,
> >>
> >> On Tue, Jul 3, 2012 at 8:09 AM, javier Martin
> >> <javier.martin@vista-silicon.com> wrote:
> >>> Hi,
> >>> I've found the following problems in linux-3.5-rc5
> >>> (6887a4131da3adaab011613776d865f4bcfb5678) in our Visstrim M10 board:
> >>
> >> Could you please try the two attached patches?
> >>
> >> They should fix the dma and mx2-camera issues.
> >>
> >> I will try to look at the ssi problem, but my mx27pdk board still does
> >> not have audio supported.
> >>
> >> Regards,
> >>
> >
> > thanks for the patches. The first one solves the issue with the audio.
> > Now I can do an aplay properly too.
> >
> > However, second patch for the mx2-camera seems that it's not right
> > yet. I get a timeout here:
> >
> > static int mx27_camera_emma_prp_reset(struct mx2_camera_dev *pcdev)
> > {
> >         u32 cntl;
> >         int count = 0;
> >
> >         cntl = readl(pcdev->base_emma + PRP_CNTL);
> >         writel(PRP_CNTL_SWRST, pcdev->base_emma + PRP_CNTL);
> >         while (count++ < 100) {
> >                 if (!(readl(pcdev->base_emma + PRP_CNTL) & PRP_CNTL_SWRST))
> >                         return 0;
> >                 barrier();
> >                 udelay(1);
> >         }
> >
> >         return -ETIMEDOUT;
> > }
> >
> > Keeping this in mind I infer that probably emma clocks have not been
> > properly enabled.
> >
> 
> The problem is that in 'clk-imx27.c' the clocks for the emma are
> defined as follows:
> 
> 	clk_register_clkdev(clk[emma_ahb_gate], "ahb", "imx-emma");
> 	clk_register_clkdev(clk[emma_ipg_gate], "ipg", "imx-emma");
> 
> However, in the patch you submitted they are requested as shown:
> 
> 	pcdev->clk_emma_ipg = devm_clk_get(&pdev->dev, "ipg");
> 	if (IS_ERR(pcdev->clk_emma_ipg)) {
> 		err = PTR_ERR(pcdev->clk_emma_ipg);
> 		goto exit_kfree;
> 	}
> 
> 	pcdev->clk_emma_ahb = devm_clk_get(&pdev->dev, "ahb");
> 	if (IS_ERR(pcdev->clk_emma_ahb)) {
> 		err = PTR_ERR(pcdev->clk_emma_ahb);
> 		goto exit_kfree;
> 	}
> 
> Which means the dev_id used is "mx2-camera.0" instead of "imx-emma".
> We cannot change the name in 'clk-imx27.c' to "mx2-camera.0" since
> there is another device "mx2_emmaprp.c" which uses these clocks,
> unless two different names can be associated with the same clock.

This can be done just by calling clk_register_clkdev again with the
second name and this is also the preferred way of associating the same
clock to different devices.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
