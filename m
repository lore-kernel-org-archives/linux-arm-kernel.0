From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Jul 2014 13:23:47 +0200
Subject: [PATCH] cpuidle: big.LITTLE: add MCPM dependency
Message-ID: <4345351.RJRQd7ghCF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

662322fcb6d ("cpuidle: big.LITTLE: Add ARCH_EXYNOS entry in config")
made it possible for the big-little cpuidle driver to run on exynos,
which may or may not include MCPM support at compile time, so we
run into a link error when it is disabled:

drivers/built-in.o: In function `bl_enter_powerdown':
:(.text+0x1889a0): undefined reference to `mcpm_cpu_powered_up'
drivers/built-in.o: In function `bl_powerdown_finisher':
:(.text+0x1889e8): undefined reference to `mcpm_set_entry_vector'
:(.text+0x1889ec): undefined reference to `mcpm_cpu_suspend'

This adds an explicit dependency to CONFIG_MCPM to avoid that
case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Chander Kashyap <chander.kashyap@linaro.org>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
I believe the broken commit is only present in the samsung/for-next
tree (through v3.17-next/cpuidle-exynos), so it should be fixed there.

On a side note, I wonder if we should have platform dependencies at
all, or just the MCPM dependency by itself.

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 2f6b33ea6e08..459b7c91407a 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -10,6 +10,7 @@ config ARM_ARMADA_370_XP_CPUIDLE
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
 	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
+	depends on MCPM
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	help
