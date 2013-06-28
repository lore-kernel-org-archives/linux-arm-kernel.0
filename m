From: maxime.ripard@free-electrons.com (maxime.ripard)
Date: Fri, 28 Jun 2013 19:03:01 +0200
Subject: [linux-sunxi] [PATCH 0/8] clocksource: sunxi: Timer fixes
 and cleanup
In-Reply-To: <alpine.DEB.2.02.1306281559490.4013@ionos.tec.linutronix.de>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <51CC0566.8010302@redhat.com> <20130627094307.GC8437@lukather>
 <51CC0BC3.5090309@redhat.com> <20130627165436.GB4319@lukather>
 <20130627232608.1174558b@i7>
 <2013062809433715678058@allwinnertech.com>
 <alpine.DEB.2.02.1306281559490.4013@ionos.tec.linutronix.de>
Message-ID: <20130628170301.GN4319@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Jun 28, 2013 at 04:02:23PM +0200, Thomas Gleixner wrote:
> On Fri, 28 Jun 2013, ?? wrote:
> > > The A10 manual from http://free-electrons.com/~maxime/pub/datasheet/
> > > does not seem to contain any details about what bad things may happen
> > > if we try to read CNT64_LO_REG while latching is still in progress and
> > > CNT64_RL_EN bit in CNT64_CTRL_REG has not changed to zero yet.
> > > I can imagine the following possible scenarios:
> > >  1. We read either the old stale CNT64_LO_REG value or the new
> > >     correct value.
> > >  2. We read either the old stale CNT64_LO_REG value or the new
> > >     correct value, or some random garbage.
> > >  3. The processor may deadlock, eat your dog, or do some other
> > >     nasty thing.
> > >
> > > In the case of 1, we probably can get away without using any spinlocks?
> > 
> > About the 64bits counter, the latch bit is needed because of the asynchronous circuit.
> > The internal circuit of 64bits counter is working under 24Mhz clock, and CNT_LO/HI
> > is read with APB clock. So the clock synchronize is needed. The function of the latch
> > is synchronous the 64bits counter from 24Mhz clock domain to APB clock domain.
> > So, if the latch is not completely, value of the CNT_LO/HI maybe a random value, because
> > some bits are latched, but others are not. So, the CNT_LO/HI should be read after
> > latch is completely.
> > The latch just takes 3 cycles of 24Mhz clock, the time is nearly 0.125 micro-second.
> > 
> 
> I really wonder why we're trying to use that timer. AFAICT the A10 has
> another six 32bit timers which do not have this restriction and the
> clocksoure/sched_clock implementation works nicely with 32 bits. So
> what's the point of using that 64 bit counter if it's horrible to
> access?

Yes, you're right. I actually wanted at first not to use a timer for
this since we had a counter to do just that.

But that's true that actually using a timer would make the code simpler
and presumably faster as well.

I'll change this in the v2.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/3705a440/attachment.sig>
