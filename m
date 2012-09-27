From: robherring2@gmail.com (Rob Herring)
Date: Thu, 27 Sep 2012 10:10:12 -0500
Subject: [PATCH] ARM: mvebu: fix build breaks from multi-platform conversion
Message-ID: <1348758612-27012-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Moving ARCH_MVEBU for multi-platform support caused several breakages in
recently added addr-map and pinctrl support for mvebu. This adds the
necessary selects and include paths to fix the build.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-mvebu/Kconfig  |    2 ++
 arch/arm/mach-mvebu/Makefile |    3 ++-
 arch/arm/plat-orion/Makefile |    1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 26a817d..416d46e 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -6,6 +6,8 @@ config ARCH_MVEBU
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select PINCTRL
+	select PLAT_ORION
 	select SPARSE_IRQ
 
 if ARCH_MVEBU
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index cbe5664..57f996b 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,4 +1,5 @@
-ccflags-$(ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+	-I$(srctree)/arch/arm/plat-orion/include
 
 obj-y += system-controller.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index 1251e5b..a82cecb 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -1,6 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 obj-y                             += addr-map.o
 
-- 
1.7.9.5
