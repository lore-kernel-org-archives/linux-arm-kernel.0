From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  8 May 2014 17:13:39 +0200
Subject: [PATCH 3/3] ARM: zynq: Enable big-endian
In-Reply-To: <5e4fb08db4f6a436fc4593b22c3ae611ba545967.1399562009.git.michal.simek@xilinx.com>
References: <5e4fb08db4f6a436fc4593b22c3ae611ba545967.1399562009.git.michal.simek@xilinx.com>
Message-ID: <c0fa40614e2bec826fe825f75d00ae927d1197c4.1399562009.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARCH_SUPPORTS_BIG_ENDIAN in Kconfig.

zynq_secondary_trampoline is the first function
that is called on secondary CPU.
Reference:
"ARM: mcpm: fix big endian issue in mcpm startup code"
(sha1: 519ceb9fd10cd7e836d0aa97b2068cc9e97f463b)

Fix early printk support. Based on:
"ARM: pl01x debug code endian fix"
(sha1: 76e3faf156fa95b6465e747d702b94faf67117fc)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/include/debug/zynq.S | 2 ++
 arch/arm/mach-zynq/Kconfig    | 1 +
 arch/arm/mach-zynq/headsmp.S  | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/debug/zynq.S b/arch/arm/include/debug/zynq.S
index 0b762fafa758..3895146341f3 100644
--- a/arch/arm/include/debug/zynq.S
+++ b/arch/arm/include/debug/zynq.S
@@ -43,12 +43,14 @@

 		.macro	waituart,rd,rx
 1001:		ldr	\rd, [\rx, #UART_SR_OFFSET]
+ARM_BE8(	rev	\rd, \rd )
 		tst	\rd, #UART_SR_TXEMPTY
 		beq	1001b
 		.endm

 		.macro	busyuart,rd,rx
 1002:		ldr	\rd, [\rx, #UART_SR_OFFSET]	@ get status register
+ARM_BE8(	rev	\rd, \rd )
 		tst	\rd, #UART_SR_TXFULL		@
 		bne	1002b			@ wait if FIFO is full
 		.endm
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 1daa5c220d1d..ff03a71bb9a3 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -2,6 +2,7 @@ config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform" if ARCH_MULTI_V7
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_GLOBAL_TIMER if !CPU_FREQ
diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
index 57a32869f0aa..dd8c071941e7 100644
--- a/arch/arm/mach-zynq/headsmp.S
+++ b/arch/arm/mach-zynq/headsmp.S
@@ -8,9 +8,12 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <asm/assembler.h>

 ENTRY(zynq_secondary_trampoline)
-	ldr	r0, [pc]
+ARM_BE8(setend	be)				@ ensure we are in BE8 mode
+	ldr	r0, zynq_secondary_trampoline_jump
+ARM_BE8(rev	r0, r0)
 	bx	r0
 .globl zynq_secondary_trampoline_jump
 zynq_secondary_trampoline_jump:
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140508/622da53b/attachment.sig>
