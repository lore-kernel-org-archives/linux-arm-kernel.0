From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 28 Oct 2013 09:49:33 -0700
Subject: [RFC PATCH 3/3] ARM: imx: cpuidle: Move the drivers to drivers/cpuidle
In-Reply-To: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
References: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1382978973-4034-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the sake of consistency and in order to facilitate code consolidation
across cpuidle drivers, moving them to the drivers/cpuidle directory is
appreciable. The different drivers for at91, calxeda, big-little (tc2),
kirkwood, ux500 and zynq are now in this directory.

As there is no more dependency between the low level pm code and the cpuidle
backend driver we can safely move it to the directory the drivers belong to.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-imx/Makefile                         |    5 -----
 drivers/cpuidle/Kconfig.arm                        |   14 ++++++++++++++
 drivers/cpuidle/Makefile                           |    2 ++
 .../mach-imx => drivers/cpuidle}/cpuidle-imx5.c    |    0
 .../mach-imx => drivers/cpuidle}/cpuidle-imx6q.c   |    0
 5 files changed, 16 insertions(+), 5 deletions(-)
 rename {arch/arm/mach-imx => drivers/cpuidle}/cpuidle-imx5.c (100%)
 rename {arch/arm/mach-imx => drivers/cpuidle}/cpuidle-imx6q.c (100%)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 5383c58..876c72d 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -27,11 +27,6 @@ obj-$(CONFIG_MXC_AVIC) += avic.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
-obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
-endif
-
 ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index f23bd75..2e1b9400 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -44,3 +44,17 @@ config ARM_AT91_CPUIDLE
 	depends on ARCH_AT91
 	help
 	  Select this to enable cpuidle for AT91 processors
+
+config ARM_IMX5_CPUIDLE
+        bool "Cpu Idle Driver for the IMX5 processors"
+	default y
+	depends on SOC_IMX5 
+	help
+	  Select this to enable cpuidle for IMX5 processors
+
+config ARM_IMX6Q_CPUIDLE
+        bool "Cpu Idle Driver for the IMX6Q processors"
+	default y
+	depends on SOC_IMX6Q
+	help
+	  Select this to enable cpuidle for IMX6Q processors
\ No newline at end of file
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 527be28..0695880 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -13,3 +13,5 @@ obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
+obj-$(CONFIG_ARM_IMX5_CPUIDLE)		+= cpuidle-imx5.o
+obj-$(CONFIG_ARM_IMX6Q_CPUIDLE)		+= cpuidle-imx6q.o
diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/drivers/cpuidle/cpuidle-imx5.c
similarity index 100%
rename from arch/arm/mach-imx/cpuidle-imx5.c
rename to drivers/cpuidle/cpuidle-imx5.c
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/drivers/cpuidle/cpuidle-imx6q.c
similarity index 100%
rename from arch/arm/mach-imx/cpuidle-imx6q.c
rename to drivers/cpuidle/cpuidle-imx6q.c
-- 
1.7.9.5
