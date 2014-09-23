From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 18:44:40 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140923133645.GA18924@kwain>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <2909480.SL9c0XWUbW@wuerfel> <20140923133645.GA18924@kwain>
Message-ID: <5140494.LzvyOiyY3U@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 15:36:45 Antoine Tenart wrote:
> On Tue, Sep 23, 2014 at 12:39:04PM +0200, Arnd Bergmann wrote:
> > On Tuesday 23 September 2014 12:28:03 Antoine Tenart wrote:
> > > +       if (dev->of_node) {
> > > +               ret = ci_hdrc_usb2_dt_probe(dev, ci_pdata);
> > > +               if (ret)
> > > +                       goto clk_err;
> > > +       } else {
> > > +               ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > > +               if (ret)
> > > +                       goto clk_err;
> > > +       }
> > > 
> > 
> > Why do you care about the non-DT case here? I think it would be nicer to
> > open-code the ci_hdrc_usb2_dt_probe() function in here and remove
> > the dma_set_mask_and_coherent(), which should not even be necessary for
> > the case where you have a hardwired platform device.
> > 
> 
> I thought we agreed to call dma_set_mask_and_coherent():
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/273335.html
> 
> I do not have a strong opinion on this as I only use the dt case for my
> usage.

The question is more about who actually wants the non-DT case.

Since this is a new driver, I suspect that the answer is "nobody",
as the existing board files are all for legacy platforms that we
are not going to adapt for this driver.

I see in the thread that at least Peter Chen was assuming the non-DT
case was still needed, but I can't find a reason for this in the code.
If we no longer care about that, the call to dev_get_platdata()
can also get removed.

Looking through the code some more, I also notice that it's using
a strange way of doing the abstraction: ci_hdrc_add_device()
actually creates a child device node, while the preferred way would
be to just call into ci_hdrc_probe(), or a generalized version of
that.
That should probably be changed, but can be done as a later cleanup.


	Arnd
