From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 11 Oct 2013 17:58:38 +0800
Subject: [PATCH V2 3/4] ARM: tegra: add LP1 support code for Tegra124
In-Reply-To: <1381485519-4027-1-git-send-email-josephl@nvidia.com>
References: <1381485519-4027-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381485519-4027-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LP1 suspend procedure is the same with Tegra30 and Tegra114. Just
need to update the difference of the register address, then we can
continue to share the code.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* squash from 2/7 to 5/7 in V1
---
 arch/arm/mach-tegra/Makefile        |  1 +
 arch/arm/mach-tegra/flowctrl.c      |  2 ++
 arch/arm/mach-tegra/iomap.h         |  3 +++
 arch/arm/mach-tegra/pm.c            | 12 +++++++++---
 arch/arm/mach-tegra/sleep-tegra30.S | 33 ++++++++++++++++++++++++++++-----
 5 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index de3748e..019bb17 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -36,6 +36,7 @@ ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
 endif
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= sleep-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= cpuidle-tegra114.o
 endif
diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index 5348543..ce8ab8a 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -87,6 +87,7 @@ void flowctrl_cpu_suspend_enter(unsigned int cpuid)
 		break;
 	case TEGRA30:
 	case TEGRA114:
+	case TEGRA124:
 		/* clear wfe bitmap */
 		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
 		/* clear wfi bitmap */
@@ -125,6 +126,7 @@ void flowctrl_cpu_suspend_exit(unsigned int cpuid)
 		break;
 	case TEGRA30:
 	case TEGRA114:
+	case TEGRA124:
 		/* clear wfe bitmap */
 		reg &= ~TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP;
 		/* clear wfi bitmap */
diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index cbee57f..26b1c2a 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -105,6 +105,9 @@
 #define TEGRA_EMC1_BASE			0x7001A800
 #define TEGRA_EMC1_SIZE			SZ_2K
 
+#define TEGRA124_EMC_BASE		0x7001B000
+#define TEGRA124_EMC_SIZE		SZ_2K
+
 #define TEGRA_CSITE_BASE		0x70040000
 #define TEGRA_CSITE_SIZE		SZ_256K
 
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 36ed88a..4ae0286 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -59,8 +59,10 @@ static void tegra_tear_down_cpu_init(void)
 		break;
 	case TEGRA30:
 	case TEGRA114:
+	case TEGRA124:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) ||
-		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) ||
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC))
 			tegra_tear_down_cpu = tegra30_tear_down_cpu;
 		break;
 	}
@@ -216,8 +218,10 @@ static bool tegra_lp1_iram_hook(void)
 		break;
 	case TEGRA30:
 	case TEGRA114:
+	case TEGRA124:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) ||
-		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) ||
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC))
 			tegra30_lp1_iram_hook();
 		break;
 	default:
@@ -244,8 +248,10 @@ static bool tegra_sleep_core_init(void)
 		break;
 	case TEGRA30:
 	case TEGRA114:
+	case TEGRA124:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) ||
-		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) ||
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC))
 			tegra30_sleep_core_init();
 		break;
 	default:
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 7c529a1..b16d4a57 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -408,8 +408,12 @@ _pll_m_c_x_done:
 	cmp	r10, #TEGRA30
 	movweq	r0, #:lower16:TEGRA_EMC_BASE	@ r0 reserved for emc base
 	movteq	r0, #:upper16:TEGRA_EMC_BASE
-	movwne	r0, #:lower16:TEGRA_EMC0_BASE
-	movtne	r0, #:upper16:TEGRA_EMC0_BASE
+	cmp	r10, #TEGRA114
+	movweq	r0, #:lower16:TEGRA_EMC0_BASE
+	movteq	r0, #:upper16:TEGRA_EMC0_BASE
+	cmp	r10, #TEGRA124
+	movweq	r0, #:lower16:TEGRA124_EMC_BASE
+	movteq	r0, #:upper16:TEGRA124_EMC_BASE
 
 exit_self_refresh:
 	ldr	r1, [r5, #0xC]		@ restore EMC_XM2VTTGENPADCTRL
@@ -556,6 +560,17 @@ tegra114_sdram_pad_address:
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL2			@0x30
 tegra114_sdram_pad_adress_end:
 
+tegra124_sdram_pad_address:
+	.word	TEGRA124_EMC_BASE + EMC_CFG				@0x0
+	.word	TEGRA124_EMC_BASE + EMC_ZCAL_INTERVAL			@0x4
+	.word	TEGRA124_EMC_BASE + EMC_AUTO_CAL_INTERVAL		@0x8
+	.word	TEGRA124_EMC_BASE + EMC_XM2VTTGENPADCTRL		@0xc
+	.word	TEGRA124_EMC_BASE + EMC_XM2VTTGENPADCTRL2		@0x10
+	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
+	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
+	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
+tegra124_sdram_pad_address_end:
+
 tegra30_sdram_pad_size:
 	.word	tegra30_sdram_pad_address_end - tegra30_sdram_pad_address
 
@@ -700,8 +715,13 @@ tegra30_sdram_self_refresh:
 	cmp	r10, #TEGRA30
 	adreq	r2, tegra30_sdram_pad_address
 	ldreq	r3, tegra30_sdram_pad_size
-	adrne	r2, tegra114_sdram_pad_address
-	ldrne	r3, tegra114_sdram_pad_size
+	cmp	r10, #TEGRA114
+	adreq	r2, tegra114_sdram_pad_address
+	ldreq	r3, tegra114_sdram_pad_size
+	cmp	r10, #TEGRA124
+	adreq	r2, tegra124_sdram_pad_address
+	ldreq	r3, tegra30_sdram_pad_size
+
 	mov	r9, #0
 
 padsave:
@@ -719,7 +739,10 @@ padsave_done:
 
 	cmp	r10, #TEGRA30
 	ldreq	r0, =TEGRA_EMC_BASE	@ r0 reserved for emc base addr
-	ldrne	r0, =TEGRA_EMC0_BASE
+	cmp	r10, #TEGRA114
+	ldreq	r0, =TEGRA_EMC0_BASE
+	cmp	r10, #TEGRA124
+	ldreq	r0, =TEGRA124_EMC_BASE
 
 enter_self_refresh:
 	cmp	r10, #TEGRA30
-- 
1.8.4
