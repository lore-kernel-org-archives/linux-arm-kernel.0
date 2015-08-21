From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Aug 2015 14:31:15 +0100
Subject: [PATCH 1/9] ARM: domains: switch to keeping domain value in register
In-Reply-To: <20150821133043.GV7557@n2100.arm.linux.org.uk>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZSmPb-0002yl-AY@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than modifying both the domain access control register and our
per-thread copy, modify only the domain access control register, and
use the per-thread copy to save and restore the register over context
switches.  We can also avoid the explicit initialisation of the
init thread_info structure.

This allows us to avoid needing to gain access to the thread information
at the uaccess control sites.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/domain.h      | 20 +++++++++++++++-----
 arch/arm/include/asm/thread_info.h |  3 ---
 arch/arm/kernel/entry-armv.S       |  2 ++
 arch/arm/kernel/process.c          | 13 ++++++++++---
 4 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 6ddbe446425e..7f2941905714 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -59,6 +59,17 @@
 
 #ifndef __ASSEMBLY__
 
+static inline unsigned int get_domain(void)
+{
+	unsigned int domain;
+
+	asm(
+	"mrc	p15, 0, %0, c3, c0	@ get domain"
+	 : "=r" (domain));
+
+	return domain;
+}
+
 #ifdef CONFIG_CPU_USE_DOMAINS
 static inline void set_domain(unsigned val)
 {
@@ -70,11 +81,10 @@ static inline void set_domain(unsigned val)
 
 #define modify_domain(dom,type)					\
 	do {							\
-	struct thread_info *thread = current_thread_info();	\
-	unsigned int domain = thread->cpu_domain;		\
-	domain &= ~domain_val(dom, DOMAIN_MANAGER);		\
-	thread->cpu_domain = domain | domain_val(dom, type);	\
-	set_domain(thread->cpu_domain);				\
+		unsigned int domain = get_domain();		\
+		domain &= ~domain_val(dom, DOMAIN_MANAGER);	\
+		domain = domain | domain_val(dom, type);	\
+		set_domain(domain);				\
 	} while (0)
 
 #else
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index bd32eded3e50..0a0aec410d8c 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -74,9 +74,6 @@ struct thread_info {
 	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
 	.addr_limit	= KERNEL_DS,					\
-	.cpu_domain	= domain_val(DOMAIN_USER, DOMAIN_MANAGER) |	\
-			  domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) |	\
-			  domain_val(DOMAIN_IO, DOMAIN_CLIENT),		\
 }
 
 #define init_thread_info	(init_thread_union.thread_info)
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 7dac3086e361..d19adcf6c580 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -770,6 +770,8 @@ ENTRY(__switch_to)
 	ldr	r4, [r2, #TI_TP_VALUE]
 	ldr	r5, [r2, #TI_TP_VALUE + 4]
 #ifdef CONFIG_CPU_USE_DOMAINS
+	mrc	p15, 0, r6, c3, c0, 0		@ Get domain register
+	str	r6, [r1, #TI_CPU_DOMAIN]	@ Save old domain register
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
 #endif
 	switch_tls r1, r4, r5, r3, r7
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f192a2a41719..e722f9b3c9b1 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -146,10 +146,9 @@ void __show_regs(struct pt_regs *regs)
 		buf[0] = '\0';
 #ifdef CONFIG_CPU_CP15_MMU
 		{
-			unsigned int transbase, dac;
+			unsigned int transbase, dac = get_domain();
 			asm("mrc p15, 0, %0, c2, c0\n\t"
-			    "mrc p15, 0, %1, c3, c0\n"
-			    : "=r" (transbase), "=r" (dac));
+			    : "=r" (transbase));
 			snprintf(buf, sizeof(buf), "  Table: %08x  DAC: %08x",
 			  	transbase, dac);
 		}
@@ -210,6 +209,14 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&thread->cpu_context, 0, sizeof(struct cpu_context_save));
 
+	/*
+	 * Copy the initial value of the domain access control register
+	 * from the current thread: thread->addr_limit will have been
+	 * copied from the current thread via setup_thread_stack() in
+	 * kernel/fork.c
+	 */
+	thread->cpu_domain = get_domain();
+
 	if (likely(!(p->flags & PF_KTHREAD))) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
-- 
2.1.0
