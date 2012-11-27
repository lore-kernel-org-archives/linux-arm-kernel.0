From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Nov 2012 12:35:27 -0500 (EST)
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121126151534.GA13620@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
 <50B2679F.3070107@gmail.com>
 <20121126111337.GA13312@mudshark.cambridge.arm.com>
 <20121126151534.GA13620@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1211271232390.4576@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Nov 2012, Will Deacon wrote:

> On Mon, Nov 26, 2012 at 11:13:37AM +0000, Will Deacon wrote:
> > On Sun, Nov 25, 2012 at 06:46:55PM +0000, Rob Herring wrote:
> > > On 11/22/2012 05:34 AM, Will Deacon wrote:
> > > > As an aside, you also need to make the asm block volatile in
> > > > __my_cpu_offset -- I can see it being re-ordered before the set for
> > > > secondary CPUs otherwise.
> > > 
> > > I don't really see where there would be a re-ordering issue. There's no
> > > percpu var access before or near the setting that I can see.
> > 
> > The issue is on bringing up the secondary core, so I assumed that a lot
> > of inlining goes on inside secondary_start_kernel and then the result is
> > shuffled around, placing a cpu-offset read before we've done the set.
> > 
> > Unfortunately, looking at the disassembly I can't see this happening at
> > all, so I'll keep digging. The good news is that I've just reproduced the
> > problem on the model, so I've got more visibility now (although both cores
> > are just stuck in spinlocks...).
> 
> That was a fun bit of debugging -- my hunch was right, but I was looking in the
> wrong place because I had an unrelated problem with my bootloader.
> 
> What happens is that every man and his dog is inlined into __schedule,
> including all the runqueue accessors, such as this_rq(), which make use of
> per-cpu offsets to get the correct pointer. The compiler then spits out
> something like this near the start of the function:
> 
>   c02c1d66:       af04            add     r7, sp, #16
>   [...]
>   c02c1d6c:       ee1d 3f90       mrc     15, 0, r3, cr13, cr0, {4}
>   c02c1d70:       199b            adds    r3, r3, r6
>   c02c1d72:       f8c7 e008       str.w   lr, [r7, #8]
>   c02c1d76:       617b            str     r3, [r7, #20]
>   c02c1d78:       613e            str     r6, [r7, #16]
>   c02c1d7a:       60fb            str     r3, [r7, #12]
> 
> so the address of the current runqueue has been calculated and stored, with
> a bunch of other stuff, in a structure on the stack.
> 
> We then do our context_switch dance (which is also inlined) and return as
> the next task (since we've done switch_{mm,to}) before doing:
> 
> 	barrier();
> 	/*
> 	 * this_rq must be evaluated again because prev may have moved
> 	 * CPUs since it called schedule(), thus the 'rq' on its stack
> 	 * frame will be invalid.
> 	 */
> 	finish_task_switch(this_rq(), prev);
> 
> The problem here is that, because our CPU accessors don't actually make any
> memory references, the barrier() has no effect and the old value is just
> reloaded off the stack:
> 
>   c02c1f22:       f54a fe49       bl      c000cbb8 <__switch_to>
>   c02c1f26:       4601            mov     r1, r0
>   c02c1f28:       68f8            ldr     r0, [r7, #12]
>   c02c1f2a:       f56f ffd5       bl      c0031ed8 <finish_task_switch>
> 
> which obviously causes complete chaos if the new task has been pulled from
> a different runqueue! (this appears as a double spin unlock on rq->lock).
> 
> Fixing this without giving up the performance improvement we gain by *avoiding*
> the memory access in the first place is going to be tricky...

What about adding a memory constraint in the offset accessor to create a 
dependency upon which the barrier will have an effect, but without 
actually making any memory access?


Nicolas
