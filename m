From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 12 Aug 2013 17:40:04 +0800
Subject: [PATCH V3 5/8] ARM: tegra: add LP1 suspend support for Tegra30
In-Reply-To: <1376300407-14750-1-git-send-email-josephl@nvidia.com>
References: <1376300407-14750-1-git-send-email-josephl@nvidia.com>
Message-ID: <1376300407-14750-6-git-send-email-josephl@nvidia.com>
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
be restored, CCLK burst policy be set in PLLX. Then jumping to
"tegra_resume" that was expected to be stored in PMC_SCRATCH41 to restore
CPU context and back to kernel.

Based on the work by: Scott Williams <scwilliams@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* remove the no meaning message "AND MUST BE FIRST"
V2:
* remove wait_for_us
* using IS_ENABLE for SoC specific code
* calculating "tegra30_sdram_pad_save" by assemby symbol
---
 arch/arm/mach-tegra/Makefile        |   1 +
 arch/arm/mach-tegra/pm-tegra30.c    |  34 +++
 arch/arm/mach-tegra/pm.c            |  18 ++
 arch/arm/mach-tegra/pm.h            |   3 +
 arch/arm/mach-tegra/sleep-tegra30.S | 492 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.S         |   8 +-
 arch/arm/mach-tegra/sleep.h         |   8 +
 7 files changed, 560 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-tegra/pm-tegra30.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 98b184e..d341980 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= cpuidle-tegra20.o
 endif
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_speedo.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
 endif
diff --git a/arch/arm/mach-tegra/pm-tegra30.c b/arch/arm/mach-tegra/pm-tegra30.c
new file mode 100644
index 0000000..8fa326d
--- /dev/null
+++ b/arch/arm/mach-tegra/pm-tegra30.c
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
+extern u32 tegra30_iram_start, tegra30_iram_end;
+extern void tegra30_sleep_core_finish(unsigned long);
+
+void tegra30_lp1_iram_hook(void)
+{
+	tegra_lp1_iram.start_addr = &tegra30_iram_start;
+	tegra_lp1_iram.end_addr = &tegra30_iram_end;
+}
+
+void tegra30_sleep_core_init(void)
+{
+	tegra_sleep_core_finish = tegra30_sleep_core_finish;
+}
+#endif
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index d12385f..d557159 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -210,6 +210,15 @@ static int tegra_sleep_core(unsigned long v2p)
  */
 static bool tegra_lp1_iram_hook(void)
 {
+	switch (tegra_chip_id) {
+	case TEGRA30:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
+			tegra30_lp1_iram_hook();
+		break;
+	default:
+		break;
+	}
+
 	if (!tegra_lp1_iram.start_addr || !tegra_lp1_iram.end_addr)
 		return false;
 
@@ -223,6 +232,15 @@ static bool tegra_lp1_iram_hook(void)
 
 static bool tegra_sleep_core_init(void)
 {
+	switch (tegra_chip_id) {
+	case TEGRA30:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
+			tegra30_sleep_core_init();
+		break;
+	default:
+		break;
+	}
+
 	if (!tegra_sleep_core_finish)
 		return false;
 
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 478706e..803bd53 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -30,6 +30,9 @@ struct tegra_lp1_iram {
 extern struct tegra_lp1_iram tegra_lp1_iram;
 extern void (*tegra_sleep_core_finish)(unsigned long v2p);
 
+void tegra30_lp1_iram_hook(void);
+void tegra30_sleep_core_init(void);
+
 extern unsigned long l2x0_saved_regs_addr;
 
 void save_cpu_arch_register(void);
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index ecad4ea..2be7f70 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -18,13 +18,102 @@
 
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
+#include <asm/cache.h>
 
 #include "fuse.h"
 #include "sleep.h"
 #include "flowctrl.h"
 
+#define EMC_CFG				0xc
+#define EMC_ADR_CFG			0x10
+#define EMC_TIMING_CONTROL		0x28
+#define EMC_REFRESH			0x70
+#define EMC_NOP				0xdc
+#define EMC_SELF_REF			0xe0
+#define EMC_MRW				0xe8
+#define EMC_FBIO_CFG5			0x104
+#define EMC_AUTO_CAL_CONFIG		0x2a4
+#define EMC_AUTO_CAL_INTERVAL		0x2a8
+#define EMC_AUTO_CAL_STATUS		0x2ac
+#define EMC_REQ_CTRL			0x2b0
+#define EMC_CFG_DIG_DLL			0x2bc
+#define EMC_EMC_STATUS			0x2b4
+#define EMC_ZCAL_INTERVAL		0x2e0
+#define EMC_ZQ_CAL			0x2ec
+#define EMC_XM2VTTGENPADCTRL		0x310
+#define EMC_XM2VTTGENPADCTRL2		0x314
+
+#define PMC_CTRL			0x0
+#define PMC_CTRL_SIDE_EFFECT_LP0 (1 << 14) /* enter LP0 when CPU pwr gated */
+
+#define PMC_PLLP_WB0_OVERRIDE		0xf8
+#define PMC_IO_DPD_REQ			0x1b8
+#define PMC_IO_DPD_STATUS		0x1bc
+
+#define CLK_RESET_CCLK_BURST		0x20
+#define CLK_RESET_CCLK_DIVIDER		0x24
+#define CLK_RESET_SCLK_BURST		0x28
+#define CLK_RESET_SCLK_DIVIDER		0x2c
+
+#define CLK_RESET_PLLC_BASE		0x80
+#define CLK_RESET_PLLC_MISC		0x8c
+#define CLK_RESET_PLLM_BASE		0x90
+#define CLK_RESET_PLLM_MISC		0x9c
+#define CLK_RESET_PLLP_BASE		0xa0
+#define CLK_RESET_PLLP_MISC		0xac
+#define CLK_RESET_PLLA_BASE		0xb0
+#define CLK_RESET_PLLA_MISC		0xbc
+#define CLK_RESET_PLLX_BASE		0xe0
+#define CLK_RESET_PLLX_MISC		0xe4
+
+#define CLK_RESET_CLK_SOURCE_MSELECT	0x3b4
+
+#define MSELECT_CLKM			(0x3 << 30)
+
+#define LOCK_DELAY 50 /* safety delay after lock is detected */
+
 #define TEGRA30_POWER_HOTPLUG_SHUTDOWN	(1 << 27) /* Hotplug shutdown */
 
+.macro emc_device_mask, rd, base
+	ldr	\rd, [\base, #EMC_ADR_CFG]
+	tst	\rd, #0x1
+	moveq	\rd, #(0x1 << 8)		@ just 1 device
+	movne	\rd, #(0x3 << 8)		@ 2 devices
+.endm
+
+.macro emc_timing_update, rd, base
+	mov	\rd, #1
+	str	\rd, [\base, #EMC_TIMING_CONTROL]
+1001:
+	ldr	\rd, [\base, #EMC_EMC_STATUS]
+	tst	\rd, #(0x1<<23)	@ wait EMC_STATUS_TIMING_UPDATE_STALLED is clear
+	bne	1001b
+.endm
+
+.macro pll_enable, rd, r_car_base, pll_base, pll_misc
+	ldr	\rd, [\r_car_base, #\pll_base]
+	tst	\rd, #(1 << 30)
+	orreq	\rd, \rd, #(1 << 30)
+	streq	\rd, [\r_car_base, #\pll_base]
+	/* Enable lock detector */
+	.if	\pll_misc
+	ldr	\rd, [\r_car_base, #\pll_misc]
+	bic	\rd, \rd, #(1 << 18)
+	str	\rd, [\r_car_base, #\pll_misc]
+	ldr	\rd, [\r_car_base, #\pll_misc]
+	ldr	\rd, [\r_car_base, #\pll_misc]
+	orr	\rd, \rd, #(1 << 18)
+	str	\rd, [\r_car_base, #\pll_misc]
+	.endif
+.endm
+
+.macro pll_locked, rd, r_car_base, pll_base
+1:
+	ldr	\rd, [\r_car_base, #\pll_base]
+	tst	\rd, #(1 << 27)
+	beq	1b
+.endm
+
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PM_SLEEP)
 /*
  * tegra30_hotplug_shutdown(void)
@@ -129,6 +218,41 @@ ENDPROC(tegra30_cpu_shutdown)
 
 #ifdef CONFIG_PM_SLEEP
 /*
+ * tegra30_sleep_core_finish(unsigned long v2p)
+ *
+ * Enters suspend in LP0 or LP1 by turning off the MMU and jumping to
+ * tegra30_tear_down_core in IRAM
+ */
+ENTRY(tegra30_sleep_core_finish)
+	/* Flush, disable the L1 data cache and exit SMP */
+	bl	tegra_disable_clean_inv_dcache
+
+	/*
+	 * Preload all the address literals that are needed for the
+	 * CPU power-gating process, to avoid loading from SDRAM which
+	 * are not supported once SDRAM is put into self-refresh.
+	 * LP0 / LP1 use physical address, since the MMU needs to be
+	 * disabled before putting SDRAM into self-refresh to avoid
+	 * memory access due to page table walks.
+	 */
+	mov32	r4, TEGRA_PMC_BASE
+	mov32	r5, TEGRA_CLK_RESET_BASE
+	mov32	r6, TEGRA_FLOW_CTRL_BASE
+	mov32	r7, TEGRA_TMRUS_BASE
+
+	mov32	r3, tegra_shut_off_mmu
+	add	r3, r3, r0
+
+	mov32	r0, tegra30_tear_down_core
+	mov32	r1, tegra30_iram_start
+	sub	r0, r0, r1
+	mov32	r1, TEGRA_IRAM_CODE_AREA
+	add	r0, r0, r1
+
+	mov	pc, r3
+ENDPROC(tegra30_sleep_core_finish)
+
+/*
  * tegra30_sleep_cpu_secondary_finish(unsigned long v2p)
  *
  * Enters LP2 on secondary CPU by exiting coherency and powergating the CPU.
@@ -158,6 +282,273 @@ ENTRY(tegra30_tear_down_cpu)
 	b	tegra30_enter_sleep
 ENDPROC(tegra30_tear_down_cpu)
 
+/* START OF ROUTINES COPIED TO IRAM */
+	.align L1_CACHE_SHIFT
+	.globl tegra30_iram_start
+tegra30_iram_start:
+
+/*
+ * tegra30_lp1_reset
+ *
+ * reset vector for LP1 restore; copied into IRAM during suspend.
+ * Brings the system back up to a safe staring point (SDRAM out of
+ * self-refresh, PLLC, PLLM and PLLP reenabled, CPU running on PLLX,
+ * system clock running on the same PLL that it suspended at), and
+ * jumps to tegra_resume to restore virtual addressing.
+ * The physical address of tegra_resume expected to be stored in
+ * PMC_SCRATCH41.
+ *
+ * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_CODE_AREA.
+ */
+ENTRY(tegra30_lp1_reset)
+	/*
+	 * The CPU and system bus are running@32KHz and executing from
+	 * IRAM when this code is executed; immediately switch to CLKM and
+	 * enable PLLP, PLLM, PLLC, PLLA and PLLX.
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
+	/* enable PLLM via PMC */
+	mov32	r2, TEGRA_PMC_BASE
+	ldr	r1, [r2, #PMC_PLLP_WB0_OVERRIDE]
+	orr	r1, r1, #(1 << 12)
+	str	r1, [r2, #PMC_PLLP_WB0_OVERRIDE]
+
+	pll_enable r1, r0, CLK_RESET_PLLM_BASE, CLK_RESET_PLLM_MISC
+	pll_enable r1, r0, CLK_RESET_PLLP_BASE, CLK_RESET_PLLP_MISC
+	pll_enable r1, r0, CLK_RESET_PLLA_BASE, CLK_RESET_PLLA_MISC
+	pll_enable r1, r0, CLK_RESET_PLLC_BASE, CLK_RESET_PLLC_MISC
+	pll_enable r1, r0, CLK_RESET_PLLX_BASE, CLK_RESET_PLLX_MISC
+
+	pll_locked r1, r0, CLK_RESET_PLLM_BASE
+	pll_locked r1, r0, CLK_RESET_PLLP_BASE
+	pll_locked r1, r0, CLK_RESET_PLLA_BASE
+	pll_locked r1, r0, CLK_RESET_PLLC_BASE
+	pll_locked r1, r0, CLK_RESET_PLLX_BASE
+
+	mov32	r7, TEGRA_TMRUS_BASE
+	ldr	r1, [r7]
+	add	r1, r1, #LOCK_DELAY
+	wait_until r1, r7, r3
+
+	adr	r5, tegra30_sdram_pad_save
+
+	ldr	r4, [r5, #0x18]		@ restore CLK_SOURCE_MSELECT
+	str	r4, [r0, #CLK_RESET_CLK_SOURCE_MSELECT]
+
+	ldr	r4, [r5, #0x1C]		@ restore SCLK_BURST
+	str	r4, [r0, #CLK_RESET_SCLK_BURST]
+
+	mov32	r4, ((1 << 28) | (0x8))	@ burst policy is PLLX
+	str	r4, [r0, #CLK_RESET_CCLK_BURST]
+
+	/* Restore pad power state to normal */
+	ldr	r1, [r5, #0x14]		@ PMC_IO_DPD_STATUS
+	mvn	r1, r1
+	bic	r1, r1, #(1 << 31)
+	orr	r1, r1, #(1 << 30)
+	str	r1, [r2, #PMC_IO_DPD_REQ]	@ DPD_OFF
+
+	mov32	r0, TEGRA_EMC_BASE	@ r0 reserved for emc base
+
+	ldr	r1, [r5, #0xC]		@ restore EMC_XM2VTTGENPADCTRL
+	str	r1, [r0, #EMC_XM2VTTGENPADCTRL]
+	ldr	r1, [r5, #0x10]		@ restore EMC_XM2VTTGENPADCTRL2
+	str	r1, [r0, #EMC_XM2VTTGENPADCTRL2]
+	ldr	r1, [r5, #0x8]		@ restore EMC_AUTO_CAL_INTERVAL
+	str	r1, [r0, #EMC_AUTO_CAL_INTERVAL]
+
+	/* Relock DLL */
+	ldr	r1, [r0, #EMC_CFG_DIG_DLL]
+	orr	r1, r1, #(1 << 30)	@ set DLL_RESET
+	str	r1, [r0, #EMC_CFG_DIG_DLL]
+
+	emc_timing_update r1, r0
+
+	ldr	r1, [r0, #EMC_AUTO_CAL_CONFIG]
+	orr	r1, r1, #(1 << 31)	@ set AUTO_CAL_ACTIVE
+	str	r1, [r0, #EMC_AUTO_CAL_CONFIG]
+
+emc_wait_auto_cal_onetime:
+	ldr	r1, [r0, #EMC_AUTO_CAL_STATUS]
+	tst	r1, #(1 << 31)		@ wait until AUTO_CAL_ACTIVE is cleared
+	bne	emc_wait_auto_cal_onetime
+
+	ldr	r1, [r0, #EMC_CFG]
+	bic	r1, r1, #(1 << 31)	@ disable DRAM_CLK_STOP_PD
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
+	lsr	r1, r1, #8		@ devSel, bit0:dev0, bit1:dev1
+
+	mov32	r7, TEGRA_TMRUS_BASE
+	ldr	r2, [r0, #EMC_FBIO_CFG5]
+
+	and	r2, r2,	#3		@ check DRAM_TYPE
+	cmp	r2, #2
+	beq	emc_lpddr2
+
+	/* Issue a ZQ_CAL for dev0 - DDR3 */
+	mov32	r2, 0x80000011		@ DEV_SELECTION=2, LENGTH=LONG, CMD=1
+	str	r2, [r0, #EMC_ZQ_CAL]
+	ldr	r2, [r7]
+	add	r2, r2, #10
+	wait_until r2, r7, r3
+
+	tst	r1, #2
+	beq	zcal_done
+
+	/* Issue a ZQ_CAL for dev1 - DDR3 */
+	mov32	r2, 0x40000011		@ DEV_SELECTION=1, LENGTH=LONG, CMD=1
+	str	r2, [r0, #EMC_ZQ_CAL]
+	ldr	r2, [r7]
+	add	r2, r2, #10
+	wait_until r2, r7, r3
+	b	zcal_done
+
+emc_lpddr2:
+	/* Issue a ZQ_CAL for dev0 - LPDDR2 */
+	mov32	r2, 0x800A00AB		@ DEV_SELECTION=2, MA=10, OP=0xAB
+	str	r2, [r0, #EMC_MRW]
+	ldr	r2, [r7]
+	add	r2, r2, #1
+	wait_until r2, r7, r3
+
+	tst	r1, #2
+	beq	zcal_done
+
+	/* Issue a ZQ_CAL for dev0 - LPDDR2 */
+	mov32	r2, 0x400A00AB		@ DEV_SELECTION=1, MA=10, OP=0xAB
+	str	r2, [r0, #EMC_MRW]
+	ldr	r2, [r7]
+	add	r2, r2, #1
+	wait_until r2, r7, r3
+
+zcal_done:
+	mov	r1, #0			@ unstall all transactions
+	str	r1, [r0, #EMC_REQ_CTRL]
+	ldr	r1, [r5, #0x4]		@ restore EMC_ZCAL_INTERVAL
+	str	r1, [r0, #EMC_ZCAL_INTERVAL]
+	ldr	r1, [r5, #0x0]		@ restore EMC_CFG
+	str	r1, [r0, #EMC_CFG]
+
+	mov32	r0, TEGRA_PMC_BASE
+	ldr	r0, [r0, #PMC_SCRATCH41]
+	mov	pc, r0			@ jump to tegra_resume
+ENDPROC(tegra30_lp1_reset)
+
+	.align	L1_CACHE_SHIFT
+tegra30_sdram_pad_address:
+	.word	TEGRA_EMC_BASE + EMC_CFG				@0x0
+	.word	TEGRA_EMC_BASE + EMC_ZCAL_INTERVAL			@0x4
+	.word	TEGRA_EMC_BASE + EMC_AUTO_CAL_INTERVAL			@0x8
+	.word	TEGRA_EMC_BASE + EMC_XM2VTTGENPADCTRL			@0xc
+	.word	TEGRA_EMC_BASE + EMC_XM2VTTGENPADCTRL2			@0x10
+	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
+	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
+	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
+
+tegra30_sdram_pad_size:
+	.word	tegra30_sdram_pad_size - tegra30_sdram_pad_address
+
+	.type	tegra30_sdram_pad_save, %object
+tegra30_sdram_pad_save:
+	.rept (tegra30_sdram_pad_size - tegra30_sdram_pad_address) / 4
+	.long	0
+	.endr
+
+/*
+ * tegra30_tear_down_core
+ *
+ * copied into and executed from IRAM
+ * puts memory in self-refresh for LP0 and LP1
+ */
+tegra30_tear_down_core:
+	bl	tegra30_sdram_self_refresh
+	bl	tegra30_switch_cpu_to_clk32k
+	b	tegra30_enter_sleep
+
+/*
+ * tegra30_switch_cpu_to_clk32k
+ *
+ * In LP0 and LP1 all PLLs will be turned off. Switching the CPU and System CLK
+ * to the 32KHz clock.
+ * r4 = TEGRA_PMC_BASE
+ * r5 = TEGRA_CLK_RESET_BASE
+ * r6 = TEGRA_FLOW_CTRL_BASE
+ * r7 = TEGRA_TMRUS_BASE
+ */
+tegra30_switch_cpu_to_clk32k:
+	/*
+	 * start by jumping to CLKM to safely disable PLLs, then jump to
+	 * CLKS.
+	 */
+	mov	r0, #(1 << 28)
+	str	r0, [r5, #CLK_RESET_SCLK_BURST]
+	/* 2uS delay delay between changing SCLK and CCLK */
+	ldr	r1, [r7]
+	add	r1, r1, #2
+	wait_until r1, r7, r9
+	str	r0, [r5, #CLK_RESET_CCLK_BURST]
+	mov	r0, #0
+	str	r0, [r5, #CLK_RESET_CCLK_DIVIDER]
+	str	r0, [r5, #CLK_RESET_SCLK_DIVIDER]
+
+	/* switch the clock source of mselect to be CLK_M */
+	ldr	r0, [r5, #CLK_RESET_CLK_SOURCE_MSELECT]
+	orr	r0, r0, #MSELECT_CLKM
+	str	r0, [r5, #CLK_RESET_CLK_SOURCE_MSELECT]
+
+	/* 2uS delay delay between changing SCLK and disabling PLLs */
+	ldr	r1, [r7]
+	add	r1, r1, #2
+	wait_until r1, r7, r9
+
+	/* disable PLLM via PMC in LP1 */
+	ldr	r0, [r4, #PMC_PLLP_WB0_OVERRIDE]
+	bic	r0, r0, #(1 << 12)
+	str	r0, [r4, #PMC_PLLP_WB0_OVERRIDE]
+
+	/* disable PLLP, PLLA, PLLC and PLLX */
+	ldr	r0, [r5, #CLK_RESET_PLLP_BASE]
+	bic	r0, r0, #(1 << 30)
+	str	r0, [r5, #CLK_RESET_PLLP_BASE]
+	ldr	r0, [r5, #CLK_RESET_PLLA_BASE]
+	bic	r0, r0, #(1 << 30)
+	str	r0, [r5, #CLK_RESET_PLLA_BASE]
+	ldr	r0, [r5, #CLK_RESET_PLLC_BASE]
+	bic	r0, r0, #(1 << 30)
+	str	r0, [r5, #CLK_RESET_PLLC_BASE]
+	ldr	r0, [r5, #CLK_RESET_PLLX_BASE]
+	bic	r0, r0, #(1 << 30)
+	str	r0, [r5, #CLK_RESET_PLLX_BASE]
+
+	/* switch to CLKS */
+	mov	r0, #0	/* brust policy = 32KHz */
+	str	r0, [r5, #CLK_RESET_SCLK_BURST]
+
+	mov	pc, lr
+
 /*
  * tegra30_enter_sleep
  *
@@ -194,4 +585,105 @@ halted:
 	/* !!!FIXME!!! Implement halt failure handler */
 	b	halted
 
+/*
+ * tegra30_sdram_self_refresh
+ *
+ * called with MMU off and caches disabled
+ * must be executed from IRAM
+ * r4 = TEGRA_PMC_BASE
+ * r5 = TEGRA_CLK_RESET_BASE
+ * r6 = TEGRA_FLOW_CTRL_BASE
+ * r7 = TEGRA_TMRUS_BASE
+ */
+tegra30_sdram_self_refresh:
+
+	adr	r2, tegra30_sdram_pad_address
+	adr	r8, tegra30_sdram_pad_save
+	mov	r9, #0
+
+	ldr	r3, tegra30_sdram_pad_size
+padsave:
+	ldr	r0, [r2, r9]		@ r0 is the addr in the pad_address
+
+	ldr	r1, [r0]
+	str	r1, [r8, r9]		@ save the content of the addr
+
+	add	r9, r9, #4
+	cmp	r3, r9
+	bne	padsave
+padsave_done:
+
+	dsb
+
+	mov32	r0, TEGRA_EMC_BASE	@ r0 reserved for emc base addr
+
+	mov	r1, #0
+	str	r1, [r0, #EMC_ZCAL_INTERVAL]
+	str	r1, [r0, #EMC_AUTO_CAL_INTERVAL]
+	ldr	r1, [r0, #EMC_CFG]
+	bic	r1, r1, #(1 << 28)
+	str	r1, [r0, #EMC_CFG]	@ disable DYN_SELF_REF
+
+	emc_timing_update r1, r0
+
+	ldr	r1, [r7]
+	add	r1, r1, #5
+	wait_until r1, r7, r2
+
+emc_wait_auto_cal:
+	ldr	r1, [r0, #EMC_AUTO_CAL_STATUS]
+	tst	r1, #(1 << 31)		@ wait until AUTO_CAL_ACTIVE is cleared
+	bne	emc_wait_auto_cal
+
+	mov	r1, #3
+	str	r1, [r0, #EMC_REQ_CTRL]	@ stall incoming DRAM requests
+
+emcidle:
+	ldr	r1, [r0, #EMC_EMC_STATUS]
+	tst	r1, #4
+	beq	emcidle
+
+	mov	r1, #1
+	str	r1, [r0, #EMC_SELF_REF]
+
+	emc_device_mask r1, r0
+
+emcself:
+	ldr	r2, [r0, #EMC_EMC_STATUS]
+	and	r2, r2, r1
+	cmp	r2, r1
+	bne	emcself			@ loop until DDR in self-refresh
+
+	/* Put VTTGEN in the lowest power mode */
+	ldr	r1, [r0, #EMC_XM2VTTGENPADCTRL]
+	mov32	r2, 0xF8F8FFFF	@ clear XM2VTTGEN_DRVUP and XM2VTTGEN_DRVDN
+	and	r1, r1, r2
+	str	r1, [r0, #EMC_XM2VTTGENPADCTRL]
+	ldr	r1, [r0, #EMC_XM2VTTGENPADCTRL2]
+	orr	r1, r1, #7		@ set E_NO_VTTGEN
+	str	r1, [r0, #EMC_XM2VTTGENPADCTRL2]
+
+	emc_timing_update r1, r0
+
+	ldr	r1, [r4, #PMC_CTRL]
+	tst	r1, #PMC_CTRL_SIDE_EFFECT_LP0
+	bne	pmc_io_dpd_skip
+	/*
+	 * Put DDR_DATA, DISC_ADDR_CMD, DDR_ADDR_CMD, POP_ADDR_CMD, POP_CLK
+	 * and COMP in the lowest power mode when LP1.
+	 */
+	mov32	r1, 0x8EC00000
+	str	r1, [r4, #PMC_IO_DPD_REQ]
+pmc_io_dpd_skip:
+
+	dsb
+
+	mov	pc, lr
+
+	.ltorg
+/* dummy symbol for end of IRAM */
+	.align L1_CACHE_SHIFT
+	.global tegra30_iram_end
+tegra30_iram_end:
+	b	.
 #endif
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 8388113..8d06213 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -134,10 +134,10 @@ ENTRY(tegra_shut_off_mmu)
 #ifdef CONFIG_CACHE_L2X0
 	/* Disable L2 cache */
 	check_cpu_part_num 0xc09, r9, r10
-	movweq	r4, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	movteq	r4, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	moveq	r5, #0
-	streq	r5, [r4, #L2X0_CTRL]
+	movweq	r2, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
+	movteq	r2, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
+	moveq	r3, #0
+	streq	r3, [r2, #L2X0_CTRL]
 #endif
 	mov	pc, r0
 ENDPROC(tegra_shut_off_mmu)
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index e907e40..a4edbb3 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -46,6 +46,14 @@
 #define TEGRA_FLUSH_CACHE_ALL	1
 
 #ifdef __ASSEMBLY__
+/* waits until the microsecond counter (base) is > rn */
+.macro wait_until, rn, base, tmp
+	add	\rn, \rn, #1
+1001:	ldr	\tmp, [\base]
+	cmp	\tmp, \rn
+	bmi	1001b
+.endm
+
 /* returns the offset of the flow controller halt register for a cpu */
 .macro cpu_to_halt_reg rd, rcpu
 	cmp	\rcpu, #0
-- 
1.8.3.4
