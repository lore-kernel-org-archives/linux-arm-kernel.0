From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri,  4 Dec 2009 04:47:02 +0200
Subject: [RFC][PATCH 02/10] arm: mxc: base support for Freescale i.MX51
	processor
In-Reply-To: <e99e70e2a619693064130a747b6ee3a93273337b.1259893118.git.amit.kucheria@canonical.com>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<e99e70e2a619693064130a747b6ee3a93273337b.1259893118.git.amit.kucheria@canonical.com>
Message-ID: <6608c4dca645d87efce78ae0b7dbad265004f482.1259893118.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kconfig and Makefiles to enable the i.MX51 processor separated to help ease
the review process

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/Makefile               |    1 +
 arch/arm/mach-mx5/Kconfig       |   17 +++++++++++++++++
 arch/arm/mach-mx5/Makefile      |    9 +++++++++
 arch/arm/mach-mx5/Makefile.boot |    3 +++
 arch/arm/plat-mxc/Kconfig       |    8 ++++++++
 5 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx5/Kconfig
 create mode 100644 arch/arm/mach-mx5/Makefile
 create mode 100644 arch/arm/mach-mx5/Makefile.boot

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a73caaf..daedbf2 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -145,6 +145,7 @@ machine-$(CONFIG_ARCH_MX1)		:= mx1
 machine-$(CONFIG_ARCH_MX2)		:= mx2
 machine-$(CONFIG_ARCH_MX25)		:= mx25
 machine-$(CONFIG_ARCH_MX3)		:= mx3
+machine-$(CONFIG_ARCH_MX5)		:= mx5
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
 machine-$(CONFIG_ARCH_NS9XXX)		:= ns9xxx
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
new file mode 100644
index 0000000..80a749c
--- /dev/null
+++ b/arch/arm/mach-mx5/Kconfig
@@ -0,0 +1,17 @@
+if ARCH_MX5
+
+config ARCH_MX51
+	bool
+	default y
+	select MXC_TZIC
+	select ARCH_MXC_IOMUX_V3
+
+comment "MX5 platforms:"
+
+config MACH_MX51_BABBAGE
+	bool "Support MX51 BABBAGE platforms"
+	help
+	  Include support for MX51 Babbage platform. This includes specific
+	  configurations for the board and its peripherals.
+
+endif
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
new file mode 100644
index 0000000..e4cf91f
--- /dev/null
+++ b/arch/arm/mach-mx5/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for the linux kernel.
+#
+
+# Object file lists.
+obj-y   := cpu.o mm.o clock.o devices.o
+
+obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
+
diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
new file mode 100644
index 0000000..9939a19
--- /dev/null
+++ b/arch/arm/mach-mx5/Makefile.boot
@@ -0,0 +1,3 @@
+   zreladdr-y	:= 0x90008000
+params_phys-y	:= 0x90000100
+initrd_phys-y	:= 0x90800000
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 11bf691..bd3be5c 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -41,6 +41,13 @@ config ARCH_MXC91231
 	help
 	  This enables support for systems based on the Freescale MXC91231 family
 
+config ARCH_MX5
+	bool "MX5-based"
+	select CPU_V7
+	select COMMON_CLKDEV
+	help
+	  This enables support for systems based on the Freescale i.MX51 family
+
 endchoice
 
 source "arch/arm/mach-mx1/Kconfig"
@@ -48,6 +55,7 @@ source "arch/arm/mach-mx2/Kconfig"
 source "arch/arm/mach-mx3/Kconfig"
 source "arch/arm/mach-mx25/Kconfig"
 source "arch/arm/mach-mxc91231/Kconfig"
+source "arch/arm/mach-mx5/Kconfig"
 
 endmenu
 
-- 
1.6.3.3
