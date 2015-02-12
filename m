From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:42:33 +0100
Subject: [PATCH 01/11] ARM: vexpress: use ARM_CPU_SUSPEND if needed
In-Reply-To: <1423770163-583064-1-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
Message-ID: <1423770163-583064-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vexpress tc2 power management code calls mcpm_loopback, which
is only available if ARM_CPU_SUSPEND is enabled, otherwise we
get a link error:

arch/arm/mach-vexpress/built-in.o: In function `tc2_pm_init':
arch/arm/mach-vexpress/tc2_pm.c:389: undefined reference to `mcpm_loopback'

This explicitly selects ARM_CPU_SUSPEND like other platforms that
need it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 3592d7e002438 ("ARM: 8082/1: TC2: test the MCPM loopback during boot")
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mach-vexpress/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index d6b16d9a7838..3c2509b4b694 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -73,6 +73,7 @@ config ARCH_VEXPRESS_TC2_PM
 	depends on MCPM
 	select ARM_CCI
 	select ARCH_VEXPRESS_SPC
+	select ARM_CPU_SUSPEND
 	help
 	  Support for CPU and cluster power management on Versatile Express
 	  with a TC2 (A15x2 A7x3) big.LITTLE core tile.
-- 
2.1.0.rc2
