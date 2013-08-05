From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 5 Aug 2013 19:21:02 +0800
Subject: [PATCH V2 6/8] ARM: tegra: add LP1 suspend support for Tegra20
In-Reply-To: <1375701664-14965-1-git-send-email-josephl@nvidia.com>
References: <1375701664-14965-1-git-send-email-josephl@nvidia.com>
Message-ID: <1375701664-14965-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LP1 suspend mode will power off the CPU, clock gated the PLLs and put
SDRAM to self-refresh mode. Any interrupt can wake up device from LP1. The
sequence when LP1 suspending:

* tunning off L1 data cache and the MMU
* putting SDRAM into self-refresh
* storing some EMC registers and SCLK burst policy
* switching CPU to CLK_M (12MHz OSC)
* switching SCLK to CLK_S (32KHz OSC)
* tunning off PLLM, PLLP and PLLC
* shutting off the CPU rail

The sequence of LP1 resuming:

* re-enabling PLLM, PLLP, and PLLC
* restoring some EMC registers and SCLK burst policy
* setting up CCLK burst policy to PLLP
* resuming SDRAM to normal mode
* jumping to the "tegra_resume" from PMC_SCRATCH41

Due to the SDRAM will be put into self-refresh mode, the low level
procedures of LP1 suspending and resuming should be copied to
TEGRA_IRAM_CODE_AREA (TEGRA_IRAM_BASE + SZ_4K) when suspending. Before
restoring the CPU context when resuming, the SDRAM needs to be switched
back to normal mode. And the PLLs need to be re-enabled, SCLK burst policy
be restored, CCLK burst policy be set in PLLP. Then jumping to
"tegra_resume" that was expected to be stored in PMC_SCRATCH41 to restore
CPU context and back to kernel.

Based on the work by:
Colin Cross <ccross@android.com>
Gary King <gking@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* using IS_ENABLE for SoC specific code
* modify "tegra20_sdram_pad_save" as suggestion
---
 arch/arm/mach-tegra/Makefile        |   1 +
 arch/arm/mach-tegra/pm-tegra20.c    |  34 +++++
 arch/arm/mach-tegra/pm.c            |   8 +
 arch/arm/mach-tegra/pm.h            |   2 +
 arch/arm/mach-tegra/sleep-tegra20.S | 296 ++++++++++++++++++++++++++++++++++++
 5 files changed, 341 insertions(+)
 create mode 100644 arch/arm/mach-tegra/pm-tegra20.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index d341980..a3fe22d 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra20_speedo.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= cpuidle-tegra20.o
 endif
diff --git a/arch/arm/mach-tegra/pm-tegra20.c b/arch/arm/mach-tegra/pm-tegra20.c
new file mode 100644
index 0000000..d65e1d7
--- /dev/null
+++ b/arch/arm/mach-tegra/pm-tegra20.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2013, NVIDIA Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/kernel.h>
+
+#include "pm.h"
+
+#ifdef CONFIG_PM_SLEEP
+extern u32 tegra20_iram_start, tegra20_iram_end;
+extern void tegra20_sleep_core_finish(unsigned long);
+
+void tegra20_lp1_iram_hook(void)
+{
+	tegra_lp1_iram.start_addr = &tegra20_iram_start;
+	tegra_lp1_iram.end_addr = &tegra20_iram_end;
+}
+
+void tegra20_sleep_core_init(void)
+{
+	tegra_sleep_core_finish = tegra20_sleep_core_finish;
+}
+#endif
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index bbe5ccd..25f3df0 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -211,6 +211,10 @@ static int tegra_sleep_core(unsigned long v2p)
 static bool tegra_lp1_iram_hook(void)
 {
 	switch (tegra_chip_id) {
+	case TEGRA20:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
+			tegra20_lp1_iram_hook();
+		break;
 	case TEGRA30:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
 			tegra30_lp1_iram_hook();
@@ -233,6 +237,10 @@ static bool tegra_lp1_iram_hook(void)
 static bool tegra_sleep_core_init(void)
 {
 	switch (tegra_chip_id) {
+	case TEGRA20:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
+			tegra20_sleep_core_init();
+		break;
 	case TEGRA30:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
 			tegra30_sleep_core_init();
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 803bd53..fe204e5 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -30,6 +30,8 @@ struct tegra_lp1_iram {
 extern struct tegra_lp1_iram tegra_lp1_iram;
 extern void (*tegra_sleep_core_finish)(unsigned long v2p);
 
+void tegra20_lp1_iram_hook(void);
+void tegra20_sleep_core_init(void);
 void tegra30_lp1_iram_hook(void);
 void tegra30_sleep_core_init(void);
 
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index f87721d..1106f45 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -23,10 +23,49 @@
 #include <asm/assembler.h>
 #include <asm/proc-fns.h>
 #include <asm/cp15.h>
+#include <asm/cache.h>
 
 #include "sleep.h"
 #include "flowctrl.h"
 
+#define EMC_CFG				0xc
+#define EMC_ADR_CFG			0x10
+#define EMC_REFRESH			0x70
+#define EMC_NOP				0xdc
+#define EMC_SELF_REF			0xe0
+#define EMC_REQ_CTRL			0x2b0
+#define EMC_EMC_STATUS			0x2b4
+
+#define CLK_RESET_CCLK_BURST		0x20
+#define CLK_RESET_CCLK_DIVIDER		0x24
+#define CLK_RESET_SCLK_BURST		0x28
+#define CLK_RESET_SCLK_DIVIDER		0x2c
+#define CLK_RESET_PLLC_BASE		0x80
+#define CLK_RESET_PLLM_BASE		0x90
+#define CLK_RESET_PLLP_BASE		0xa0
+
+#define APB_MISC_XM2CFGCPADCTRL		0x8c8
+#define APB_MISC_XM2CFGDPADCTRL		0x8cc
+#define APB_MISC_XM2CLKCFGPADCTRL	0x8d0
+#define APB_MISC_XM2COMPPADCTRL		0x8d4
+#define APB_MISC_XM2VTTGENPADCTRL	0x8d8
+#define APB_MISC_XM2CFGCPADCTRL2	0x8e4
+#define APB_MISC_XM2CFGDPADCTRL2	0x8e8
+
+.macro pll_enable, rd, r_car_base, pll_base
+	ldr	\rd, [\r_car_base, #\pll_base]
+	tst	\rd, #(1 << 30)
+	orreq	\rd, \rd, #(1 << 30)
+	streq	\rd, [\r_car_base, #\pll_base]
+.endm
+
+.macro emc_device_mask, rd, base
+	ldr	\rd, [\base, #EMC_ADR_CFG]
+	tst	\rd, #(0x3 << 24)
+	moveq	\rd, #(0x1 << 8)		@ just 1 device
+	movne	\rd, #(0x3 << 8)		@ 2 devices
+.endm
+
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PM_SLEEP)
 /*
  * tegra20_hotplug_shutdown(void)
@@ -181,6 +220,28 @@ ENTRY(tegra20_cpu_is_resettable_soon)
 ENDPROC(tegra20_cpu_is_resettable_soon)
 
 /*
+ * tegra20_sleep_core_finish(unsigned long v2p)
+ *
+ * Enters suspend in LP0 or LP1 by turning off the mmu and jumping to
+ * tegra20_tear_down_core in IRAM
+ */
+ENTRY(tegra20_sleep_core_finish)
+	/* Flush, disable the L1 data cache and exit SMP */
+	bl	tegra_disable_clean_inv_dcache
+
+	mov32	r3, tegra_shut_off_mmu
+	add	r3, r3, r0
+
+	mov32	r0, tegra20_tear_down_core
+	mov32	r1, tegra20_iram_start
+	sub	r0, r0, r1
+	mov32	r1, TEGRA_IRAM_CODE_AREA
+	add	r0, r0, r1
+
+	mov	pc, r3
+ENDPROC(tegra20_sleep_core_finish)
+
+/*
  * tegra20_sleep_cpu_secondary_finish(unsigned long v2p)
  *
  * Enters WFI on secondary CPU by exiting coherency.
@@ -251,6 +312,150 @@ ENTRY(tegra20_tear_down_cpu)
 	b	tegra20_enter_sleep
 ENDPROC(tegra20_tear_down_cpu)
 
+/* START OF ROUTINES COPIED TO IRAM */
+	.align L1_CACHE_SHIFT
+	.globl tegra20_iram_start
+tegra20_iram_start:
+
+/*
+ * tegra20_lp1_reset
+ *
+ * reset vector for LP1 restore; copied into IRAM during suspend.
+ * Brings the system back up to a safe staring point (SDRAM out of
+ * self-refresh, PLLC, PLLM and PLLP reenabled, CPU running on PLLP,
+ * system clock running on the same PLL that it suspended at), and
+ * jumps to tegra_resume to restore virtual addressing and PLLX.
+ * The physical address of tegra_resume expected to be stored in
+ * PMC_SCRATCH41.
+ *
+ * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_CODE_AREA.
+ */
+ENTRY(tegra20_lp1_reset)
+	/*
+	 * The CPU and system bus are running@32KHz and executing from
+	 * IRAM when this code is executed; immediately switch to CLKM and
+	 * enable PLLM, PLLP, PLLC.
+	 */
+	mov32	r0, TEGRA_CLK_RESET_BASE
+
+	mov	r1, #(1 << 28)
+	str	r1, [r0, #CLK_RESET_SCLK_BURST]
+	str	r1, [r0, #CLK_RESET_CCLK_BURST]
+	mov	r1, #0
+	str	r1, [r0, #CLK_RESET_CCLK_DIVIDER]
+	str	r1, [r0, #CLK_RESET_SCLK_DIVIDER]
+
+	pll_enable r1, r0, CLK_RESET_PLLM_BASE
+	pll_enable r1, r0, CLK_RESET_PLLP_BASE
+	pll_enable r1, r0, CLK_RESET_PLLC_BASE
+
+	adr	r2, tegra20_sdram_pad_address
+	adr	r4, tegra20_sdram_pad_save
+	mov	r5, #0
+
+	ldr	r6, tegra20_sdram_pad_size
+padload:
+	ldr	r7, [r2, r5]		@ r7 is the addr in the pad_address
+
+	ldr	r1, [r4, r5]
+	str	r1, [r7]		@ restore the value in pad_save
+
+	add	r5, r5, #4
+	cmp	r6, r5
+	bne	padload
+
+padload_done:
+	/* 255uS delay for PLL stabilization */
+	mov32	r7, TEGRA_TMRUS_BASE
+	ldr	r1, [r7]
+	add	r1, r1, #0xff
+	wait_until r1, r7, r9
+
+	adr	r4, tegra20_sclk_save
+	ldr	r4, [r4]
+	str	r4, [r0, #CLK_RESET_SCLK_BURST]
+	mov32	r4, ((1 << 28) | (4))	@ burst policy is PLLP
+	str	r4, [r0, #CLK_RESET_CCLK_BURST]
+
+	mov32	r0, TEGRA_EMC_BASE
+	ldr	r1, [r0, #EMC_CFG]
+	bic	r1, r1, #(1 << 31)	@ disable DRAM_CLK_STOP
+	str	r1, [r0, #EMC_CFG]
+
+	mov	r1, #0
+	str	r1, [r0, #EMC_SELF_REF]	@ take DRAM out of self refresh
+	mov	r1, #1
+	str	r1, [r0, #EMC_NOP]
+	str	r1, [r0, #EMC_NOP]
+	str	r1, [r0, #EMC_REFRESH]
+
+	emc_device_mask r1, r0
+
+exit_selfrefresh_loop:
+	ldr	r2, [r0, #EMC_EMC_STATUS]
+	ands	r2, r2, r1
+	bne	exit_selfrefresh_loop
+
+	mov	r1, #0			@ unstall all transactions
+	str	r1, [r0, #EMC_REQ_CTRL]
+
+	mov32	r0, TEGRA_PMC_BASE
+	ldr	r0, [r0, #PMC_SCRATCH41]
+	mov	pc, r0			@ jump to tegra_resume
+ENDPROC(tegra20_lp1_reset)
+
+/*
+ * tegra20_tear_down_core
+ *
+ * copied into and executed from IRAM
+ * puts memory in self-refresh for LP0 and LP1
+ */
+tegra20_tear_down_core:
+	bl	tegra20_sdram_self_refresh
+	bl	tegra20_switch_cpu_to_clk32k
+	b	tegra20_enter_sleep
+
+/*
+ * tegra20_switch_cpu_to_clk32k
+ *
+ * In LP0 and LP1 all PLLs will be turned off. Switch the CPU and system clock
+ * to the 32KHz clock.
+ */
+tegra20_switch_cpu_to_clk32k:
+	/*
+	 * start by switching to CLKM to safely disable PLLs, then switch to
+	 * CLKS.
+	 */
+	mov	r0, #(1 << 28)
+	str	r0, [r5, #CLK_RESET_SCLK_BURST]
+	str	r0, [r5, #CLK_RESET_CCLK_BURST]
+	mov	r0, #0
+	str	r0, [r5, #CLK_RESET_CCLK_DIVIDER]
+	str	r0, [r5, #CLK_RESET_SCLK_DIVIDER]
+
+	/* 2uS delay delay between changing SCLK and disabling PLLs */
+	mov32	r7, TEGRA_TMRUS_BASE
+	ldr	r1, [r7]
+	add	r1, r1, #2
+	wait_until r1, r7, r9
+
+	/* switch to CLKS */
+	mov	r0, #0	/* brust policy = 32KHz */
+	str	r0, [r5, #CLK_RESET_SCLK_BURST]
+
+	/* disable PLLM, PLLP and PLLC */
+	ldr	r0, [r5, #CLK_RESET_PLLM_BASE]
+	bic	r0, r0, #(1 << 30)
+	str	r0, [r5, #CLK_RESET_PLLM_BASE]
+	ldr	r0, [r5, #CLK_RESET_PLLP_BASE]
+	bic	r0, r0, #(1 << 30)
+	str	r0, [r5, #CLK_RESET_PLLP_BASE]
+	ldr	r0, [r5, #CLK_RESET_PLLC_BASE]
+	bic	r0, r0, #(1 << 30)
+	str	r0, [r5, #CLK_RESET_PLLC_BASE]
+
+	mov	pc, lr
+
 /*
  * tegra20_enter_sleep
  *
@@ -275,4 +480,95 @@ halted:
 	isb
 	b	halted
 
+/*
+ * tegra20_sdram_self_refresh
+ *
+ * called with MMU off and caches disabled
+ * puts sdram in self refresh
+ * must be executed from IRAM
+ */
+tegra20_sdram_self_refresh:
+	mov32	r1, TEGRA_EMC_BASE	@ r1 reserved for emc base addr
+
+	mov	r2, #3
+	str	r2, [r1, #EMC_REQ_CTRL]	@ stall incoming DRAM requests
+
+emcidle:
+	ldr	r2, [r1, #EMC_EMC_STATUS]
+	tst	r2, #4
+	beq	emcidle
+
+	mov	r2, #1
+	str	r2, [r1, #EMC_SELF_REF]
+
+	emc_device_mask r2, r1
+
+emcself:
+	ldr	r3, [r1, #EMC_EMC_STATUS]
+	and	r3, r3, r2
+	cmp	r3, r2
+	bne	emcself			@ loop until DDR in self-refresh
+
+	adr	r2, tegra20_sdram_pad_address
+	adr	r3, tegra20_sdram_pad_safe
+	adr	r4, tegra20_sdram_pad_save
+	mov	r5, #0
+
+	ldr	r6, tegra20_sdram_pad_size
+padsave:
+	ldr	r0, [r2, r5]		@ r0 is the addr in the pad_address
+
+	ldr	r1, [r0]
+	str	r1, [r4, r5]		@ save the content of the addr
+
+	ldr	r1, [r3, r5]
+	str	r1, [r0]		@ set the save val to the addr
+
+	add	r5, r5, #4
+	cmp	r6, r5
+	bne	padsave
+padsave_done:
+
+	mov32	r5, TEGRA_CLK_RESET_BASE
+	ldr	r0, [r5, #CLK_RESET_SCLK_BURST]
+	adr	r2, tegra20_sclk_save
+	str	r0, [r2]
+	dsb
+	mov	pc, lr
+
+tegra20_sdram_pad_address:
+	.word	TEGRA_APB_MISC_BASE + APB_MISC_XM2CFGCPADCTRL
+	.word	TEGRA_APB_MISC_BASE + APB_MISC_XM2CFGDPADCTRL
+	.word	TEGRA_APB_MISC_BASE + APB_MISC_XM2CLKCFGPADCTRL
+	.word	TEGRA_APB_MISC_BASE + APB_MISC_XM2COMPPADCTRL
+	.word	TEGRA_APB_MISC_BASE + APB_MISC_XM2VTTGENPADCTRL
+	.word	TEGRA_APB_MISC_BASE + APB_MISC_XM2CFGCPADCTRL2
+	.word	TEGRA_APB_MISC_BASE + APB_MISC_XM2CFGDPADCTRL2
+
+tegra20_sdram_pad_size:
+	.word	tegra20_sdram_pad_size - tegra20_sdram_pad_address
+
+tegra20_sdram_pad_safe:
+	.word	0x8
+	.word	0x8
+	.word	0x0
+	.word	0x8
+	.word	0x5500
+	.word	0x08080040
+	.word	0x0
+
+tegra20_sclk_save:
+	.word	0x0
+
+tegra20_sdram_pad_save:
+	.rept (tegra20_sdram_pad_size - tegra20_sdram_pad_address) / 4
+	.long	0
+	.endr
+
+	.ltorg
+/* dummy symbol for end of IRAM */
+	.align L1_CACHE_SHIFT
+	.globl tegra20_iram_end
+tegra20_iram_end:
+	b	.
 #endif
-- 
1.8.3.4
