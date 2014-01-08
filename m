From: b20788@freescale.com (Anson Huang)
Date: Wed, 8 Jan 2014 16:51:05 +0800
Subject: [PATCH V2 2/3] ARM: imx: add suspend in ocram support on i.mx6dl
In-Reply-To: <1389171067-32008-1-git-send-email-b20788@freescale.com>
References: <1389171067-32008-1-git-send-email-b20788@freescale.com>
Message-ID: <1389171067-32008-2-git-send-email-b20788@freescale.com>
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
Changes since V1:
  Add cpu type check to get correct device node.

 arch/arm/mach-imx/pm-imx6q.c     |    5 +-
 arch/arm/mach-imx/suspend-imx6.S |  185 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 185 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 4ade606..19c8de3 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -342,7 +342,10 @@ void __init imx6q_pm_init(void)
 	pm_info->src_addr[0] = (void *)be32_to_cpu(*of_get_address(node, 0, NULL, NULL));
 	pm_info->src_addr[1] = base;
 
-	node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-iomuxc");
+	if (cpu_is_imx6q())
+		node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-iomuxc");
+	else if (cpu_is_imx6dl())
+		node = of_find_compatible_node(NULL, NULL, "fsl,imx6dl-iomuxc");
 	if (!node) {
 		pr_warn("failed to find iomuxc node!\n");
 		goto ocram_out;
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index be0f6bf..5e358e7f3 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -233,6 +233,163 @@
 
 	.endm
 
+	.macro	imx6dl_ddr_io_save
+
+	ldr	r6, [r11, #0x470] /* DRAM_DQM0 */
+	ldr	r7, [r11, #0x474] /* DRAM_DQM1 */
+	ldr	r8, [r11, #0x478] /* DRAM_DQM2 */
+	ldr	r9, [r11, #0x47c] /* DRAM_DQM3 */
+	stmfd	r10!, {r6-r9}
+
+	ldr	r6, [r11, #0x480] /* DRAM_DQM4 */
+	ldr	r7, [r11, #0x484] /* DRAM_DQM5 */
+	ldr	r8, [r11, #0x488] /* DRAM_DQM6 */
+	ldr	r9, [r11, #0x48c] /* DRAM_DQM7 */
+	stmfd	r10!, {r6-r9}
+
+	ldr	r6, [r11, #0x464] /* DRAM_CAS */
+	ldr	r7, [r11, #0x490] /* DRAM_RAS */
+	ldr	r8, [r11, #0x4ac] /* DRAM_SDCLK_0 */
+	ldr	r9, [r11, #0x4b0] /* DRAM_SDCLK_1 */
+	stmfd	r10!, {r6-r9}
+
+	ldr	r8, [r11, #0x750] /* DDRMODE_CTL */
+	ldr	r9, [r11, #0x760] /* DDRMODE */
+	stmfd	r10!, {r8-r9}
+
+	ldr	r6, [r11, #0x4bc] /* DRAM_SDQS0 */
+	ldr	r7, [r11, #0x4c0] /* DRAM_SDQS1 */
+	ldr	r8, [r11, #0x4c4] /* DRAM_SDQS2 */
+	ldr	r9, [r11, #0x4c8] /* DRAM_SDQS3 */
+	stmfd	r10!, {r6-r9}
+
+	ldr	r6, [r11, #0x4cc] /* DRAM_SDQS4 */
+	ldr	r7, [r11, #0x4d0] /* DRAM_SDQS5 */
+	ldr	r8, [r11, #0x4d4] /* DRAM_SDQS6 */
+	ldr	r9, [r11, #0x4d8] /* DRAM_SDQS7 */
+	stmfd	r10!, {r6-r9}
+
+	ldr	r6, [r11, #0x764] /* GPR_B0DS */
+	ldr	r7, [r11, #0x770] /* GPR_B1DS */
+	ldr	r8, [r11, #0x778] /* GPR_B2DS */
+	ldr	r9, [r11, #0x77c] /* GPR_B3DS */
+	stmfd	r10!, {r6-r9}
+
+	ldr	r6, [r11, #0x780] /* GPR_B4DS */
+	ldr	r7, [r11, #0x784] /* GPR_B5DS */
+	ldr	r8, [r11, #0x78c] /* GPR_B6DS */
+	ldr	r9, [r11, #0x748] /* GPR_B7DS */
+	stmfd	r10!, {r6-r9}
+
+	ldr	r7, [r11, #0x74c] /* GPR_ADDS*/
+	ldr	r8, [r11, #0x4b4] /* DRAM_SODT0*/
+	ldr	r9, [r11, #0x4b8] /* DRAM_SODT1*/
+	stmfd	r10!, {r7-r9}
+
+	.endm
+
+	.macro	imx6dl_ddr_io_restore
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x470] /* DRAM_DQM0 */
+	str	r7, [r11, #0x474] /* DRAM_DQM1 */
+	str	r8, [r11, #0x478] /* DRAM_DQM2 */
+	str	r9, [r11, #0x47c] /* DRAM_DQM3 */
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x480] /* DRAM_DQM4 */
+	str	r7, [r11, #0x484] /* DRAM_DQM5 */
+	str	r8, [r11, #0x488] /* DRAM_DQM6 */
+	str	r9, [r11, #0x48c] /* DRAM_DQM7 */
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x464] /* DRAM_CAS */
+	str	r7, [r11, #0x490] /* DRAM_RAS */
+	str	r8, [r11, #0x4ac] /* DRAM_SDCLK_0 */
+	str	r9, [r11, #0x4b0] /* DRAM_SDCLK_1 */
+
+	ldmea	r10!, {r8-r9}
+	str	r8, [r11, #0x750] /* DDRMODE_CTL */
+	str	r9, [r11, #0x760] /* DDRMODE */
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x4bc] /* DRAM_SDQS0 */
+	str	r7, [r11, #0x4c0] /* DRAM_SDQS1 */
+	str	r8, [r11, #0x4c4] /* DRAM_SDQS2 */
+	str	r9, [r11, #0x4c8] /* DRAM_SDQS3 */
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x4cc] /* DRAM_SDQS4 */
+	str	r7, [r11, #0x4d0] /* DRAM_SDQS5 */
+	str	r8, [r11, #0x4d4] /* DRAM_SDQS6 */
+	str	r9, [r11, #0x4d8] /* DRAM_SDQS7 */
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x764] /* GPR_B0DS */
+	str	r7, [r11, #0x770] /* GPR_B1DS */
+	str	r8, [r11, #0x778] /* GPR_B2DS */
+	str	r9, [r11, #0x77c] /* GPR_B3DS */
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x780] /* GPR_B4DS */
+	str	r7, [r11, #0x784] /* GPR_B5DS */
+	str	r8, [r11, #0x78c] /* GPR_B6DS */
+	str	r9, [r11, #0x748] /* GPR_B7DS */
+
+	ldmea	r10!, {r7-r9}
+	str	r7, [r11, #0x74c] /* GPR_ADDS*/
+	str	r8, [r11, #0x4b4] /* DRAM_SODT0*/
+	str	r9, [r11, #0x4b8] /* DRAM_SODT1*/
+
+	.endm
+
+	.macro	imx6dl_ddr_io_set_lpm
+
+	mov	r9, #0
+	str	r9, [r11, #0x470] /* DRAM_DQM0 */
+	str	r9, [r11, #0x474] /* DRAM_DQM1 */
+	str	r9, [r11, #0x478] /* DRAM_DQM2 */
+	str	r9, [r11, #0x47c] /* DRAM_DQM3 */
+
+	str	r9, [r11, #0x480] /* DRAM_DQM4 */
+	str	r9, [r11, #0x484] /* DRAM_DQM5 */
+	str	r9, [r11, #0x488] /* DRAM_DQM6 */
+	str	r9, [r11, #0x48c] /* DRAM_DQM7 */
+
+	str	r9, [r11, #0x464] /* DRAM_CAS */
+	str	r9, [r11, #0x490] /* DRAM_RAS */
+	str	r9, [r11, #0x4ac] /* DRAM_SDCLK_0 */
+	str	r9, [r11, #0x4b0] /* DRAM_SDCLK_1 */
+
+	str	r9, [r11, #0x750] /* DDRMODE_CTL */
+	str	r9, [r11, #0x760] /* DDRMODE */
+
+	str	r9, [r11, #0x4bc] /* DRAM_SDQS0 */
+	str	r9, [r11, #0x4c0] /* DRAM_SDQS1 */
+	str	r9, [r11, #0x4c4] /* DRAM_SDQS2 */
+	str	r9, [r11, #0x4c8] /* DRAM_SDQS3 */
+
+	str	r9, [r11, #0x4cc] /* DRAM_SDQS4 */
+	str	r9, [r11, #0x4d0] /* DRAM_SDQS5 */
+	str	r9, [r11, #0x4d4] /* DRAM_SDQS6 */
+	str	r9, [r11, #0x4d8] /* DRAM_SDQS7 */
+
+	str	r9, [r11, #0x764] /* GPR_B0DS */
+	str	r9, [r11, #0x770] /* GPR_B1DS */
+	str	r9, [r11, #0x778] /* GPR_B2DS */
+	str	r9, [r11, #0x77c] /* GPR_B3DS */
+
+	str	r9, [r11, #0x780] /* GPR_B4DS */
+	str	r9, [r11, #0x784] /* GPR_B5DS */
+	str	r9, [r11, #0x78c] /* GPR_B6DS */
+	str	r9, [r11, #0x748] /* GPR_B7DS */
+
+	str	r9, [r11, #0x74c] /* GPR_ADDS*/
+	str	r9, [r11, #0x4b4] /* DRAM_SODT0*/
+	str	r9, [r11, #0x4b8] /* DRAM_SODT1*/
+
+	.endm
+
 	.macro  sync_l2_cache
 
 	/* sync L2 cache to drain L2's buffers to DRAM. */
@@ -291,8 +448,13 @@ ENTRY(imx6_suspend)
 	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
 
 	cmp     r1, #MXC_CPU_IMX6Q
-	bne	ddr_io_save_dsm_done
+	bne	dl_io_dsm_save
 	imx6dq_ddr_io_save
+	b	ddr_io_save_dsm_done
+dl_io_dsm_save:
+	cmp     r1, #MXC_CPU_IMX6DL
+	bne	ddr_io_save_dsm_done
+	imx6dl_ddr_io_save
 ddr_io_save_dsm_done:
 
 	/* need to sync L2 cache before DSM. */
@@ -320,8 +482,13 @@ poll_dvfs_set_1:
 	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
 
 	cmp     r1, #MXC_CPU_IMX6Q
-	bne	ddr_io_set_lpm_dsm_done
+	bne	dl_io_dsm_set_lpm
 	imx6dq_ddr_io_set_lpm
+	b	ddr_io_set_lpm_dsm_done
+dl_io_dsm_set_lpm:
+	cmp     r1, #MXC_CPU_IMX6DL
+	bne	ddr_io_set_lpm_dsm_done
+	imx6dl_ddr_io_set_lpm
 ddr_io_set_lpm_dsm_done:
 
 	/*
@@ -403,8 +570,13 @@ rbc_loop:
 	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_V_OFFSET]
 
 	cmp     r1, #MXC_CPU_IMX6Q
-	bne	ddr_io_restore_done
+	bne	dl_io_restore
 	imx6dq_ddr_io_restore
+	b	ddr_io_restore_done
+dl_io_restore:
+	cmp     r1, #MXC_CPU_IMX6DL
+	bne     ddr_io_restore_done
+	imx6dl_ddr_io_restore
 ddr_io_restore_done:
 
 	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
@@ -451,8 +623,13 @@ resume:
 	ldr	r11, [r0, #PM_INFO_MX6Q_IOMUXC_P_OFFSET]
 
 	cmp	r1, #MXC_CPU_IMX6Q
-	bne	ddr_io_restore_dsm_done
+	bne	dl_io_dsm_restore
 	imx6dq_ddr_io_restore
+	b	ddr_io_restore_dsm_done
+dl_io_dsm_restore:
+	cmp     r1, #MXC_CPU_IMX6DL
+	bne	ddr_io_restore_dsm_done
+	imx6dl_ddr_io_restore
 ddr_io_restore_dsm_done:
 
 	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
-- 
1.7.9.5
