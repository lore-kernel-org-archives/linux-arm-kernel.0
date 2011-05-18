From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Wed, 18 May 2011 16:25:15 +0100 (BST)
Subject: Question on ARM inline assembly - stackframes, sp/fp usage,
 __naked
Message-ID: <alpine.DEB.2.00.1105181505080.2374@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


with the work on the hibernation support code, I've managed to make it all 
C-with-inline-asm. This happens to work fine on OMAP3, but there's an 
issue when I build it for Samsung 64xx. It's about this code:


int __naked swsusp_arch_resume(void)
{
 	register struct pbe *pbe;
 	register void *sp asm("sp") = swsusp_resume_stack + PAGE_SIZE - 8;
 	register void *saved_ctx asm ("r0") = ctx;

 	__asm__ __volatile__("" : "+sp"(sp));		/* don't optimize away ! */

 	for (pbe = restore_pblist; pbe; pbe = pbe->next)
 		copy_page(pbe->orig_address, pbe->address);

 	__asm__ __volatile__(
 		"mov	r1, #" __stringify(SYSTEM_MODE) "\n\t"
 		"msr	cpsr_c, r1\n\t"
 		"ldr	r1, [r0], #4\n\t"
 		"msr	cpsr_cxsf, r1\n\t"
 		"ldm	r0!, {r4-r12,lr}\n\t"
 		"ldr	sp, [r0], #4\n\t"
 		"mov	r2, #" __stringify(SVC_MODE) "\n\t"
 		"msr	cpsr_c, r2\n\t"
 		"ldm	r0!, {r2, lr}\n\t"
 		"ldr	sp, [r0], #4\n\t"
 		"msr	spsr_cxsf, r2\n\t"
 		"msr	cpsr, r1\n\t"
 		"mov	r1, #0\n\t"
 		"push	{r1, lr}\n\t"
 		"bl	__restore_processor_state\n\t"
 		"pop	{r0, pc}\n\t"
 		: "+r"(saved_ctx)
 		:
 		: "memory", "cc",
 		"r1", "r2", "r3", "r4", "r5", "r6", "r7",
 		"r8", "r9", "r10", "ip", "fp" "sp", "lr", "pc");

 	return 0;
}


This has the special requirement to run on a separate stack, because the 
copy loop will blot over whatever there is. Clobbering everything is part 
of the design/intent.



On OMAP (where I compile _without_ CONFIG_FTRACE, but even when 
switching it on there's no change), this creates the following assembly, 
which is ok:

00005bb0 <swsusp_arch_resume>:
     5bb0:       e59fd074        ldr     sp, [pc, #116]  ; 5c2c <swsusp_arch_resume+0x7c>
     5bb4:       e3003000        movw    r3, #0  ; 0x0
     5bb8:       e3403000        movt    r3, #0  ; 0x0
     5bbc:       e5934000        ldr     r4, [r3]
     5bc0:       e3540000        cmp     r4, #0  ; 0x0
     5bc4:       0a000005        beq     5be0 <swsusp_arch_resume+0x30>
     5bc8:       e5940004        ldr     r0, [r4, #4]
     5bcc:       e5941000        ldr     r1, [r4]
     5bd0:       ebfffffe        bl      162b80 <copy_page>
     5bd4:       e5944008        ldr     r4, [r4, #8]
     5bd8:       e3540000        cmp     r4, #0  ; 0x0
     5bdc:       1afffff9        bne     5bc8 <swsusp_arch_resume+0x18>
     5be0:       e3000000        movw    r0, #0  ; 0x0
     5be4:       e3400000        movt    r0, #0  ; 0x0
     5be8:       e3a0101f        mov     r1, #31 ; 0x1f
     5bec:       e121f001        msr     CPSR_c, r1
[ ... inline as above follows ... ]
     5c1c:       e92d4002        push    {r1, lr}
     5c20:       ebfffffe        bl      1538c <__restore_processor_state>
     5c24:       e8bd8001        pop     {r0, pc}
     5c28:       e3a00000        mov     r0, #0  ; 0x0
     5c2c:       00000ff8        .word   0x00000ff8

Notice how the for() loop has been coded into using R4.



When I build it for S5P64xx though (where we have CONFIG_FTRACE, but see 
below), I get a compile error (same gcc, just different kernel defconfig 
target, ARM11xx instead of Cortex-A8):

arch/arm/kernel/hibernate.c: In function 'swsusp_arch_resume':
arch/arm/kernel/hibernate.c:136: error: fp cannot be used in asm here

That's the '}' of the function. Strange enough ... the compiler wants to 
do something with FP and isn't willing to give that up.


If I take "fp" out of the clobber list then it compiles.

But the generated assembly code is incorrect:

0000757c <swsusp_arch_resume>:
     757c:       e59fd078        ldr     sp, [pc, #120]  ; 75fc <swsusp_arch_resume+0x80>
     7580:       e59f3078        ldr     r3, [pc, #120]  ; 7600 <swsusp_arch_resume+0x84>
     7584:       e5933000        ldr     r3, [r3]
     7588:       ea000005        b       75a4 <swsusp_arch_resume+0x28>
     758c:       e59b3000        ldr     r3, [fp]
     7590:       e5930004        ldr     r0, [r3, #4]
     7594:       e5931000        ldr     r1, [r3]
     7598:       ebfffffe        bl      1647a0 <copy_page>
     759c:       e59b3000        ldr     r3, [fp]
     75a0:       e5933008        ldr     r3, [r3, #8]
     75a4:       e58b3000        str     r3, [fp]
     75a8:       e59b3000        ldr     r3, [fp]
     75ac:       e3530000        cmp     r3, #0  ; 0x0
     75b0:       1afffff5        bne     758c <swsusp_arch_resume+0x10>
     75b4:       e59f0048        ldr     r0, [pc, #72]   ; 7604 <swsusp_arch_resume+0x88>
     75b8:       e3a0101f        mov     r1, #31 ; 0x1f
     75bc:       e121f001        msr     CPSR_c, r1
[ ... inline as above follows ... ]
     75ec:       e92d4002        push    {r1, lr}
     75f0:       ebfffffe        bl      dc58 <__restore_processor_state>
     75f4:       e8bd8001        pop     {r0, pc}
     75f8:       e59b0000        ldr     r0, [fp]
     75fc:       00000ff8        .word   0x00000ff8
     7600:       00000000        .word   0x00000000
     7604:       00002000        .word   0x00002000


This assumes FP is set up so that the local variable held in R3 (that the 
OMAP compile stuffs into R4) can be stored there, to preserve over the 
function call.

Adding a register asm("r4") to the variable declaration changes nothing, 
it still insists on saving it to/from the stack via [fp].


Now this means there's something wrong here; either it's lucky that my 
compiler creates the OMAP (armv7) code that it does and the 6450 (armv6) 
is actually correct in assuming this reg/mem location is available/usable 
for it.

Or there's a problem with the ARM11xx / armv6 code generation.


I'm tending towards believing that the OMAP result is luck, and to make 
sure the stack switch fools the entire ABI convention into working the 
stackframe setup needs to initialize more than just SP.


I can hack around the issue by explicitly initializing FP via:

         __asm__ __volatile__("add fp, %0, #4\n\t" : "+sp"(sp));

instead, but that's sneaky in the sense that I'm not telling the compiler 
I've done so (adding "fp" to the clobber fails compile again). Also, while 
this specific incantation uses one word, how can I be sure that that'll be 
it and no other gcc version will pull more [fp] usage out of some hat ?

Note that while GCC chose to use [fp], it hasn't actually put proper 
offsets in; it uses the same [fp] for both 'pbe' and the zero return 
value; that's definitely not ok, but again is an artifact of the __naked.



Another option I've found is:

int __naked swsusp_arch_resume(void)
{
         register void *sp asm("sp") = swsusp_resume_stack + PAGE_SIZE - 8;
         __asm__ __volatile__("" : "+sp"(sp));

         return resume_internal();
}

and make resume_internal() the actual function, non-naked; this creates a 
normal prologue which sets up FP. resume_internal() cannot be made static, 
though, or else the compiler inlines it - without the prologues, and it's 
back to #1^2.



Re, the use of CONFIG_FTRACE: Just switching that off on S5P6450 results 
in using [sp #4] instead of [fp]. Still incorrect code (albeit it works 
out of the box), and still not possible to put "fp" into the clobber list.




I am wondering if there's a way to convince gcc to do the right thing 
here, __naked notwithstanding.

Is the use of a naked "bounce function" for this specific purpose (switch 
the stackpointer) acceptable, and guaranteed to create the correct code ?


It'd be nice not having to dump this piece into assembly...



Thanks for any ideas !
FrankH.
