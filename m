From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 27 Feb 2012 17:56:46 +0800
Subject: [PATCH 3/4] ARM: perf: check that we have an event in the PMU
 IRQ handlers
In-Reply-To: <20120224101130.GB13504@mudshark.cambridge.arm.com>
References: <1330012696-13472-1-git-send-email-will.deacon@arm.com>
 <1330012696-13472-4-git-send-email-will.deacon@arm.com>
 <CACVXFVM6HOMeJCMznLqO6-jMT8owoK65Ap6c_CNCJbwWxphCBA@mail.gmail.com>
 <20120224101130.GB13504@mudshark.cambridge.arm.com>
Message-ID: <20120227175646.7c39e542@tom-ThinkPad-T410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 24 Feb 2012 10:11:30 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Fri, Feb 24, 2012 at 01:34:32AM +0000, Ming Lei wrote:
> > On Thu, Feb 23, 2012 at 11:58 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > @@ -513,7 +496,8 @@ armv6pmu_handle_irq(int irq_num,
> > > ? ? ? ? ? ? ? ?struct perf_event *event = cpuc->events[idx];
> > > ? ? ? ? ? ? ? ?struct hw_perf_event *hwc;
> > >
> > > - ? ? ? ? ? ? ? if (!counter_is_active(pmcr, idx))
> > > + ? ? ? ? ? ? ? /* Ignore if we don't have an event. */
> > > + ? ? ? ? ? ? ? if (!event)
> > 
> > I think we should check it via test_bit(idx, cpuc->used_mask) because
> > 'hw_events->events[idx] = val' is not atomic operation and it is read here
> > in irq context.
> 
> I dunno, that code is compiled to:
> 
> e5973000        ldr     r3, [r7]
> e7834106        str     r4, [r3, r6, lsl #2]
> 
> so you should either see the new value or the old one - you can't see half a
> pointer in there since it's a single 32-bit store.

Firstly the code above is only generated from one of many existing compile
options, for example, maybe storing to 32bit variable involves two instructions
in thumb mode, so are you sure it is always OK for all cases?

Secondly, I am even not sure if ARM irq handler is always triggered in instruction
boundary, maybe the irq handler is started during execution of the store instruction.
In fact, I can find the sentence below in 'B1.6.16 IRQ exception' of ARMv7 manual:

	This relaxation of the normal definition of a precise asynchronous exception
	permits interrupts to occur during the execution of instructions that change register
	or memory values, while only requiring the implementation to restore those register
	values that are needed to correctly re-execute the instruction after the preferred
	exception return. LDM and STM are examples of such instructions.

So suggest to take the correct way in theory, IMO.

thanks,
-- 
Ming Lei
