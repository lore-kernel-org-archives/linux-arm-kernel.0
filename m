From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 29 May 2011 13:01:58 +0100
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <20110529102659.GY24876@n2100.arm.linux.org.uk>
References: <1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526122623.GA11875@elte.hu>
	<20110526123137.GG24876@n2100.arm.linux.org.uk>
	<20110526125007.GA27083@elte.hu>
	<BANLkTinUZ7EwN_nBCi_RQ9u8-LBcr_A74g@mail.gmail.com>
	<20110527120629.GA32617@elte.hu>
	<20110527205240.GT24876@n2100.arm.linux.org.uk>
	<20110529102119.GC9489@e102109-lin.cambridge.arm.com>
	<20110529102659.GY24876@n2100.arm.linux.org.uk>
Message-ID: <BANLkTin-5+jE6U-3RrPjPiFVRMGNhvwVEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, 29 May 2011, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Sun, May 29, 2011 at 11:21:19AM +0100, Catalin Marinas wrote:
>> To avoid extra per-thread flags, we could set a per-cpu variable in
>> switch_mm() so that we know what to switch the page tables to in the
>> post-switch hook.
>
> Why do we need to add more per-cpu stuff when we already have easy access
> to the thread flags?

It could work, I was thinking that we only get an mm structure in the
post-switch hook.

BTW, we currently have a per-cpu current_mm variable in context.c
because switch_mm() is called before switch_to() and the CPU may
receive an IPI to reset the ASID in this interval. But we can remove
it entirely if we set the ASID in the post-switch hook and run the
main switch code with interrupts disabled.


-- 
Catalin
