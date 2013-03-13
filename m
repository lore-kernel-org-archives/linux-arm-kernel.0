From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 14 Mar 2013 00:16:34 +0100
Subject: [PATCH 6/7] ARM: SAMSUNG: use clk_prepare_enable in samsung-time
In-Reply-To: <CADTbHxq-gxoN9HKkjPsZ5uBt7PhrvO8XdQdmAyscOA+xPy9Z7A@mail.gmail.com>
References: <201303120141.31262.heiko@sntech.de>
 <201303120145.21072.heiko@sntech.de>
 <CADTbHxq-gxoN9HKkjPsZ5uBt7PhrvO8XdQdmAyscOA+xPy9Z7A@mail.gmail.com>
Message-ID: <201303140016.35152.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 13. M?rz 2013, 17:59:04 schrieb Pankaj Jangra:
> Hi,
> 
> On Tue, Mar 12, 2013 at 6:15 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > The common clock framework expects clocks to be prepared
> > before they are enabled.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  arch/arm/plat-samsung/samsung-time.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/plat-samsung/samsung-time.c
> > b/arch/arm/plat-samsung/samsung-time.c index f899cbc..6ebb851 100644
> > --- a/arch/arm/plat-samsung/samsung-time.c
> > +++ b/arch/arm/plat-samsung/samsung-time.c
> > @@ -355,7 +355,7 @@ static void __init samsung_timer_resources(void)
> > 
> >         if (IS_ERR(timerclk))
> >         
> >                 panic("failed to get timers clock for timer");
> 
> Also how about calling the clk_prepare_enable() only if the clk_get()
> call is a sucess? Though clk framework will take care of it. Just
> thinking even to avoid that call if clk_get() fails since you are
> modifying the code.

I remember there was a discussion about panic vc error handling when this was 
introduced but I don't remember the specifics, but it seems they agreed to do 
it this way with letting the kernel panic when the clock is missing.


Also the current plan seems to replace the clocksource and pwm drivers that 
occupy the same register space with a driver handling both, making the pwm 
specific clocks obsolete and only the timers clock will remain. So this was 
merely meant as a fixup when using the clock changes with the current 
clocksource code.


> > -       clk_enable(timerclk);
> > +       clk_prepare_enable(timerclk);
> > 
> >         sprintf(devname, "s3c24xx-pwm.%lu", event_id);
> >         s3c_device_timer[event_id].id = event_id;
> > 
> > @@ -369,7 +369,7 @@ static void __init samsung_timer_resources(void)
> > 
> >         if (IS_ERR(tdiv_event))
> >         
> >                 panic("failed to get pwm-tdiv clock for event timer");
> 
> Same here...
> 
> > -       clk_enable(tin_event);
> > +       clk_prepare_enable(tin_event);
> > 
> >         sprintf(devname, "s3c24xx-pwm.%lu", source_id);
> 
> Regards,
> Pankaj Jangra
