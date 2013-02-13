From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 13 Feb 2013 10:55:27 +0000
Subject: [PATCH 9/9] mvebu: support running big-endian
In-Reply-To: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360752927-29331-10-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add indication we can run these cores in BE mode, and ensure that the
secondary CPU is set to big-endian mode in the initialisation code as
the initial code runs little-endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/Kconfig        |    1 +
 arch/arm/mach-mvebu/coherency_ll.S |    3 +++
 arch/arm/mach-mvebu/headsmp.S      |    2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 440b13e..2afa026 100644
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
index 53e8391..bc2d70d 100644
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
index a06e0ed..3b77eac 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -36,6 +36,8 @@
  */
 ENTRY(armada_xp_secondary_startup)
 
+ ARM_BE8(setend	be )			@ go BE8 if booted LE
+
 	/* Read CPU id */
 	mrc     p15, 0, r1, c0, c0, 5
 	and     r1, r1, #0xF
-- 
1.7.10.4
