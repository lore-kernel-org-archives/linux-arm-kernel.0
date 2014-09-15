From: b20788@freescale.com (Anson Huang)
Date: Mon, 15 Sep 2014 15:44:45 +0800
Subject: [PATCH 1/2] ARM: imx: replace cpu type check with ddr type check
Message-ID: <1410767086-3462-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the DDR/IO and MMDC setting are different on LPDDR2 and DDR3,
we used cpu type to decide how to do these settings in suspend
before which is NOT flexible, take i.MX6SL for example, although
it has LPDDR2 on EVK board, but users can also use DDR3 on other
boards, so it is better to read the DDR type from MMDC then decide
how to do related settings.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/common.h       |    1 +
 arch/arm/mach-imx/mmdc.c         |   17 +++++++++++++++++
 arch/arm/mach-imx/pm-imx6.c      |   10 +++-------
 arch/arm/mach-imx/suspend-imx6.S |   16 +++++++++-------
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 1dabf43..23c84e6 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -116,6 +116,7 @@ void imx_anatop_post_resume(void);
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
 void imx6q_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
+int imx_mmdc_get_ddr_type(void);
 
 void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 7a9686a..3729d90 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -21,6 +21,12 @@
 #define BP_MMDC_MAPSR_PSD	0
 #define BP_MMDC_MAPSR_PSS	4
 
+#define MMDC_MDMISC		0x18
+#define BM_MMDC_MDMISC_DDR_TYPE	0x18
+#define BP_MMDC_MDMISC_DDR_TYPE	0x3
+
+static int ddr_type;
+
 static int imx_mmdc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -31,6 +37,12 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 	mmdc_base = of_iomap(np, 0);
 	WARN_ON(!mmdc_base);
 
+	reg = mmdc_base + MMDC_MDMISC;
+	/* Get ddr type */
+	val = readl_relaxed(reg);
+	ddr_type = (val & BM_MMDC_MDMISC_DDR_TYPE) >>
+		 BP_MMDC_MDMISC_DDR_TYPE;
+
 	reg = mmdc_base + MMDC_MAPSR;
 
 	/* Enable automatic power saving */
@@ -51,6 +63,11 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+int imx_mmdc_get_ddr_type(void)
+{
+	return ddr_type;
+}
+
 static struct of_device_id imx_mmdc_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-mmdc", },
 	{ /* sentinel */ }
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 5c3af8f..c653dd4 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -88,7 +88,7 @@ struct imx6_pm_base {
 };
 
 struct imx6_pm_socdata {
-	u32 cpu_type;
+	u32 ddr_type;
 	const char *mmdc_compat;
 	const char *src_compat;
 	const char *iomuxc_compat;
@@ -138,7 +138,6 @@ static const u32 imx6sx_mmdc_io_offset[] __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
-	.cpu_type = MXC_CPU_IMX6Q,
 	.mmdc_compat = "fsl,imx6q-mmdc",
 	.src_compat = "fsl,imx6q-src",
 	.iomuxc_compat = "fsl,imx6q-iomuxc",
@@ -148,7 +147,6 @@ static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
-	.cpu_type = MXC_CPU_IMX6DL,
 	.mmdc_compat = "fsl,imx6q-mmdc",
 	.src_compat = "fsl,imx6q-src",
 	.iomuxc_compat = "fsl,imx6dl-iomuxc",
@@ -158,7 +156,6 @@ static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
-	.cpu_type = MXC_CPU_IMX6SL,
 	.mmdc_compat = "fsl,imx6sl-mmdc",
 	.src_compat = "fsl,imx6sl-src",
 	.iomuxc_compat = "fsl,imx6sl-iomuxc",
@@ -168,7 +165,6 @@ static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
 };
 
 static const struct imx6_pm_socdata imx6sx_pm_data __initconst = {
-	.cpu_type = MXC_CPU_IMX6SX,
 	.mmdc_compat = "fsl,imx6sx-mmdc",
 	.src_compat = "fsl,imx6sx-src",
 	.iomuxc_compat = "fsl,imx6sx-iomuxc",
@@ -187,7 +183,7 @@ static const struct imx6_pm_socdata imx6sx_pm_data __initconst = {
 struct imx6_cpu_pm_info {
 	phys_addr_t pbase; /* The physical address of pm_info. */
 	phys_addr_t resume_addr; /* The physical resume address for asm code */
-	u32 cpu_type;
+	u32 ddr_type;
 	u32 pm_info_size; /* Size of pm_info. */
 	struct imx6_pm_base mmdc_base;
 	struct imx6_pm_base src_base;
@@ -522,7 +518,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 		goto pl310_cache_map_failed;
 	}
 
-	pm_info->cpu_type = socdata->cpu_type;
+	pm_info->ddr_type = imx_mmdc_get_ddr_type();
 	pm_info->mmdc_io_num = socdata->mmdc_io_num;
 	mmdc_offset_array = socdata->mmdc_io_offset;
 
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index ca4ea2d..c224c9c 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -45,7 +45,7 @@
  */
 #define PM_INFO_PBASE_OFFSET			0x0
 #define PM_INFO_RESUME_ADDR_OFFSET		0x4
-#define PM_INFO_CPU_TYPE_OFFSET			0x8
+#define PM_INFO_DDR_TYPE_OFFSET			0x8
 #define PM_INFO_PM_INFO_SIZE_OFFSET		0xC
 #define PM_INFO_MX6Q_MMDC_P_OFFSET		0x10
 #define PM_INFO_MX6Q_MMDC_V_OFFSET		0x14
@@ -72,6 +72,8 @@
 #define MX6Q_GPC_IMR4	0x14
 #define MX6Q_CCM_CCR	0x0
 
+#define DDR_TYPE_LPDDR2	0x1
+
 	.align 3
 
 	.macro  sync_l2_cache
@@ -110,7 +112,7 @@
 	ldreq	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
 	ldrne	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
 
-	cmp 	r3, #MXC_CPU_IMX6SL
+	cmp	r3, #DDR_TYPE_LPDDR2
 	bne	4f
 
 	/* reset read FIFO, RST_RD_FIFO */
@@ -151,7 +153,7 @@
 ENTRY(imx6_suspend)
 	ldr	r1, [r0, #PM_INFO_PBASE_OFFSET]
 	ldr	r2, [r0, #PM_INFO_RESUME_ADDR_OFFSET]
-	ldr	r3, [r0, #PM_INFO_CPU_TYPE_OFFSET]
+	ldr	r3, [r0, #PM_INFO_DDR_TYPE_OFFSET]
 	ldr	r4, [r0, #PM_INFO_PM_INFO_SIZE_OFFSET]
 
 	/*
@@ -209,8 +211,8 @@ poll_dvfs_set:
 	ldr	r7, [r0, #PM_INFO_MMDC_IO_NUM_OFFSET]
 	ldr	r8, =PM_INFO_MMDC_IO_VAL_OFFSET
 	add	r8, r8, r0
-	/* i.MX6SL's last 3 IOs need special setting */
-	cmp	r3, #MXC_CPU_IMX6SL
+	/* LPDDR2's last 3 IOs need special setting */
+	cmp	r3, #DDR_TYPE_LPDDR2
 	subeq	r7, r7, #0x3
 set_mmdc_io_lpm:
 	ldr	r9, [r8], #0x8
@@ -218,7 +220,7 @@ set_mmdc_io_lpm:
 	subs	r7, r7, #0x1
 	bne	set_mmdc_io_lpm
 
-	cmp 	r3, #MXC_CPU_IMX6SL
+	cmp 	r3, #DDR_TYPE_LPDDR2
 	bne	set_mmdc_io_lpm_done
 	ldr	r6, =0x1000
 	ldr	r9, [r8], #0x8
@@ -324,7 +326,7 @@ resume:
 	str	r7, [r11, #MX6Q_SRC_GPR1]
 	str	r7, [r11, #MX6Q_SRC_GPR2]
 
-	ldr	r3, [r0, #PM_INFO_CPU_TYPE_OFFSET]
+	ldr	r3, [r0, #PM_INFO_DDR_TYPE_OFFSET]
 	mov	r5, #0x1
 	resume_mmdc
 
-- 
1.7.9.5
