From: vikas.sajjan@linaro.org (Vikas Sajjan)
Date: Wed, 11 Dec 2013 16:25:15 +0545
Subject: [PATCH 1/2] ARM: EXYNOS: Add initial support of PMU for Exynos5260
In-Reply-To: <1386758416-31065-1-git-send-email-vikas.sajjan@linaro.org>
References: <1386758416-31065-1-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <1386758416-31065-2-git-send-email-vikas.sajjan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds initial PMU support for Exynos5260

Following are the changes done
------------------------------

1) Added initial PMU support for exynos5260

2) Added exynos5260_iodesc for mapping 5260 specific SFRs. We modified
exynos5_map_io so that in case of exynos5260 only exynos5260_iodesc can
be initialized.

3) Added new macros for WAKEUP MASK for 5260, and modified exynos_pm_drvinit
accrodingly.

Change-Id: Ie585d47a499c17813cfe0e5a668072ca7b13ffb5
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/common.c                |  89 ++++++++++-
 arch/arm/mach-exynos/common.h                |   5 +
 arch/arm/mach-exynos/include/mach/map.h      |  17 +++
 arch/arm/mach-exynos/include/mach/regs-pmu.h | 221 +++++++++++++++++++++++++++
 arch/arm/mach-exynos/pm.c                    |  33 +++-
 arch/arm/mach-exynos/pmu.c                   | 140 +++++++++++++++++
 arch/arm/plat-samsung/include/plat/map-s5p.h |  14 ++
 7 files changed, 508 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 5eb77d1..70da5c4 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -272,10 +272,90 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 
 static struct map_desc exynos5260_iodesc[] __initdata = {
 	{
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_PERI,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_PERI),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_EGL,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_EGL),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_KFC,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_KFC),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_G2D,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_G2D),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_MIF,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_MIF),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_MFC,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_MFC),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_G3D,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_G3D),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_FSYS,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_FSYS),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_AUD,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_AUD),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_ISP,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_ISP),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_GSCL,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_GSCL),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_SYS_DISP,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYS_DISP),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
+		.pfn		= __phys_to_pfn(EXYNOS5_PA_WATCHDOG),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SROMC,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SROMC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SYSRAM,
+		.pfn		= __phys_to_pfn(EXYNOS5_PA_SYSRAM),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
 		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
 		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYSRAM_NS),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_PMU,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_PMU),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
 	},
 };
 
@@ -386,11 +466,14 @@ static void __init exynos4_map_io(void)
 
 static void __init exynos5_map_io(void)
 {
-	iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
-	if (soc_is_exynos5260())
-		iotable_init(exynos5260_iodesc, ARRAY_SIZE(exynos5260_iodesc));
+	if (!soc_is_exynos5260())
+		iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
+
 	if (soc_is_exynos5250())
 		iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
+
+	if (soc_is_exynos5260())
+		iotable_init(exynos5260_iodesc, ARRAY_SIZE(exynos5260_iodesc));
 }
 
 struct bus_type exynos_subsys = {
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index ff9b6a9..e2cabfe 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -47,6 +47,11 @@ enum sys_powerdown {
 	NUM_SYS_POWERDOWN,
 };
 
+enum running_cpu {
+	KFC,
+	ARM,
+};
+
 extern unsigned long l2x0_regs_phys;
 struct exynos_pmu_conf {
 	void __iomem *reg;
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index bd6fa02..cc190b9 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -31,6 +31,23 @@
 #define EXYNOS5250_PA_SYSRAM_NS		0x0204F000
 #define EXYNOS5260_PA_SYSRAM_NS		0x02073000
 
+#define EXYNOS5260_PA_PMU				0x10D50000
+#define EXYNOS5260_PA_SROMC				0x12180000
+#define EXYNOS5260_PA_PWM				0x12D90000
+
+#define EXYNOS5260_PA_SYS_PERI				0x10220000
+#define EXYNOS5260_PA_SYS_MIF				0x10D00000
+#define EXYNOS5260_PA_SYS_MFC				0x110A0000
+#define EXYNOS5260_PA_SYS_KFC				0x10710000
+#define EXYNOS5260_PA_SYS_ISP				0x133E0000
+#define EXYNOS5260_PA_SYS_GSCL				0x13F20000
+#define EXYNOS5260_PA_SYS_G3D				0x11850000
+#define EXYNOS5260_PA_SYS_G2D				0x10A20000
+#define EXYNOS5260_PA_SYS_FSYS				0x122F0000
+#define EXYNOS5260_PA_SYS_EGL				0x10610000
+#define EXYNOS5260_PA_SYS_DISP				0x14540000
+#define EXYNOS5260_PA_SYS_AUD				0x128F0000
+
 #define EXYNOS_PA_CHIPID		0x10000000
 
 #define EXYNOS4_PA_SYSCON		0x10010000
diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index 09ae29a..ac53f85 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -125,6 +125,25 @@
 #define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
 #define S5P_ARM_CORE1_OPTION			S5P_PMUREG(0x2088)
 
+#define EXYNOS_ARM_CORE_OPTION(_nr)             (S5P_ARM_CORE0_OPTION \
+						+ ((_nr) * 0x80))
+#define EXYNOS_ARM_CORE_STATUS(_nr)             (S5P_ARM_CORE0_STATUS \
+						+ ((_nr) * 0x80))
+#define EXYNOS_ARM_CORE_CONFIGURATION(_nr)      \
+		(S5P_ARM_CORE0_CONFIGURATION + ((_nr) * 0x80))
+#define EXYNOS_CORE_LOCAL_PWR_EN                0xf
+
+#define EXYNOS_ARM_COMMON_CONFIGURATION         S5P_PMUREG(0x2500)
+#define EXYNOS_ARM_COMMON_STATUS                S5P_PMUREG(0x2504)
+#define EXYNOS_COMMON_CONFIGURATION(_nr)        \
+		(EXYNOS_ARM_COMMON_CONFIGURATION + ((_nr) * 0x80))
+#define EXYNOS_COMMON_STATUS(_nr)               \
+		(EXYNOS_COMMON_CONFIGURATION(_nr) + 0x4)
+#define EXYNOS_COMMON_OPTION(_nr)               \
+		(EXYNOS_COMMON_CONFIGURATION(_nr) + 0x8)
+
+#define EXYNOS_PS_HOLD_CONTROL			S5P_PMUREG(0x330c)
+
 #define S5P_ARM_COMMON_OPTION			S5P_PMUREG(0x2408)
 #define S5P_TOP_PWR_OPTION			S5P_PMUREG(0x2C48)
 #define S5P_CAM_OPTION				S5P_PMUREG(0x3C08)
@@ -227,6 +246,13 @@
 
 /* For EXYNOS5 */
 
+/* PS_HOLD_CONTROL */
+
+#define EXYNOS_PS_HOLD_CONTROL			S5P_PMUREG(0x330c)
+
+#define EXYNOS_PS_HOLD_EN			(1 << 31)
+#define EXYNOS_PS_HOLD_OUTPUT_HIGH		(3 << 8)
+
 #define EXYNOS5_SYS_I2C_CFG					S5P_SYSREG(0x0234)
 
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				S5P_PMUREG(0x0408)
@@ -369,4 +395,199 @@
 
 #define EXYNOS5_OPTION_USE_RETENTION				(1 << 4)
 
+/* Exynos5260 specific Sys Regs */
+#define EXYNOS5260_SYSREG_PERI(x)	(EXYNOS5260_VA_SYS_PERI + (x))
+#define EXYNOS5260_SYSREG_EGL(x)	(EXYNOS5260_VA_SYS_EGL + (x))
+#define EXYNOS5260_SYSREG_KFC(x)	(EXYNOS5260_VA_SYS_KFC + (x))
+#define EXYNOS5260_SYSREG_G2D(x)	(EXYNOS5260_VA_SYS_G2D + (x))
+#define EXYNOS5260_SYSREG_MIF(x)	(EXYNOS5260_VA_SYS_MIF + (x))
+#define EXYNOS5260_SYSREG_MFC(x)	(EXYNOS5260_VA_SYS_MFC + (x))
+#define EXYNOS5260_SYSREG_G3D(x)	(EXYNOS5260_VA_SYS_G3D + (x))
+#define EXYNOS5260_SYSREG_FSYS(x)	(EXYNOS5260_VA_SYS_FSYS + (x))
+#define EXYNOS5260_SYSREG_AUD(x)	(EXYNOS5260_VA_SYS_AUD + (x))
+#define EXYNOS5260_SYSREG_ISP(x)	(EXYNOS5260_VA_SYS_ISP + (x))
+#define EXYNOS5260_SYSREG_GSCL(x)	(EXYNOS5260_VA_SYS_GSCL + (x))
+#define EXYNOS5260_SYSREG_DISP(x)	(EXYNOS5260_VA_SYS_DISP + (x))
+
+#define EXYNOS5260_SYS_DISP1_BLK_CFG	EXYNOS5260_SYSREG_DISP(0x0)
+
+#define EXYNOS5260_CORE_LOCAL_PWR_EN				0xf
+#define EXYNOS5260_CPUS_PER_CLUSTER				4
+#define EXYNOS5260_USE_DELAYED_RESET_ASSERTION			(1 << 12)
+
+#define EXYNOS5260_WAKEUP_STAT2			S5P_PMUREG(0x0604)
+#define EXYNOS5260_WAKEUP_STAT3			S5P_PMUREG(0x0608)
+#define EXYNOS5260_EINT_WAKEUP_MASK		S5P_PMUREG(0x060C)
+#define EXYNOS5260_WAKEUP_MASK			S5P_PMUREG(0x0610)
+#define EXYNOS5260_WAKEUP_MASK2			S5P_PMUREG(0x0614)
+#define EXYNOS5260_WAKEUP_MASK3			S5P_PMUREG(0x0618)
+
+
+/* Exynos5260 specific PMU SYS_PWR_REGs */
+#define	EXYNOS5260_A15_EGL0_SYS_PWR_REG			S5P_PMUREG(0x1000)
+#define	EXYNOS5260_DIS_IRQ_A15_EGL0_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1004)
+#define	EXYNOS5260_DIS_IRQ_A15_EGL0_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1008)
+#define	EXYNOS5260_DIS_IRQ_A15_EGL0_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x100C)
+#define	EXYNOS5260_A15_EGL1_SYS_PWR_REG			S5P_PMUREG(0x1010)
+#define	EXYNOS5260_DIS_IRQ_A15_EGL1_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1014)
+#define	EXYNOS5260_DIS_IRQ_A15_EGL1_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1018)
+#define	EXYNOS5260_DIS_IRQ_A15_EGL1_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x101C)
+#define	EXYNOS5260_A7_KFC0_SYS_PWR_REG			S5P_PMUREG(0x1040)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC0_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1044)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC0_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1048)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC0_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x104C)
+#define	EXYNOS5260_A7_KFC1_SYS_PWR_REG			S5P_PMUREG(0x1050)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC1_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1054)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC1_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1058)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC1_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x105C)
+#define	EXYNOS5260_A7_KFC2_SYS_PWR_REG			S5P_PMUREG(0x1060)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC2_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1064)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC2_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1068)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC2_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x106C)
+#define	EXYNOS5260_A7_KFC3_SYS_PWR_REG			S5P_PMUREG(0x1070)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC3_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x1074)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC3_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x1078)
+#define	EXYNOS5260_DIS_IRQ_A7_KFC3_EGLSEQ_SYS_PWR_REG	S5P_PMUREG(0x107C)
+#define	EXYNOS5260_CORTEXA15_NONEAGLE_SYS_PWR_REG	S5P_PMUREG(0x1080)
+#define	EXYNOS5260_CORTEXA7_NONEAGLE_SYS_PWR_REG	S5P_PMUREG(0x1084)
+#define	EXYNOS5260_A5IS_SYS_PWR_REG			S5P_PMUREG(0x10B0)
+#define	EXYNOS5260_DIS_IRQ_A5IS_LOCAL_SYS_PWR_REG	S5P_PMUREG(0x10B4)
+#define	EXYNOS5260_DIS_IRQ_A5IS_CNTRL_SYS_PWR_REG	S5P_PMUREG(0x10B8)
+#define	EXYNOS5260_CORTEXA15_L2_SYS_PWR_REG		S5P_PMUREG(0x10C0)
+#define	EXYNOS5260_CORTEXA7_L2_SYS_PWR_REG		S5P_PMUREG(0x10C4)
+#define	EXYNOS5260_CLKSTOP_CMU_TOP_SYS_PWR_REG		S5P_PMUREG(0x1100)
+#define	EXYNOS5260_CLKRUN_CMU_TOP_SYS_PWR_REG		S5P_PMUREG(0x1104)
+#define	EXYNOS5260_RESET_CMU_TOP_SYS_PWR_REG		S5P_PMUREG(0x110C)
+#define	EXYNOS5260_RESET_EAGLECLKSTOP_SYS_PWR_REG	S5P_PMUREG(0x111C)
+#define	EXYNOS5260_CLKSTOP_CMU_MIF_SYS_PWR_REG		S5P_PMUREG(0x1120)
+#define	EXYNOS5260_CLKRUN_CMU_MIF_SYS_PWR_REG		S5P_PMUREG(0x1124)
+#define	EXYNOS5260_RESET_CMU_MIF_SYS_PWR_REG		S5P_PMUREG(0x112C)
+#define	EXYNOS5260_DISABLE_PLL_CMU_TOP_SYS_PWR_REG	S5P_PMUREG(0x1140)
+#define	EXYNOS5260_DISABLE_PLL_AUD_PLL_SYS_PWR_REG	S5P_PMUREG(0x1144)
+#define	EXYNOS5260_DISABLE_PLL_CMU_MIF_SYS_PWR_REG	S5P_PMUREG(0x1160)
+#define	EXYNOS5260_TOP_BUS_MIF_SYS_PWR_REG		S5P_PMUREG(0x1190)
+#define	EXYNOS5260_TOP_RET_MIF_SYS_PWR_REG		S5P_PMUREG(0x1194)
+#define	EXYNOS5260_TOP_PWR_MIF_SYS_PWR_REG		S5P_PMUREG(0x1198)
+#define	EXYNOS5260_LOGIC_RESET_SYS_PWR_REG		S5P_PMUREG(0x11A0)
+#define	EXYNOS5260_OSCCLK_GATE_SYS_PWR_REG		S5P_PMUREG(0x11A4)
+#define	EXYNOS5260_SLEEP_RESET_SYS_PWR_REG		S5P_PMUREG(0x11A8)
+#define	EXYNOS5260_LOGIC_RESET_MIF_SYS_PWR_REG		S5P_PMUREG(0x11B0)
+#define	EXYNOS5260_OSCCLK_GATE_MIF_SYS_PWR_REG		S5P_PMUREG(0x11B4)
+#define	EXYNOS5260_SLEEP_RESET_MIF_SYS_PWR_REG		S5P_PMUREG(0x11B8)
+#define	EXYNOS5260_MEMORY_TOP_SYS_PWR_REG		S5P_PMUREG(0x11C0)
+#define	EXYNOS5260_MEMORY_MIF_SYS_PWR_REG		S5P_PMUREG(0x11E0)
+#define	EXYNOS5260_PAD_RET_LPDDR3_SYS_PWR_REG		S5P_PMUREG(0x1200)
+#define	EXYNOS5260_PAD_RET_AUD_SYS_PWR_REG		S5P_PMUREG(0x1204)
+#define	EXYNOS5260_PAD_RET_JTAG_SYS_PWR_REG		S5P_PMUREG(0x1208)
+#define	EXYNOS5260_PAD_RET_MMC2_SYS_PWR_REG		S5P_PMUREG(0x1218)
+#define	EXYNOS5260_PAD_RET_JTAG_APM_SYS_PWR_REG		S5P_PMUREG(0x121C)
+#define	EXYNOS5260_PAD_RET_TOP_SYS_PWR_REG		S5P_PMUREG(0x1220)
+#define	EXYNOS5260_PAD_RET_UART_SYS_PWR_REG		S5P_PMUREG(0x1224)
+#define	EXYNOS5260_PAD_RET_MMC0_SYS_PWR_REG		S5P_PMUREG(0x1228)
+#define	EXYNOS5260_PAD_RET_MMC1_SYS_PWR_REG		S5P_PMUREG(0x122C)
+#define	EXYNOS5260_PAD_RET_EBIA_SYS_PWR_REG		S5P_PMUREG(0x1230)
+#define	EXYNOS5260_PAD_RET_EBIB_SYS_PWR_REG		S5P_PMUREG(0x1234)
+#define	EXYNOS5260_PAD_RET_SPI_SYS_PWR_REG		S5P_PMUREG(0x1238)
+#define	EXYNOS5260_PAD_RET_MIF_SYS_PWR_REG		S5P_PMUREG(0x123C)
+#define	EXYNOS5260_PAD_ISOLATION_SYS_PWR_REG		S5P_PMUREG(0x1240)
+#define	EXYNOS5260_PAD_RET_USBXTI_SYS_PWR_REG		S5P_PMUREG(0x1244)
+#define	EXYNOS5260_PAD_RET_BOOTLDO_SYS_PWR_REG		S5P_PMUREG(0x1248)
+#define	EXYNOS5260_PAD_RET_UFS_SYS_PWR_REG		S5P_PMUREG(0x124C)
+#define	EXYNOS5260_PAD_ISOLATION_MIF_SYS_PWR_REG	S5P_PMUREG(0x1250)
+#define	EXYNOS5260_PAD_ALV_SEL_SYS_PWR_REG		S5P_PMUREG(0x1260)
+#define	EXYNOS5260_XXTI_SYS_PWR_REG			S5P_PMUREG(0x1284)
+#define	EXYNOS5260_XXTI26_SYS_PWR_REG			S5P_PMUREG(0x1288)
+#define	EXYNOS5260_EXT_REGULATOR_SYS_PWR_REG		S5P_PMUREG(0x12C0)
+#define	EXYNOS5260_GPIO_MODE_SYS_PWR_REG		S5P_PMUREG(0x1300)
+#define	EXYNOS5260_GPIO_MODE_MIF_SYS_PWR_REG		S5P_PMUREG(0x1320)
+#define	EXYNOS5260_GPIO_MODE_AUD_SYS_PWR_REG		S5P_PMUREG(0x1340)
+#define	EXYNOS5260_GSCL_SYS_PWR_REG			S5P_PMUREG(0x1400)
+#define	EXYNOS5260_CAM0_SYS_PWR_REG			S5P_PMUREG(0x1404)
+#define	EXYNOS5260_MSCL_SYS_PWR_REG			S5P_PMUREG(0x1408)
+#define	EXYNOS5260_DISP_SYS_PWR_REG			S5P_PMUREG(0x1410)
+#define	EXYNOS5260_CAM1_SYS_PWR_REG			S5P_PMUREG(0x1414)
+#define	EXYNOS5260_AUD_SYS_PWR_REG			S5P_PMUREG(0x1418)
+#define	EXYNOS5260_FSYS_SYS_PWR_REG			S5P_PMUREG(0x141C)
+#define	EXYNOS5260_G2D_SYS_PWR_REG			S5P_PMUREG(0x1424)
+#define	EXYNOS5260_ISP_SYS_PWR_REG			S5P_PMUREG(0x1428)
+#define	EXYNOS5260_MFC_SYS_PWR_REG			S5P_PMUREG(0x1430)
+#define	EXYNOS5260_CLKRUN_CMU_GSCL_SYS_PWR_REG		S5P_PMUREG(0x1440)
+#define	EXYNOS5260_CLKRUN_CMU_CAM0_SYS_PWR_REG		S5P_PMUREG(0x1444)
+#define	EXYNOS5260_CLKRUN_CMU_MSCL_SYS_PWR_REG		S5P_PMUREG(0x1448)
+#define	EXYNOS5260_CLKRUN_CMU_G3D_SYS_PWR_REG		S5P_PMUREG(0x144C)
+#define	EXYNOS5260_CLKRUN_CMU_DISP_SYS_PWR_REG		S5P_PMUREG(0x1450)
+#define	EXYNOS5260_CLKRUN_CMU_CAM1_SYS_PWR_REG		S5P_PMUREG(0x1454)
+#define	EXYNOS5260_CLKRUN_CMU_AUD_SYS_PWR_REG		S5P_PMUREG(0x1458)
+#define	EXYNOS5260_CLKRUN_CMU_FSYS_SYS_PWR_REG		S5P_PMUREG(0x145C)
+#define	EXYNOS5260_CLKRUN_CMU_G2D_SYS_PWR_REG		S5P_PMUREG(0x1464)
+#define	EXYNOS5260_CLKRUN_CMU_ISP_SYS_PWR_REG		S5P_PMUREG(0x1468)
+#define	EXYNOS5260_CLKRUN_CMU_MFC_SYS_PWR_REG		S5P_PMUREG(0x1470)
+#define	EXYNOS5260_CLKSTOP_CMU_GSCL_SYS_PWR_REG		S5P_PMUREG(0x1480)
+#define	EXYNOS5260_CLKSTOP_CMU_CAM0_SYS_PWR_REG		S5P_PMUREG(0x1484)
+#define	EXYNOS5260_CLKSTOP_CMU_MSCL_SYS_PWR_REG		S5P_PMUREG(0x1488)
+#define	EXYNOS5260_CLKSTOP_CMU_G3D_SYS_PWR_REG		S5P_PMUREG(0x148C)
+#define	EXYNOS5260_CLKSTOP_CMU_DISP_SYS_PWR_REG		S5P_PMUREG(0x1490)
+#define	EXYNOS5260_CLKSTOP_CMU_CAM1_SYS_PWR_REG		S5P_PMUREG(0x1494)
+#define	EXYNOS5260_CLKSTOP_CMU_AUD_SYS_PWR_REG		S5P_PMUREG(0x1498)
+#define	EXYNOS5260_CLKSTOP_CMU_FSYS_SYS_PWR_REG		S5P_PMUREG(0x149C)
+#define	EXYNOS5260_CLKSTOP_CMU_G2D_SYS_PWR_REG		S5P_PMUREG(0x14A4)
+#define	EXYNOS5260_CLKSTOP_CMU_ISP_SYS_PWR_REG		S5P_PMUREG(0x14A8)
+#define	EXYNOS5260_CLKSTOP_CMU_MFC_SYS_PWR_REG		S5P_PMUREG(0x14B0)
+#define	EXYNOS5260_DISABLE_PLL_CMU_GSCL_SYS_PWR_REG	S5P_PMUREG(0x14C0)
+#define	EXYNOS5260_DISABLE_PLL_CMU_CAM0_SYS_PWR_REG	S5P_PMUREG(0x14C4)
+#define	EXYNOS5260_DISABLE_PLL_CMU_MSCL_SYS_PWR_REG	S5P_PMUREG(0x14C8)
+#define	EXYNOS5260_DISABLE_PLL_CMU_G3D_SYS_PWR_REG	S5P_PMUREG(0x14CC)
+#define	EXYNOS5260_DISABLE_PLL_CMU_DISP_SYS_PWR_REG	S5P_PMUREG(0x14D0)
+#define	EXYNOS5260_DISABLE_PLL_CMU_CAM1_SYS_PWR_REG	S5P_PMUREG(0x14D4)
+#define	EXYNOS5260_DISABLE_PLL_CMU_AUD_SYS_PWR_REG	S5P_PMUREG(0x14D8)
+#define	EXYNOS5260_DISABLE_PLL_CMU_FSYS_SYS_PWR_REG	S5P_PMUREG(0x14DC)
+#define	EXYNOS5260_DISABLE_PLL_CMU_G2D_SYS_PWR_REG	S5P_PMUREG(0x14E4)
+#define	EXYNOS5260_DISABLE_PLL_CMU_ISP_SYS_PWR_REG	S5P_PMUREG(0x14E8)
+#define	EXYNOS5260_DISABLE_PLL_CMU_MFC_SYS_PWR_REG	S5P_PMUREG(0x14F0)
+#define	EXYNOS5260_RESET_LOGIC_GSCL_SYS_PWR_REG		S5P_PMUREG(0x1500)
+#define	EXYNOS5260_RESET_LOGIC_CAM0_SYS_PWR_REG		S5P_PMUREG(0x1504)
+#define	EXYNOS5260_RESET_LOGIC_MSCL_SYS_PWR_REG		S5P_PMUREG(0x1508)
+#define	EXYNOS5260_RESET_LOGIC_G3D_SYS_PWR_REG		S5P_PMUREG(0x150C)
+#define	EXYNOS5260_RESET_LOGIC_DISP_SYS_PWR_REG		S5P_PMUREG(0x1510)
+#define	EXYNOS5260_RESET_LOGIC_CAM1_SYS_PWR_REG		S5P_PMUREG(0x1514)
+#define	EXYNOS5260_RESET_LOGIC_AUD_SYS_PWR_REG		S5P_PMUREG(0x1518)
+#define	EXYNOS5260_RESET_LOGIC_FSYS_SYS_PWR_REG		S5P_PMUREG(0x151C)
+#define	EXYNOS5260_RESET_LOGIC_G2D_SYS_PWR_REG		S5P_PMUREG(0x1524)
+#define	EXYNOS5260_RESET_LOGIC_ISP_SYS_PWR_REG		S5P_PMUREG(0x1528)
+#define	EXYNOS5260_RESET_LOGIC_MFC_SYS_PWR_REG		S5P_PMUREG(0x1530)
+#define	EXYNOS5260_MEMORY_G2D_SYS_PWR_REG		S5P_PMUREG(0x1564)
+#define	EXYNOS5260_RESET_CMU_GSCL_SYS_PWR_REG		S5P_PMUREG(0x1580)
+#define	EXYNOS5260_RESET_CMU_CAM0_SYS_PWR_REG		S5P_PMUREG(0x1584)
+#define	EXYNOS5260_RESET_CMU_MSCL_SYS_PWR_REG		S5P_PMUREG(0x1588)
+#define	EXYNOS5260_RESET_CMU_G3D_SYS_PWR_REG		S5P_PMUREG(0x158C)
+#define	EXYNOS5260_RESET_CMU_DISP_SYS_PWR_REG		S5P_PMUREG(0x1590)
+#define	EXYNOS5260_RESET_CMU_CAM1_SYS_PWR_REG		S5P_PMUREG(0x1594)
+#define	EXYNOS5260_RESET_CMU_AUD_SYS_PWR_REG		S5P_PMUREG(0x1598)
+#define	EXYNOS5260_RESET_CMU_FSYS_SYS_PWR_REG		S5P_PMUREG(0x159C)
+#define	EXYNOS5260_RESET_CMU_G2D_SYS_PWR_REG		S5P_PMUREG(0x15A4)
+#define	EXYNOS5260_RESET_CMU_ISP_SYS_PWR_REG		S5P_PMUREG(0x15A8)
+#define	EXYNOS5260_RESET_CMU_MFC_SYS_PWR_REG		S5P_PMUREG(0x15B0)
+
+/* CENTRAL_SEQ_OPTION */
+#define EXYNOS5260_ARM_USE_STANDBY_WFI0			(1 << 16)
+#define EXYNOS5260_ARM_USE_STANDBY_WFI1			(1 << 17)
+#define EXYNOS5260_KFC_USE_STANDBY_WFI0			(1 << 20)
+#define EXYNOS5260_KFC_USE_STANDBY_WFI1			(1 << 21)
+#define EXYNOS5260_KFC_USE_STANDBY_WFI2			(1 << 22)
+#define EXYNOS5260_KFC_USE_STANDBY_WFI3			(1 << 23)
+#define EXYNOS5260_ARM_USE_STANDBY_WFE0			(1 << 24)
+#define EXYNOS5260_ARM_USE_STANDBY_WFE1			(1 << 25)
+#define EXYNOS5260_KFC_USE_STANDBY_WFE0			(1 << 28)
+#define EXYNOS5260_KFC_USE_STANDBY_WFE1			(1 << 29)
+#define EXYNOS5260_KFC_USE_STANDBY_WFE2			(1 << 30)
+#define EXYNOS5260_KFC_USE_STANDBY_WFE3			(1 << 31)
+
+#define EXYNOS5260_USE_STANDBY_WFI_ALL	(EXYNOS5260_ARM_USE_STANDBY_WFI0  \
+					| EXYNOS5260_ARM_USE_STANDBY_WFI1  \
+					| EXYNOS5260_KFC_USE_STANDBY_WFI0  \
+					| EXYNOS5260_KFC_USE_STANDBY_WFI1  \
+					| EXYNOS5260_KFC_USE_STANDBY_WFI2  \
+					| EXYNOS5260_KFC_USE_STANDBY_WFI3)
+
+
 #endif /* __ASM_ARCH_REGS_PMU_H */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 78a22bf..c6def953 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -58,7 +58,7 @@ static int exynos_cpu_suspend(unsigned long arg)
 	outer_flush_all();
 #endif
 
-	if (soc_is_exynos5250())
+	if (soc_is_exynos5250() || soc_is_exynos5260())
 		flush_cache_all();
 
 	/* issue the standby signal into the pm unit. */
@@ -117,9 +117,15 @@ static __init int exynos_pm_drvinit(void)
 
 	/* All wakeup disable */
 
-	tmp = __raw_readl(S5P_WAKEUP_MASK);
-	tmp |= ((0xFF << 8) | (0x1F << 1));
-	__raw_writel(tmp, S5P_WAKEUP_MASK);
+	if (soc_is_exynos5260()) {
+		tmp = __raw_readl(EXYNOS5260_WAKEUP_MASK);
+		tmp |= ((0xE << 12) | (0xE << 8) | (0x3 << 1));
+		__raw_writel(tmp, EXYNOS5260_WAKEUP_MASK);
+	} else {
+		tmp = __raw_readl(S5P_WAKEUP_MASK);
+		tmp |= ((0xFF << 8) | (0x1F << 1));
+		__raw_writel(tmp, S5P_WAKEUP_MASK);
+	}
 
 	return subsys_interface_register(&exynos_pm_interface);
 }
@@ -128,6 +134,7 @@ arch_initcall(exynos_pm_drvinit);
 static int exynos_pm_suspend(void)
 {
 	unsigned long tmp;
+	unsigned int cluster_id;
 
 	/* Setting Central Sequence Register for power down mode */
 
@@ -136,11 +143,21 @@ static int exynos_pm_suspend(void)
 	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
 
 	/* Setting SEQ_OPTION register */
+	if (soc_is_exynos5250()) {
+		tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
+		__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
+	} else if (soc_is_exynos5260()) {
+		cluster_id = (read_cpuid(CPUID_MPIDR) >> 8) & 0xf;
+		if (!cluster_id)
+			__raw_writel(EXYNOS5260_ARM_USE_STANDBY_WFI0,
+				     S5P_CENTRAL_SEQ_OPTION);
+		else
+			__raw_writel(EXYNOS5260_KFC_USE_STANDBY_WFI0,
+				     S5P_CENTRAL_SEQ_OPTION);
 
-	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
-	__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
+	}
 
-	if (!soc_is_exynos5250()) {
+	if (!soc_is_exynos5250() || !soc_is_exynos5260()) {
 		/* Save Power control register */
 		asm ("mrc p15, 0, %0, c15, c0, 0"
 		     : "=r" (tmp) : : "cc");
@@ -174,7 +191,7 @@ static void exynos_pm_resume(void)
 		/* No need to perform below restore code */
 		goto early_wakeup;
 	}
-	if (!soc_is_exynos5250()) {
+	if (!soc_is_exynos5250() || !soc_is_exynos5260()) {
 		/* Restore Power control register */
 		tmp = save_arm_register[0];
 		asm volatile ("mcr p15, 0, %0, c15, c0, 0"
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 97d6885..c828d07 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -317,6 +317,99 @@ static struct exynos_pmu_conf exynos5250_pmu_config[] = {
 	{ PMU_TABLE_END,},
 };
 
+static struct exynos_pmu_conf exynos5260_pmu_config[] = {
+	/* { .reg = address, .val = { AFTR, LPA, SLEEP } */
+	{ EXYNOS5260_A15_EGL0_SYS_PWR_REG,		{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A15_EGL0_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A15_EGL0_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_A15_EGL1_SYS_PWR_REG,		 { 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A15_EGL1_LOCAL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A15_EGL1_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_A7_KFC0_SYS_PWR_REG,		{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC0_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC0_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_A7_KFC1_SYS_PWR_REG,		{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC1_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC1_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_A7_KFC2_SYS_PWR_REG,		{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC2_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC2_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_A7_KFC3_SYS_PWR_REG,		{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC3_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A7_KFC3_CNTRL_SYS_PWR_REG, { 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_CORTEXA15_NONEAGLE_SYS_PWR_REG,	{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_CORTEXA7_NONEAGLE_SYS_PWR_REG,	{ 0x0, 0x0, 0x8} },
+	{ EXYNOS5260_A5IS_SYS_PWR_REG,			{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A5IS_LOCAL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_DIS_IRQ_A5IS_CNTRL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_CORTEXA15_L2_SYS_PWR_REG,		{ 0x0, 0x0, 0x7} },
+	{ EXYNOS5260_CORTEXA7_L2_SYS_PWR_REG,		{ 0x0, 0x0, 0x7} },
+	{ EXYNOS5260_CLKSTOP_CMU_TOP_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_CLKRUN_CMU_TOP_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_TOP_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_RESET_EAGLECLKSTOP_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_CLKSTOP_CMU_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_CLKRUN_CMU_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_MIF_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_DISABLE_PLL_CMU_TOP_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_DISABLE_PLL_AUD_PLL_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_DISABLE_PLL_CMU_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5_TOP_BUS_SYS_PWR_REG,			{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5_TOP_RETENTION_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5_TOP_PWR_SYS_PWR_REG,			{ 0x3, 0x0, 0x3} },
+	{ EXYNOS5260_TOP_BUS_MIF_SYS_PWR_REG,		{ 0x7, 0x0, 0x0} },
+	{ EXYNOS5260_TOP_RET_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5260_TOP_PWR_MIF_SYS_PWR_REG,		{ 0x3, 0x0, 0x3} },
+	{ EXYNOS5260_LOGIC_RESET_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_OSCCLK_GATE_SYS_PWR_REG,		{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5260_SLEEP_RESET_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_LOGIC_RESET_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_OSCCLK_GATE_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x1} },
+	{ EXYNOS5260_SLEEP_RESET_MIF_SYS_PWR_REG,	{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_MEMORY_TOP_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5260_MEMORY_MIF_SYS_PWR_REG,		{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_LPDDR3_SYS_PWR_REG,	{ 0x3, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_AUD_SYS_PWR_REG,		{ 0x0, 0x1, 0x0} },
+	{ EXYNOS5260_PAD_RET_JTAG_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_MMC2_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_TOP_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_UART_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_MMC0_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_MMC1_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_SPI_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_ISOLATION_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_RET_BOOTLDO_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_ISOLATION_MIF_SYS_PWR_REG,	{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_PAD_ALV_SEL_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_XXTI_SYS_PWR_REG,			{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_EXT_REGULATOR_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_GPIO_MODE_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_GPIO_MODE_MIF_SYS_PWR_REG,		{ 0x1, 0x0, 0x0} },
+	{ EXYNOS5260_GPIO_MODE_AUD_SYS_PWR_REG,		{ 0x1, 0x1, 0x0} },
+	{ EXYNOS5260_GSCL_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5_G3D_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5260_DISP_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5260_AUD_SYS_PWR_REG,			{ 0xF, 0xF, 0x0} },
+	{ EXYNOS5260_G2D_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5260_ISP_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5260_MFC_SYS_PWR_REG,			{ 0xF, 0x0, 0x0} },
+	{ EXYNOS5260_MEMORY_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0xF} },
+	{ EXYNOS5260_RESET_CMU_GSCL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_CAM0_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_MSCL_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_G3D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_DISP_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_CAM1_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_AUD_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_FSYS_SYS_PWR_REG,	{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_G2D_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_ISP_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ EXYNOS5260_RESET_CMU_MFC_SYS_PWR_REG,		{ 0x0, 0x0, 0x0} },
+	{ PMU_TABLE_END,},
+};
+
 static void __iomem *exynos5_list_both_cnt_feed[] = {
 	EXYNOS5_ARM_CORE0_OPTION,
 	EXYNOS5_ARM_CORE1_OPTION,
@@ -388,6 +481,30 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 	}
 }
 
+static void exynos5260_reset_assert_ctrl(bool on, enum running_cpu cluster)
+{
+	unsigned int i;
+	unsigned int option;
+	unsigned int cpu_s, cpu_f;
+
+	if (cluster == KFC) {
+		cpu_s = EXYNOS5260_CPUS_PER_CLUSTER;
+		cpu_f = cpu_s + EXYNOS5260_CPUS_PER_CLUSTER;
+	} else {
+		cpu_s = 0;
+		cpu_f = 2;
+	}
+
+	for (i = cpu_s; i < cpu_f; i++) {
+		option = __raw_readl(EXYNOS_ARM_CORE_OPTION(i));
+		option = on ?
+		(option | EXYNOS5260_USE_DELAYED_RESET_ASSERTION) :
+			(option & ~EXYNOS5260_USE_DELAYED_RESET_ASSERTION);
+		__raw_writel(option, EXYNOS_ARM_CORE_OPTION(i));
+	}
+}
+
+
 static int __init exynos_pmu_init(void)
 {
 	unsigned int value;
@@ -415,6 +532,29 @@ static int __init exynos_pmu_init(void)
 
 		exynos_pmu_config = exynos5250_pmu_config;
 		pr_info("EXYNOS5250 PMU Initialize\n");
+	} else if (soc_is_exynos5260()) {
+		/* Enable USE_STANDBY_WFI for all CORE */
+		__raw_writel(EXYNOS5260_USE_STANDBY_WFI_ALL,
+			S5P_CENTRAL_SEQ_OPTION);
+		/*
+		 * Set PSHOLD port for output high
+		 */
+		value = __raw_readl(EXYNOS_PS_HOLD_CONTROL);
+		value |= EXYNOS_PS_HOLD_OUTPUT_HIGH;
+		__raw_writel(value, EXYNOS_PS_HOLD_CONTROL);
+
+		/*
+		 * Enable signal for PSHOLD port
+		 */
+		value = __raw_readl(EXYNOS_PS_HOLD_CONTROL);
+		value |= EXYNOS_PS_HOLD_EN;
+		__raw_writel(value, EXYNOS_PS_HOLD_CONTROL);
+
+		exynos5260_reset_assert_ctrl(true, ARM);
+
+		exynos_pmu_config = exynos5260_pmu_config;
+
+		pr_info("EXYNOS5260 PMU Initialized\n");
 	} else {
 		pr_info("EXYNOS: PMU not supported\n");
 	}
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index 804597c..c2d7fcf 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -58,6 +58,20 @@
 #define S3C_UART_OFFSET		(0x400)
 #endif
 
+/* Exynos5260 specific definitions */
+#define EXYNOS5260_VA_SYS_PERI		S3C_ADDR(0x02848000)
+#define EXYNOS5260_VA_SYS_EGL           S3C_ADDR(0x0284C000)
+#define EXYNOS5260_VA_SYS_KFC           S3C_ADDR(0x02850000)
+#define EXYNOS5260_VA_SYS_G2D           S3C_ADDR(0x02854000)
+#define EXYNOS5260_VA_SYS_MIF           S3C_ADDR(0x02858000)
+#define EXYNOS5260_VA_SYS_MFC           S3C_ADDR(0x0285C000)
+#define EXYNOS5260_VA_SYS_G3D           S3C_ADDR(0x02860000)
+#define EXYNOS5260_VA_SYS_FSYS		S3C_ADDR(0x02864000)
+#define EXYNOS5260_VA_SYS_AUD           S3C_ADDR(0x02868000)
+#define EXYNOS5260_VA_SYS_ISP		S3C_ADDR(0x0286C000)
+#define EXYNOS5260_VA_SYS_GSCL          S3C_ADDR(0x02870000)
+#define EXYNOS5260_VA_SYS_DISP          S3C_ADDR(0x02874000)
+
 #include <plat/map-s3c.h>
 
 #endif /* __ASM_PLAT_MAP_S5P_H */
-- 
1.7.12.4
