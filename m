From: joelf@ti.com (Joel Fernandes)
Date: Mon, 25 Nov 2013 15:44:33 -0600
Subject: [PATCH 4/7] ARM: OMAP4: hwmod: Add hwmod data for AES IP
In-Reply-To: <1385415876-12387-1-git-send-email-joelf@ti.com>
References: <1385415876-12387-1-git-send-email-joelf@ti.com>
Message-ID: <1385415876-12387-5-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Crypto modules AES0/1 belong to:
    PD_L4_PER power domain
    CD_L4_SEC clock domain
    On the L3, the AES modules are mapped to
    L3_CLK2: Peripherals and multimedia sub clock domain

We add hwmod data for the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 54 ++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 1e5b12c..664b2c6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4791,6 +4791,59 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__emif2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/*
+    Crypto modules AES0/1 belong to:
+	PD_L4_PER power domain
+	CD_L4_SEC clock domain
+	On the L3, the AES modules are mapped to
+	L3_CLK2: Peripherals and multimedia sub clock domain
+*/
+
+static struct omap_hwmod_class_sysconfig omap4_aes1_sysc = {
+	.rev_offs	= 0x80,
+	.sysc_offs	= 0x84,
+	.syss_offs	= 0x88,
+	.sysc_flags	= SYSS_HAS_RESET_STATUS,
+	.sysc_fields	= &omap_hwmod_sysc_type4,
+};
+
+static struct omap_hwmod_class omap4_aes1_hwmod_class = {
+	.name		= "aes1",
+	.sysc		= &omap4_aes1_sysc,
+};
+
+static struct omap_hwmod omap4_aes1_hwmod = {
+	.name		= "aes",
+	.class		= &omap4_aes1_hwmod_class,
+	.clkdm_name	= "l4_secure_clkdm",
+	.main_clk	= "aes1_fck",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs = OMAP4_CM_L4SEC_AES1_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4SEC_AES1_CONTEXT_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/* l3_main_2 -> aes1 */
+static struct omap_hwmod_addr_space omap4_aes1_addrs[] = {
+	{
+		.pa_start	= 0x4B500000,
+		.pa_end		= 0x4B500000 + SZ_1M - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if omap4_l3_main_2__aes1 = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap4_aes1_hwmod,
+	.clk		= "aes1_fck",
+	.addr		= omap4_aes1_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l3_main_1__dmm,
 	&omap44xx_mpu__dmm,
@@ -4945,6 +4998,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_abe__wd_timer3_dma,
 	&omap44xx_mpu__emif1,
 	&omap44xx_mpu__emif2,
+	&omap4_l3_main_2__aes1,
 	NULL,
 };
 
-- 
1.8.1.2
