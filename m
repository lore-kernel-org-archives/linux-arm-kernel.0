From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:33 -0700
Subject: [PATCH 09/15] ARM: OMAP4: hwmod data: add some interconnect-related
 IP blocks
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105133.14753.52890.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SL2 interface IP block and interconnect data.  The SL2 is related
to the IVA-HD subsystem.

Add IP block and interconnect data for the C2C ("Chip-to-chip")
interconnect.  This can provide a direct system interconnect link to
other devices stacked on the OMAP package.

Add the ELM IP block and interconnect data.  The ELM can be used
to locate errors in NAND flash connected to the GPMC.


Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |  224 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 
 2 files changed, 221 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3be64f5..8d3a7c1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -50,6 +50,27 @@
  */
 
 /*
+ * 'c2c_target_fw' class
+ * instance(s): c2c_target_fw
+ */
+static struct omap_hwmod_class omap44xx_c2c_target_fw_hwmod_class = {
+	.name	= "c2c_target_fw",
+};
+
+/* c2c_target_fw */
+static struct omap_hwmod omap44xx_c2c_target_fw_hwmod = {
+	.name		= "c2c_target_fw",
+	.class		= &omap44xx_c2c_target_fw_hwmod_class,
+	.clkdm_name	= "d2d_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_D2D_SAD2D_FW_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_D2D_SAD2D_FW_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'dmm' class
  * instance(s): dmm
  */
@@ -248,8 +269,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  * - They still need to be validated with the driver
  *   properly adapted to omap_hwmod / omap_device
  *
- *  c2c
- *  c2c_target_fw
  *  cm_core
  *  cm_core_aon
  *  ctrl_module_core
@@ -259,7 +278,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  debugss
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
- *  elm
  *  mpu_c0
  *  mpu_c1
  *  ocmc_ram
@@ -268,7 +286,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  prcm_mpu
  *  prm
  *  scrm
- *  sl2if
  *  usb_host_fs
  *  usb_host_hs
  *  usb_phy_cm
@@ -331,6 +348,41 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 };
 
 /*
+ * 'c2c' class
+ * chip 2 chip interface used to plug the ape soc (omap) with an external modem
+ * soc
+ */
+
+static struct omap_hwmod_class omap44xx_c2c_hwmod_class = {
+	.name	= "c2c",
+};
+
+/* c2c */
+static struct omap_hwmod_irq_info omap44xx_c2c_irqs[] = {
+	{ .irq = 88 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_c2c_sdma_reqs[] = {
+	{ .dma_req = 68 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
+static struct omap_hwmod omap44xx_c2c_hwmod = {
+	.name		= "c2c",
+	.class		= &omap44xx_c2c_hwmod_class,
+	.clkdm_name	= "d2d_clkdm",
+	.mpu_irqs	= omap44xx_c2c_irqs,
+	.sdma_reqs	= omap44xx_c2c_sdma_reqs,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_D2D_SAD2D_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_D2D_SAD2D_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'counter' class
  * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
  */
@@ -806,6 +858,46 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 };
 
 /*
+ * 'elm' class
+ * bch error location module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_elm_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_elm_hwmod_class = {
+	.name	= "elm",
+	.sysc	= &omap44xx_elm_sysc,
+};
+
+/* elm */
+static struct omap_hwmod_irq_info omap44xx_elm_irqs[] = {
+	{ .irq = 4 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod omap44xx_elm_hwmod = {
+	.name		= "elm",
+	.class		= &omap44xx_elm_hwmod_class,
+	.clkdm_name	= "l4_per_clkdm",
+	.mpu_irqs	= omap44xx_elm_irqs,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L4PER_ELM_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_ELM_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'emif' class
  * external memory interface no1
  */
@@ -2268,6 +2360,29 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 };
 
 /*
+ * 'sl2if' class
+ * shared level 2 memory interface
+ */
+
+static struct omap_hwmod_class omap44xx_sl2if_hwmod_class = {
+	.name	= "sl2if",
+};
+
+/* sl2if */
+static struct omap_hwmod omap44xx_sl2if_hwmod = {
+	.name		= "sl2if",
+	.class		= &omap44xx_sl2if_hwmod_class,
+	.clkdm_name	= "ivahd_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_IVAHD_SL2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_IVAHD_SL2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * 'slimbus' class
  * bidirectional, multi-drop, multi-channel two-line serial interface between
  * the device and external components
@@ -3181,6 +3296,32 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
  * interfaces
  */
 
+static struct omap_hwmod_addr_space omap44xx_c2c_target_fw_addrs[] = {
+	{
+		.pa_start	= 0x4a204000,
+		.pa_end		= 0x4a2040ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* c2c -> c2c_target_fw */
+static struct omap_hwmod_ocp_if omap44xx_c2c__c2c_target_fw = {
+	.master		= &omap44xx_c2c_hwmod,
+	.slave		= &omap44xx_c2c_target_fw_hwmod,
+	.clk		= "div_core_ck",
+	.addr		= omap44xx_c2c_target_fw_addrs,
+	.user		= OCP_USER_MPU,
+};
+
+/* l4_cfg -> c2c_target_fw */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__c2c_target_fw = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_c2c_target_fw_hwmod,
+	.clk		= "l4_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_1 -> dmm */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_1__dmm = {
 	.master		= &omap44xx_l3_main_1_hwmod,
@@ -3207,6 +3348,14 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__dmm = {
 	.user		= OCP_USER_MPU,
 };
 
+/* c2c -> emif_fw */
+static struct omap_hwmod_ocp_if omap44xx_c2c__emif_fw = {
+	.master		= &omap44xx_c2c_hwmod,
+	.slave		= &omap44xx_emif_fw_hwmod,
+	.clk		= "div_core_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* dmm -> emif_fw */
 static struct omap_hwmod_ocp_if omap44xx_dmm__emif_fw = {
 	.master		= &omap44xx_dmm_hwmod,
@@ -3315,6 +3464,14 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
 	.user		= OCP_USER_MPU,
 };
 
+/* c2c_target_fw -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_c2c_target_fw__l3_main_2 = {
+	.master		= &omap44xx_c2c_target_fw_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* dma_system -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
 	.master		= &omap44xx_dma_system_hwmod,
@@ -3547,6 +3704,14 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess_dma = {
 	.user		= OCP_USER_SDMA,
 };
 
+/* l3_main_2 -> c2c */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__c2c = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_c2c_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_counter_32k_addrs[] = {
 	{
 		.pa_start	= 0x4a304000,
@@ -3629,6 +3794,14 @@ static struct omap_hwmod_ocp_if omap44xx_dsp__iva = {
 	.user		= OCP_USER_DSP,
 };
 
+/* dsp -> sl2if */
+static struct omap_hwmod_ocp_if omap44xx_dsp__sl2if = {
+	.master		= &omap44xx_dsp_hwmod,
+	.slave		= &omap44xx_sl2if_hwmod,
+	.clk		= "dpll_iva_m5x2_ck",
+	.user		= OCP_USER_DSP,
+};
+
 /* l4_cfg -> dsp */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dsp = {
 	.master		= &omap44xx_l4_cfg_hwmod,
@@ -3889,6 +4062,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_venc = {
 	.user		= OCP_USER_MPU,
 };
 
+static struct omap_hwmod_addr_space omap44xx_elm_addrs[] = {
+	{
+		.pa_start	= 0x48078000,
+		.pa_end		= 0x48078fff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_per -> elm */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__elm = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_elm_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_elm_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_emif1_addrs[] = {
 	{
 		.pa_start	= 0x4c000000,
@@ -4221,6 +4412,14 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__iss = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* iva -> sl2if */
+static struct omap_hwmod_ocp_if omap44xx_iva__sl2if = {
+	.master		= &omap44xx_iva_hwmod,
+	.slave		= &omap44xx_sl2if_hwmod,
+	.clk		= "dpll_iva_m5x2_ck",
+	.user		= OCP_USER_IVA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_iva_addrs[] = {
 	{
 		.pa_start	= 0x5a000000,
@@ -4641,6 +4840,14 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l3_main_2 -> sl2if */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sl2if = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_sl2if_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_slimbus1_addrs[] = {
 	{
 		.pa_start	= 0x4012c000,
@@ -5230,8 +5437,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3_dma = {
 };
 
 static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
+	&omap44xx_c2c__c2c_target_fw,
+	&omap44xx_l4_cfg__c2c_target_fw,
 	&omap44xx_l3_main_1__dmm,
 	&omap44xx_mpu__dmm,
+	&omap44xx_c2c__emif_fw,
 	&omap44xx_dmm__emif_fw,
 	&omap44xx_l4_cfg__emif_fw,
 	&omap44xx_iva__l3_instr,
@@ -5243,6 +5453,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_mmc1__l3_main_1,
 	&omap44xx_mmc2__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
+	&omap44xx_c2c_target_fw__l3_main_2,
 	&omap44xx_dma_system__l3_main_2,
 	&omap44xx_fdif__l3_main_2,
 	&omap44xx_gpu__l3_main_2,
@@ -5267,11 +5478,13 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_mpu__mpu_private,
 	&omap44xx_l4_abe__aess,
 	&omap44xx_l4_abe__aess_dma,
+	&omap44xx_l3_main_2__c2c,
 	&omap44xx_l4_wkup__counter_32k,
 	&omap44xx_l4_cfg__dma_system,
 	&omap44xx_l4_abe__dmic,
 	&omap44xx_l4_abe__dmic_dma,
 	&omap44xx_dsp__iva,
+	&omap44xx_dsp__sl2if,
 	&omap44xx_l4_cfg__dsp,
 	&omap44xx_l3_main_2__dss,
 	&omap44xx_l4_per__dss,
@@ -5287,6 +5500,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__dss_rfbi,
 	&omap44xx_l3_main_2__dss_venc,
 	&omap44xx_l4_per__dss_venc,
+	&omap44xx_l4_per__elm,
 	&omap44xx_emif_fw__emif1,
 	&omap44xx_emif_fw__emif2,
 	&omap44xx_l4_cfg__fdif,
@@ -5306,6 +5520,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__i2c4,
 	&omap44xx_l3_main_2__ipu,
 	&omap44xx_l3_main_2__iss,
+	&omap44xx_iva__sl2if,
 	&omap44xx_l3_main_2__iva,
 	&omap44xx_l4_wkup__kbd,
 	&omap44xx_l4_cfg__mailbox,
@@ -5329,6 +5544,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__mmc3,
 	&omap44xx_l4_per__mmc4,
 	&omap44xx_l4_per__mmc5,
+	&omap44xx_l3_main_2__sl2if,
 	&omap44xx_l4_abe__slimbus1,
 	&omap44xx_l4_abe__slimbus1_dma,
 	&omap44xx_l4_per__slimbus2,
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8c39f70..965d8ab 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -214,6 +214,7 @@ struct omap_hwmod_addr_space {
 #define OCP_USER_MPU			(1 << 0)
 #define OCP_USER_SDMA			(1 << 1)
 #define OCP_USER_DSP			(1 << 2)
+#define OCP_USER_IVA			(1 << 3)
 
 /* omap_hwmod_ocp_if.flags bits */
 #define OCPIF_SWSUP_IDLE		(1 << 0)
