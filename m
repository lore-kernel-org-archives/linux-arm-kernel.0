From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Oct 2010 16:18:21 +0900
Subject: [PATCH 06/08] ARM: Add setup_irq_stubs() function
In-Reply-To: <20101006071731.28048.89938.sendpatchset@t400s>
References: <20101006071731.28048.89938.sendpatchset@t400s>
Message-ID: <20101006071821.28048.16107.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a setup_irq_stubs() function to allow registration
of per-mach/plat IRQ demux routines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/include/asm/traps.h |    1 +
 arch/arm/kernel/entry-armv.S |    2 ++
 arch/arm/kernel/traps.c      |   14 ++++++++++++++
 3 files changed, 17 insertions(+)

--- 0001/arch/arm/include/asm/traps.h
+++ work/arch/arm/include/asm/traps.h	2010-10-05 20:26:18.000000000 +0900
@@ -24,6 +24,7 @@ static inline int in_exception_text(unsi
 	       ptr < (unsigned long)&__exception_text_end;
 }
 
+extern void __init setup_irq_stubs(void *irq_usr, void *irq_svr);
 extern void __init early_trap_init(void);
 extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
 
--- 0008/arch/arm/kernel/entry-armv.S
+++ work/arch/arm/kernel/entry-armv.S	2010-10-05 20:28:22.000000000 +0900
@@ -883,6 +883,8 @@ __stubs_start:
  */
 	vector_stub	irq, IRQ_MODE, 4
 
+	.globl	__stubs_irq
+__stubs_irq:
 	.long	__irq_usr_default		@  0  (USR_26 / USR_32)
 	.long	__irq_invalid			@  1  (FIQ_26 / FIQ_32)
 	.long	__irq_invalid			@  2  (IRQ_26 / IRQ_32)
--- 0001/arch/arm/kernel/traps.c
+++ work/arch/arm/kernel/traps.c	2010-10-05 20:27:11.000000000 +0900
@@ -757,6 +757,20 @@ static void __init kuser_get_tls_init(un
 		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
 }
 
+void __init setup_irq_stubs(void *usr_handler, void *svc_handler)
+{
+	unsigned long vectors = CONFIG_VECTORS_BASE;
+	extern char __stubs_start[], __stubs_irq[];
+	void **stubs_ptr;
+
+	stubs_ptr = (void *)vectors + 0x200 + (__stubs_irq - __stubs_start);
+
+	stubs_ptr[0] = usr_handler;
+	stubs_ptr[3] = svc_handler;
+
+	flush_icache_range(vectors, vectors + PAGE_SIZE);
+}
+
 void __init early_trap_init(void)
 {
 	unsigned long vectors = CONFIG_VECTORS_BASE;
