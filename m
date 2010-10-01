From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:31 +0530
Subject: [PATCH V2 11/69] ST SPEAr: Adding support for CLCD on SPEAr3xx/6xx
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <7e14843c38691f8d55010fe02c9cf3f8e8719232.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul-kumar Samar <vipulkumar.samar@st.com>

SPEAr 3xx and 6xx have ARM PL110 CLCD controller. This patch adds
supports for CLCD in these machines.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    6 ++
 arch/arm/mach-spear3xx/spear300.c             |   17 ++++
 arch/arm/mach-spear3xx/spear300_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear320.c             |   16 ++++
 arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
 arch/arm/mach-spear6xx/include/mach/generic.h |    4 +
 arch/arm/mach-spear6xx/spear600_evb.c         |    1 +
 arch/arm/mach-spear6xx/spear6xx.c             |   17 ++++
 arch/arm/plat-spear/Makefile                  |    2 +-
 arch/arm/plat-spear/clcd.c                    |  114 +++++++++++++++++++++++++
 drivers/video/Kconfig                         |   14 +++-
 11 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-spear/clcd.c

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index e7d2de8..1c8f9f1 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -100,6 +100,7 @@ extern struct pmx_driver pmx_driver;
 /* spear300 declarations */
 #ifdef CONFIG_MACH_SPEAR300
 /* Add spear300 machine device structure declarations here */
+extern struct amba_device clcd_device;
 extern struct amba_device gpio1_device;
 
 /* pad mux modes */
@@ -136,6 +137,8 @@ extern struct pmx_dev pmx_gpio1;
 /* Add spear300 machine function declarations here */
 void __init spear300_init(void);
 
+/* Add misc structure declarations here */
+extern struct clcd_board clcd_plat_data;
 #endif /* CONFIG_MACH_SPEAR300 */
 
 /* spear310 declarations */
@@ -160,6 +163,7 @@ void __init spear310_init(void);
 /* spear320 declarations */
 #ifdef CONFIG_MACH_SPEAR320
 /* Add spear320 machine device structure declarations here */
+extern struct amba_device clcd_device;
 
 /* pad mux modes */
 extern struct pmx_mode auto_net_smii_mode;
@@ -194,6 +198,8 @@ extern struct pmx_dev pmx_i2c1;
 /* Add spear320 machine function declarations here */
 void __init spear320_init(void);
 
+/* Add misc structure declarations here */
+extern struct clcd_board clcd_plat_data;
 #endif /* CONFIG_MACH_SPEAR320 */
 
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 19c2daf..fb7d5f1 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -371,6 +371,23 @@ struct pmx_driver pmx_driver = {
 };
 
 /* Add spear300 specific devices here */
+
+/* CLCD device registration */
+struct amba_device clcd_device = {
+	.dev = {
+		.init_name = "clcd",
+		.coherent_dma_mask = ~0,
+		.platform_data = &clcd_plat_data,
+	},
+	.res = {
+		.start = SPEAR300_CLCD_BASE,
+		.end = SPEAR300_CLCD_BASE + SPEAR300_CLCD_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.dma_mask = ~0,
+	.irq = {IRQ_CLCD, NO_IRQ},
+};
+
 /* arm gpio1 device registeration */
 static struct pl061_platform_data gpio1_plat_data = {
 	.gpio_base	= 8,
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index cd23c98..3bb7fbc 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -38,6 +38,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	&uart_device,
 
 	/* spear300 specific devices */
+	&clcd_device,
 	&gpio1_device,
 };
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 2886bb2..e5baa00 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -386,6 +386,22 @@ struct pmx_driver pmx_driver = {
 
 /* Add spear320 specific devices here */
 
+/* CLCD device registration */
+struct amba_device clcd_device = {
+	.dev = {
+		.init_name = "clcd",
+		.coherent_dma_mask = ~0,
+		.platform_data = &clcd_plat_data,
+	},
+	.res = {
+		.start = SPEAR320_CLCD_BASE,
+		.end = SPEAR320_CLCD_BASE + SPEAR320_CLCD_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.dma_mask = ~0,
+	.irq = {VIRQ_CLCD, NO_IRQ},
+};
+
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 4a7ce35..821e806 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -43,6 +43,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	&uart_device,
 
 	/* spear320 specific devices */
+	&clcd_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index e5967ed..d6a04f2 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -29,6 +29,7 @@
 #define SPEAR_GPT0_CHAN1_IRQ	IRQ_CPU_GPT1_2
 
 /* Add spear6xx family device structure declarations here */
+extern struct amba_device clcd_device;
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
 extern struct sys_timer spear6xx_timer;
@@ -43,4 +44,7 @@ void __init clk_init(void);
 
 /* Add spear600 machine device structure declarations here */
 
+/* Add misc structure declarations here */
+extern struct clcd_board clcd_plat_data;
+
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index bdd5b76..88e69f4 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -17,6 +17,7 @@
 #include <mach/spear.h>
 
 static struct amba_device *amba_devs[] __initdata = {
+	&clcd_device,
 	&gpio_device[0],
 	&gpio_device[1],
 	&gpio_device[2],
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index e0bf51e..ebb504f 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -23,6 +23,23 @@
 #include <mach/spear.h>
 
 /* Add spear6xx machines common devices here */
+
+/* CLCD device registration */
+struct amba_device clcd_device = {
+	.dev = {
+		.init_name = "clcd",
+		.coherent_dma_mask = ~0,
+		.platform_data = &clcd_plat_data,
+	},
+	.res = {
+		.start = SPEAR6XX_ICM3_CLCD_BASE,
+		.end = SPEAR6XX_ICM3_CLCD_BASE + SPEAR6XX_ICM3_CLCD_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.dma_mask = ~0,
+	.irq = {IRQ_BASIC_CLCD, NO_IRQ},
+};
+
 /* uart device registeration */
 struct amba_device uart_device[] = {
 	{
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index b4f340b..01a4a91 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -3,6 +3,6 @@
 #
 
 # Common support
-obj-y	:= clock.o time.o
+obj-y	:= clcd.o clock.o time.o
 
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
diff --git a/arch/arm/plat-spear/clcd.c b/arch/arm/plat-spear/clcd.c
new file mode 100644
index 0000000..d469b81
--- /dev/null
+++ b/arch/arm/plat-spear/clcd.c
@@ -0,0 +1,114 @@
+/*
+* arch/arm/plat-spear/clcd.c
+*
+* Copyright (C) 2009 ST Microelectronics
+* Shiraz Hashim<shiraz.hashim@st.com>
+* Ashish Priyadarshi<ashish.priyadarshi@st.com>
+*
+* This file is licensed under the terms of the GNU General Public
+* License version 2. This program is licensed "as is" without any
+* warranty of any kind, whether express or implied.
+*/
+
+#include <linux/dma-mapping.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/clcd.h>
+
+/* This is enough for the size of 800x480 (1.5 MB) */
+#define FRAMESIZE 0x00180000
+
+#ifdef CONFIG_FB_ARMCLCD_SHARP_LQ043T1DG01
+static struct clcd_panel sharp_LQ043T1DG01_in = {
+	.mode = {
+		.name = "Sharp LQ043T1DG01",
+		.refresh = 0,
+		.xres = 480,
+		.yres = 272,
+		.pixclock = 48000,
+		.left_margin = 2,
+		.right_margin = 2,
+		.upper_margin = 2,
+		.lower_margin = 2,
+		.hsync_len = 41,
+		.vsync_len = 11,
+		.sync = 0,/* FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT */
+		.vmode = FB_VMODE_NONINTERLACED,
+	},
+	.width = -1,
+	.height = -1,
+	.tim2 = TIM2_IOE | TIM2_CLKSEL | 3,
+	.cntl = CNTL_LCDTFT | CNTL_BGR,
+	.bpp = 32,
+};
+#endif
+
+#ifdef CONFIG_FB_ARMCLCD_SAMSUNG_LMS700
+static struct clcd_panel samsung_LMS700_in = {
+	.mode = {
+		.name = "Samsung LMS700",
+		.refresh = 0,
+		.xres = 800,
+		.yres = 480,
+		.pixclock = 48000,
+		.left_margin = 16,
+		.right_margin = 8,
+		.upper_margin = 6,
+		.lower_margin = 5,
+		.hsync_len = 3,
+		.vsync_len = 2,
+		.sync = 0,
+		.vmode = FB_VMODE_NONINTERLACED,
+	},
+	.width = -1,
+	.height = -1,
+	.tim2 = TIM2_CLKSEL,
+	.cntl = CNTL_LCDTFT | CNTL_BGR,
+	.bpp = 32,
+};
+#endif
+
+static int clcd_setup(struct clcd_fb *fb)
+{
+	dma_addr_t dma;
+
+	/* Detect which LCD panel is connected */
+#ifdef CONFIG_FB_ARMCLCD_SHARP_LQ043T1DG01
+	fb->panel = &sharp_LQ043T1DG01_in;
+#endif
+#ifdef CONFIG_FB_ARMCLCD_SAMSUNG_LMS700
+	fb->panel = &samsung_LMS700_in;
+#endif
+	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, FRAMESIZE,
+			&dma, GFP_KERNEL);
+	if (!fb->fb.screen_base) {
+		printk(KERN_ERR "CLCD: unable to map framebuffer\n");
+		return -ENOMEM;
+	}
+	fb->fb.fix.smem_start = dma;
+	fb->fb.fix.smem_len = FRAMESIZE;
+
+	return 0;
+}
+
+static void clcd_remove(struct clcd_fb *fb)
+{
+	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
+			fb->fb.screen_base, fb->fb.fix.smem_start);
+}
+
+static int clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
+{
+	return dma_mmap_writecombine(&fb->dev->dev, vma,
+			fb->fb.screen_base,
+			fb->fb.fix.smem_start,
+			fb->fb.fix.smem_len);
+}
+
+struct clcd_board clcd_plat_data = {
+	.name = "spear-clcd",
+	.check = clcdfb_check,
+	.decode = clcdfb_decode,
+	.setup = clcd_setup,
+	.mmap = clcd_mmap,
+	.remove = clcd_remove,
+};
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8b31fdf..24c919e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -307,10 +307,22 @@ config FB_ARMCLCD
 
 choice
 
-	depends on FB_ARMCLCD && (ARCH_LH7A40X || ARCH_LH7952X)
+	depends on FB_ARMCLCD && (ARCH_LH7A40X || ARCH_LH7952X || ARCH_SPEAR6XX || MACH_SPEAR300 || MACH_SPEAR320)
 	prompt "LCD Panel"
 	default FB_ARMCLCD_SHARP_LQ035Q7DB02
 
+config FB_ARMCLCD_SHARP_LQ043T1DG01
+	bool "SHARP LQ043T1DG01 CLCD 4.2\" TFT(480x272)"
+	help
+	  This is an implementation of the Sharp LQ043T1DG01, a 4.2"
+	  color TFT panel. The native resolution is 480x272.
+
+config FB_ARMCLCD_SAMSUNG_LMS700
+	bool "SAMSUNG CLCD 7\" TFT(800x480)"
+	help
+	  This is an implementation of the Samsung LMS700, a 7"
+	  color TFT panel. The native resolution is 800x480.
+
 config FB_ARMCLCD_SHARP_LQ035Q7DB02_HRTFT
 	bool "LogicPD LCD 3.5\" QVGA w/HRTFT IC"
 	help
-- 
1.7.2.2
