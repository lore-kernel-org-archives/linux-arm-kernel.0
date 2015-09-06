From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 06 Sep 2015 23:31:34 +0200
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <20150906194805.GP21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Sun, 6 Sep 2015 20:48:06 +0100")
References: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
 <20150902103955.GF6281@e103592.cambridge.arm.com>
 <878u8lx9hl.fsf@belgarion.home>
 <20150905142519.GN21084@n2100.arm.linux.org.uk>
 <87y4gkx04m.fsf@belgarion.home>
 <20150905203818.GO21084@n2100.arm.linux.org.uk>
 <87lhcjwjde.fsf@belgarion.home>
 <20150906194805.GP21084@n2100.arm.linux.org.uk>
Message-ID: <87egibw7yh.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> [1] Approach 1 : translation table sync
>> =======================================
...
> The important place is in arch/arm/include/asm/domain.h, which is where
> we manipulate the DACR within probe_kernel_address().

Gah, silly me. But even with [1], I still get an error [2]. I have a
confirmation that I have a "Page Permission" fault on the
probe_kernel_address().

Next thing I'll check is if I can read the TLB cache for the code entry. It's a
very instructive bug for me :)

Cheers.

-- 
Robert

[1] Approach 1 : translation table sync + PrefetchFlush
=======================================================
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 7bbf325a4f31..73d5ad456e32 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -449,6 +449,13 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+	.macro	dacr_sync, rd
+	mrc     p15, 0, \rd, c2, c0, 0
+	mov     \rd, \rd
+	sub     pc, pc, #4
+	mcr     p15, 0, \rd, c7, c5, 4
+	.endm
+
 	.macro	uaccess_disable, tmp, isb=1
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/*
@@ -457,6 +464,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	 */
 	mov	\tmp, #DACR_UACCESS_DISABLE
 	mcr	p15, 0, \tmp, c3, c0, 0		@ Set domain register
+	dacr_sync \tmp
 	.if	\isb
 	instr_sync
 	.endif
@@ -471,6 +479,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	 */
 	mov	\tmp, #DACR_UACCESS_ENABLE
 	mcr	p15, 0, \tmp, c3, c0, 0
+	dacr_sync \tmp
 	.if	\isb
 	instr_sync
 	.endif
@@ -488,6 +497,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	ldr	r0, [sp, #S_FRAME_SIZE]
 	mcr	p15, 0, r0, c3, c0, 0
+	dacr_sync r0
 #endif
 	.endm
 
diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index e878129f2fee..10c9a38636ac 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -97,7 +97,11 @@ static inline unsigned int get_domain(void)
 static inline void set_domain(unsigned val)
 {
 	asm volatile(
-	"mcr	p15, 0, %0, c3, c0	@ set domain"
+	"mcr	p15, 0, %0, c3, c0;	@ set domain	\
+	mrc	p15, 0, %0, c2, c0, 0;			\
+	mov	%0, %0;					\
+	sub	pc, pc, #4;				\
+	mcr     p15, 0, %0, c7, c5, 4"
 	  : : "r" (val));
 	isb();
 }
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 9769f1eefe3b..c9c454129344 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -747,6 +747,27 @@ do_alignment_t32_to_handler(unsigned long *pinstr, struct pt_regs *regs,
 	return NULL;
 }
 
+static u32 far_read(void)
+{
+        u32 far;
+        asm("mrc        p15, 0, %0, c6, c0, 0" : "=r" (far));
+        return far;
+}
+
+static u32 fsr_read(void)
+{
+        u32 fsr;
+        asm("mrc        p15, 0, %0, c5, c0, 0" : "=r" (fsr));
+        return fsr;
+}
+
+static u32 dacr_read(void)
+{
+        u32 dacr;
+        asm("mrc        p15, 0, %0, c3, c0, 0" : "=r" (dacr));
+        return dacr;
+}
+
 static int
 do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
@@ -763,6 +784,8 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		local_irq_enable();
 
 	instrptr = instruction_pointer(regs);
+	pr_info("RJK1: fsr=%x far=%x dacr=%x\n", fsr_read(), far_read(), dacr_read());
+	pr_info("RJK2: fsr=%x far=%x dacr=%x\n", fsr_read(), far_read(), dacr_read());
 
 	if (thumb_mode(regs)) {
 		u16 *ptr = (u16 *)(instrptr & ~1);
@@ -787,6 +810,8 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		instr = __mem_to_opcode_arm(instr);
 	}
 
+	pr_info("RJK3: fsr=%x far=%x dacr=%x\n", fsr_read(), far_read(), dacr_read());
+	pr_info("RJK: fault=%d instr=0x%08x instrptr=%p\n", fault, instr, instrptr);
 	if (fault) {
 		type = TYPE_FAULT;
 		goto bad_or_fault;

[2] Oops
========
# insmod /tmp/unalign.ko 
RJK1: fsr=23 far=e1c23643 dacr=51
RJK2: fsr=23 far=e1c23643 dacr=51
RJK3: fsr=2f far=bf00202c dacr=51
RJK: fault=4 instr=0x00000000 instrptr=bf00202c
Unable to handle kernel paging request at virtual address e1c23643
pgd = e1cd4000
[e1c23643] *pgd=c1c0044e(bad)
Internal error: Oops: 823 [#1] ARM
Modules linked in: unalign(+)
CPU: 0 PID: 608 Comm: insmod Not tainted 4.2.0-rc8-next-20150828-cm-x300+ #919
Hardware name: CM-X300 module
task: e1c69880 ti: e1cb0000 task.ti: e1cb0000
PC is at u_init+0x2c/0x40 [unalign]
LR is at u_init+0x14/0x40 [unalign]
pc : [<bf00202c>]    lr : [<bf002014>]    psr: a0000013
sp : e1cb1df8  ip : e1c23e00  fp : 1e3dc89c
r10: e1c23780  r9 : 00000001  r8 : 00000000
r7 : bf002000  r6 : e1ca65c0  r5 : c0b85b80  r4 : c0b85b80
r3 : e1c23640  r2 : 00000004  r1 : a0000013  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: c1cd4018  DAC: 00000051
Process insmod (pid: 608, stack limit = 0xe1cb0198)
