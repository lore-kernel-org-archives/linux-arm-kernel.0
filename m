From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 25 Jul 2013 11:13:41 +0900
Subject: [PATCH v2 1/3] ARM: shmobile: marzen: Switch to DT_MACHINE_START
In-Reply-To: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
References: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1374718423-24230-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert the marzen board to use DT_MACHINE_START. With this in
place all mach-shmobile boards use DT_MACHINE_START. Also, this
makes it possible for the r8a7779 SMP code to use DT for CPUs.

So appended DTB is the way forward on this board.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

v2 [Simon Horman]
* Select USE_OF in Kconfig
* Provide dt_compat in DT_MACHINE_START
* Provide r8a7779-marzen dts

v1 [Magnus Damm]
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/r8a7779-marzen.dts  | 27 +++++++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig        |  1 +
 arch/arm/mach-shmobile/board-marzen.c |  8 +++++++-
 4 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/r8a7779-marzen.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0cfe54a..d19a5cf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -187,6 +187,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7740-armadillo800eva-reference.dtb \
+	r8a7779-marzen.dtb \
 	r8a7779-marzen-reference.dtb \
 	r8a7790-lager.dtb \
 	r8a7790-lager-reference.dtb \
diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
new file mode 100644
index 0000000..f3f7f79
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -0,0 +1,27 @@
+/*
+ * Device Tree Source for the Marzen board
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Simon Horman
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a7779.dtsi"
+
+/ {
+	model = "marzen";
+	compatible = "renesas,marzen", "renesas,r8a7779";
+
+	chosen {
+		bootargs = "console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6f71c94..35b11ce 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -168,6 +168,7 @@ config MACH_MARZEN
 	depends on ARCH_R8A7779
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select USE_OF
 
 config MACH_MARZEN_REFERENCE
 	bool "MARZEN board - Reference Device Tree Implementation"
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 1f57865..91f8751 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -237,7 +237,12 @@ static void __init marzen_init(void)
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
 
-MACHINE_START(MARZEN, "marzen")
+static const char *marzen_boards_compat_dt[] __initdata = {
+        "renesas,marzen",
+        NULL,
+};
+
+DT_MACHINE_START(MARZEN, "marzen")
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_add_early_devices,
@@ -245,5 +250,6 @@ MACHINE_START(MARZEN, "marzen")
 	.init_irq	= r8a7779_init_irq,
 	.init_machine	= marzen_init,
 	.init_late	= r8a7779_init_late,
+	.dt_compat	= marzen_boards_compat_dt,
 	.init_time	= r8a7779_earlytimer_init,
 MACHINE_END
-- 
1.8.2.1
