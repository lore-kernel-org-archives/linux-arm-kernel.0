From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 25 Aug 2015 16:42:08 +0100
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <20150825154026.GT7557@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a software-based implementation of the priviledged no access
support found in ARMv8.1.

Userspace pages are mapped using a different domain number from the
kernel and IO mappings.  If we switch the user domain to "no access"
when we enter the kernel, we can prevent the kernel from touching
userspace.

However, the kernel needs to be able to access userspace via the
various user accessor functions.  With the wrapping in the previous
patch, we can temporarily enable access when the kernel needs user
access, and re-disable it afterwards.

This allows us to trap non-intended accesses to userspace, eg, caused
by an inadvertent dereference of the LIST_POISON* values, which, with
appropriate user mappings setup, can be made to succeed.  This in turn
can allow use-after-free bugs to be further exploited than would
otherwise be possible.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                   | 15 +++++++++++++++
 arch/arm/include/asm/assembler.h   | 30 ++++++++++++++++++++++++++++++
 arch/arm/include/asm/domain.h      | 21 +++++++++++++++++++--
 arch/arm/include/asm/uaccess.h     | 14 ++++++++++++++
 arch/arm/kernel/process.c          | 24 ++++++++++++++++++------
 arch/arm/lib/csumpartialcopyuser.S | 14 ++++++++++++++
 6 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a750c1425c3a..a898eb72da51 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1694,6 +1694,21 @@ config HIGHPTE
 	bool "Allocate 2nd-level pagetables from highmem"
 	depends on HIGHMEM
 
+config CPU_SW_DOMAIN_PAN
+	bool "Enable use of CPU domains to implement priviledged no-access"
+	depends on MMU && !ARM_LPAE
+	default y
+	help
+	  Increase kernel security by ensuring that normal kernel accesses
+	  are unable to access userspace addresses.  This can help prevent
+	  use-after-free bugs becoming an exploitable privilege escalation
+	  by ensuring that magic values (such as LIST_POISON) will always
+	  fault when dereferenced.
+
+	  CPUs with low-vector mappings use a best-efforts implementation.
+	  Their lower 1MB needs to remain accessible for the vectors, but
+	  the remainder of userspace will become appropriately inaccessible.
+
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
 	depends on PERF_EVENTS
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index a91177043467..ff74f0b54b0e 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -446,15 +446,45 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.endm
 
 	.macro	uaccess_disable, tmp, isb=1
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+	/*
+	 * Whenever we re-enter userspace, the domains should always be
+	 * set appropriately.
+	 */
+	mov	\tmp, #DACR_UACCESS_DISABLE
+	mcr	p15, 0, \tmp, c3, c0, 0		@ Set domain register
+	.if	\isb
+	isb
+	.endif
+#endif
 	.endm
 
 	.macro	uaccess_enable, tmp, isb=1
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+	/*
+	 * Whenever we re-enter userspace, the domains should always be
+	 * set appropriately.
+	 */
+	mov	\tmp, #DACR_UACCESS_ENABLE
+	mcr	p15, 0, \tmp, c3, c0, 0
+	.if	\isb
+	isb
+	.endif
+#endif
 	.endm
 
 	.macro	uaccess_save, tmp
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+	mrc	p15, 0, \tmp, c3, c0, 0
+	str	\tmp, [sp, #S_FRAME_SIZE]
+#endif
 	.endm
 
 	.macro	uaccess_restore
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+	ldr	r0, [sp, #S_FRAME_SIZE]
+	mcr	p15, 0, r0, c3, c0, 0
+#endif
 	.endm
 
 	.macro	uaccess_save_and_disable, tmp
diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 2be929549938..e878129f2fee 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -57,11 +57,29 @@
 #define domain_mask(dom)	((3) << (2 * (dom)))
 #define domain_val(dom,type)	((type) << (2 * (dom)))
 
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+#define DACR_INIT \
+	(domain_val(DOMAIN_USER, DOMAIN_NOACCESS) | \
+	 domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
+	 domain_val(DOMAIN_IO, DOMAIN_CLIENT) | \
+	 domain_val(DOMAIN_VECTORS, DOMAIN_CLIENT))
+#else
 #define DACR_INIT \
 	(domain_val(DOMAIN_USER, DOMAIN_CLIENT) | \
 	 domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
 	 domain_val(DOMAIN_IO, DOMAIN_CLIENT) | \
 	 domain_val(DOMAIN_VECTORS, DOMAIN_CLIENT))
+#endif
+
+#define __DACR_DEFAULT \
+	domain_val(DOMAIN_KERNEL, DOMAIN_CLIENT) | \
+	domain_val(DOMAIN_IO, DOMAIN_CLIENT) | \
+	domain_val(DOMAIN_VECTORS, DOMAIN_CLIENT)
+
+#define DACR_UACCESS_DISABLE	\
+	(__DACR_DEFAULT | domain_val(DOMAIN_USER, DOMAIN_NOACCESS))
+#define DACR_UACCESS_ENABLE	\
+	(__DACR_DEFAULT | domain_val(DOMAIN_USER, DOMAIN_CLIENT))
 
 #ifndef __ASSEMBLY__
 
@@ -76,7 +94,6 @@ static inline unsigned int get_domain(void)
 	return domain;
 }
 
-#ifdef CONFIG_CPU_USE_DOMAINS
 static inline void set_domain(unsigned val)
 {
 	asm volatile(
@@ -85,6 +102,7 @@ static inline void set_domain(unsigned val)
 	isb();
 }
 
+#ifdef CONFIG_CPU_USE_DOMAINS
 #define modify_domain(dom,type)					\
 	do {							\
 		unsigned int domain = get_domain();		\
@@ -94,7 +112,6 @@ static inline void set_domain(unsigned val)
 	} while (0)
 
 #else
-static inline void set_domain(unsigned val) { }
 static inline void modify_domain(unsigned dom, unsigned type)	{ }
 #endif
 
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 82880132f941..01bae13b2cea 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -57,11 +57,25 @@ extern int fixup_exception(struct pt_regs *regs);
  */
 static inline unsigned int uaccess_save_and_enable(void)
 {
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+	unsigned int old_domain = get_domain();
+
+	/* Set the current domain access to permit user accesses */
+	set_domain((old_domain & ~domain_mask(DOMAIN_USER)) |
+		   domain_val(DOMAIN_USER, DOMAIN_CLIENT));
+
+	return old_domain;
+#else
 	return 0;
+#endif
 }
 
 static inline void uaccess_restore(unsigned int flags)
 {
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+	/* Restore the user access mask */
+	set_domain(flags);
+#endif
 }
 
 /*
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index e722f9b3c9b1..b407cc7a7b55 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -129,12 +129,24 @@ void __show_regs(struct pt_regs *regs)
 	buf[4] = '\0';
 
 #ifndef CONFIG_CPU_V7M
-	printk("Flags: %s  IRQs o%s  FIQs o%s  Mode %s  ISA %s  Segment %s\n",
-		buf, interrupts_enabled(regs) ? "n" : "ff",
-		fast_interrupts_enabled(regs) ? "n" : "ff",
-		processor_modes[processor_mode(regs)],
-		isa_modes[isa_mode(regs)],
-		get_fs() == get_ds() ? "kernel" : "user");
+	{
+		unsigned int domain = get_domain();
+		const char *segment;
+
+		if ((domain & domain_mask(DOMAIN_USER)) ==
+		    domain_val(DOMAIN_USER, DOMAIN_NOACCESS))
+			segment = "none";
+		else if (get_fs() == get_ds())
+			segment = "kernel";
+		else
+			segment = "user";
+
+		printk("Flags: %s  IRQs o%s  FIQs o%s  Mode %s  ISA %s  Segment %s\n",
+			buf, interrupts_enabled(regs) ? "n" : "ff",
+			fast_interrupts_enabled(regs) ? "n" : "ff",
+			processor_modes[processor_mode(regs)],
+			isa_modes[isa_mode(regs)], segment);
+	}
 #else
 	printk("xPSR: %08lx\n", regs->ARM_cpsr);
 #endif
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 1d0957e61f89..52784f6f1086 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -17,6 +17,19 @@
 
 		.text
 
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+		.macro	save_regs
+		mrc	p15, 0, r3, c3, c0, 0
+		stmfd	sp!, {r1 - r8, lr}
+		uaccess_enable r3
+		.endm
+
+		.macro	load_regs
+		ldmfd	sp!, {r1 - r8, lr}
+		mcr	p15, 0, r3, c3, c0, 0
+		ret	lr
+		.endm
+#else
 		.macro	save_regs
 		stmfd	sp!, {r1, r2, r4 - r8, lr}
 		.endm
@@ -24,6 +37,7 @@
 		.macro	load_regs
 		ldmfd	sp!, {r1, r2, r4 - r8, pc}
 		.endm
+#endif
 
 		.macro	load1b,	reg1
 		ldrusr	\reg1, r0, 1
-- 
2.1.0
