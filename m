From: b20788@freescale.com (Anson Huang)
Date: Mon, 6 Jan 2014 15:55:38 -0500
Subject: [PATCH 2/3] ARM: imx: add suspend in ocram support on i.mx6dl
In-Reply-To: <1389041739-18389-1-git-send-email-b20788@freescale.com>
References: <1389041739-18389-1-git-send-email-b20788@freescale.com>
Message-ID: <1389041739-18389-2-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6DL's suspend in ocram function is derived from i.MX6Q,
the only difference is the offset of DDR IO pins, so we need
to check cpu type in runtime to set DDR IO to high-Z mode
correctly. This patch can lower the DDR IO power from
~26mA at 1.5V to ~15mA at 1.5V, measured on i.MX6Q/DL SabreSD board,
R25.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/suspend-imx6.S |  191 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 184 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index 2ae0354..415dfa0 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -24,6 +24,163 @@
 
 	.align 3
 
+	.macro	imx6dl_ddr_io_save
+
+	ldr	r4, [r8, #0x470] /* DRAM_DQM0 */
+	ldr	r5, [r8, #0x474] /* DRAM_DQM1 */
+	ldr	r6, [r8, #0x478] /* DRAM_DQM2 */
+	ldr	r7, [r8, #0x47c] /* DRAM_DQM3 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x480] /* DRAM_DQM4 */
+	ldr	r5, [r8, #0x484] /* DRAM_DQM5 */
+	ldr	r6, [r8, #0x488] /* DRAM_DQM6 */
+	ldr	r7, [r8, #0x48c] /* DRAM_DQM7 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x464] /* DRAM_CAS */
+	ldr	r5, [r8, #0x490] /* DRAM_RAS */
+	ldr	r6, [r8, #0x4ac] /* DRAM_SDCLK_0 */
+	ldr	r7, [r8, #0x4b0] /* DRAM_SDCLK_1 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r5, [r8, #0x750] /* DDRMODE_CTL */
+	ldr	r6, [r8, #0x760] /* DDRMODE */
+	stmfd	r10!, {r5-r6}
+
+	ldr	r4, [r8, #0x4bc] /* DRAM_SDQS0 */
+	ldr	r5, [r8, #0x4c0] /* DRAM_SDQS1 */
+	ldr	r6, [r8, #0x4c4] /* DRAM_SDQS2 */
+	ldr	r7, [r8, #0x4c8] /* DRAM_SDQS3 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x4cc] /* DRAM_SDQS4 */
+	ldr	r5, [r8, #0x4d0] /* DRAM_SDQS5 */
+	ldr	r6, [r8, #0x4d4] /* DRAM_SDQS6 */
+	ldr	r7, [r8, #0x4d8] /* DRAM_SDQS7 */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x764] /* GPR_B0DS */
+	ldr	r5, [r8, #0x770] /* GPR_B1DS */
+	ldr	r6, [r8, #0x778] /* GPR_B2DS */
+	ldr	r7, [r8, #0x77c] /* GPR_B3DS */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r4, [r8, #0x780] /* GPR_B4DS */
+	ldr	r5, [r8, #0x784] /* GPR_B5DS */
+	ldr	r6, [r8, #0x78c] /* GPR_B6DS */
+	ldr	r7, [r8, #0x748] /* GPR_B7DS */
+	stmfd	r10!, {r4-r7}
+
+	ldr	r5, [r8, #0x74c] /* GPR_ADDS*/
+	ldr	r6, [r8, #0x4b4] /* DRAM_SODT0*/
+	ldr	r7, [r8, #0x4b8] /* DRAM_SODT1*/
+	stmfd	r10!, {r5-r7}
+
+	.endm
+
+	.macro	imx6dl_ddr_io_restore
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x470] /* DRAM_DQM0 */
+	str	r5, [r8, #0x474] /* DRAM_DQM1 */
+	str	r6, [r8, #0x478] /* DRAM_DQM2 */
+	str	r7, [r8, #0x47c] /* DRAM_DQM3 */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x480] /* DRAM_DQM4 */
+	str	r5, [r8, #0x484] /* DRAM_DQM5 */
+	str	r6, [r8, #0x488] /* DRAM_DQM6 */
+	str	r7, [r8, #0x48c] /* DRAM_DQM7 */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x464] /* DRAM_CAS */
+	str	r5, [r8, #0x490] /* DRAM_RAS */
+	str	r6, [r8, #0x4ac] /* DRAM_SDCLK_0 */
+	str	r7, [r8, #0x4b0] /* DRAM_SDCLK_1 */
+
+	ldmea	r10!, {r5-r6}
+	str	r5, [r8, #0x750] /* DDRMODE_CTL */
+	str	r6, [r8, #0x760] /* DDRMODE */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x4bc] /* DRAM_SDQS0 */
+	str	r5, [r8, #0x4c0] /* DRAM_SDQS1 */
+	str	r6, [r8, #0x4c4] /* DRAM_SDQS2 */
+	str	r7, [r8, #0x4c8] /* DRAM_SDQS3 */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x4cc] /* DRAM_SDQS4 */
+	str	r5, [r8, #0x4d0] /* DRAM_SDQS5 */
+	str	r6, [r8, #0x4d4] /* DRAM_SDQS6 */
+	str	r7, [r8, #0x4d8] /* DRAM_SDQS7 */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x764] /* GPR_B0DS */
+	str	r5, [r8, #0x770] /* GPR_B1DS */
+	str	r6, [r8, #0x778] /* GPR_B2DS */
+	str	r7, [r8, #0x77c] /* GPR_B3DS */
+
+	ldmea	r10!, {r4-r7}
+	str	r4, [r8, #0x780] /* GPR_B4DS */
+	str	r5, [r8, #0x784] /* GPR_B5DS */
+	str	r6, [r8, #0x78c] /* GPR_B6DS */
+	str	r7, [r8, #0x748] /* GPR_B7DS */
+
+	ldmea	r10!, {r5-r7}
+	str	r5, [r8, #0x74c] /* GPR_ADDS*/
+	str	r6, [r8, #0x4b4] /* DRAM_SODT0*/
+	str	r7, [r8, #0x4b8] /* DRAM_SODT1*/
+
+	.endm
+
+	.macro	imx6dl_ddr_io_set_lpm
+
+	mov	r10, #0
+	str	r10, [r8, #0x470] /* DRAM_DQM0 */
+	str	r10, [r8, #0x474] /* DRAM_DQM1 */
+	str	r10, [r8, #0x478] /* DRAM_DQM2 */
+	str	r10, [r8, #0x47c] /* DRAM_DQM3 */
+
+	str	r10, [r8, #0x480] /* DRAM_DQM4 */
+	str	r10, [r8, #0x484] /* DRAM_DQM5 */
+	str	r10, [r8, #0x488] /* DRAM_DQM6 */
+	str	r10, [r8, #0x48c] /* DRAM_DQM7 */
+
+	str	r10, [r8, #0x464] /* DRAM_CAS */
+	str	r10, [r8, #0x490] /* DRAM_RAS */
+	str	r10, [r8, #0x4ac] /* DRAM_SDCLK_0 */
+	str	r10, [r8, #0x4b0] /* DRAM_SDCLK_1 */
+
+	str	r10, [r8, #0x750] /* DDRMODE_CTL */
+	str	r10, [r8, #0x760] /* DDRMODE */
+
+	str	r10, [r8, #0x4bc] /* DRAM_SDQS0 */
+	str	r10, [r8, #0x4c0] /* DRAM_SDQS1 */
+	str	r10, [r8, #0x4c4] /* DRAM_SDQS2 */
+	str	r10, [r8, #0x4c8] /* DRAM_SDQS3 */
+
+	str	r10, [r8, #0x4cc] /* DRAM_SDQS4 */
+	str	r10, [r8, #0x4d0] /* DRAM_SDQS5 */
+	str	r10, [r8, #0x4d4] /* DRAM_SDQS6 */
+	str	r10, [r8, #0x4d8] /* DRAM_SDQS7 */
+
+	str	r10, [r8, #0x764] /* GPR_B0DS */
+	str	r10, [r8, #0x770] /* GPR_B1DS */
+	str	r10, [r8, #0x778] /* GPR_B2DS */
+	str	r10, [r8, #0x77c] /* GPR_B3DS */
+
+	str	r10, [r8, #0x780] /* GPR_B4DS */
+	str	r10, [r8, #0x784] /* GPR_B5DS */
+	str	r10, [r8, #0x78c] /* GPR_B6DS */
+	str	r10, [r8, #0x748] /* GPR_B7DS */
+
+	str	r10, [r8, #0x74c] /* GPR_ADDS*/
+	str	r10, [r8, #0x4b4] /* DRAM_SODT0*/
+	str	r10, [r8, #0x4b8] /* DRAM_SODT1*/
+
+	.endm
+
 	.macro	imx6dq_ddr_io_save
 
 	ldr	r4, [r8, #0x5ac] /* DRAM_DQM0 */
@@ -238,9 +395,14 @@ ENTRY(imx6_suspend)
 
 	ldr	r8, =IMX_IO_P2V(MX6Q_IOMUXC_BASE_ADDR)
 
-	cmp     r2, #MXC_CPU_IMX6Q
-	bne	ddr_io_save_dsm_done
+	cmp	r2, #MXC_CPU_IMX6Q
+	bne	dl_io_dsm_save
 	imx6dq_ddr_io_save
+	b	ddr_io_save_dsm_done
+dl_io_dsm_save:
+	cmp	r2, #MXC_CPU_IMX6DL
+	bne	ddr_io_save_dsm_done
+	imx6dl_ddr_io_save
 ddr_io_save_dsm_done:
 
 	/* need to sync L2 cache before DSM. */
@@ -267,9 +429,14 @@ poll_dvfs_set_1:
 
 	ldr	r8, =IMX_IO_P2V(MX6Q_IOMUXC_BASE_ADDR)
 
-	cmp     r2, #MXC_CPU_IMX6Q
-	bne	ddr_io_set_lpm_dsm_done
+	cmp	r2, #MXC_CPU_IMX6Q
+	bne	dl_io_dsm_set_lpm
 	imx6dq_ddr_io_set_lpm
+	b	ddr_io_set_lpm_dsm_done
+dl_io_dsm_set_lpm:
+	cmp	r2, #MXC_CPU_IMX6DL
+	bne	ddr_io_set_lpm_dsm_done
+	imx6dl_ddr_io_set_lpm
 ddr_io_set_lpm_dsm_done:
 
 	/*
@@ -353,9 +520,14 @@ rbc_loop:
 
 	ldr	r8, =IMX_IO_P2V(MX6Q_IOMUXC_BASE_ADDR)
 
-	cmp     r2, #MXC_CPU_IMX6Q
-	bne	ddr_io_restore_done
+	cmp	r2, #MXC_CPU_IMX6Q
+	bne	dl_io_restore
 	imx6dq_ddr_io_restore
+	b	ddr_io_restore_done
+dl_io_restore:
+	cmp	r2, #MXC_CPU_IMX6DL
+	bne	ddr_io_restore_done
+	imx6dl_ddr_io_restore
 ddr_io_restore_done:
 
 	ldr	r8, =IMX_IO_P2V(MX6Q_MMDC_P0_BASE_ADDR)
@@ -402,8 +574,13 @@ resume:
 	ldr	r8, =MX6Q_IOMUXC_BASE_ADDR
 
 	cmp	r2, #MXC_CPU_IMX6Q
-	bne	ddr_io_restore_dsm_done
+	bne	dl_io_dsm_restore
 	imx6dq_ddr_io_restore
+	b	ddr_io_restore_dsm_done
+dl_io_dsm_restore:
+	cmp	r2, #MXC_CPU_IMX6DL
+	bne	ddr_io_restore_dsm_done
+	imx6dl_ddr_io_restore
 ddr_io_restore_dsm_done:
 
 	ldr	r8, =MX6Q_MMDC_P0_BASE_ADDR
-- 
1.7.9.5
