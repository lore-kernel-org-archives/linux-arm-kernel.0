From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Sep 2012 11:07:50 +0100
Subject: [PATCH v2 2/2] ARM: delay: add registration mechanism for delay
 timer sources
In-Reply-To: <503FFC7D.9050704@codeaurora.org>
References: <1346275524-13817-1-git-send-email-will.deacon@arm.com>
 <1346275524-13817-2-git-send-email-will.deacon@arm.com>
 <503FFC7D.9050704@codeaurora.org>
Message-ID: <20120904100750.GC2458@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 12:51:25AM +0100, Stephen Boyd wrote:
> On 8/29/2012 2:25 PM, Will Deacon wrote:
> > From: Jonathan Austin <Jonathan.Austin@arm.com>
> >
> > The current timer-based delay loop relies on the architected timer to
> > initiate the switch away from the polling-based implementation. This is
> > unfortunate for platforms without the architected timers but with a
> > suitable delay source (that is, constant frequency, always powered-up
> > and ticking as long as the CPUs are online).
> >
> > This patch introduces a registration mechanism for the delay timer
> > (which provides an unconditional read_current_timer implementation) and
> > updates the architected timer code to use the new interface.
> >
> > Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks Stephen.

> I wonder if we should print a warning and not actually switch to the
> timer based udelay if the frequency is not fast enough (< 1Mhz). Or
> people just wouldn't do that?

I don't think we need to worry about that -- we should let people decide
whether they deem their timer to be appropriate or not.

> > @@ -55,18 +62,24 @@ static void __timer_udelay(unsigned long usecs)
> >  	__timer_const_udelay(usecs * UDELAY_MULT);
> >  }
> >  
> > -void __init init_current_timer_delay(unsigned long freq)
> > +void __init register_current_timer_delay(struct delay_timer *timer)
> 
> const?

Sure. I'll send an updated patch.

> > +		pr_info("Ignoring duplicate/late registration of read_current_timer delay\n");
> 
> warn?

Nah, it's not the end of the world if this happens. We'll just fall back to
the CPU-based calibration, which isn't a problem.

Will
