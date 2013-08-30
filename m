From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:10:45 +0100
Subject: [PATCH 09/20] mvebu: support running big-endian
In-Reply-To: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377889856-9447-10-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add indication we can run these cores in BE mode, and ensure that the
secondary CPU is set to big-endian mode in the initialisation code as
the initial code runs little-endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/Kconfig        |    1 +
 arch/arm/mach-mvebu/coherency_ll.S |    3 +++
 arch/arm/mach-mvebu/headsmp.S      |    4 ++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 9eb63d7..5e269d7 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_MVEBU
 	bool "Marvell SOCs with Device Tree support" if ARCH_MULTI_V7
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CLKSRC_MMIO
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index 5476669..ee7598f 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -20,6 +20,8 @@
 #define ARMADA_XP_CFB_CTL_REG_OFFSET 0x0
 #define ARMADA_XP_CFB_CFG_REG_OFFSET 0x4
 
+#include <asm/assembler.h>
+
 	.text
 /*
  * r0: Coherency fabric base register address
@@ -29,6 +31,7 @@ ENTRY(ll_set_cpu_coherent)
 	/* Create bit by cpu index */
 	mov	r3, #(1 << 24)
 	lsl	r1, r3, r1
+ARM_BE8(rev	r1, r1)
 
 	/* Add CPU to SMP group - Atomic */
 	add	r3, r0, #ARMADA_XP_CFB_CTL_REG_OFFSET
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
index 8a1b0c9..3dd80df4 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -21,12 +21,16 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
+#include <asm/assembler.h>
+
 /*
  * Armada XP specific entry point for secondary CPUs.
  * We add the CPU to the coherency fabric and then jump to secondary
  * startup
  */
 ENTRY(armada_xp_secondary_startup)
+ ARM_BE8(setend	be )			@ go BE8 if entered LE
+
 	/* Get coherency fabric base physical address */
 	adr	r0, 1f
 	ldr	r1, [r0]
-- 
1.7.10.4
