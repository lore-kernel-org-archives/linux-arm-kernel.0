From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:47 +0000
Subject: [PATCH 17/17] mvebu: support running big-endian
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-18-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add indication we can run these cores in BE mode, and ensure that the
secondary CPU is set to big-endian mode in the initialisation code as
the initial code runs little-endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/Kconfig   |    1 +
 arch/arm/mach-mvebu/headsmp.S |    4 ++++
 2 files changed, 5 insertions(+)

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
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
index a06e0ed..8b09f8d 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -36,6 +36,10 @@
  */
 ENTRY(armada_xp_secondary_startup)
 
+#ifdef CONFIG_CPU_BE8_BOOT_LE
+	setend	be
+#endif
+
 	/* Read CPU id */
 	mrc     p15, 0, r1, c0, c0, 5
 	and     r1, r1, #0xF
-- 
1.7.10.4
