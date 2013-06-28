From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Fri, 28 Jun 2013 14:14:12 +0300
Subject: [linux-sunxi] [PATCH 0/8] clocksource: sunxi: Timer fixes and
 cleanup
In-Reply-To: <alpine.DEB.2.02.1306281211330.4013@ionos.tec.linutronix.de>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <51CC0566.8010302@redhat.com> <20130627094307.GC8437@lukather>
 <51CC0BC3.5090309@redhat.com> <20130627165436.GB4319@lukather>
 <20130627232608.1174558b@i7>
 <2013062809433715678058@allwinnertech.com>
 <20130628124843.242df804@i7>
 <alpine.DEB.2.02.1306281211330.4013@ionos.tec.linutronix.de>
Message-ID: <20130628141412.2bf3f68f@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Jun 2013 12:26:10 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 28 Jun 2013, Siarhei Siamashka wrote:
> > On Fri, 28 Jun 2013 09:43:37 +0800
> > ?? <kevin@allwinnertech.com> wrote:
> > 
> > > > The A10 manual from http://free-electrons.com/~maxime/pub/datasheet/
> > > > does not seem to contain any details about what bad things may happen
> > > > if we try to read CNT64_LO_REG while latching is still in progress and
> > > > CNT64_RL_EN bit in CNT64_CTRL_REG has not changed to zero yet.
> > > > I can imagine the following possible scenarios:
> > > >  1. We read either the old stale CNT64_LO_REG value or the new
> > > >     correct value.
> > > >  2. We read either the old stale CNT64_LO_REG value or the new
> > > >     correct value, or some random garbage.
> > > >  3. The processor may deadlock, eat your dog, or do some other
> > > >     nasty thing.
> > > >
> > > > In the case of 1, we probably can get away without using any spinlocks?
> > > 
> > > About the 64bits counter, the latch bit is needed because of the
> > > asynchronous circuit. The internal circuit of 64bits counter is
> > > working under 24Mhz clock, and CNT_LO/HI is read with APB clock.
> > > So the clock synchronize is needed. The function of the latch is
> > > synchronous the 64bits counter from 24Mhz clock domain to APB clock
> > > domain. So, if the latch is not completely, value of the CNT_LO/HI
> > > maybe a random value, because some bits are latched, but others are
> > > not. So, the CNT_LO/HI should be read after latch is completely.
> > > The latch just takes 3 cycles of 24Mhz clock, the time is nearly
> > > 0.125 micro-second.
> > 
> > Thanks for the clarification! It is very much appreciated.
> > 
> > So basically we get scenario 2, which still allows some optimizations
> > compared to scenario 3. On single-core systems (Allwinner A10), it
> > probably makes sense to avoid spinlocks overhead and just place
> 
> Spinlocks are NOPs on UP and just disable preemption, but they
> provide you the same ordering guarantees as spinlocks on SMP. So no
> special case optimization necessary.

Still I would not want some high priority and latency sensitive junk
(such as pulseaudio for example) not to get scheduled at the right
time because of some low priority gettimeofday spammer application.
The time spent latching and reading these counters is non negligible.

Though I agree Maxime that first we need an initial implementation,
which just works safely. And then we can optimize it by testing real
use cases and providing the relevant benchmark numbers. Knowing the
precise details about the hardware helps.

But enough bikeshedding, it's time for me to shut up :)

-- 
Best regards,
Siarhei Siamashka
