From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 May 2011 15:45:39 +0100
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <20110526125007.GA27083@elte.hu>
References: <1306272750.2497.79.camel@laptop> <1306343335.21578.65.camel@twins>
	<1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526122623.GA11875@elte.hu>
	<20110526123137.GG24876@n2100.arm.linux.org.uk>
	<20110526125007.GA27083@elte.hu>
Message-ID: <BANLkTinUZ7EwN_nBCi_RQ9u8-LBcr_A74g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 May 2011 13:50, Ingo Molnar <mingo@elte.hu> wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>
>> On Thu, May 26, 2011 at 02:26:23PM +0200, Ingo Molnar wrote:
>> >
>> > * Peter Zijlstra <peterz@infradead.org> wrote:
>> >
>> > > Sort this by reverting to the old behaviour for this situation
>> > > and perform a full remote wake-up.
>> >
>> > Btw., ARM should consider switching most of its subarchitectures
>> > to !__ARCH_WANT_INTERRUPTS_ON_CTXSW - enabling irqs during
>> > context switches is silly and now expensive as well.
>>
>> Not going to happen. ?The reason we do it is because most of the
>> CPUs have to (slowly) flush their caches during switch_mm(), and to
>> have IRQs off over the cache flush means that we lose IRQs.
>
> How much time does that take on contemporary ARM hardware, typically
> (and worst-case)?

On newer ARMv6 and ARMv7 hardware, we no longer flush the caches at
context switch as we got VIPT (or PIPT-like) caches.

But modern ARM processors use something called ASID to tag the TLB
entries and we are limited to 256. The switch_mm() code checks for
whether we ran out of them to restart the counting. This ASID
roll-over event needs to be broadcast to the other CPUs and issuing
IPIs with the IRQs disabled isn't always safe. Of course, we could
briefly re-enable them at the ASID roll-over time but I'm not sure
what the expectations of the code calling switch_mm() are.

-- 
Catalin
