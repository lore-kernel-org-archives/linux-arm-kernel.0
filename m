From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Aug 2014 16:53:49 +0200
Subject: [PATCH v2] usb: gadget: at91_udc: move prepare clk into process
 context
In-Reply-To: <20140812033456.16355.48522@quantum>
References: <1407330702-2926-1-git-send-email-ronald.wahl@raritan.com>
 <20140812033456.16355.48522@quantum>
Message-ID: <20140813145348.GA26008@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 11/08/2014 at 20:34:56 -0700, Mike Turquette wrote :
> Quoting Ronald Wahl (2014-08-06 06:11:42)
> > Commit 7628083227b6bc4a7e33d7c381d7a4e558424b6b added clock preparation in
> > interrupt context. This is not allowed as it might sleep. Move clock
> > preparation into process context (at91udc_probe).
> > ---
> >  drivers/usb/gadget/udc/at91_udc.c | 39 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 30 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
> > index cfd18bc..0b347a0 100644
> > --- a/drivers/usb/gadget/udc/at91_udc.c
> > +++ b/drivers/usb/gadget/udc/at91_udc.c
> > @@ -872,10 +872,10 @@ static void clk_on(struct at91_udc *udc)
> >  
> >         if (IS_ENABLED(CONFIG_COMMON_CLK)) {
> 
> Why is this check necessary at all? Drivers shouldn't have to care at
> all about the underlying clock framework implementation.
> 

I believe it has been done because without the common clock framework,
usb_clk is not defined.

> >                 clk_set_rate(udc->uclk, 48000000);
> > -               clk_prepare_enable(udc->uclk);
> > +               clk_enable(udc->uclk);
> >         }
> > -       clk_prepare_enable(udc->iclk);
> > -       clk_prepare_enable(udc->fclk);
> > +       clk_enable(udc->iclk);
> > +       clk_enable(udc->fclk);
> >  }
> >  
> >  static void clk_off(struct at91_udc *udc)
> > @@ -884,10 +884,10 @@ static void clk_off(struct at91_udc *udc)
> >                 return;
> >         udc->clocked = 0;
> >         udc->gadget.speed = USB_SPEED_UNKNOWN;
> > -       clk_disable_unprepare(udc->fclk);
> > -       clk_disable_unprepare(udc->iclk);
> > +       clk_disable(udc->fclk);
> > +       clk_disable(udc->iclk);
> >         if (IS_ENABLED(CONFIG_COMMON_CLK))
> > -               clk_disable_unprepare(udc->uclk);
> > +               clk_disable(udc->uclk);
> >  }
> >  
> >  /*
> > @@ -1780,14 +1780,23 @@ static int at91udc_probe(struct platform_device *pdev)
> >         }
> >  
> >         /* don't do anything until we have both gadget driver and VBUS */
> > +       if (IS_ENABLED(CONFIG_COMMON_CLK)) {
> 
> Same question here. What does the clock framework implementation have to
> do with uclk?
> 
> Regards,
> Mike
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
