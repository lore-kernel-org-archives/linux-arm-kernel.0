From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Oct 2010 16:18:29 +0900
Subject: [PATCH 07/08] ARM: Add CONFIG_DEFAULT_IRQ_DEMUX
In-Reply-To: <20101006071731.28048.89938.sendpatchset@t400s>
References: <20101006071731.28048.89938.sendpatchset@t400s>
Message-ID: <20101006071829.28048.45307.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a CONFIG_DEFAULT_IRQ_DEMUX to allow removing the
default IRQ demuxer from the ARM kernel. This will
reduce the memory footprint and also remove the need
for some of the macros in entry-macro.S.

In the case of CONFIG_DEFAULT_IRQ_DEMUX=n the default
IRQ demux code is omitted from the kernel and the per-
mach/plat demux code must then be registered using the
function setup_irq_stubs(). CONFIG_DEFAULT_IRQ_DEMUX=y
keeps the default IRQ demuxer code as-is in the kernel.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/Kconfig             |    3 +++
 arch/arm/kernel/entry-armv.S |   13 +++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

--- 0001/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2010-10-05 20:36:45.000000000 +0900
@@ -1337,6 +1337,9 @@ config SPARSE_IRQ
 	  number of off-chip IRQs will want to treat this as
 	  experimental until they have been independently verified.
 
+config DEFAULT_IRQ_DEMUX
+	def_bool y
+
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
--- 0009/arch/arm/kernel/entry-armv.S
+++ work/arch/arm/kernel/entry-armv.S	2010-10-05 20:34:16.000000000 +0900
@@ -128,8 +128,9 @@ __dabt_svc:
  UNWIND(.fnend		)
 ENDPROC(__dabt_svc)
 
+#ifdef CONFIG_DEFAULT_IRQ_DEMUX
 	__irq_svc	default
-
+#endif
 	.align	5
 __und_svc:
 #ifdef CONFIG_KPROBES
@@ -258,8 +259,9 @@ __dabt_usr:
  UNWIND(.fnend		)
 ENDPROC(__dabt_usr)
 
+#ifdef CONFIG_DEFAULT_IRQ_DEMUX
 	__irq_usr	default
-
+#endif
 	.align	5
 __und_usr:
 	usr_entry
@@ -885,10 +887,17 @@ __stubs_start:
 
 	.globl	__stubs_irq
 __stubs_irq:
+#ifdef CONFIG_DEFAULT_IRQ_DEMUX
 	.long	__irq_usr_default		@  0  (USR_26 / USR_32)
 	.long	__irq_invalid			@  1  (FIQ_26 / FIQ_32)
 	.long	__irq_invalid			@  2  (IRQ_26 / IRQ_32)
 	.long	__irq_svc_default		@  3  (SVC_26 / SVC_32)
+#else
+	.long	__irq_invalid			@  0  (USR_26 / USR_32)
+	.long	__irq_invalid			@  1  (FIQ_26 / FIQ_32)
+	.long	__irq_invalid			@  2  (IRQ_26 / IRQ_32)
+	.long	__irq_invalid			@  3  (SVC_26 / SVC_32)
+#endif
 	.long	__irq_invalid			@  4
 	.long	__irq_invalid			@  5
 	.long	__irq_invalid			@  6
