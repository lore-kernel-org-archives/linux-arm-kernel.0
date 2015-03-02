From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Mar 2015 22:28:58 +0100
Subject: [PATCH 8/9] ARM: EXYNOS: suspend requires regulator access
In-Reply-To: <1423769746-582629-1-git-send-email-arnd@arndb.de>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
Message-ID: <2062492.pEav958W9c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building an exynos kernel without regulators but with suspend enabled results
in a link error:

arch/arm/mach-exynos/built-in.o: In function `exynos_suspend_finish':
arch/arm/mach-exynos/suspend.c:532: undefined reference to `regulator_suspend_finish'
arch/arm/mach-exynos/built-in.o: In function `exynos_suspend_prepare':
arch/arm/mach-exynos/suspend.c:515: undefined reference to `regulator_suspend_prepare'

This adds an appropriate 'select' statement in Kconfig to ensure the symbols
are available.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 603820e5aba7..f4bd06370ad8 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -22,6 +22,7 @@ menuconfig ARCH_EXYNOS
 	select PINCTRL
 	select PINCTRL_EXYNOS
 	select PM_GENERIC_DOMAINS if PM
+	select REGULATOR if PM_SLEEP
 	select S5P_DEV_MFC
 	select SRAM
 	select MFD_SYSCON
-- 
2.1.0.rc2
