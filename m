From: b20788@freescale.com (Anson Huang)
Date: Mon, 6 Jan 2014 15:55:39 -0500
Subject: [PATCH 3/3] ARM: imx: add suspend in ocram support on i.mx6sl
In-Reply-To: <1389041739-18389-1-git-send-email-b20788@freescale.com>
References: <1389041739-18389-1-git-send-email-b20788@freescale.com>
Message-ID: <1389041739-18389-3-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SL's suspend in ocram function is derived from i.MX6Q,
the only difference is the offset of DDR IO pins, so we need
to check cpu type in runtime to set DDR IO to high-Z mode
correctly. This patch can lower the DDR IO power from
~10mA at 1.2V to ~1mA at 1.2V, measured on i.MX6SL EVK board, SH5.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/Makefile       |    2 +-
 arch/arm/mach-imx/mach-imx6sl.c  |    8 +-
 arch/arm/mach-imx/suspend-imx6.S |  160 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 164 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 61770b9..d8205fb 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -104,7 +104,7 @@ ifeq ($(CONFIG_PM),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o suspend-imx6.o
 # i.MX6SL reuses i.MX6Q code
-obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o
+obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o suspend-imx6.o
 endif
 
 # i.MX5 based machines
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index cca183a..7fdd4e8 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -52,6 +52,12 @@ static void __init imx6sl_init_machine(void)
 	imx6q_pm_init();
 }
 
+static void __init imx6sl_map_io(void)
+{
+	debug_ll_io_init();
+	imx6_pm_map_io();
+}
+
 static void __init imx6sl_init_irq(void)
 {
 	imx_init_revision_from_anatop();
@@ -67,7 +73,7 @@ static const char *imx6sl_dt_compat[] __initconst = {
 };
 
 DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
-	.map_io		= debug_ll_io_init,
+	.map_io		= imx6sl_map_io,
 	.init_irq	= imx6sl_init_irq,
 	.init_machine	= imx6sl_init_machine,
 	.dt_compat	= imx6sl_dt_compat,
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index 415dfa0..edf5599 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -16,6 +16,7 @@
 #define MX6Q_SRC_GPR1	0x20
 #define MX6Q_SRC_GPR2	0x24
 #define MX6Q_MMDC_MAPSR	0x404
+#define MX6Q_MMDC_MPDGCTRL0	0x83c
 #define MX6Q_GPC_IMR1	0x08
 #define MX6Q_GPC_IMR2	0x0c
 #define MX6Q_GPC_IMR3	0x10
@@ -24,6 +25,103 @@
 
 	.align 3
 
+	.macro	imx6sl_ddr_io_save
+
+	ldr	r4, [r8, #0x30c] /* DRAM_DQM0 */
+	ldr	r5, [r8, #0x310] /* DRAM_DQM1 */
+	ldr	r6, [r8, #0x314] /* DRAM_DQM2 */
+	ldr	r7, [r8, #0x318] /* DRAM_DQM3 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x5c4] /* GPR_B0DS */
+	ldr	r5, [r8, #0x5cc] /* GPR_B1DS */
+	ldr	r6, [r8, #0x5d4] /* GPR_B2DS */
+	ldr	r7, [r8, #0x5d8] /* GPR_B3DS */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x300] /* DRAM_CAS */
+	ldr	r5, [r8, #0x31c] /* DRAM_RAS */
+	ldr	r6, [r8, #0x338] /* DRAM_SDCLK_0 */
+	ldr	r7, [r8, #0x5ac] /* GPR_ADDS*/
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x5b0] /* DDRMODE_CTL */
+	ldr	r5, [r8, #0x5c0] /* DDRMODE */
+	ldr	r6, [r8, #0x33c] /* DRAM_SODT0*/
+	ldr	r7, [r8, #0x340] /* DRAM_SODT1*/
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x330] /* DRAM_SDCKE0 */
+	ldr	r5, [r8, #0x334] /* DRAM_SDCKE1 */
+	ldr	r6, [r8, #0x320] /* DRAM_RESET */
+	stmfd	r10!, {r4-r6}
+
+	.endm
+
+	.macro	imx6sl_ddr_io_restore
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x30c] /* DRAM_DQM0 */
+	str	r5, [r8, #0x310] /* DRAM_DQM1 */
+	str	r6, [r8, #0x314] /* DRAM_DQM2 */
+	str	r7, [r8, #0x318] /* DRAM_DQM3 */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x5c4] /* GPR_B0DS */
+	str	r5, [r8, #0x5cc] /* GPR_B1DS */
+	str	r6, [r8, #0x5d4] /* GPR_B2DS */
+	str	r7, [r8, #0x5d8] /* GPR_B3DS */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x300] /* DRAM_CAS */
+	str	r5, [r8, #0x31c] /* DRAM_RAS */
+	str	r6, [r8, #0x338] /* DRAM_SDCLK_0 */
+	str	r7, [r8, #0x5ac] /* GPR_ADDS*/
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x5b0] /* DDRMODE_CTL */
+	str	r5, [r8, #0x5c0] /* DDRMODE */
+	str	r6, [r8, #0x33c] /* DRAM_SODT0*/
+	str	r7, [r8, #0x340] /* DRAM_SODT1*/
+
+	ldmea	r10!, {r4-r6}
+	str	r4, [r8, #0x330] /* DRAM_SDCKE0 */
+	str	r5, [r8, #0x334] /* DRAM_SDCKE1 */
+	str	r6, [r8, #0x320] /* DRAM_RESET */
+
+	.endm
+
+	.macro	imx6sl_ddr_io_set_lpm
+
+	mov	r10, #0
+	str	r10, [r8, #0x30c] /* DRAM_DQM0 */
+	str	r10, [r8, #0x310] /* DRAM_DQM1 */
+	str	r10, [r8, #0x314] /* DRAM_DQM2 */
+	str	r10, [r8, #0x318] /* DRAM_DQM3 */
+
+	str	r10, [r8, #0x5c4] /* GPR_B0DS */
+	str	r10, [r8, #0x5cc] /* GPR_B1DS */
+	str	r10, [r8, #0x5d4] /* GPR_B2DS */
+	str	r10, [r8, #0x5d8] /* GPR_B3DS */
+
+	str	r10, [r8, #0x300] /* DRAM_CAS */
+	str	r10, [r8, #0x31c] /* DRAM_RAS */
+	str	r10, [r8, #0x338] /* DRAM_SDCLK_0 */
+	str	r10, [r8, #0x5ac] /* GPR_ADDS*/
+
+	str	r10, [r8, #0x5b0] /* DDRMODE_CTL */
+	str	r10, [r8, #0x5c0] /* DDRMODE */
+	str	r10, [r8, #0x33c] /* DRAM_SODT0*/
+	str	r10, [r8, #0x340] /* DRAM_SODT1*/
+
+	mov	r10, #0x80000
+	str	r10, [r8, #0x320] /* DRAM_RESET */
+	mov	r10, #0x1000
+	str	r10, [r8, #0x330] /* DRAM_SDCKE0 */
+	str	r10, [r8, #0x334] /* DRAM_SDCKE1 */
+
+	.endm
+
 	.macro	imx6dl_ddr_io_save
 
 	ldr	r4, [r8, #0x470] /* DRAM_DQM0 */
@@ -401,8 +499,11 @@ ENTRY(imx6_suspend)
 	b	ddr_io_save_dsm_done
 dl_io_dsm_save:
 	cmp	r2, #MXC_CPU_IMX6DL
-	bne	ddr_io_save_dsm_done
+	bne	sl_io_save
 	imx6dl_ddr_io_save
+	b	ddr_io_save_dsm_done
+sl_io_save:
+	imx6sl_ddr_io_save
 ddr_io_save_dsm_done:
 
 	/* need to sync L2 cache before DSM. */
@@ -435,8 +536,11 @@ poll_dvfs_set_1:
 	b	ddr_io_set_lpm_dsm_done
 dl_io_dsm_set_lpm:
 	cmp	r2, #MXC_CPU_IMX6DL
-	bne	ddr_io_set_lpm_dsm_done
+	bne	sl_io_dsm_set_lpm
 	imx6dl_ddr_io_set_lpm
+	b	ddr_io_set_lpm_dsm_done
+sl_io_dsm_set_lpm:
+	imx6sl_ddr_io_set_lpm
 ddr_io_set_lpm_dsm_done:
 
 	/*
@@ -526,8 +630,32 @@ rbc_loop:
 	b	ddr_io_restore_done
 dl_io_restore:
 	cmp	r2, #MXC_CPU_IMX6DL
-	bne	ddr_io_restore_done
+	bne	sl_io_restore
 	imx6dl_ddr_io_restore
+	b	ddr_io_restore_done
+sl_io_restore:
+	imx6sl_ddr_io_restore
+	ldr	r8, =IMX_IO_P2V(MX6Q_MMDC_P0_BASE_ADDR)
+	/* reset read FIFO, RST_RD_FIFO */
+	ldr	r7, =MX6Q_MMDC_MPDGCTRL0
+	ldr	r6, [r8, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r8, r7]
+fifo_reset1_wait:
+	ldr	r6, [r8, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	fifo_reset1_wait
+
+	/* reset FIFO a second time */
+	ldr	r6, [r8, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r8, r7]
+fifo_reset2_wait:
+	ldr	r6, [r8, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	fifo_reset2_wait
 ddr_io_restore_done:
 
 	ldr	r8, =IMX_IO_P2V(MX6Q_MMDC_P0_BASE_ADDR)
@@ -579,8 +707,32 @@ resume:
 	b	ddr_io_restore_dsm_done
 dl_io_dsm_restore:
 	cmp	r2, #MXC_CPU_IMX6DL
-	bne	ddr_io_restore_dsm_done
+	bne	sl_io_dsm_restore
 	imx6dl_ddr_io_restore
+	b	ddr_io_restore_dsm_done
+sl_io_dsm_restore:
+	imx6sl_ddr_io_restore
+	ldr	r8, =MX6Q_MMDC_P0_BASE_ADDR
+	/* reset read FIFO, RST_RD_FIFO */
+	ldr	r7, =MX6Q_MMDC_MPDGCTRL0
+	ldr	r6, [r8, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r8, r7]
+dsm_fifo_reset1_wait:
+	ldr	r6, [r8, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	dsm_fifo_reset1_wait
+
+	/* reset FIFO a second time */
+	ldr	r6, [r8, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r8, r7]
+dsm_fifo_reset2_wait:
+	ldr	r6, [r8, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	dsm_fifo_reset2_wait
 ddr_io_restore_dsm_done:
 
 	ldr	r8, =MX6Q_MMDC_P0_BASE_ADDR
-- 
1.7.9.5
