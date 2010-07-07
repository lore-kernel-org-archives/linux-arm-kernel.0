From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jul 2010 17:42:09 +0100
Subject: [PATCH 3/4] ARM: atomic ops: add memory constraints to inline asm
In-Reply-To: <1277906688-12065-4-git-send-email-will.deacon@arm.com>
References: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
	<1277906688-12065-2-git-send-email-will.deacon@arm.com>
	<1277906688-12065-3-git-send-email-will.deacon@arm.com>
	<1277906688-12065-4-git-send-email-will.deacon@arm.com>
Message-ID: <004101cb1df3$5825ecd0$0871c670$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> Subject: [PATCH 3/4] ARM: atomic ops: add memory constraints to inline asm
> 
> Currently, the 32-bit and 64-bit atomic operations on ARM do not
> include memory constraints in the inline assembly blocks. In the
> case of barrier-less operations [for example, atomic_add], this
> means that the compiler may constant fold values which have actually
> been modified by a call to an atomic operation.
> 
> This issue can be observed in the atomic64_test routine in
> <kernel root>/lib/atomic64_test.c:
> 
> 00000000 <test_atomic64>:
>    0:	e1a0c00d 	mov	ip, sp
>    4:	e92dd830 	push	{r4, r5, fp, ip, lr, pc}
>    8:	e24cb004 	sub	fp, ip, #4
>    c:	e24dd008 	sub	sp, sp, #8
>   10:	e24b3014 	sub	r3, fp, #20
>   14:	e30d000d 	movw	r0, #53261	; 0xd00d
>   18:	e3011337 	movw	r1, #4919	; 0x1337
>   1c:	e34c0001 	movt	r0, #49153	; 0xc001
>   20:	e34a1aa3 	movt	r1, #43683	; 0xaaa3
>   24:	e16300f8 	strd	r0, [r3, #-8]!
>   28:	e30c0afe 	movw	r0, #51966	; 0xcafe
>   2c:	e30b1eef 	movw	r1, #48879	; 0xbeef
>   30:	e34d0eaf 	movt	r0, #57007	; 0xdeaf
>   34:	e34d1ead 	movt	r1, #57005	; 0xdead
>   38:	e1b34f9f 	ldrexd	r4, [r3]
>   3c:	e1a34f90 	strexd	r4, r0, [r3]
>   40:	e3340000 	teq	r4, #0
>   44:	1afffffb 	bne	38 <test_atomic64+0x38>
>   48:	e59f0004 	ldr	r0, [pc, #4]	; 54 <test_atomic64+0x54>
>   4c:	e3a0101e 	mov	r1, #30
>   50:	ebfffffe 	bl	0 <__bug>
>   54:	00000000 	.word	0x00000000
> 
> The atomic64_set (0x38-0x44) writes to the atomic64_t, but the
> compiler doesn't see this, assumes the test condition is always
> false and generates an unconditional branch to __bug. The rest of the
> test is optimised away.
> 
> This patch adds suitable memory constraints to the atomic operations on ARM
> to ensure that the compiler is informed of the correct data hazards. We have
> to use the "Qo" constraints to avoid hitting the GCC anomaly described at
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=44492 , where the compiler
> makes assumptions about the writeback in the addressing mode used by the
> inline assembly. These constraints forbid the use of auto{inc,dec} addressing
> modes, so it doesn't matter if we don't use the operand exactly once.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Does anybody have any feedback on this patch? The other three in the
series are straightforward, but I'd like another set of eyes to go over this
code [I know it makes for tough reading!] before submitted to the patch
system.

Any comments appreciated!

Cheers,

Will
