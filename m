From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 18 Jul 2012 19:15:26 +0530
Subject: [PATCH 6/8] ARM: EXYNOS5: Add machine data for USB3.0
In-Reply-To: <1342619128-25013-1-git-send-email-gautam.vivek@samsung.com>
References: <1342619128-25013-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1342619128-25013-7-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock definitions and address mapping of PHY
for USB3.0 in exynos5

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 774533c..af1b917 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -668,6 +668,11 @@ static struct clk exynos5_init_clocks_off[] = {
 		.enable		= exynos5_clk_ip_fsys_ctrl ,
 		.ctrlbit	= (1 << 18),
 	}, {
+		.name		= "usbdrd30",
+		.parent		= &exynos5_clk_aclk_200.clk,
+		.enable		= exynos5_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 19),
+	}, {
 		.name		= "usbotg",
 		.enable		= exynos5_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 7),
@@ -909,6 +914,16 @@ struct clksrc_sources exynos5_clkset_group = {
 	.nr_sources	= ARRAY_SIZE(exynos5_clkset_group_list),
 };
 
+struct clk *exynos5_clkset_usbdrd30_list[] = {
+	[0] = &exynos5_clk_mout_mpll.clk,
+	[1] = &exynos5_clk_mout_cpll.clk,
+};
+
+struct clksrc_sources exynos5_clkset_usbdrd30 = {
+	.sources        = exynos5_clkset_usbdrd30_list,
+	.nr_sources     = ARRAY_SIZE(exynos5_clkset_usbdrd30_list),
+};
+
 /* Possible clock sources for aclk_266_gscl_sub Mux */
 static struct clk *clk_src_gscl_266_list[] = {
 	[0] = &clk_ext_xtal_mux,
@@ -1199,6 +1214,15 @@ static struct clksrc_clk exynos5_clksrcs[] = {
 			.parent		= &exynos5_clk_mout_cpll.clk,
 		},
 		.reg_div = { .reg = EXYNOS5_CLKDIV_GEN, .shift = 4, .size = 3 },
+	}, {
+		.clk    = {
+			.name           = "sclk_usbdrd30",
+			.enable         = exynos5_clksrc_mask_fsys_ctrl,
+			.ctrlbit        = (1 << 28),
+		},
+		.sources = &exynos5_clkset_usbdrd30,
+		.reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 28, .size = 1 },
+		.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS0, .shift = 24, .size = 4 },
 	},
 };
 
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 92d5e61..c17f1df 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -280,6 +280,11 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_USB_PHY),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
+	}, {
+		.virtual        = (unsigned long)S5P_VA_DRD_PHY,
+		.pfn            = __phys_to_pfn(EXYNOS5_PA_DRD_PHY),
+		.length         = SZ_4K,
+		.type           = MT_DEVICE,
 	},
 };
 
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 331ae57..b95b245 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -193,6 +193,7 @@
 #define EXYNOS5_PA_UART			0x12C00000
 
 #define EXYNOS5_PA_USB_PHY		0x12130000
+#define EXYNOS5_PA_DRD_PHY		0x12100000
 
 #define EXYNOS4_PA_VP			0x12C00000
 #define EXYNOS4_PA_MIXER		0x12C10000
diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index d4e392b..67132b4 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -39,6 +39,10 @@
 #define S5P_HDMI_PHY_CONTROL			S5P_PMUREG(0x0700)
 #define S5P_HDMI_PHY_ENABLE			(1 << 0)
 
+/* only for EXYNOS5250*/
+#define S5P_USBDRD_PHY_CONTROL			S5P_PMUREG(0x0704)
+#define S5P_USBDRD_PHY_ENABLE			(1 << 0)
+
 #define S5P_DAC_PHY_CONTROL			S5P_PMUREG(0x070C)
 #define S5P_DAC_PHY_ENABLE			(1 << 0)
 
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index c2d7bda..836863a 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -40,6 +40,8 @@
 #define S5P_VA_GIC_CPU		S3C_ADDR(0x02810000)
 #define S5P_VA_GIC_DIST		S3C_ADDR(0x02820000)
 
+#define S5P_VA_DRD_PHY		S3C_ADDR(0x03000000)
+
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
 #define VA_VIC1			VA_VIC(1)
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index a7773a3..e9cbe34 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -53,6 +53,7 @@ config USB_ARCH_HAS_EHCI
 # some non-PCI HCDs implement xHCI
 config USB_ARCH_HAS_XHCI
 	boolean
+	default y if ARCH_EXYNOS5
 	default PCI
 
 menuconfig USB_SUPPORT
-- 
1.7.0.4
