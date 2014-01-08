From: b20788@freescale.com (Anson Huang)
Date: Wed, 8 Jan 2014 16:51:06 +0800
Subject: [PATCH V2 3/3] ARM: imx: add suspend in ocram support on i.mx6sl
In-Reply-To: <1389171067-32008-1-git-send-email-b20788@freescale.com>
References: <1389171067-32008-1-git-send-email-b20788@freescale.com>
Message-ID: <1389171067-32008-3-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SL's suspend in ocram function is derived from i.MX6Q,
the only difference is the offset of DDR IO pins, so we need
to check cpu type in runtime to set DDR IO to high-Z mode
correctly. This patch can lower the DDR IO power from
~10mA at 1.2V to ~1mA at 1.2V, measured on i.MX6SL EVK board, SH5.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
Changes since V1:
  Add cpu type check to get correct device node.

 arch/arm/mach-imx/pm-imx6q.c     |   12 ++-
 arch/arm/mach-imx/suspend-imx6.S |  168 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 174 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index 19c8de3..d3253ff 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -333,7 +333,10 @@ void __init imx6q_pm_init(void)
 	pm_info->mmdc_addr[0] = (void *)be32_to_cpu(*of_get_address(node, 0, NULL, NULL));
 	pm_info->mmdc_addr[1] = base;
 
-	node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
+	if (cpu_is_imx6q() || cpu_is_imx6dl())
+		node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
+	else if (cpu_is_imx6sl())
+		node = of_find_compatible_node(NULL, NULL, "fsl,imx6sl-src");
 	if (!node) {
 		pr_warn("failed to find src node!\n");
 		goto ocram_out;
@@ -346,6 +349,8 @@ void __init imx6q_pm_init(void)
 		node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-iomuxc");
 	else if (cpu_is_imx6dl())
 		node = of_find_compatible_node(NULL, NULL, "fsl,imx6dl-iomuxc");
+	else if (cpu_is_imx6sl())
+		node = of_find_compatible_node(NULL, NULL, "fsl,imx6sl-iomuxc");
 	if (!node) {
 		pr_warn("failed to find iomuxc node!\n");
 		goto ocram_out;
@@ -354,7 +359,10 @@ void __init imx6q_pm_init(void)
 	pm_info->iomuxc_addr[0] = (void *)be32_to_cpu(*of_get_address(node, 0, NULL, NULL));
 	pm_info->iomuxc_addr[1] = base;
 
-	node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ccm");
+	if (cpu_is_imx6q() || cpu_is_imx6dl())
+		node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ccm");
+	else if (cpu_is_imx6sl())
+		node = of_find_compatible_node(NULL, NULL, "fsl,imx6sl-ccm");
 	if (!node) {
 		pr_warn("failed to find ccm node!\n");
 		goto ocram_out;
diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index 5e358e7f3..3c6a4ef 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -68,6 +68,7 @@
 #define MX6Q_SRC_GPR1	0x20
 #define MX6Q_SRC_GPR2	0x24
 #define MX6Q_MMDC_MAPSR	0x404
+#define MX6Q_MMDC_MPDGCTRL0	0x83c
 #define MX6Q_GPC_IMR1	0x08
 #define MX6Q_GPC_IMR2	0x0c
 #define MX6Q_GPC_IMR3	0x10
@@ -390,6 +391,103 @@
 
 	.endm
 
+	.macro	imx6sl_ddr_io_save
+
+	ldr	r6, [r11, #0x30c] /* DRAM_DQM0 */
+	ldr	r7, [r11, #0x310] /* DRAM_DQM1 */
+	ldr	r8, [r11, #0x314] /* DRAM_DQM2 */
+	ldr	r9, [r11, #0x318] /* DRAM_DQM3 */
+	stmfd	r10!, {r6-r9}
+
+	ldr	r6, [r11, #0x5c4] /* GPR_B0DS */
+	ldr	r7, [r11, #0x5cc] /* GPR_B1DS */
+	ldr	r8, [r11, #0x5d4] /* GPR_B2DS */
+	ldr	r9, [r11, #0x5d8] /* GPR_B3DS */
+	stmfd	r10!, {r6-r9}
+
+	ldr	r6, [r11, #0x300] /* DRAM_CAS */
+	ldr	r7, [r11, #0x31c] /* DRAM_RAS */
+	ldr	r8, [r11, #0x338] /* DRAM_SDCLK_0 */
+	ldr	r9, [r11, #0x5ac] /* GPR_ADDS*/
+	stmfd	r10!, {r6-r9}
+
+	ldr	r6, [r11, #0x5b0] /* DDRMODE_CTL */
+	ldr	r7, [r11, #0x5c0] /* DDRMODE */
+	ldr	r8, [r11, #0x33c] /* DRAM_SODT0*/
+	ldr	r9, [r11, #0x340] /* DRAM_SODT1*/
+	stmfd	r10!, {r6-r9}
+
+	ldr	r7, [r11, #0x330] /* DRAM_SDCKE0 */
+	ldr	r8, [r11, #0x334] /* DRAM_SDCKE1 */
+	ldr	r9, [r11, #0x320] /* DRAM_RESET */
+	stmfd	r10!, {r7-r9}
+
+	.endm
+
+	.macro	imx6sl_ddr_io_restore
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x30c] /* DRAM_DQM0 */
+	str	r7, [r11, #0x310] /* DRAM_DQM1 */
+	str	r8, [r11, #0x314] /* DRAM_DQM2 */
+	str	r9, [r11, #0x318] /* DRAM_DQM3 */
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x5c4] /* GPR_B0DS */
+	str	r7, [r11, #0x5cc] /* GPR_B1DS */
+	str	r8, [r11, #0x5d4] /* GPR_B2DS */
+	str	r9, [r11, #0x5d8] /* GPR_B3DS */
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x300] /* DRAM_CAS */
+	str	r7, [r11, #0x31c] /* DRAM_RAS */
+	str	r8, [r11, #0x338] /* DRAM_SDCLK_0 */
+	str	r9, [r11, #0x5ac] /* GPR_ADDS*/
+
+	ldmea	r10!, {r6-r9}
+	str	r6, [r11, #0x5b0] /* DDRMODE_CTL */
+	str	r7, [r11, #0x5c0] /* DDRMODE */
+	str	r8, [r11, #0x33c] /* DRAM_SODT0*/
+	str	r9, [r11, #0x340] /* DRAM_SODT1*/
+
+	ldmea	r10!, {r7-r9}
+	str	r7, [r11, #0x330] /* DRAM_SDCKE0 */
+	str	r8, [r11, #0x334] /* DRAM_SDCKE1 */
+	str	r9, [r11, #0x320] /* DRAM_RESET */
+
+	.endm
+
+	.macro	imx6sl_ddr_io_set_lpm
+
+	mov	r9, #0
+	str	r9, [r11, #0x30c] /* DRAM_DQM0 */
+	str	r9, [r11, #0x310] /* DRAM_DQM1 */
+	str	r9, [r11, #0x314] /* DRAM_DQM2 */
+	str	r9, [r11, #0x318] /* DRAM_DQM3 */
+
+	str	r9, [r11, #0x5c4] /* GPR_B0DS */
+	str	r9, [r11, #0x5cc] /* GPR_B1DS */
+	str	r9, [r11, #0x5d4] /* GPR_B2DS */
+	str	r9, [r11, #0x5d8] /* GPR_B3DS */
+
+	str	r9, [r11, #0x300] /* DRAM_CAS */
+	str	r9, [r11, #0x31c] /* DRAM_RAS */
+	str	r9, [r11, #0x338] /* DRAM_SDCLK_0 */
+	str	r9, [r11, #0x5ac] /* GPR_ADDS*/
+
+	str	r9, [r11, #0x5b0] /* DDRMODE_CTL */
+	str	r9, [r11, #0x5c0] /* DDRMODE */
+	str	r9, [r11, #0x33c] /* DRAM_SODT0*/
+	str	r9, [r11, #0x340] /* DRAM_SODT1*/
+
+	mov	r9, #0x80000
+	str	r9, [r11, #0x320] /* DRAM_RESET */
+	mov	r9, #0x1000
+	str	r9, [r11, #0x330] /* DRAM_SDCKE0 */
+	str	r9, [r11, #0x334] /* DRAM_SDCKE1 */
+
+	.endm
+
 	.macro  sync_l2_cache
 
 	/* sync L2 cache to drain L2's buffers to DRAM. */
@@ -453,8 +551,13 @@ ENTRY(imx6_suspend)
 	b	ddr_io_save_dsm_done
 dl_io_dsm_save:
 	cmp     r1, #MXC_CPU_IMX6DL
-	bne	ddr_io_save_dsm_done
+	bne	sl_io_save
 	imx6dl_ddr_io_save
+	b	ddr_io_save_dsm_done
+sl_io_save:
+	cmp     r1, #MXC_CPU_IMX6SL
+	bne	ddr_io_save_dsm_done
+	imx6sl_ddr_io_save
 ddr_io_save_dsm_done:
 
 	/* need to sync L2 cache before DSM. */
@@ -487,8 +590,13 @@ poll_dvfs_set_1:
 	b	ddr_io_set_lpm_dsm_done
 dl_io_dsm_set_lpm:
 	cmp     r1, #MXC_CPU_IMX6DL
-	bne	ddr_io_set_lpm_dsm_done
+	bne	sl_io_dsm_set_lpm
 	imx6dl_ddr_io_set_lpm
+	b	ddr_io_set_lpm_dsm_done
+sl_io_dsm_set_lpm:
+	cmp     r1, #MXC_CPU_IMX6SL
+	bne	ddr_io_set_lpm_dsm_done
+	imx6sl_ddr_io_set_lpm
 ddr_io_set_lpm_dsm_done:
 
 	/*
@@ -575,8 +683,34 @@ rbc_loop:
 	b	ddr_io_restore_done
 dl_io_restore:
 	cmp     r1, #MXC_CPU_IMX6DL
-	bne     ddr_io_restore_done
+	bne     sl_io_restore
 	imx6dl_ddr_io_restore
+	b	ddr_io_restore_done
+sl_io_restore:
+	cmp     r1, #MXC_CPU_IMX6SL
+	bne	ddr_io_restore_done
+	imx6sl_ddr_io_restore
+	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
+	/* reset read FIFO, RST_RD_FIFO */
+	ldr	r7, =MX6Q_MMDC_MPDGCTRL0
+	ldr	r6, [r11, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r11, r7]
+fifo_reset1_wait:
+	ldr	r6, [r11, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	fifo_reset1_wait
+
+	/* reset FIFO a second time */
+	ldr	r6, [r11, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r11, r7]
+fifo_reset2_wait:
+	ldr	r6, [r11, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	fifo_reset2_wait
 ddr_io_restore_done:
 
 	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
@@ -628,8 +762,34 @@ resume:
 	b	ddr_io_restore_dsm_done
 dl_io_dsm_restore:
 	cmp     r1, #MXC_CPU_IMX6DL
-	bne	ddr_io_restore_dsm_done
+	bne	sl_io_dsm_restore
 	imx6dl_ddr_io_restore
+	b	ddr_io_restore_dsm_done
+sl_io_dsm_restore:
+	cmp     r1, #MXC_CPU_IMX6SL
+	bne	ddr_io_restore_dsm_done
+	imx6sl_ddr_io_restore
+	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
+	/* reset read FIFO, RST_RD_FIFO */
+	ldr	r7, =MX6Q_MMDC_MPDGCTRL0
+	ldr	r6, [r11, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r11, r7]
+dsm_fifo_reset1_wait:
+	ldr	r6, [r11, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	dsm_fifo_reset1_wait
+
+	/* reset FIFO a second time */
+	ldr	r6, [r11, r7]
+	orr     r6, r6, #(1 << 31)
+	str	r6, [r11, r7]
+dsm_fifo_reset2_wait:
+	ldr	r6, [r11, r7]
+	and	r6, r6, #(1 << 31)
+	cmp	r6, #0
+	bne	dsm_fifo_reset2_wait
 ddr_io_restore_dsm_done:
 
 	ldr	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
-- 
1.7.9.5
