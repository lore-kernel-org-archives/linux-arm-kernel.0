From: Anson.Huang@nxp.com (Anson Huang)
Date: Sat, 27 Aug 2016 05:21:55 +0800
Subject: [PATCH] ARM: imx: use soc type instead of cpu type for i.MX
Message-ID: <1472246515-3707-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX is a SoC rather than a CPU, so for those names
of cpu_is_xxx and cpu_type etc., better to use soc_is_xxx
and soc_type etc. instead, this patch improves these names.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/anatop.c     |  6 ++---
 arch/arm/mach-imx/common.h     |  2 +-
 arch/arm/mach-imx/cpu-imx31.c  | 12 ++++-----
 arch/arm/mach-imx/cpu.c        | 36 +++++++++++++--------------
 arch/arm/mach-imx/mach-imx1.c  |  2 +-
 arch/arm/mach-imx/mach-imx25.c |  2 +-
 arch/arm/mach-imx/mach-imx51.c |  2 +-
 arch/arm/mach-imx/mach-imx53.c |  2 +-
 arch/arm/mach-imx/mach-imx6q.c | 10 ++++----
 arch/arm/mach-imx/mm-imx21.c   |  2 +-
 arch/arm/mach-imx/mm-imx27.c   |  2 +-
 arch/arm/mach-imx/mm-imx3.c    |  4 +--
 arch/arm/mach-imx/mxc.h        | 56 +++++++++++++++++++++---------------------
 arch/arm/mach-imx/pm-imx6.c    | 14 +++++------
 14 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 649a84c..071380c8 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -81,7 +81,7 @@ void imx_anatop_pre_suspend(void)
 
 	imx_anatop_enable_fet_odrive(true);
 
-	if (cpu_is_imx6sl())
+	if (soc_is_imx6sl())
 		imx_anatop_disconnect_high_snvs(true);
 }
 
@@ -94,7 +94,7 @@ void imx_anatop_post_resume(void)
 
 	imx_anatop_enable_fet_odrive(false);
 
-	if (cpu_is_imx6sl())
+	if (soc_is_imx6sl())
 		imx_anatop_disconnect_high_snvs(false);
 
 }
@@ -168,7 +168,7 @@ void __init imx_init_revision_from_anatop(void)
 		revision = digprog & 0xff;
 	}
 
-	mxc_set_cpu_type(digprog >> 16 & 0xff);
+	mxc_set_soc_type(digprog >> 16 & 0xff);
 	imx_set_soc_revision(revision);
 }
 
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index bcca481..2130ee0 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -46,7 +46,7 @@ int mx35_clocks_init(void);
 int mx31_clocks_init_dt(void);
 struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
-void mxc_set_cpu_type(unsigned int type);
+void mxc_set_soc_type(unsigned int type);
 void mxc_restart(enum reboot_mode, const char *);
 void mxc_arch_reset_init(void __iomem *);
 void imx1_reset_init(void __iomem *);
diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
index 3daf195..33d36d7 100644
--- a/arch/arm/mach-imx/cpu-imx31.c
+++ b/arch/arm/mach-imx/cpu-imx31.c
@@ -22,7 +22,7 @@ static struct {
 	u8 srev;
 	const char *name;
 	unsigned int rev;
-} mx31_cpu_type[] = {
+} mx31_soc_type[] = {
 	{ .srev = 0x00, .name = "i.MX31(L)", .rev = IMX_CHIP_REVISION_1_0 },
 	{ .srev = 0x10, .name = "i.MX31",    .rev = IMX_CHIP_REVISION_1_1 },
 	{ .srev = 0x11, .name = "i.MX31L",   .rev = IMX_CHIP_REVISION_1_1 },
@@ -42,11 +42,11 @@ static int mx31_read_cpu_rev(void)
 	srev = imx_readl(MX31_IO_ADDRESS(MX31_IIM_BASE_ADDR + MXC_IIMSREV));
 	srev &= 0xff;
 
-	for (i = 0; i < ARRAY_SIZE(mx31_cpu_type); i++)
-		if (srev == mx31_cpu_type[i].srev) {
-			imx_print_silicon_rev(mx31_cpu_type[i].name,
-						mx31_cpu_type[i].rev);
-			return mx31_cpu_type[i].rev;
+	for (i = 0; i < ARRAY_SIZE(mx31_soc_type); i++)
+		if (srev == mx31_soc_type[i].srev) {
+			imx_print_silicon_rev(mx31_soc_type[i].name,
+						mx31_soc_type[i].rev);
+			return mx31_soc_type[i].rev;
 		}
 
 	imx_print_silicon_rev("i.MX31", IMX_CHIP_REVISION_UNKNOWN);
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index b3347d3..5519cf4 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -9,12 +9,12 @@
 #include "hardware.h"
 #include "common.h"
 
-unsigned int __mxc_cpu_type;
+unsigned int __mxc_soc_type;
 static unsigned int imx_soc_revision;
 
-void mxc_set_cpu_type(unsigned int type)
+void mxc_set_soc_type(unsigned int type)
 {
-	__mxc_cpu_type = type;
+	__mxc_soc_type = type;
 }
 
 void imx_set_soc_revision(unsigned int rev)
@@ -91,47 +91,47 @@ struct device * __init imx_soc_device_init(void)
 	if (ret)
 		goto free_soc;
 
-	switch (__mxc_cpu_type) {
-	case MXC_CPU_MX1:
+	switch (__mxc_soc_type) {
+	case MXC_SOC_MX1:
 		soc_id = "i.MX1";
 		break;
-	case MXC_CPU_MX21:
+	case MXC_SOC_MX21:
 		soc_id = "i.MX21";
 		break;
-	case MXC_CPU_MX25:
+	case MXC_SOC_MX25:
 		soc_id = "i.MX25";
 		break;
-	case MXC_CPU_MX27:
+	case MXC_SOC_MX27:
 		soc_id = "i.MX27";
 		break;
-	case MXC_CPU_MX31:
+	case MXC_SOC_MX31:
 		soc_id = "i.MX31";
 		break;
-	case MXC_CPU_MX35:
+	case MXC_SOC_MX35:
 		soc_id = "i.MX35";
 		break;
-	case MXC_CPU_MX51:
+	case MXC_SOC_MX51:
 		soc_id = "i.MX51";
 		break;
-	case MXC_CPU_MX53:
+	case MXC_SOC_MX53:
 		soc_id = "i.MX53";
 		break;
-	case MXC_CPU_IMX6SL:
+	case MXC_SOC_IMX6SL:
 		soc_id = "i.MX6SL";
 		break;
-	case MXC_CPU_IMX6DL:
+	case MXC_SOC_IMX6DL:
 		soc_id = "i.MX6DL";
 		break;
-	case MXC_CPU_IMX6SX:
+	case MXC_SOC_IMX6SX:
 		soc_id = "i.MX6SX";
 		break;
-	case MXC_CPU_IMX6Q:
+	case MXC_SOC_IMX6Q:
 		soc_id = "i.MX6Q";
 		break;
-	case MXC_CPU_IMX6UL:
+	case MXC_SOC_IMX6UL:
 		soc_id = "i.MX6UL";
 		break;
-	case MXC_CPU_IMX7D:
+	case MXC_SOC_IMX7D:
 		soc_id = "i.MX7D";
 		break;
 	default:
diff --git a/arch/arm/mach-imx/mach-imx1.c b/arch/arm/mach-imx/mach-imx1.c
index de5ab8d..36c9158d 100644
--- a/arch/arm/mach-imx/mach-imx1.c
+++ b/arch/arm/mach-imx/mach-imx1.c
@@ -18,7 +18,7 @@
 
 static void __init imx1_init_early(void)
 {
-	mxc_set_cpu_type(MXC_CPU_MX1);
+	mxc_set_soc_type(MXC_SOC_MX1);
 }
 
 static void __init imx1_init_irq(void)
diff --git a/arch/arm/mach-imx/mach-imx25.c b/arch/arm/mach-imx/mach-imx25.c
index 32dcb5e..23e28cd 100644
--- a/arch/arm/mach-imx/mach-imx25.c
+++ b/arch/arm/mach-imx/mach-imx25.c
@@ -20,7 +20,7 @@
 
 static void __init imx25_init_early(void)
 {
-	mxc_set_cpu_type(MXC_CPU_MX25);
+	mxc_set_soc_type(MXC_SOC_MX25);
 }
 
 static void __init mx25_init_irq(void)
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 3835b6a..35b19bb 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -22,7 +22,7 @@
 
 static void __init imx51_init_early(void)
 {
-	mxc_set_cpu_type(MXC_CPU_MX51);
+	mxc_set_soc_type(MXC_SOC_MX51);
 }
 
 /*
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 07c2e8d..730801d 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -25,7 +25,7 @@
 
 static void __init imx53_init_early(void)
 {
-	mxc_set_cpu_type(MXC_CPU_MX53);
+	mxc_set_soc_type(MXC_SOC_MX53);
 }
 
 static void __init imx53_dt_init(void)
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 97fd251..9896015 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -266,10 +266,10 @@ static void __init imx6q_init_machine(void)
 {
 	struct device *parent;
 
-	if (cpu_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_2_0)
+	if (soc_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_2_0)
 		imx_print_silicon_rev("i.MX6QP", IMX_CHIP_REVISION_1_0);
 	else
-		imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
+		imx_print_silicon_rev(soc_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
 				imx_get_soc_revision());
 
 	parent = imx_soc_device_init();
@@ -281,7 +281,7 @@ static void __init imx6q_init_machine(void)
 	of_platform_default_populate(NULL, NULL, parent);
 
 	imx_anatop_init();
-	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
+	soc_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
 	imx6q_1588_init();
 	imx6q_axi_init();
 }
@@ -322,13 +322,13 @@ static void __init imx6q_opp_check_speed_grading(struct device *cpu_dev)
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
-	if ((val != OCOTP_CFG3_SPEED_1P2GHZ) && cpu_is_imx6q())
+	if ((val != OCOTP_CFG3_SPEED_1P2GHZ) && soc_is_imx6q())
 		if (dev_pm_opp_disable(cpu_dev, 1200000000))
 			pr_warn("failed to disable 1.2 GHz OPP\n");
 	if (val < OCOTP_CFG3_SPEED_996MHZ)
 		if (dev_pm_opp_disable(cpu_dev, 996000000))
 			pr_warn("failed to disable 996 MHz OPP\n");
-	if (cpu_is_imx6q()) {
+	if (soc_is_imx6q()) {
 		if (val != OCOTP_CFG3_SPEED_852MHZ)
 			if (dev_pm_opp_disable(cpu_dev, 852000000))
 				pr_warn("failed to disable 852 MHz OPP\n");
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 2e91ab2..a5e6413 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -65,7 +65,7 @@ void __init mx21_map_io(void)
 
 void __init imx21_init_early(void)
 {
-	mxc_set_cpu_type(MXC_CPU_MX21);
+	mxc_set_soc_type(MXC_SOC_MX21);
 	imx_iomuxv1_init(MX21_IO_ADDRESS(MX21_GPIO_BASE_ADDR),
 			MX21_NUM_GPIO_PORT);
 }
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 862b9b7..4b5128b 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -65,7 +65,7 @@ void __init mx27_map_io(void)
 
 void __init imx27_init_early(void)
 {
-	mxc_set_cpu_type(MXC_CPU_MX27);
+	mxc_set_soc_type(MXC_SOC_MX27);
 	imx_iomuxv1_init(MX27_IO_ADDRESS(MX27_GPIO_BASE_ADDR),
 			MX27_NUM_GPIO_PORT);
 }
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 7638a35..b7261c0 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -145,7 +145,7 @@ static void imx31_idle(void)
 
 void __init imx31_init_early(void)
 {
-	mxc_set_cpu_type(MXC_CPU_MX31);
+	mxc_set_soc_type(MXC_SOC_MX31);
 	arch_ioremap_caller = imx3_ioremap_caller;
 	arm_pm_idle = imx31_idle;
 	mx3_ccm_base = MX31_IO_ADDRESS(MX31_CCM_BASE_ADDR);
@@ -238,7 +238,7 @@ static void imx35_idle(void)
 
 void __init imx35_init_early(void)
 {
-	mxc_set_cpu_type(MXC_CPU_MX35);
+	mxc_set_soc_type(MXC_SOC_MX35);
 	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
 	arm_pm_idle = imx35_idle;
 	arch_ioremap_caller = imx3_ioremap_caller;
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 34f2ff6..89a0c0f 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -26,61 +26,61 @@
 #error "Do not include directly."
 #endif
 
-#define MXC_CPU_MX1		1
-#define MXC_CPU_MX21		21
-#define MXC_CPU_MX25		25
-#define MXC_CPU_MX27		27
-#define MXC_CPU_MX31		31
-#define MXC_CPU_MX35		35
-#define MXC_CPU_MX51		51
-#define MXC_CPU_MX53		53
-#define MXC_CPU_IMX6SL		0x60
-#define MXC_CPU_IMX6DL		0x61
-#define MXC_CPU_IMX6SX		0x62
-#define MXC_CPU_IMX6Q		0x63
-#define MXC_CPU_IMX6UL		0x64
-#define MXC_CPU_IMX7D		0x72
+#define MXC_SOC_MX1		1
+#define MXC_SOC_MX21		21
+#define MXC_SOC_MX25		25
+#define MXC_SOC_MX27		27
+#define MXC_SOC_MX31		31
+#define MXC_SOC_MX35		35
+#define MXC_SOC_MX51		51
+#define MXC_SOC_MX53		53
+#define MXC_SOC_IMX6SL		0x60
+#define MXC_SOC_IMX6DL		0x61
+#define MXC_SOC_IMX6SX		0x62
+#define MXC_SOC_IMX6Q		0x63
+#define MXC_SOC_IMX6UL		0x64
+#define MXC_SOC_IMX7D		0x72
 
 #define IMX_DDR_TYPE_LPDDR2		1
 
 #ifndef __ASSEMBLY__
-extern unsigned int __mxc_cpu_type;
+extern unsigned int __mxc_soc_type;
 
 #ifdef CONFIG_SOC_IMX6SL
-static inline bool cpu_is_imx6sl(void)
+static inline bool soc_is_imx6sl(void)
 {
-	return __mxc_cpu_type == MXC_CPU_IMX6SL;
+	return __mxc_soc_type == MXC_SOC_IMX6SL;
 }
 #else
-static inline bool cpu_is_imx6sl(void)
+static inline bool soc_is_imx6sl(void)
 {
 	return false;
 }
 #endif
 
-static inline bool cpu_is_imx6dl(void)
+static inline bool soc_is_imx6dl(void)
 {
-	return __mxc_cpu_type == MXC_CPU_IMX6DL;
+	return __mxc_soc_type == MXC_SOC_IMX6DL;
 }
 
-static inline bool cpu_is_imx6sx(void)
+static inline bool soc_is_imx6sx(void)
 {
-	return __mxc_cpu_type == MXC_CPU_IMX6SX;
+	return __mxc_soc_type == MXC_SOC_IMX6SX;
 }
 
-static inline bool cpu_is_imx6ul(void)
+static inline bool soc_is_imx6ul(void)
 {
-	return __mxc_cpu_type == MXC_CPU_IMX6UL;
+	return __mxc_soc_type == MXC_SOC_IMX6UL;
 }
 
-static inline bool cpu_is_imx6q(void)
+static inline bool soc_is_imx6q(void)
 {
-	return __mxc_cpu_type == MXC_CPU_IMX6Q;
+	return __mxc_soc_type == MXC_SOC_IMX6Q;
 }
 
-static inline bool cpu_is_imx7d(void)
+static inline bool soc_is_imx7d(void)
 {
-	return __mxc_cpu_type == MXC_CPU_IMX7D;
+	return __mxc_soc_type == MXC_SOC_IMX7D;
 }
 
 struct cpu_op {
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 67bab74..4824bea 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -293,9 +293,9 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= 0x2 << BP_CLPCR_LPM;
 		val &= ~BM_CLPCR_VSTBY;
 		val &= ~BM_CLPCR_SBYOS;
-		if (cpu_is_imx6sl())
+		if (soc_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
+		if (soc_is_imx6sl() || soc_is_imx6sx() || soc_is_imx6ul())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -310,9 +310,9 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= 0x3 << BP_CLPCR_STBY_COUNT;
 		val |= BM_CLPCR_VSTBY;
 		val |= BM_CLPCR_SBYOS;
-		if (cpu_is_imx6sl())
+		if (soc_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
+		if (soc_is_imx6sl() || soc_is_imx6sx() || soc_is_imx6ul())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -369,11 +369,11 @@ static int imx6q_pm_enter(suspend_state_t state)
 		imx6_set_lpm(STOP_POWER_ON);
 		imx6q_set_int_mem_clk_lpm(true);
 		imx_gpc_pre_suspend(false);
-		if (cpu_is_imx6sl())
+		if (soc_is_imx6sl())
 			imx6sl_set_wait_clk(true);
 		/* Zzz ... */
 		cpu_do_idle();
-		if (cpu_is_imx6sl())
+		if (soc_is_imx6sl())
 			imx6sl_set_wait_clk(false);
 		imx_gpc_post_resume();
 		imx6_set_lpm(WAIT_CLOCKED);
@@ -392,7 +392,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 		imx_anatop_pre_suspend();
 		/* Zzz ... */
 		cpu_suspend(0, imx6q_suspend_finish);
-		if (cpu_is_imx6q() || cpu_is_imx6dl())
+		if (soc_is_imx6q() || soc_is_imx6dl())
 			imx_smp_prepare();
 		imx_anatop_post_resume();
 		imx_gpc_post_resume();
-- 
1.9.1
