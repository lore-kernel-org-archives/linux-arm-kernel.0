From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sun,  7 Apr 2013 22:27:22 +0200
Subject: [PATCH] ARM: Samsung: Select ARM_CPU_SUSPEND when required
Message-ID: <1365366442-16025-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power management code of S3C24XX, S3C64XX, S5PV210 platform in
arch/arm/plat-samsung/, arch/arm/mach-s3c24xx/, arch/arm/mach-s3c64xx/
directories uses generic cpu_suspend routine. Make sure it is compiled
in when building with power management support. Without this patch
compilation fails with errors as below. It can be reproduced by using
default config files with CONFIG_SUSPEND disabled and CONFIG_PM_RUNTIME
enabled.

 - s5pv210_defconfig
 arch/arm/plat-samsung/built-in.o: In function `s3c_pm_enter':
 arch/arm/plat-samsung/pm.c:304: undefined reference to `cpu_suspend'
 arch/arm/plat-samsung/built-in.o: In function `s3c_cpu_resume':
 arch/arm/plat-samsung/s5p-sleep.S:74: undefined reference to `cpu_resume'

 - s3c24xx_defconfig
 arch/arm/mach-s3c24xx/built-in.o: In function `s3c_cpu_resume':
 arch/arm/mach-s3c24xx/sleep.S:83: undefined reference to `cpu_resume'
 arch/arm/plat-samsung/built-in.o: In function `s3c_pm_enter':
 arch/arm/plat-samsung/pm.c:304: undefined reference to `cpu_suspend'

 - s3c64xx_defconfig
 arch/arm/mach-s3c64xx/built-in.o: In function `s3c_cpu_resume':
 arch/arm/mach-s3c64xx/sleep.S:72: undefined reference to `cpu_resume'
 arch/arm/plat-samsung/built-in.o: In function `s3c_pm_enter':
 arch/arm/plat-samsung/pm.c:304: undefined reference to `cpu_suspend'

To fix this issue select ARM_CPU_SUSPEND for PLAT_SAMSUNG when PM is set.

The build break occurs for kernels at least back to v3.0, however this
patch applies without conflicts only back to v3.7.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: stable at vger.kernel.org
---
 arch/arm/plat-samsung/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 54d1861..02355ba 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -10,6 +10,7 @@ config PLAT_SAMSUNG
 	default y
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT
+	select ARM_CPU_SUSPEND if PM
 	help
 	  Base platform code for all Samsung SoC based systems
 
-- 
1.7.4.1
