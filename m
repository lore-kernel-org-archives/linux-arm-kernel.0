From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 13 Nov 2015 20:57:27 +0800
Subject: [PATCH v2] clocksource/drivers/dw_apb_timer: Use
 {readl|writel}_relaxed
In-Reply-To: <3713227.4t0cg6qNF9@wuerfel>
References: <1447417883-7881-1-git-send-email-jszhang@marvell.com>
 <3713227.4t0cg6qNF9@wuerfel>
Message-ID: <20151113205727.24354052@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

On Fri, 13 Nov 2015 13:42:09 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 13 November 2015 20:31:23 Jisheng Zhang wrote:
> > diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
> > index c76c750..04282ee 100644
> > --- a/drivers/clocksource/dw_apb_timer.c
> > +++ b/drivers/clocksource/dw_apb_timer.c
> > @@ -51,13 +51,13 @@ clocksource_to_dw_apb_clocksource(struct clocksource *cs)
> >  
> >  static unsigned long apbt_readl(struct dw_apb_timer *timer, unsigned long offs)
> >  {
> > -       return readl(timer->base + offs);
> > +       return readl_relaxed(timer->base + offs);
> >  }
> >  
> >  static void apbt_writel(struct dw_apb_timer *timer, unsigned long val,
> >                  unsigned long offs)
> >  {
> > -       writel(val, timer->base + offs);
> > +       writel_relaxed(val, timer->base + offs);
> >  }
> >  
> >   
> 
> As with the other patch, I think it would be nicer to only change the
> functions that benefit from the change, to make it easier to prove

I think to show performance improvement for this dw_apb_timer case is much
easier, because the clocksource ->read() function also calls the apbt_readl.
I will add some performance numbers in v3

> that the conversion is correct. You could introduce apbt_readl_releaxed()
> etc functions and call them from __apbt_read_clocksource()
> and apbt_next_event().

I'm not sure whether such changes would make the code a bit complex. From
another side, it's safe to always use relaxed version in this driver, so
is it better to switch to relaxed version no matter the code path benefit from
it or not?

PS: for the global timer related patch, I just hack code a bit to make it works
as clockevent on my platform, and I still try to think about a test case to
measure the improvement, cyclictest? Any idea is appreciated.

Thanks in advance,
Jisheng
