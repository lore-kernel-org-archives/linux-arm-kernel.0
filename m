From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon,  7 Mar 2011 10:19:28 +0900
Subject: [PATCH 2/2] ARM: EXYNOS4: Implement Clock gating for System MMU
In-Reply-To: <1299460768-4077-1-git-send-email-pullip.cho@samsung.com>
References: <1299460768-4077-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <1299460768-4077-3-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes the implementation of the clock gating
for System MMU. Initially, all System MMUs are not asserted
the system clock. Asserting the system clock to a System MMU
is enabled only when s5p_sysmmu_enable() is called. Likewise,
it is disabled only when s5p_sysmmu_disable() is called.
Therefore, clock gating on System MMUs are still invisible to
the outside of the System MMU driver.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 arch/arm/mach-exynos4/clock.c                   |   83 ++++++++++++++++++++++-
 arch/arm/mach-exynos4/dev-sysmmu.c              |   22 ++++++
 arch/arm/mach-exynos4/include/mach/regs-clock.h |    2 +
 arch/arm/mach-exynos4/include/mach/sysmmu.h     |    4 +
 arch/arm/plat-s5p/sysmmu.c                      |    6 ++
 5 files changed, 116 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 72d53d5..45ce79a 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -23,6 +23,7 @@
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
+#include <mach/sysmmu.h>
 
 static struct clk clk_sclk_hdmi27m = {
 	.name		= "sclk_hdmi27m",
@@ -81,11 +82,21 @@ static int exynos4_clksrc_mask_peril1_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKSRC_MASK_PERIL1, clk, enable);
 }
 
+static int exynos4_clk_ip_mfc_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP_MFC, clk, enable);
+}
+
 static int exynos4_clk_ip_cam_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_CAM, clk, enable);
 }
 
+static int exynos4_clk_ip_tv_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP_TV, clk, enable);
+}
+
 static int exynos4_clk_ip_image_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_IMAGE, clk, enable);
@@ -589,7 +600,77 @@ static struct clk init_clocks_off[] = {
 		.parent		= &clk_aclk_100.clk,
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 13),
-	},
+	}, {
+		.name		= "SYSMMU_MDMA",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_image_ctrl,
+		.ctrlbit	= (1 << 5),
+	}, {
+		.name		= "SYSMMU_FIMC0",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 7),
+	}, {
+		.name		= "SYSMMU_FIMC1",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 8),
+	}, {
+		.name		= "SYSMMU_FIMC2",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 9),
+	}, {
+		.name		= "SYSMMU_FIMC3",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 10),
+	}, {
+		.name		= "SYSMMU_JPEG",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 11),
+	}, {
+		.name		= "SYSMMU_FIMD0",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_lcd0_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "SYSMMU_FIMD1",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_lcd1_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "SYSMMU_PCIe",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 18),
+	}, {
+		.name		= "SYSMMU_G2D",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_image_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "SYSMMU_ROTATOR",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_image_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "SYSMMU_TV",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_tv_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "SYSMMU_MFC_L",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_mfc_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "SYSMMU_MFC_R",
+		.id		= -1,
+		.enable		= exynos4_clk_ip_mfc_ctrl,
+		.ctrlbit	= (1 << 2),
+	}
 };
 
 static struct clk init_clocks[] = {
diff --git a/arch/arm/mach-exynos4/dev-sysmmu.c b/arch/arm/mach-exynos4/dev-sysmmu.c
index 6889c9a..3b7cae0 100644
--- a/arch/arm/mach-exynos4/dev-sysmmu.c
+++ b/arch/arm/mach-exynos4/dev-sysmmu.c
@@ -208,3 +208,25 @@ struct platform_device exynos4_device_sysmmu = {
 	.resource	= exynos4_sysmmu_resource,
 };
 EXPORT_SYMBOL(exynos4_device_sysmmu);
+
+static struct clk *sysmmu_clk[S5P_SYSMMU_TOTAL_IPNUM];
+void sysmmu_clk_init(struct device *dev, sysmmu_ips ips)
+{
+	sysmmu_clk[ips] = clk_get(dev, sysmmu_ips_name[ips]);
+	if (IS_ERR(sysmmu_clk[ips]))
+		sysmmu_clk[ips] = NULL;
+	else
+		clk_put(sysmmu_clk[ips]);
+}
+
+void sysmmu_clk_enable(sysmmu_ips ips)
+{
+	if (sysmmu_clk[ips])
+		clk_enable(sysmmu_clk[ips]);
+}
+
+void sysmmu_clk_disable(sysmmu_ips ips)
+{
+	if (sysmmu_clk[ips])
+		clk_disable(sysmmu_clk[ips]);
+}
diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h b/arch/arm/mach-exynos4/include/mach/regs-clock.h
index ba8f91c..5c15084 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-clock.h
@@ -67,6 +67,8 @@
 #define S5P_CLKDIV_STAT_TOP		S5P_CLKREG(0x0C610)
 
 #define S5P_CLKGATE_IP_CAM		S5P_CLKREG(0x0C920)
+#define S5P_CLKGATE_IP_TV		S5P_CLKREG(0x0C924)
+#define S5P_CLKGATE_IP_MFC		S5P_CLKREG(0x0C928)
 #define S5P_CLKGATE_IP_IMAGE		S5P_CLKREG(0x0C930)
 #define S5P_CLKGATE_IP_LCD0		S5P_CLKREG(0x0C934)
 #define S5P_CLKGATE_IP_LCD1		S5P_CLKREG(0x0C938)
diff --git a/arch/arm/mach-exynos4/include/mach/sysmmu.h b/arch/arm/mach-exynos4/include/mach/sysmmu.h
index eff3dc3..6a5fbb5 100644
--- a/arch/arm/mach-exynos4/include/mach/sysmmu.h
+++ b/arch/arm/mach-exynos4/include/mach/sysmmu.h
@@ -39,4 +39,8 @@ extern const char *sysmmu_ips_name[EXYNOS4_SYSMMU_TOTAL_IPNUM];
 
 typedef enum exynos4_sysmmu_ips sysmmu_ips;
 
+void sysmmu_clk_init(struct device *dev, sysmmu_ips ips);
+void sysmmu_clk_enable(sysmmu_ips ips);
+void sysmmu_clk_disable(sysmmu_ips ips);
+
 #endif /* __ASM_ARM_ARCH_SYSMMU_H */
diff --git a/arch/arm/plat-s5p/sysmmu.c b/arch/arm/plat-s5p/sysmmu.c
index 89e024f..54f5edd 100644
--- a/arch/arm/plat-s5p/sysmmu.c
+++ b/arch/arm/plat-s5p/sysmmu.c
@@ -174,6 +174,8 @@ void s5p_sysmmu_set_tablebase_pgd(sysmmu_ips ips, unsigned long pgd)
 void s5p_sysmmu_enable(sysmmu_ips ips, unsigned long pgd)
 {
 	if (!is_sysmmu_active(ips)) {
+		sysmmu_clk_enable(ips);
+
 		__sysmmu_set_ptbase(ips, pgd);
 
 		__raw_writel(CTRL_ENABLE, sysmmusfrs[ips] + S5P_MMU_CTRL);
@@ -190,6 +192,7 @@ void s5p_sysmmu_disable(sysmmu_ips ips)
 	if (is_sysmmu_active(ips)) {
 		__raw_writel(CTRL_DISABLE, sysmmusfrs[ips] + S5P_MMU_CTRL);
 		set_sysmmu_inactive(ips);
+		sysmmu_clk_disable(ips);
 		dev_dbg(dev, "%s is disabled.\n", sysmmu_ips_name[ips]);
 	} else {
 		dev_dbg(dev, "%s is already disabled.\n", sysmmu_ips_name[ips]);
@@ -218,6 +221,9 @@ static int s5p_sysmmu_probe(struct platform_device *pdev)
 	for (i = 0; i < S5P_SYSMMU_TOTAL_IPNUM; i++) {
 		int irq;
 
+		sysmmu_clk_init(dev, i);
+		sysmmu_clk_disable(i);
+
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
 		if (!res) {
 			dev_err(dev, "Failed to get the resource of %s.\n",
-- 
1.7.1
