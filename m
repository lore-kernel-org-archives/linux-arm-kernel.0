From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 08 Jul 2010 08:42:05 -0400 (EDT)
Subject: [PATCH 3/4] ARM: atomic ops: add memory constraints to inline asm
In-Reply-To: <004b01cb1e81$0b745960$225d0c20$%deacon@arm.com>
References: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
	<1277906688-12065-2-git-send-email-will.deacon@arm.com>
	<1277906688-12065-3-git-send-email-will.deacon@arm.com>
	<1277906688-12065-4-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1007080109590.6020@xanadu.home>
	<004b01cb1e81$0b745960$225d0c20$%deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1007080830210.6020@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Jul 2010, Will Deacon wrote:

> Hi Nicolas,
> 
> > > Currently, the 32-bit and 64-bit atomic operations on ARM do not
> > > include memory constraints in the inline assembly blocks. In the
> > > case of barrier-less operations [for example, atomic_add], this
> > > means that the compiler may constant fold values which have actually
> > > been modified by a call to an atomic operation.
> 
> Thanks a lot for looking at this.
> 
> > Why do you use the "o" constraint?  That's for an offsetable
> > memory reference.  Since we already use the actual address value with a
> > register constraint, it would be more logical to simply use the "Q"
> > constraint alone without any "o".  The gcc manual says:
> > 
> > |    `Q'
> > |          A memory reference where the exact address is in a single
> > |          register
> > 
> > Both "Qo" and "Q" provide the same wanted end result in this
> > case.  But a quick test shows that "Q" produces exactly what we need,
> > more so than "Qo", because of the other operand which is the actual
> > address (the same register is used in both cases).
> 
> Whilst using "Q" on its own does generate correct code, using "Qo" is
> a slight optimisation. The issue with "Q" is that GCC computes the address
> again, even though it has already done so for the "r" constraint. Ideally,
> we'd ditch the "r" constraint and just use "Q", but unfortunately this results
> in code like ldrex r0, [r1, #0] which GAS refuses to accept. If we use "o",
> then GCC doesn't compute the address twice, but can fail if it ends up with
> a non-offsettable address (complaining that the constraints are impossible
> to satisfy). Using "Qo" results in "o" being used if possible but, where
> it doesn't match, "Q" is used at the expense of an extra register:
> 
> With "Q":
> 
>  740:   f57ff05f        dmb     sy
>  744:   e30f4001        movw    r4, #61441      ; 0xf001
>  748:   e30a5bad        movw    r5, #43949      ; 0xabad
>  74c:   e34f400d        movt    r4, #61453      ; 0xf00d
>  750:   e34f5ace        movt    r5, #64206      ; 0xface
>  754:   e24be034        sub     lr, fp, #52     ; 0x34    <--- Redundant address computation
>  758:   e3a02000        mov     r2, #0
>  75c:   e1b36f9f        ldrexd  r6, [r3]
>  760:   e1360004        teq     r6, r4
>  764:   01370005        teqeq   r7, r5
>  768:   01a32f90        strexdeq        r2, r0, [r3]
>  76c:   e3520000        cmp     r2, #0
>  770:   1afffff7        bne     754 <test_atomic64+0x754>
>  774:   f57ff05f        dmb     sy

That's weird.  The simple test I did was:

int foo(int *x)
{
        int r;
        asm("%1 %2" : "=&r" (r), "+Q" (x[2]) : "r" (&x[2]));
        return r;
}

which resulted in:

        add     r0, r0, #8
#APP
@ 4 "t.c" 1
        [r0, #0] r0
@ 0 "" 2
        mov     r0, r1
        bx      lr

So the address is clearly computed only once.

> > In any case:
> > 
> > Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> Thanks, I'll submit this to the patch system today.

Nicolas
