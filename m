From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Jul 2010 10:36:29 +0100
Subject: [PATCH 3/4] ARM: atomic ops: add memory constraints to inline asm
In-Reply-To: <alpine.LFD.2.00.1007080109590.6020@xanadu.home>
References: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
	<1277906688-12065-2-git-send-email-will.deacon@arm.com>
	<1277906688-12065-3-git-send-email-will.deacon@arm.com>
	<1277906688-12065-4-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1007080109590.6020@xanadu.home>
Message-ID: <004b01cb1e81$0b745960$225d0c20$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> > Currently, the 32-bit and 64-bit atomic operations on ARM do not
> > include memory constraints in the inline assembly blocks. In the
> > case of barrier-less operations [for example, atomic_add], this
> > means that the compiler may constant fold values which have actually
> > been modified by a call to an atomic operation.

Thanks a lot for looking at this.

> Why do you use the "o" constraint?  That's for an offsetable
> memory reference.  Since we already use the actual address value with a
> register constraint, it would be more logical to simply use the "Q"
> constraint alone without any "o".  The gcc manual says:
> 
> |    `Q'
> |          A memory reference where the exact address is in a single
> |          register
> 
> Both "Qo" and "Q" provide the same wanted end result in this
> case.  But a quick test shows that "Q" produces exactly what we need,
> more so than "Qo", because of the other operand which is the actual
> address (the same register is used in both cases).

Whilst using "Q" on its own does generate correct code, using "Qo" is
a slight optimisation. The issue with "Q" is that GCC computes the address
again, even though it has already done so for the "r" constraint. Ideally,
we'd ditch the "r" constraint and just use "Q", but unfortunately this results
in code like ldrex r0, [r1, #0] which GAS refuses to accept. If we use "o",
then GCC doesn't compute the address twice, but can fail if it ends up with
a non-offsettable address (complaining that the constraints are impossible
to satisfy). Using "Qo" results in "o" being used if possible but, where
it doesn't match, "Q" is used at the expense of an extra register:

With "Q":

 740:   f57ff05f        dmb     sy
 744:   e30f4001        movw    r4, #61441      ; 0xf001
 748:   e30a5bad        movw    r5, #43949      ; 0xabad
 74c:   e34f400d        movt    r4, #61453      ; 0xf00d
 750:   e34f5ace        movt    r5, #64206      ; 0xface
 754:   e24be034        sub     lr, fp, #52     ; 0x34    <--- Redundant address computation
 758:   e3a02000        mov     r2, #0
 75c:   e1b36f9f        ldrexd  r6, [r3]
 760:   e1360004        teq     r6, r4
 764:   01370005        teqeq   r7, r5
 768:   01a32f90        strexdeq        r2, r0, [r3]
 76c:   e3520000        cmp     r2, #0
 770:   1afffff7        bne     754 <test_atomic64+0x754>
 774:   f57ff05f        dmb     sy

With "Qo":

 6f4:   f57ff05f        dmb     sy
 6f8:   e30f4001        movw    r4, #61441      ; 0xf001
 6fc:   e30a5bad        movw    r5, #43949      ; 0xabad
 700:   e34f400d        movt    r4, #61453      ; 0xf00d
 704:   e34f5ace        movt    r5, #64206      ; 0xface
 708:   e3a02000        mov     r2, #0
 70c:   e1b36f9f        ldrexd  r6, [r3]
 710:   e1360004        teq     r6, r4
 714:   01370005        teqeq   r7, r5
 718:   01a32f90        strexdeq        r2, r0, [r3]
 71c:   e3520000        cmp     r2, #0
 720:   1afffff8        bne     708 <test_atomic64+0x708>
 724:   f57ff05f        dmb     sy
 
> In any case:
> 
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks, I'll submit this to the patch system today.

> Also, I'm assuming that such a constraint should be added to the 32 bit
> versions too for the same correctness reason?

That's right. The patch updates the 32-bit variants as well as the
64-bit ones.

Cheers,

Will
