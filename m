From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  2 Oct 2018 23:11:44 +0200
Subject: [PATCH] arm64: arch_timer: avoid unused function warning
Message-ID: <20181002211214.2672576-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64_1188873_read_cntvct_el0() is protected by the correct
CONFIG_ARM64_ERRATUM_1188873 #ifdef, but the only reference to it is
also inside of an CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND section,
and causes a warning if that is disabled:

drivers/clocksource/arm_arch_timer.c:323:20: error: 'arm64_1188873_read_cntvct_el0' defined but not used [-Werror=unused-function]

Since the erratum requires that we always apply the workaround
in the timer driver, select that symbol as we do for SoC
specific errata.

Fixes: 95b861a4a6d9 ("arm64: arch_timer: Add workaround for ARM erratum 1188873")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 130f3a766aef..0661c6103c21 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -483,6 +483,7 @@ config ARM64_ERRATUM_1024718
 config ARM64_ERRATUM_1188873
 	bool "Cortex-A76: MRC read following MRRC read of specific Generic Timer in AArch32 might give incorrect result"
 	default y
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
 	help
 	  This option adds work arounds for ARM Cortex-A76 erratum 1188873
 
-- 
2.18.0
