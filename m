From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 02 Jul 2010 09:29:43 -0600
Subject: [PATCH 16/20] OMAP2: hwmod data: add IVA1 (2420), IVA2 (2430) hwmods
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Message-ID: <20100702152939.6221.16377.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IVA1 hwmod data for OMAP2420 and IVA2 hwmod data for 2430.  The data
is based on Beno?t Cousson's hwmod data for the OMAP3 IVA blocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   30 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   32 ++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 8c90b27..3cc768e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -30,6 +30,7 @@
  */
 
 static struct omap_hwmod omap2420_mpu_hwmod;
+static struct omap_hwmod omap2420_iva_hwmod;
 static struct omap_hwmod omap2420_l3_main_hwmod;
 static struct omap_hwmod omap2420_l4_core_hwmod;
 
@@ -136,11 +137,40 @@ static struct omap_hwmod omap2420_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
+/*
+ * IVA1 interface data
+ */
+
+/* IVA <- L3 interface */
+static struct omap_hwmod_ocp_if omap2420_l3__iva = {
+	.master		= &omap2420_l3_main_hwmod,
+	.slave		= &omap2420_iva_hwmod,
+	.clk		= "iva1_ifck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2420_iva_masters[] = {
+	&omap2420_l3__iva,
+};
+
+/*
+ * IVA2 (IVA2)
+ */
+
+static struct omap_hwmod omap2420_iva_hwmod = {
+	.name		= "iva",
+	.class		= &iva_hwmod_class,
+	.masters	= omap2420_iva_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2420_iva_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
 	&omap2420_l4_wkup_hwmod,
 	&omap2420_mpu_hwmod,
+	&omap2420_iva_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c0f3311..4526628 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -30,6 +30,7 @@
  */
 
 static struct omap_hwmod omap2430_mpu_hwmod;
+static struct omap_hwmod omap2430_iva_hwmod;
 static struct omap_hwmod omap2430_l3_main_hwmod;
 static struct omap_hwmod omap2430_l4_core_hwmod;
 
@@ -70,8 +71,6 @@ static struct omap_hwmod omap2430_l3_main_hwmod = {
 };
 
 static struct omap_hwmod omap2430_l4_wkup_hwmod;
-static struct omap_hwmod omap2430_mmc1_hwmod;
-static struct omap_hwmod omap2430_mmc2_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
@@ -138,11 +137,40 @@ static struct omap_hwmod omap2430_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/*
+ * IVA2_1 interface data
+ */
+
+/* IVA2 <- L3 interface */
+static struct omap_hwmod_ocp_if omap2430_l3__iva = {
+	.master		= &omap2430_l3_main_hwmod,
+	.slave		= &omap2430_iva_hwmod,
+	.clk		= "dsp_fck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_iva_masters[] = {
+	&omap2430_l3__iva,
+};
+
+/*
+ * IVA2 (IVA2)
+ */
+
+static struct omap_hwmod omap2430_iva_hwmod = {
+	.name		= "iva",
+	.class		= &iva_hwmod_class,
+	.masters	= omap2430_iva_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2430_iva_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
+	&omap2430_iva_hwmod,
 	NULL,
 };
 
