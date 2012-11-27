From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2012 13:17:42 +0000
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <50B3A74F.20602@gmail.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
 <50B2679F.3070107@gmail.com>
 <20121126111337.GA13312@mudshark.cambridge.arm.com>
 <20121126151534.GA13620@mudshark.cambridge.arm.com>
 <50B3A74F.20602@gmail.com>
Message-ID: <20121127131742.GB16122@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 05:30:55PM +0000, Rob Herring wrote:
> On 11/26/2012 09:15 AM, Will Deacon wrote:
> > The problem here is that, because our CPU accessors don't actually make any
> > memory references, the barrier() has no effect and the old value is just
> > reloaded off the stack:
> > 
> >   c02c1f22:       f54a fe49       bl      c000cbb8 <__switch_to>
> >   c02c1f26:       4601            mov     r1, r0
> >   c02c1f28:       68f8            ldr     r0, [r7, #12]
> >   c02c1f2a:       f56f ffd5       bl      c0031ed8 <finish_task_switch>
> > 
> > which obviously causes complete chaos if the new task has been pulled from
> > a different runqueue! (this appears as a double spin unlock on rq->lock).
> > 
> > Fixing this without giving up the performance improvement we gain by *avoiding*
> > the memory access in the first place is going to be tricky...
> 
> What compiler and config are you using? I get a reload of the register here:
> 
> c0350fba:       f001 fa9d       bl      c03524f8 <__switch_to>
> c0350fbe:       4601            mov     r1, r0
> c0350fc0:       ee1d 0f90       mrc     15, 0, r0, cr13, cr0, {4}
> c0350fc4:       4c2a            ldr     r4, [pc, #168]  ; (c0351070
> <__schedule+0x390>)
> c0350fc6:       f649 1590       movw    r5, #39312      ; 0x9990
> c0350fca:       1900            adds    r0, r0, r4
> c0350fcc:       f2cc 0556       movt    r5, #49238      ; 0xc056
> c0350fd0:       f4e7 fd56       bl      c0038a80 <finish_task_switch>

I tried both Linaro 12.07 and 12.10 GCC builds, although the problem would
only occur if I did a make clean and then a fresh build on top of that.
Just building the relavant object files didn't seem to tickle the problem.

I can mail you my .config if you like?

Will
