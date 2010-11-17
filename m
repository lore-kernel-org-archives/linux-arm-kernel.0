From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:31 +0100
Subject: [PATCH 03/51] ARM: imx: use MXxy_IO_P2V macros to setup static
	mappings
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes less code rely on the virtual constants.

To further simplify code and reduce the needed boilerplate when
defining the static mappings a new helper macro is defined in
mach/hardware.h.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx1.c               |    7 +---
 arch/arm/mach-imx/mm-imx21.c              |   21 ++----------
 arch/arm/mach-imx/mm-imx27.c              |   21 ++----------
 arch/arm/mach-mx25/mm.c                   |   25 +++----------
 arch/arm/mach-mx3/mm.c                    |   53 ++++++++++------------------
 arch/arm/mach-mx5/mm.c                    |   35 ++++---------------
 arch/arm/mach-mxc91231/mm.c               |   53 +++++-----------------------
 arch/arm/plat-mxc/include/mach/hardware.h |    7 ++++
 8 files changed, 56 insertions(+), 166 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index 9be92b9..729ae09 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -25,12 +25,7 @@
 #include <mach/hardware.h>
 
 static struct map_desc imx_io_desc[] __initdata = {
-	{
-		.virtual = MX1_IO_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX1_IO_BASE_ADDR),
-		.length = MX1_IO_SIZE,
-		.type = MT_DEVICE
-	}
+	imx_map_entry(MX1, IO, MT_DEVICE),
 };
 
 void __init mx1_map_io(void)
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 12faeeaa..e728af8 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -35,33 +35,18 @@ static struct map_desc imx21_io_desc[] __initdata = {
 	 * - ROM Patch
 	 * - and some reserved space
 	 */
-	{
-		.virtual = MX21_AIPI_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX21_AIPI_BASE_ADDR),
-		.length = MX21_AIPI_SIZE,
-		.type = MT_DEVICE
-	},
+	imx_map_entry(MX21, AIPI, MT_DEVICE),
 	/*
 	 * this fixed mapping covers:
 	 * - CSI
 	 * - ATA
 	 */
-	{
-		.virtual = MX21_SAHB1_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX21_SAHB1_BASE_ADDR),
-		.length = MX21_SAHB1_SIZE,
-		.type = MT_DEVICE
-	},
+	imx_map_entry(MX21, SAHB1, MT_DEVICE),
 	/*
 	 * this fixed mapping covers:
 	 * - EMI
 	 */
-	{
-		.virtual = MX21_X_MEMC_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX21_X_MEMC_BASE_ADDR),
-		.length = MX21_X_MEMC_SIZE,
-		.type = MT_DEVICE
-	},
+	imx_map_entry(MX21, X_MEMC, MT_DEVICE),
 };
 
 /*
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index a246229..374e48b 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -35,33 +35,18 @@ static struct map_desc imx27_io_desc[] __initdata = {
 	 * - ROM Patch
 	 * - and some reserved space
 	 */
-	{
-		.virtual = MX27_AIPI_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX27_AIPI_BASE_ADDR),
-		.length = MX27_AIPI_SIZE,
-		.type = MT_DEVICE
-	},
+	imx_map_entry(MX27, AIPI, MT_DEVICE),
 	/*
 	 * this fixed mapping covers:
 	 * - CSI
 	 * - ATA
 	 */
-	{
-		.virtual = MX27_SAHB1_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX27_SAHB1_BASE_ADDR),
-		.length = MX27_SAHB1_SIZE,
-		.type = MT_DEVICE
-	},
+	imx_map_entry(MX27, SAHB1, MT_DEVICE),
 	/*
 	 * this fixed mapping covers:
 	 * - EMI
 	 */
-	{
-		.virtual = MX27_X_MEMC_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX27_X_MEMC_BASE_ADDR),
-		.length = MX27_X_MEMC_SIZE,
-		.type = MT_DEVICE
-	},
+	imx_map_entry(MX27, X_MEMC, MT_DEVICE),
 };
 
 /*
diff --git a/arch/arm/mach-mx25/mm.c b/arch/arm/mach-mx25/mm.c
index bb67711..11cd335 100644
--- a/arch/arm/mach-mx25/mm.c
+++ b/arch/arm/mach-mx25/mm.c
@@ -30,25 +30,12 @@
 
 /*
  * This table defines static virtual address mappings for I/O regions.
- * These are the mappings common across all MX3 boards.
+ * These are the mappings common across all MX25 boards.
  */
-static struct map_desc mxc_io_desc[] __initdata = {
-	{
-		.virtual	= MX25_AVIC_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MX25_AVIC_BASE_ADDR),
-		.length		= MX25_AVIC_SIZE,
-		.type		= MT_DEVICE_NONSHARED
-	}, {
-		.virtual	= MX25_AIPS1_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MX25_AIPS1_BASE_ADDR),
-		.length		= MX25_AIPS1_SIZE,
-		.type		= MT_DEVICE_NONSHARED
-	}, {
-		.virtual	= MX25_AIPS2_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MX25_AIPS2_BASE_ADDR),
-		.length		= MX25_AIPS2_SIZE,
-		.type		= MT_DEVICE_NONSHARED
-	},
+static struct map_desc mx25_io_desc[] __initdata = {
+	imx_map_entry(MX25, AVIC, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX25, AIPS1, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX25, AIPS2, MT_DEVICE_NONSHARED),
 };
 
 /*
@@ -62,7 +49,7 @@ void __init mx25_map_io(void)
 	mxc_iomux_v3_init(MX25_IO_ADDRESS(MX25_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX25_IO_ADDRESS(MX25_WDOG_BASE_ADDR));
 
-	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
+	iotable_init(mx25_io_desc, ARRAY_SIZE(mx25_io_desc));
 }
 
 int imx25_register_gpios(void);
diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index 809ee40..193c18c 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -36,40 +36,16 @@
  * @ingroup Memory
  */
 
-/*!
- * This table defines static virtual address mappings for I/O regions.
- * These are the mappings common across all MX3 boards.
- */
-static struct map_desc mxc_io_desc[] __initdata = {
-	{
-		.virtual = MX3x_X_MEMC_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX3x_X_MEMC_BASE_ADDR),
-		.length = MX3x_X_MEMC_SIZE,
-		.type = MT_DEVICE
-	}, {
-		.virtual = MX3x_AVIC_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX3x_AVIC_BASE_ADDR),
-		.length = MX3x_AVIC_SIZE,
-		.type = MT_DEVICE_NONSHARED
-	}, {
-		.virtual = MX3x_AIPS1_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX3x_AIPS1_BASE_ADDR),
-		.length = MX3x_AIPS1_SIZE,
-		.type = MT_DEVICE_NONSHARED
-	}, {
-		.virtual = MX3x_AIPS2_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX3x_AIPS2_BASE_ADDR),
-		.length = MX3x_AIPS2_SIZE,
-		.type = MT_DEVICE_NONSHARED
-	}, {
-		.virtual = MX3x_SPBA0_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX3x_SPBA0_BASE_ADDR),
-		.length = MX3x_SPBA0_SIZE,
-		.type = MT_DEVICE_NONSHARED
-	},
+#ifdef CONFIG_ARCH_MX31
+static struct map_desc mx31_io_desc[] __initdata = {
+	imx_map_entry(MX31, X_MEMC, MT_DEVICE),
+	imx_map_entry(MX31, AVIC, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX31, AIPS1, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX31, AIPS2, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX31, SPBA0, MT_DEVICE_NONSHARED),
 };
 
-/*!
+/*
  * This function initializes the memory map. It is called during the
  * system startup to create static physical to virtual memory mappings
  * for the IO modules.
@@ -79,17 +55,26 @@ void __init mx31_map_io(void)
 	mxc_set_cpu_type(MXC_CPU_MX31);
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
 
-	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
+	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
 }
+#endif
 
 #ifdef CONFIG_ARCH_MX35
+static struct map_desc mx35_io_desc[] __initdata = {
+	imx_map_entry(MX35, X_MEMC, MT_DEVICE),
+	imx_map_entry(MX35, AVIC, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, AIPS1, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, AIPS2, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, SPBA0, MT_DEVICE_NONSHARED),
+};
+
 void __init mx35_map_io(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX35);
 	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX3x_WDOG_BASE_ADDR));
 
-	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
+	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
 }
 #endif
 
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index bc3f30d..01dff26 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -23,33 +23,12 @@
 /*
  * Define the MX51 memory map.
  */
-static struct map_desc mxc_io_desc[] __initdata = {
-	{
-		.virtual = MX51_IRAM_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_IRAM_BASE_ADDR),
-		.length = MX51_IRAM_SIZE,
-		.type = MT_DEVICE
-	}, {
-		.virtual = MX51_DEBUG_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_DEBUG_BASE_ADDR),
-		.length = MX51_DEBUG_SIZE,
-		.type = MT_DEVICE
-	}, {
-		.virtual = MX51_AIPS1_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_AIPS1_BASE_ADDR),
-		.length = MX51_AIPS1_SIZE,
-		.type = MT_DEVICE
-	}, {
-		.virtual = MX51_SPBA0_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_SPBA0_BASE_ADDR),
-		.length = MX51_SPBA0_SIZE,
-		.type = MT_DEVICE
-	}, {
-		.virtual = MX51_AIPS2_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(MX51_AIPS2_BASE_ADDR),
-		.length = MX51_AIPS2_SIZE,
-		.type = MT_DEVICE
-	},
+static struct map_desc mx51_io_desc[] __initdata = {
+	imx_map_entry(MX51, IRAM, MT_DEVICE),
+	imx_map_entry(MX51, DEBUG, MT_DEVICE),
+	imx_map_entry(MX51, AIPS1, MT_DEVICE),
+	imx_map_entry(MX51, SPBA0, MT_DEVICE),
+	imx_map_entry(MX51, AIPS2, MT_DEVICE),
 };
 
 /*
@@ -62,7 +41,7 @@ void __init mx51_map_io(void)
 	mxc_set_cpu_type(MXC_CPU_MX51);
 	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG_BASE_ADDR));
-	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
+	iotable_init(mx51_io_desc, ARRAY_SIZE(mx51_io_desc));
 }
 
 int imx51_register_gpios(void);
diff --git a/arch/arm/mach-mxc91231/mm.c b/arch/arm/mach-mxc91231/mm.c
index aeccfd7..7652c30 100644
--- a/arch/arm/mach-mxc91231/mm.c
+++ b/arch/arm/mach-mxc91231/mm.c
@@ -27,48 +27,15 @@
 /*
  * This structure defines the MXC memory map.
  */
-static struct map_desc mxc_io_desc[] __initdata = {
-	{
-		.virtual	= MXC91231_L2CC_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MXC91231_L2CC_BASE_ADDR),
-		.length		= MXC91231_L2CC_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= MXC91231_X_MEMC_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MXC91231_X_MEMC_BASE_ADDR),
-		.length		= MXC91231_X_MEMC_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= MXC91231_ROMP_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MXC91231_ROMP_BASE_ADDR),
-		.length		= MXC91231_ROMP_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= MXC91231_AVIC_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MXC91231_AVIC_BASE_ADDR),
-		.length		= MXC91231_AVIC_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= MXC91231_AIPS1_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MXC91231_AIPS1_BASE_ADDR),
-		.length		= MXC91231_AIPS1_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= MXC91231_SPBA0_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MXC91231_SPBA0_BASE_ADDR),
-		.length		= MXC91231_SPBA0_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= MXC91231_SPBA1_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MXC91231_SPBA1_BASE_ADDR),
-		.length		= MXC91231_SPBA1_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= MXC91231_AIPS2_BASE_ADDR_VIRT,
-		.pfn		= __phys_to_pfn(MXC91231_AIPS2_BASE_ADDR),
-		.length		= MXC91231_AIPS2_SIZE,
-		.type		= MT_DEVICE,
-	},
+static struct map_desc mxc91231_io_desc[] __initdata = {
+	imx_map_entry(MXC91231, L2CC, MT_DEVICE),
+	imx_map_entry(MXC91231, X_MEMC, MT_DEVICE),
+	imx_map_entry(MXC91231, ROMP, MT_DEVICE),
+	imx_map_entry(MXC91231, AVIC, MT_DEVICE),
+	imx_map_entry(MXC91231, AIPS1, MT_DEVICE),
+	imx_map_entry(MXC91231, SPBA0, MT_DEVICE),
+	imx_map_entry(MXC91231, SPBA1, MT_DEVICE),
+	imx_map_entry(MXC91231, AIPS2, MT_DEVICE),
 };
 
 /*
@@ -80,7 +47,7 @@ void __init mxc91231_map_io(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MXC91231);
 
-	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
+	iotable_init(mxc91231_io_desc, ARRAY_SIZE(mxc91231_io_desc));
 }
 
 int mxc91231_register_gpios(void);
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 4bbe506..409cec6 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -66,4 +66,11 @@
 
 #include <mach/mxc.h>
 
+#define imx_map_entry(soc, name, _type)	{				\
+	.virtual = soc ## _IO_P2V(soc ## _ ## name ## _BASE_ADDR),	\
+	.pfn = __phys_to_pfn(soc ## _ ## name ## _BASE_ADDR),		\
+	.length = soc ## _ ## name ## _SIZE,				\
+	.type = _type,							\
+}
+
 #endif /* __ASM_ARCH_MXC_HARDWARE_H__ */
-- 
1.7.2.3
