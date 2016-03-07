From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 7 Mar 2016 14:03:04 +0100
Subject: [PATCH 3/3] hwrng: mxc-fsl - add support for Freescale RNGC
In-Reply-To: <20160301074937.GU2613@pengutronix.de>
References: <1456761156-27664-1-git-send-email-s.trumtrar@pengutronix.de>
 <1456761156-27664-3-git-send-email-s.trumtrar@pengutronix.de>
 <CAOMZO5BN-1U6vX0HAHWX30t+23NnqEpOw6AttSgvqaZnq=cN6Q@mail.gmail.com>
 <20160229213850.GS2613@pengutronix.de>
 <CAOMZO5BLYumOrBuoB5-RgzLAJ=o4zp9ocv4jcZRy=p6Pky1SyQ@mail.gmail.com>
 <20160301074937.GU2613@pengutronix.de>
Message-ID: <20160307130304.GA791@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Mar 01, 2016 at 08:49:37AM +0100, Uwe Kleine-K?nig wrote:
> Hello Fabio,
> 
> On Mon, Feb 29, 2016 at 08:54:19PM -0300, Fabio Estevam wrote:
> > On Mon, Feb 29, 2016 at 6:38 PM, Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Mon, Feb 29, 2016 at 06:16:50PM -0300, Fabio Estevam wrote:
> > >> On Mon, Feb 29, 2016 at 12:52 PM, Steffen Trumtrar
> > >> <s.trumtrar@pengutronix.de> wrote:
> > >>
> > >> > +       ret = clk_prepare_enable(rngc->clk);
> > >> > +       if (ret)
> > >> > +               return ret;
> > >> > +
> > >> > +       rngc->irq = platform_get_irq(pdev, 0);
> > >> > +       if (!rngc->irq) {
> > >> > +               dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
> > >> > +               clk_disable_unprepare(rngc->clk);
> > >> > +
> > >> > +               return ret;
> > >>
> > >> You are returning the wrong error code here:
> > >>
> > >> Better do like this:
> > >>
> > >>        rngc->irq = platform_get_irq(pdev, 0);
> > >>        if (rngc->irq < 0) {
> > >
> > > rngc->irq is unsigned, so this is never true.
> > >
> > >>                dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
> > >>                clk_disable_unprepare(rngc->clk);
> > >>                return rngc->irq;
> > >>        }
> > >
> > > So here comes my better approach:
> > 
> > As irq is only used inside probe it can be removed from struct mxc_rngc.
> 
> Good idea.
> 

Actually it is currently used in the mxc_rngc_init function, but I think I can
just move the call there into the probe function and get rid of the irq in the
struct.

> > Or maybe like this:
> > 
> >          ret = platform_get_irq(pdev, 0);
> >          if (ret < 0) {
> >                  dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
> >                  clk_disable_unprepare(rngc->clk);
> >                  return ret;
> >          }
> 

This looks better, yes. I will change that, of course.

> Some people think platform_get_irq returning 0 should be handled as
> error.

And who is right? drivers/of/unittest.c checks for irq < 0 for example.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
