From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Mar 2013 18:06:39 +0000
Subject: [PATCH 1/2] arm: vexpress: Move the poweroff/restart code to
 drivers/power/reset
In-Reply-To: <1363716400-9002-1-git-send-email-catalin.marinas@arm.com>
References: <1363716400-9002-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1363716400-9002-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the arch/arm/mach-vexpress/reset.c functionality to
drivers/platform/reset/ and adds the necessary Kconfig wiring.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/Kconfig                                     | 3 +++
 arch/arm/mach-vexpress/Makefile                                    | 2 +-
 drivers/power/reset/Kconfig                                        | 7 +++++++
 drivers/power/reset/Makefile                                       | 3 ++-
 .../reset.c => drivers/power/reset/vexpress-poweroff.c             | 0
 5 files changed, 13 insertions(+), 2 deletions(-)
 rename arch/arm/mach-vexpress/reset.c => drivers/power/reset/vexpress-poweroff.c (100%)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 52d315b..0f1c5e5 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -17,6 +17,9 @@ config ARCH_VEXPRESS
 	select NO_IOPORT
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
+	select POWER_RESET
+	select POWER_RESET_VEXPRESS
+	select POWER_SUPPLY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select VEXPRESS_CONFIG
 	help
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 80b6497..42703e8 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -4,7 +4,7 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-versatile/include
 
-obj-y					:= v2m.o reset.o
+obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 1ae65b8..349e9ae 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -30,3 +30,10 @@ config POWER_RESET_RESTART
 	  Some boards don't actually have the ability to power off.
 	  Instead they restart, and u-boot holds the SoC until the
 	  user presses a key. u-boot then boots into Linux.
+
+config POWER_RESET_VEXPRESS
+	bool
+	depends on POWER_RESET
+	help
+	  Power off and reset support for the ARM Ltd. Versatile
+	  Express boards.
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0f317f5..372807f 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
-obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
\ No newline at end of file
+obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
+obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
diff --git a/arch/arm/mach-vexpress/reset.c b/drivers/power/reset/vexpress-poweroff.c
similarity index 100%
rename from arch/arm/mach-vexpress/reset.c
rename to drivers/power/reset/vexpress-poweroff.c
