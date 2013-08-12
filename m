From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 12 Aug 2013 17:40:06 +0800
Subject: [PATCH V3 7/8] ARM: tegra: add LP1 suspend support for Tegra114
In-Reply-To: <1376300407-14750-1-git-send-email-josephl@nvidia.com>
References: <1376300407-14750-1-git-send-email-josephl@nvidia.com>
Message-ID: <1376300407-14750-8-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LP1 suspend mode will power off the CPU, clock gated the PLLs and put
SDRAM to self-refresh mode. Any interrupt can wake up device from LP1. The
sequence when LP1 suspending:

* tunning off L1 data cache and the MMU
* storing some EMC registers, DPD (deep power down) status, clk source of
  mselect and SCLK burst policy
* putting SDRAM into self-refresh
* switching CPU to CLK_M (12MHz OSC)
* tunning off PLLM, PLLP, PLLA, PLLC and PLLX
* switching SCLK to CLK_S (32KHz OSC)
* shutting off the CPU rail

The sequence of LP1 resuming:

* re-enabling PLLM, PLLP, PLLA, PLLC and PLLX
* restoring the clk source of mselect and SCLK burst policy
* setting up CCLK burst policy to PLLX
* restoring DPD status and some EMC registers
* resuming SDRAM to normal mode
* jumping to the "tegra_resume" from PMC_SCRATCH41

Due to the SDRAM will be put into self-refresh mode, the low level
procedures of LP1 suspending and resuming should be copied to
TEGRA_IRAM_CODE_AREA (TEGRA_IRAM_BASE + SZ_4K) when suspending. Before
restoring the CPU context when resuming, the SDRAM needs to be switched
back to normal mode. And the PLLs need to be re-enabled, SCLK burst policy
be restored. Then jumping to "tegra_resume" that was expected to be stored
in PMC_SCRATCH41 to restore CPU context and back to kernel.

Based on the work by: Bo Yan <byan@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* setting up CCLK burst policy to PLLX in lp1_resume
V2:
* using IS_ENABLE for SoC specific code
* moving the fix of PLL lock func to previous patch
---
 arch/arm/mach-tegra/Makefile        |   1 +
 arch/arm/mach-tegra/iomap.h         |   6 ++
 arch/arm/mach-tegra/pm.c            |   8 +-
 arch/arm/mach-tegra/sleep-tegra30.S | 141 ++++++++++++++++++++++++++++++++----
 4 files changed, 141 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index a3fe22d..f4e7063 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= tegra114_speedo.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
 endif
diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index f2bdcb4..aba3629 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -239,6 +239,12 @@
 #define TEGRA_KFUSE_BASE		0x7000FC00
 #define TEGRA_KFUSE_SIZE		SZ_1K
 
+#define TEGRA_EMC0_BASE			0x7001A000
+#define TEGRA_EMC0_SIZE			SZ_2K
+
+#define TEGRA_EMC1_BASE			0x7001A800
+#define TEGRA_EMC1_SIZE			SZ_2K
+
 #define TEGRA_CSITE_BASE		0x70040000
 #define TEGRA_CSITE_SIZE		SZ_256K
 
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index d2f736a..dedb75b 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -216,7 +216,9 @@ static bool tegra_lp1_iram_hook(void)
 			tegra20_lp1_iram_hook();
 		break;
 	case TEGRA30:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
+	case TEGRA114:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) ||
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
 			tegra30_lp1_iram_hook();
 		break;
 	default:
@@ -242,7 +244,9 @@ static bool tegra_sleep_core_init(void)
 			tegra20_sleep_core_init();
 		break;
 	case TEGRA30:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
+	case TEGRA114:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) ||
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
 			tegra30_sleep_core_init();
 		break;
 	default:
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 2be7f70..63fa91b 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -65,6 +65,10 @@
 #define CLK_RESET_PLLA_MISC		0xbc
 #define CLK_RESET_PLLX_BASE		0xe0
 #define CLK_RESET_PLLX_MISC		0xe4
+#define CLK_RESET_PLLX_MISC3		0x518
+#define CLK_RESET_PLLX_MISC3_IDDQ	3
+#define CLK_RESET_PLLM_MISC_IDDQ	5
+#define CLK_RESET_PLLC_MISC_IDDQ	26
 
 #define CLK_RESET_CLK_SOURCE_MSELECT	0x3b4
 
@@ -114,6 +118,18 @@
 	beq	1b
 .endm
 
+.macro pll_iddq_exit, rd, car, iddq, iddq_bit
+	ldr	\rd, [\car, #\iddq]
+	bic	\rd, \rd, #(1<<\iddq_bit)
+	str	\rd, [\car, #\iddq]
+.endm
+
+.macro pll_iddq_entry, rd, car, iddq, iddq_bit
+	ldr	\rd, [\car, #\iddq]
+	orr	\rd, \rd, #(1<<\iddq_bit)
+	str	\rd, [\car, #\iddq]
+.endm
+
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PM_SLEEP)
 /*
  * tegra30_hotplug_shutdown(void)
@@ -315,6 +331,32 @@ ENTRY(tegra30_lp1_reset)
 	str	r1, [r0, #CLK_RESET_CCLK_DIVIDER]
 	str	r1, [r0, #CLK_RESET_SCLK_DIVIDER]
 
+	tegra_get_soc_id TEGRA_APB_MISC_BASE, r10
+	cmp	r10, #TEGRA30
+	beq	_no_pll_iddq_exit
+
+	pll_iddq_exit r1, r0, CLK_RESET_PLLM_MISC, CLK_RESET_PLLM_MISC_IDDQ
+	pll_iddq_exit r1, r0, CLK_RESET_PLLC_MISC, CLK_RESET_PLLC_MISC_IDDQ
+	pll_iddq_exit r1, r0, CLK_RESET_PLLX_MISC3, CLK_RESET_PLLX_MISC3_IDDQ
+
+	mov32	r7, TEGRA_TMRUS_BASE
+	ldr	r1, [r7]
+	add	r1, r1, #2
+	wait_until r1, r7, r3
+
+	/* enable PLLM via PMC */
+	mov32	r2, TEGRA_PMC_BASE
+	ldr	r1, [r2, #PMC_PLLP_WB0_OVERRIDE]
+	orr	r1, r1, #(1 << 12)
+	str	r1, [r2, #PMC_PLLP_WB0_OVERRIDE]
+
+	pll_enable r1, r0, CLK_RESET_PLLM_BASE, 0
+	pll_enable r1, r0, CLK_RESET_PLLC_BASE, 0
+	pll_enable r1, r0, CLK_RESET_PLLX_BASE, 0
+
+	b	_pll_m_c_x_done
+
+_no_pll_iddq_exit:
 	/* enable PLLM via PMC */
 	mov32	r2, TEGRA_PMC_BASE
 	ldr	r1, [r2, #PMC_PLLP_WB0_OVERRIDE]
@@ -322,11 +364,13 @@ ENTRY(tegra30_lp1_reset)
 	str	r1, [r2, #PMC_PLLP_WB0_OVERRIDE]
 
 	pll_enable r1, r0, CLK_RESET_PLLM_BASE, CLK_RESET_PLLM_MISC
-	pll_enable r1, r0, CLK_RESET_PLLP_BASE, CLK_RESET_PLLP_MISC
-	pll_enable r1, r0, CLK_RESET_PLLA_BASE, CLK_RESET_PLLA_MISC
 	pll_enable r1, r0, CLK_RESET_PLLC_BASE, CLK_RESET_PLLC_MISC
 	pll_enable r1, r0, CLK_RESET_PLLX_BASE, CLK_RESET_PLLX_MISC
 
+_pll_m_c_x_done:
+	pll_enable r1, r0, CLK_RESET_PLLP_BASE, CLK_RESET_PLLP_MISC
+	pll_enable r1, r0, CLK_RESET_PLLA_BASE, CLK_RESET_PLLA_MISC
+
 	pll_locked r1, r0, CLK_RESET_PLLM_BASE
 	pll_locked r1, r0, CLK_RESET_PLLP_BASE
 	pll_locked r1, r0, CLK_RESET_PLLA_BASE
@@ -346,7 +390,11 @@ ENTRY(tegra30_lp1_reset)
 	ldr	r4, [r5, #0x1C]		@ restore SCLK_BURST
 	str	r4, [r0, #CLK_RESET_SCLK_BURST]
 
-	mov32	r4, ((1 << 28) | (0x8))	@ burst policy is PLLX
+	cmp	r10, #TEGRA30
+	movweq	r4, #:lower16:((1 << 28) | (0x8))	@ burst policy is PLLX
+	movteq	r4, #:upper16:((1 << 28) | (0x8))
+	movwne	r4, #:lower16:((1 << 28) | (0xe))
+	movtne	r4, #:upper16:((1 << 28) | (0xe))
 	str	r4, [r0, #CLK_RESET_CCLK_BURST]
 
 	/* Restore pad power state to normal */
@@ -356,8 +404,13 @@ ENTRY(tegra30_lp1_reset)
 	orr	r1, r1, #(1 << 30)
 	str	r1, [r2, #PMC_IO_DPD_REQ]	@ DPD_OFF
 
-	mov32	r0, TEGRA_EMC_BASE	@ r0 reserved for emc base
+	cmp	r10, #TEGRA30
+	movweq	r0, #:lower16:TEGRA_EMC_BASE	@ r0 reserved for emc base
+	movteq	r0, #:upper16:TEGRA_EMC_BASE
+	movwne	r0, #:lower16:TEGRA_EMC0_BASE
+	movtne	r0, #:upper16:TEGRA_EMC0_BASE
 
+exit_self_refresh:
 	ldr	r1, [r5, #0xC]		@ restore EMC_XM2VTTGENPADCTRL
 	str	r1, [r0, #EMC_XM2VTTGENPADCTRL]
 	ldr	r1, [r5, #0x10]		@ restore EMC_XM2VTTGENPADCTRL2
@@ -372,8 +425,14 @@ ENTRY(tegra30_lp1_reset)
 
 	emc_timing_update r1, r0
 
+	cmp	r10, #TEGRA114
+	movweq	r1, #:lower16:TEGRA_EMC1_BASE
+	movteq	r1, #:upper16:TEGRA_EMC1_BASE
+	cmpeq	r0, r1
+
 	ldr	r1, [r0, #EMC_AUTO_CAL_CONFIG]
 	orr	r1, r1, #(1 << 31)	@ set AUTO_CAL_ACTIVE
+	orreq	r1, r1, #(1 << 27)	@ set slave mode for channel 1
 	str	r1, [r0, #EMC_AUTO_CAL_CONFIG]
 
 emc_wait_auto_cal_onetime:
@@ -388,9 +447,10 @@ emc_wait_auto_cal_onetime:
 	mov	r1, #0
 	str	r1, [r0, #EMC_SELF_REF]	@ take DRAM out of self refresh
 	mov	r1, #1
-	str	r1, [r0, #EMC_NOP]
-	str	r1, [r0, #EMC_NOP]
-	str	r1, [r0, #EMC_REFRESH]
+	cmp	r10, #TEGRA30
+	streq	r1, [r0, #EMC_NOP]
+	streq	r1, [r0, #EMC_NOP]
+	streq	r1, [r0, #EMC_REFRESH]
 
 	emc_device_mask r1, r0
 
@@ -452,6 +512,16 @@ zcal_done:
 	ldr	r1, [r5, #0x0]		@ restore EMC_CFG
 	str	r1, [r0, #EMC_CFG]
 
+	/* Tegra114 had dual EMC channel, now config the other one */
+	cmp	r10, #TEGRA114
+	bne	__no_dual_emc_chanl
+	mov32	r1, TEGRA_EMC1_BASE
+	cmp	r0, r1
+	movne	r0, r1
+	addne	r5, r5, #0x20
+	bne	exit_self_refresh
+__no_dual_emc_chanl:
+
 	mov32	r0, TEGRA_PMC_BASE
 	ldr	r0, [r0, #PMC_SCRATCH41]
 	mov	pc, r0			@ jump to tegra_resume
@@ -468,12 +538,30 @@ tegra30_sdram_pad_address:
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
 
+tegra114_sdram_pad_address:
+	.word	TEGRA_EMC0_BASE + EMC_CFG				@0x0
+	.word	TEGRA_EMC0_BASE + EMC_ZCAL_INTERVAL			@0x4
+	.word	TEGRA_EMC0_BASE + EMC_AUTO_CAL_INTERVAL			@0x8
+	.word	TEGRA_EMC0_BASE + EMC_XM2VTTGENPADCTRL			@0xc
+	.word	TEGRA_EMC0_BASE + EMC_XM2VTTGENPADCTRL2			@0x10
+	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
+	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
+	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
+	.word	TEGRA_EMC1_BASE + EMC_CFG				@0x20
+	.word	TEGRA_EMC1_BASE + EMC_ZCAL_INTERVAL			@0x24
+	.word	TEGRA_EMC1_BASE + EMC_AUTO_CAL_INTERVAL			@0x28
+	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL			@0x2c
+	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL2			@0x30
+
 tegra30_sdram_pad_size:
-	.word	tegra30_sdram_pad_size - tegra30_sdram_pad_address
+	.word	tegra114_sdram_pad_address - tegra30_sdram_pad_address
+
+tegra114_sdram_pad_size:
+	.word	tegra30_sdram_pad_size - tegra114_sdram_pad_address
 
 	.type	tegra30_sdram_pad_save, %object
 tegra30_sdram_pad_save:
-	.rept (tegra30_sdram_pad_size - tegra30_sdram_pad_address) / 4
+	.rept (tegra30_sdram_pad_size - tegra114_sdram_pad_address) / 4
 	.long	0
 	.endr
 
@@ -497,6 +585,7 @@ tegra30_tear_down_core:
  * r5 = TEGRA_CLK_RESET_BASE
  * r6 = TEGRA_FLOW_CTRL_BASE
  * r7 = TEGRA_TMRUS_BASE
+ * r10= SoC ID
  */
 tegra30_switch_cpu_to_clk32k:
 	/*
@@ -543,6 +632,11 @@ tegra30_switch_cpu_to_clk32k:
 	bic	r0, r0, #(1 << 30)
 	str	r0, [r5, #CLK_RESET_PLLX_BASE]
 
+	cmp	r10, #TEGRA30
+	beq	_no_pll_in_iddq
+	pll_iddq_entry r1, r5, CLK_RESET_PLLX_MISC3, CLK_RESET_PLLX_MISC3_IDDQ
+_no_pll_in_iddq:
+
 	/* switch to CLKS */
 	mov	r0, #0	/* brust policy = 32KHz */
 	str	r0, [r5, #CLK_RESET_SCLK_BURST]
@@ -594,14 +688,19 @@ halted:
  * r5 = TEGRA_CLK_RESET_BASE
  * r6 = TEGRA_FLOW_CTRL_BASE
  * r7 = TEGRA_TMRUS_BASE
+ * r10= SoC ID
  */
 tegra30_sdram_self_refresh:
 
-	adr	r2, tegra30_sdram_pad_address
 	adr	r8, tegra30_sdram_pad_save
+	tegra_get_soc_id TEGRA_APB_MISC_BASE, r10
+	cmp	r10, #TEGRA30
+	adreq	r2, tegra30_sdram_pad_address
+	ldreq	r3, tegra30_sdram_pad_size
+	adrne	r2, tegra114_sdram_pad_address
+	ldrne	r3, tegra114_sdram_pad_size
 	mov	r9, #0
 
-	ldr	r3, tegra30_sdram_pad_size
 padsave:
 	ldr	r0, [r2, r9]		@ r0 is the addr in the pad_address
 
@@ -615,13 +714,18 @@ padsave_done:
 
 	dsb
 
-	mov32	r0, TEGRA_EMC_BASE	@ r0 reserved for emc base addr
+	cmp	r10, #TEGRA30
+	ldreq	r0, =TEGRA_EMC_BASE	@ r0 reserved for emc base addr
+	ldrne	r0, =TEGRA_EMC0_BASE
 
+enter_self_refresh:
+	cmp	r10, #TEGRA30
 	mov	r1, #0
 	str	r1, [r0, #EMC_ZCAL_INTERVAL]
 	str	r1, [r0, #EMC_AUTO_CAL_INTERVAL]
 	ldr	r1, [r0, #EMC_CFG]
 	bic	r1, r1, #(1 << 28)
+	bicne	r1, r1, #(1 << 29)
 	str	r1, [r0, #EMC_CFG]	@ disable DYN_SELF_REF
 
 	emc_timing_update r1, r0
@@ -660,11 +764,22 @@ emcself:
 	and	r1, r1, r2
 	str	r1, [r0, #EMC_XM2VTTGENPADCTRL]
 	ldr	r1, [r0, #EMC_XM2VTTGENPADCTRL2]
-	orr	r1, r1, #7		@ set E_NO_VTTGEN
+	cmp	r10, #TEGRA30
+	orreq	r1, r1, #7		@ set E_NO_VTTGEN
+	orrne	r1, r1, #0x3f
 	str	r1, [r0, #EMC_XM2VTTGENPADCTRL2]
 
 	emc_timing_update r1, r0
 
+	/* Tegra114 had dual EMC channel, now config the other one */
+	cmp	r10, #TEGRA114
+	bne	no_dual_emc_chanl
+	mov32	r1, TEGRA_EMC1_BASE
+	cmp	r0, r1
+	movne	r0, r1
+	bne	enter_self_refresh
+no_dual_emc_chanl:
+
 	ldr	r1, [r4, #PMC_CTRL]
 	tst	r1, #PMC_CTRL_SIDE_EFFECT_LP0
 	bne	pmc_io_dpd_skip
-- 
1.8.3.4
