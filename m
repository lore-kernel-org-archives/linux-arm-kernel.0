From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Aug 2010 18:56:11 +0100
Subject: hotplug and init section
In-Reply-To: <4C58B996.3000601@codeaurora.org>
References: <989bc3c9f8d8ce1d51c480a0dbdce07e.squirrel@www.codeaurora.org>
	<20100722205753.GU31293@n2100.arm.linux.org.uk>
	<4C5898AD.9020300@codeaurora.org>
	<20100803230541.GA30769@n2100.arm.linux.org.uk>
	<4C58B996.3000601@codeaurora.org>
Message-ID: <20100804175611.GA12502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 03, 2010 at 05:51:34PM -0700, Jeff Ohlstein wrote:
> This doesn't boot for me, I will look into it further. I am using a  
> 2.6.32 kernel, but I think commit  
> a1c29fa34b6be6b7c1d9075f4057c3995c993e8c or  "ARM: convert to use __HEAD  
> and HEAD_TEXT macros" should be sufficient.

Hmm.  Well, what seems to be happening is that the assembler is being
utterly stupid (we've had this kind of problem before.)  Take this:

	.text
	nop
	nop
	nop
	adr	r0, sym
	nop
	nop

	.data
	.long	1
sym:	.long	0
	.long	2

As the assembler to build this (which it does successfully), and look at
the resulting object:

$ arm-linux-objdump -dr t.o

t.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <.text>:
   0:   e1a00000        nop                     (mov r0,r0)
   4:   e1a00000        nop                     (mov r0,r0)
   8:   e1a00000        nop                     (mov r0,r0)
   c:   e24f0004        sub     r0, pc, #4      ; 0x4
  10:   e1a00000        nop                     (mov r0,r0)
  14:   e1a00000        nop                     (mov r0,r0)

So, it succesfully built the object, and somehow thinks that 'sym' can
be referenced by the ADR pseudo-instruction by a PC-relative reference
even though it's in a different section an unknown distance away.

Clearly it's not just my toolchain which accepts this, but whatever
toolchain you're using as well - I'd go so far as to suggest that almost
every recent toolchain has this broken behaviour.

This is why the patch I sent you passes build testing, but doesn't
actually work - what's coming out of the assembler is utter garbage.

Here's a slightly fixed-up and refined version - but it still won't
completely fix your problem.  __enable_mmu ends up still being in
the head text section, which is placed on the start of the kernel
image along with stuff to be freed.  Moving this to the __cpuinit.text
section results in the function being moved outside of the 1:1 mapped
region, causing the system to crash when it tries to turn the MMU on.

I haven't worked out how to sanely sort this out yet - that in itself
is quite a horrible problem to resolve.  I'm toying with the idea of
putting an assembly function before and after the __enable_mmu code
which returns the address that each of these functions is located -
and using that to ensure that we have 1:1 mappings.  This just feels
like a really insane way to fix it - though I don't think changing the
layout of the cpuinit sections etc is really on either.

We could just add more 1:1 mappings and just hope that we cover the
code - but that's not going to work for really big kernels.

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index b9505aa..706a6c1 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -143,56 +143,7 @@ __error:
 	b	1b
 ENDPROC(__error)
 
-
-/*
- * Read processor ID register (CP#15, CR0), and look up in the linker-built
- * supported processor list.  Note that we can't use the absolute addresses
- * for the __proc_info lists since we aren't running with the MMU on
- * (and therefore, we are not in the correct address space).  We have to
- * calculate the offset.
- *
- *	r9 = cpuid
- * Returns:
- *	r3, r4, r6 corrupted
- *	r5 = proc_info pointer in physical address space
- *	r9 = cpuid (preserved)
- */
-__lookup_processor_type:
-	adr	r3, 3f
-	ldmia	r3, {r5 - r7}
-	add	r3, r3, #8
-	sub	r3, r3, r7			@ get offset between virt&phys
-	add	r5, r5, r3			@ convert virt addresses to
-	add	r6, r6, r3			@ physical address space
-1:	ldmia	r5, {r3, r4}			@ value, mask
-	and	r4, r4, r9			@ mask wanted bits
-	teq	r3, r4
-	beq	2f
-	add	r5, r5, #PROC_INFO_SZ		@ sizeof(proc_info_list)
-	cmp	r5, r6
-	blo	1b
-	mov	r5, #0				@ unknown processor
-2:	mov	pc, lr
-ENDPROC(__lookup_processor_type)
-
-/*
- * This provides a C-API version of the above function.
- */
-ENTRY(lookup_processor_type)
-	stmfd	sp!, {r4 - r7, r9, lr}
-	mov	r9, r0
-	bl	__lookup_processor_type
-	mov	r0, r5
-	ldmfd	sp!, {r4 - r7, r9, pc}
-ENDPROC(lookup_processor_type)
-
-/*
- * Look in <asm/procinfo.h> and arch/arm/kernel/arch.[ch] for
- * more information about the __proc_info and __arch_info structures.
- */
 	.align	2
-3:	.long	__proc_info_begin
-	.long	__proc_info_end
 4:	.long	.
 	.long	__arch_info_begin
 	.long	__arch_info_end
@@ -265,3 +216,54 @@ __vet_atags:
 1:	mov	r2, #0
 	mov	pc, lr
 ENDPROC(__vet_atags)
+
+	__CPUINIT
+
+/*
+ * Read processor ID register (CP#15, CR0), and look up in the linker-built
+ * supported processor list.  Note that we can't use the absolute addresses
+ * for the __proc_info lists since we aren't running with the MMU on
+ * (and therefore, we are not in the correct address space).  We have to
+ * calculate the offset.
+ *
+ *	r9 = cpuid
+ * Returns:
+ *	r3, r4, r6 corrupted
+ *	r5 = proc_info pointer in physical address space
+ *	r9 = cpuid (preserved)
+ */
+__lookup_processor_type:
+	adr	r3, 3f
+	ldmia	r3, {r4 - r6}
+	sub	r3, r3, r4			@ get offset between virt&phys
+	add	r5, r5, r3			@ convert virt addresses to
+	add	r6, r6, r3			@ physical address space
+1:	ldmia	r5, {r3, r4}			@ value, mask
+	and	r4, r4, r9			@ mask wanted bits
+	teq	r3, r4
+	beq	2f
+	add	r5, r5, #PROC_INFO_SZ		@ sizeof(proc_info_list)
+	cmp	r5, r6
+	blo	1b
+	mov	r5, #0				@ unknown processor
+2:	mov	pc, lr
+ENDPROC(__lookup_processor_type)
+
+/*
+ * Look in <asm/procinfo.h> more information about the __proc_info structure.
+ */
+	.align	2
+3:	.long	.
+	.long	__proc_info_begin
+	.long	__proc_info_end
+
+/*
+ * This provides a C-API version of the above function.
+ */
+ENTRY(lookup_processor_type)
+	stmfd	sp!, {r4 - r6, r9, lr}
+	mov	r9, r0
+	bl	__lookup_processor_type
+	mov	r0, r5
+	ldmfd	sp!, {r4 - r6, r9, pc}
+ENDPROC(lookup_processor_type)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..c8ab09d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -104,6 +104,7 @@ ENTRY(stext)
 ENDPROC(stext)
 
 #if defined(CONFIG_SMP)
+	__CPUINIT
 ENTRY(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
@@ -126,12 +127,13 @@ ENTRY(secondary_startup)
 	ldmia	r4, {r5, r7, r12}		@ address to jump to after
 	sub	r4, r4, r5			@ mmu has been enabled
 	ldr	r4, [r7, r4]			@ get secondary_data.pgdir
-	adr	lr, BSYM(__enable_mmu)		@ return address
+	adr	lr, BSYM(1f)			@ return address
 	mov	r13, r12			@ __secondary_switched address
  ARM(	add	pc, r10, #PROCINFO_INITFUNC	) @ initialise processor
 						  @ (return control reg)
  THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
  THUMB(	mov	pc, r12				)
+1:	b	__enable_mmu
 ENDPROC(secondary_startup)
 
 	/*
@@ -148,6 +150,8 @@ __secondary_data:
 	.long	.
 	.long	secondary_data
 	.long	__secondary_switched
+
+	__HEAD
 #endif /* defined(CONFIG_SMP) */
 
 
