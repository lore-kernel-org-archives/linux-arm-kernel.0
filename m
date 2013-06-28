From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 28 Jun 2013 16:02:23 +0200 (CEST)
Subject: [linux-sunxi] [PATCH 0/8] clocksource: sunxi: Timer fixes
 and cleanup
In-Reply-To: <2013062809433715678058@allwinnertech.com>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <51CC0566.8010302@redhat.com> <20130627094307.GC8437@lukather>
 <51CC0BC3.5090309@redhat.com> <20130627165436.GB4319@lukather>,
 <20130627232608.1174558b@i7>
 <2013062809433715678058@allwinnertech.com>
Message-ID: <alpine.DEB.2.02.1306281559490.4013@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Jun 2013, ?? wrote:
> > The A10 manual from http://free-electrons.com/~maxime/pub/datasheet/
> > does not seem to contain any details about what bad things may happen
> > if we try to read CNT64_LO_REG while latching is still in progress and
> > CNT64_RL_EN bit in CNT64_CTRL_REG has not changed to zero yet.
> > I can imagine the following possible scenarios:
> >  1. We read either the old stale CNT64_LO_REG value or the new
> >     correct value.
> >  2. We read either the old stale CNT64_LO_REG value or the new
> >     correct value, or some random garbage.
> >  3. The processor may deadlock, eat your dog, or do some other
> >     nasty thing.
> >
> > In the case of 1, we probably can get away without using any spinlocks?
> 
> About the 64bits counter, the latch bit is needed because of the asynchronous circuit.
> The internal circuit of 64bits counter is working under 24Mhz clock, and CNT_LO/HI
> is read with APB clock. So the clock synchronize is needed. The function of the latch
> is synchronous the 64bits counter from 24Mhz clock domain to APB clock domain.
> So, if the latch is not completely, value of the CNT_LO/HI maybe a random value, because
> some bits are latched, but others are not. So, the CNT_LO/HI should be read after
> latch is completely.
> The latch just takes 3 cycles of 24Mhz clock, the time is nearly 0.125 micro-second.
> 

I really wonder why we're trying to use that timer. AFAICT the A10 has
another six 32bit timers which do not have this restriction and the
clocksoure/sched_clock implementation works nicely with 32 bits. So
what's the point of using that 64 bit counter if it's horrible to
access?

Thanks,

	tglx
