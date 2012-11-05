From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2012 22:28:59 +0000
Subject: scheduler clock for MXS [Was: Re: Wakeup latency measured with
 SCHED_TRACER depends on HZ]
In-Reply-To: <5097E4A9.3090008@meduna.org>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org>
Message-ID: <20121105222859.GI28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 05:09:13PM +0100, Stanislav Meduna wrote:
> On 05.11.2012 14:46, Shawn Guo wrote:
> 
> >>> From my quick testing on imx23 with printk timestamp, it's not OK,
> >>> so we may need to leave imx23 out there.
> >>
> > I should say it's practically not OK since it wraps in such a short
> > period.  But it actually works as expected.
> > 
> >> Hmm, does it wrap after 2 seconds?
> > 
> > Yes, it does wrap after ~2 seconds.
> 
> This is weird. AFAIK the printk should be using sched_clock(),
> which is a weak symbol overridden in arch/arm/kernel/sched_clock.c
> and it should take care of the extension to never-ever-wrapping
> 64-bit timestamp. Looks that it does not and if it does not,
> I think there is more to be worried of than just printk timestamps.

It most certainly does handle the wrapping correctly - it was designed
to from the very start.

> BTW this patch deserves IMHO looking at
>   https://patchwork.kernel.org/patch/1193631/
> but it is probably not the problem here.

Yes, that patch is probably required... if an update to the sched_clock
epoch happens on a different CPU, then the epoch cycles can be in advance
of the read clock cycle value.  That needs to get into my patch system.
