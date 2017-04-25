From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 25 Apr 2017 18:27:06 +0200
Subject: [PATCH/RFC 2/2] soc: renesas: Rework Kconfig and Makefile logic
In-Reply-To: <1493137626-21404-1-git-send-email-geert+renesas@glider.be>
References: <1493137626-21404-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1493137626-21404-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goals are to:
  - Allow precise control over and automatic selection of which
    (sub)drivers are used for which SoC,
  - Allow adding support for new SoCs easily,
  - Allow compile-testing of all (sub)drivers,
  - Keep driver selection logic in the subsystem-specific Kconfig,
    independent from the architecture-specific Kconfig (i.e. no "select"
    from arch/arm64/Kconfig.platforms), to avoid dependencies.

This is implemented by:
  - Introducing Kconfig symbols for all drivers and sub-drivers,
  - Introducing the Kconfig symbol SOC_RENESAS, which is enabled
    automatically when building for a Renesas ARM platform, and which
    enables all required drivers without interaction of the user, based
    on SoC-specific ARCH_* symbols,
  - Allowing the user to enable any Kconfig symbol manually if
    COMPILE_TEST is enabled,
  - Using the new Kconfig symbols instead of the ARCH_* symbols to
    control compilation in the Makefile,
  - Always entering drivers/soc/renesas/ during the build.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/Kconfig                  |  1 +
 drivers/soc/Makefile                 |  2 +-
 drivers/soc/renesas/Kconfig          | 63 ++++++++++++++++++++++++++++++++++++
 drivers/soc/renesas/Makefile         | 31 +++++++++---------
 drivers/soc/renesas/rcar-sysc.c      | 24 +++++++-------
 include/linux/soc/renesas/rcar-rst.h |  3 +-
 6 files changed, 92 insertions(+), 32 deletions(-)
 create mode 100644 drivers/soc/renesas/Kconfig

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index f09023f7ab119025..de4fcdbae2a8fa03 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -4,6 +4,7 @@ source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
+source "drivers/soc/renesas/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/samsung/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 05eae52a30b45133..59d8c937f4a8748e 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
-obj-$(CONFIG_ARCH_RENESAS)	+= renesas/
+obj-y				+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
new file mode 100644
index 0000000000000000..87a4be46bd9834c1
--- /dev/null
+++ b/drivers/soc/renesas/Kconfig
@@ -0,0 +1,63 @@
+config SOC_RENESAS
+	bool "Renesas SoC driver support" if COMPILE_TEST && !ARCH_RENESAS
+	default y if ARCH_RENESAS
+	select SOC_BUS
+	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || \
+			   ARCH_R8A7795 || ARCH_R8A7796
+	select SYSC_R8A7743 if ARCH_R8A7743
+	select SYSC_R8A7745 if ARCH_R8A7745
+	select SYSC_R8A7779 if ARCH_R8A7779
+	select SYSC_R8A7790 if ARCH_R8A7790
+	select SYSC_R8A7791 if ARCH_R8A7791 || ARCH_R8A7793
+	select SYSC_R8A7792 if ARCH_R8A7792
+	select SYSC_R8A7794 if ARCH_R8A7794
+	select SYSC_R8A7795 if ARCH_R8A7795
+	select SYSC_R8A7796 if ARCH_R8A7796
+
+if SOC_RENESAS
+
+# SoC
+config SYSC_R8A7743
+	bool "RZ/G1M System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7745
+	bool "RZ/G1E System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7779
+	bool "R-Car H1 System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7790
+	bool "R-Car H2 System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7791
+	bool "R-Car M2-W/N System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7792
+	bool "R-Car V2H System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7794
+	bool "R-Car E2 System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7795
+	bool "R-Car H3 System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
+config SYSC_R8A7796
+	bool "R-Car M3-W System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
+# Family
+config RST_RCAR
+	bool "R-Car Reset Controller support" if COMPILE_TEST
+
+config SYSC_RCAR
+	bool "R-Car System Controller support" if COMPILE_TEST
+
+endif # SOC_RENESAS
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index d9115cb5ed9dae78..1a1a297b26a79613 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1,18 +1,17 @@
-obj-$(CONFIG_SOC_BUS)		+= renesas-soc.o
+# Generic, must be first because of soc_device_register()
+obj-$(CONFIG_SOC_RENESAS)	+= renesas-soc.o
 
-obj-$(CONFIG_ARCH_RCAR_GEN1)	+= rcar-rst.o
-obj-$(CONFIG_ARCH_RCAR_GEN2)	+= rcar-rst.o
-obj-$(CONFIG_ARCH_R8A7795)	+= rcar-rst.o
-obj-$(CONFIG_ARCH_R8A7796)	+= rcar-rst.o
+# SoC
+obj-$(CONFIG_SYSC_R8A7743)	+= r8a7743-sysc.o
+obj-$(CONFIG_SYSC_R8A7745)	+= r8a7745-sysc.o
+obj-$(CONFIG_SYSC_R8A7779)	+= r8a7779-sysc.o
+obj-$(CONFIG_SYSC_R8A7790)	+= r8a7790-sysc.o
+obj-$(CONFIG_SYSC_R8A7791)	+= r8a7791-sysc.o
+obj-$(CONFIG_SYSC_R8A7792)	+= r8a7792-sysc.o
+obj-$(CONFIG_SYSC_R8A7794)	+= r8a7794-sysc.o
+obj-$(CONFIG_SYSC_R8A7795)	+= r8a7795-sysc.o
+obj-$(CONFIG_SYSC_R8A7796)	+= r8a7796-sysc.o
 
-obj-$(CONFIG_ARCH_R8A7743)	+= rcar-sysc.o r8a7743-sysc.o
-obj-$(CONFIG_ARCH_R8A7745)	+= rcar-sysc.o r8a7745-sysc.o
-obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
-obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
-obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
-obj-$(CONFIG_ARCH_R8A7792)	+= rcar-sysc.o r8a7792-sysc.o
-# R-Car M2-N is identical to R-Car M2-W w.r.t. power domains.
-obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o r8a7791-sysc.o
-obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o r8a7794-sysc.o
-obj-$(CONFIG_ARCH_R8A7795)	+= rcar-sysc.o r8a7795-sysc.o
-obj-$(CONFIG_ARCH_R8A7796)	+= rcar-sysc.o r8a7796-sysc.o
+# Family
+obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
+obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 528a13742aeb98d8..dcad5c42a5e81c87 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -275,35 +275,33 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 }
 
 static const struct of_device_id rcar_sysc_matches[] = {
-#ifdef CONFIG_ARCH_R8A7743
+#ifdef CONFIG_SYSC_R8A7743
 	{ .compatible = "renesas,r8a7743-sysc", .data = &r8a7743_sysc_info },
 #endif
-#ifdef CONFIG_ARCH_R8A7745
+#ifdef CONFIG_SYSC_R8A7745
 	{ .compatible = "renesas,r8a7745-sysc", .data = &r8a7745_sysc_info },
 #endif
-#ifdef CONFIG_ARCH_R8A7779
+#ifdef CONFIG_SYSC_R8A7779
 	{ .compatible = "renesas,r8a7779-sysc", .data = &r8a7779_sysc_info },
 #endif
-#ifdef CONFIG_ARCH_R8A7790
+#ifdef CONFIG_SYSC_R8A7790
 	{ .compatible = "renesas,r8a7790-sysc", .data = &r8a7790_sysc_info },
 #endif
-#ifdef CONFIG_ARCH_R8A7791
+#ifdef CONFIG_SYSC_R8A7791
 	{ .compatible = "renesas,r8a7791-sysc", .data = &r8a7791_sysc_info },
-#endif
-#ifdef CONFIG_ARCH_R8A7792
-	{ .compatible = "renesas,r8a7792-sysc", .data = &r8a7792_sysc_info },
-#endif
-#ifdef CONFIG_ARCH_R8A7793
 	/* R-Car M2-N is identical to R-Car M2-W w.r.t. power domains. */
 	{ .compatible = "renesas,r8a7793-sysc", .data = &r8a7791_sysc_info },
 #endif
-#ifdef CONFIG_ARCH_R8A7794
+#ifdef CONFIG_SYSC_R8A7792
+	{ .compatible = "renesas,r8a7792-sysc", .data = &r8a7792_sysc_info },
+#endif
+#ifdef CONFIG_SYSC_R8A7794
 	{ .compatible = "renesas,r8a7794-sysc", .data = &r8a7794_sysc_info },
 #endif
-#ifdef CONFIG_ARCH_R8A7795
+#ifdef CONFIG_SYSC_R8A7795
 	{ .compatible = "renesas,r8a7795-sysc", .data = &r8a7795_sysc_info },
 #endif
-#ifdef CONFIG_ARCH_R8A7796
+#ifdef CONFIG_SYSC_R8A7796
 	{ .compatible = "renesas,r8a7796-sysc", .data = &r8a7796_sysc_info },
 #endif
 	{ /* sentinel */ }
diff --git a/include/linux/soc/renesas/rcar-rst.h b/include/linux/soc/renesas/rcar-rst.h
index 787e7ad53d45f61c..2c231f2280a6dc50 100644
--- a/include/linux/soc/renesas/rcar-rst.h
+++ b/include/linux/soc/renesas/rcar-rst.h
@@ -1,8 +1,7 @@
 #ifndef __LINUX_SOC_RENESAS_RCAR_RST_H__
 #define __LINUX_SOC_RENESAS_RCAR_RST_H__
 
-#if defined(CONFIG_ARCH_RCAR_GEN1) || defined(CONFIG_ARCH_RCAR_GEN2) || \
-    defined(CONFIG_ARCH_R8A7795) || defined(CONFIG_ARCH_R8A7796)
+#ifdef CONFIG_RST_RCAR
 int rcar_rst_read_mode_pins(u32 *mode);
 #else
 static inline int rcar_rst_read_mode_pins(u32 *mode) { return -ENODEV; }
-- 
2.7.4
