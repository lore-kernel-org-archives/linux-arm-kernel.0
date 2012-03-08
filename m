From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 07 Mar 2012 19:38:39 -0700
Subject: [PATCH 09/12] ARM: OMAP2xxx: hwmod data: share common interface data
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Message-ID: <20120308023838.8205.31672.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several struct omap_hwmod_ocp_if records can be shared between OMAP2420
and OMAP2430.  Move these shared records out of the chip-specific files
into mach-omap2/omap_hwmod_2xxx_interconnect_data.c.  This should save some
memory and source lines, at the cost of readability.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  281 +-------------------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  256 +-----------------
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  266 ++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   39 ++-
 4 files changed, 324 insertions(+), 518 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 75c57d3..b01b66a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -212,85 +212,6 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
  * interfaces
  */
 
-/* L3 -> L4_CORE interface */
-static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
-	.master	= &omap2xxx_l3_main_hwmod,
-	.slave	= &omap2xxx_l4_core_hwmod,
-	.user	= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* MPU -> L3 interface */
-static struct omap_hwmod_ocp_if omap2420_mpu__l3_main = {
-	.master = &omap2xxx_mpu_hwmod,
-	.slave	= &omap2xxx_l3_main_hwmod,
-	.user	= OCP_USER_MPU,
-};
-
-/* DSS -> l3 */
-static struct omap_hwmod_ocp_if omap2420_dss__l3 = {
-	.master		= &omap2xxx_dss_core_hwmod,
-	.slave		= &omap2xxx_l3_main_hwmod,
-	.fw = {
-		.omap2 = {
-			.l3_perm_bit  = OMAP2_L3_CORE_FW_CONNID_DSS,
-			.flags	= OMAP_FIREWALL_L3,
-		}
-	},
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 core -> mcspi1 interface */
-static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi1 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_mcspi1_hwmod,
-	.clk		= "mcspi1_ick",
-	.addr		= omap2_mcspi1_addr_space,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 core -> mcspi2 interface */
-static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi2 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_mcspi2_hwmod,
-	.clk		= "mcspi2_ick",
-	.addr		= omap2_mcspi2_addr_space,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* L4_CORE -> L4_WKUP interface */
-static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
-	.master	= &omap2xxx_l4_core_hwmod,
-	.slave	= &omap2xxx_l4_wkup_hwmod,
-	.user	= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* L4 CORE -> UART1 interface */
-static struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_uart1_hwmod,
-	.clk		= "uart1_ick",
-	.addr		= omap2xxx_uart1_addr_space,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* L4 CORE -> UART2 interface */
-static struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_uart2_hwmod,
-	.clk		= "uart2_ick",
-	.addr		= omap2xxx_uart2_addr_space,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* L4 PER -> UART3 interface */
-static struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_uart3_hwmod,
-	.clk		= "uart3_ick",
-	.addr		= omap2xxx_uart3_addr_space,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* L4 CORE -> I2C1 interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__i2c1 = {
 	.master		= &omap2xxx_l4_core_hwmod,
@@ -335,105 +256,6 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup__timer1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_core -> timer2 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer2 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer2_hwmod,
-	.clk		= "gpt2_ick",
-	.addr		= omap2xxx_timer2_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer3 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer3 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer3_hwmod,
-	.clk		= "gpt3_ick",
-	.addr		= omap2xxx_timer3_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer4 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer4 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer4_hwmod,
-	.clk		= "gpt4_ick",
-	.addr		= omap2xxx_timer4_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer5 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer5 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer5_hwmod,
-	.clk		= "gpt5_ick",
-	.addr		= omap2xxx_timer5_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer6 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer6 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer6_hwmod,
-	.clk		= "gpt6_ick",
-	.addr		= omap2xxx_timer6_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer7 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer7 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer7_hwmod,
-	.clk		= "gpt7_ick",
-	.addr		= omap2xxx_timer7_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer8 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer8 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer8_hwmod,
-	.clk		= "gpt8_ick",
-	.addr		= omap2xxx_timer8_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer9 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer9 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer9_hwmod,
-	.clk		= "gpt9_ick",
-	.addr		= omap2xxx_timer9_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer10 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer10 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer10_hwmod,
-	.clk		= "gpt10_ick",
-	.addr		= omap2_timer10_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer11 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer11 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer11_hwmod,
-	.clk		= "gpt11_ick",
-	.addr		= omap2_timer11_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer12 */
-static struct omap_hwmod_ocp_if omap2420_l4_core__timer12 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer12_hwmod,
-	.clk		= "gpt12_ick",
-	.addr		= omap2xxx_timer12_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_wkup -> wd_timer2 */
 static struct omap_hwmod_addr_space omap2420_wd_timer2_addrs[] = {
 	{
@@ -452,67 +274,6 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup__wd_timer2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_core -> dss */
-static struct omap_hwmod_ocp_if omap2420_l4_core__dss = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_dss_core_hwmod,
-	.clk		= "dss_ick",
-	.addr		= omap2_dss_addrs,
-	.fw = {
-		.omap2 = {
-			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_CORE_REGION,
-			.flags	= OMAP_FIREWALL_L4,
-		}
-	},
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> dss_dispc */
-static struct omap_hwmod_ocp_if omap2420_l4_core__dss_dispc = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_dss_dispc_hwmod,
-	.clk		= "dss_ick",
-	.addr		= omap2_dss_dispc_addrs,
-	.fw = {
-		.omap2 = {
-			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_DISPC_REGION,
-			.flags	= OMAP_FIREWALL_L4,
-		}
-	},
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> dss_rfbi */
-static struct omap_hwmod_ocp_if omap2420_l4_core__dss_rfbi = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_dss_rfbi_hwmod,
-	.clk		= "dss_ick",
-	.addr		= omap2_dss_rfbi_addrs,
-	.fw = {
-		.omap2 = {
-			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_CORE_REGION,
-			.flags	= OMAP_FIREWALL_L4,
-		}
-	},
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> dss_venc */
-static struct omap_hwmod_ocp_if omap2420_l4_core__dss_venc = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_dss_venc_hwmod,
-	.clk		= "dss_ick",
-	.addr		= omap2_dss_venc_addrs,
-	.fw = {
-		.omap2 = {
-			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_VENC_REGION,
-			.flags	= OMAP_FIREWALL_L4,
-		}
-	},
-	.flags		= OCPIF_SWSUP_IDLE,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_wkup -> gpio1 */
 static struct omap_hwmod_addr_space omap2420_gpio1_addr_space[] = {
 	{
@@ -629,12 +390,12 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 = {
 };
 
 static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
-	&omap2420_l3_main__l4_core,
-	&omap2420_mpu__l3_main,
-	&omap2420_dss__l3,
-	&omap2420_l4_core__mcspi1,
-	&omap2420_l4_core__mcspi2,
-	&omap2420_l4_core__l4_wkup,
+	&omap2xxx_l3_main__l4_core,
+	&omap2xxx_mpu__l3_main,
+	&omap2xxx_dss__l3,
+	&omap2xxx_l4_core__mcspi1,
+	&omap2xxx_l4_core__mcspi2,
+	&omap2xxx_l4_core__l4_wkup,
 	&omap2_l4_core__uart1,
 	&omap2_l4_core__uart2,
 	&omap2_l4_core__uart3,
@@ -642,22 +403,22 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2420_l4_core__i2c2,
 	&omap2420_l3__iva,
 	&omap2420_l4_wkup__timer1,
-	&omap2420_l4_core__timer2,
-	&omap2420_l4_core__timer3,
-	&omap2420_l4_core__timer4,
-	&omap2420_l4_core__timer5,
-	&omap2420_l4_core__timer6,
-	&omap2420_l4_core__timer7,
-	&omap2420_l4_core__timer8,
-	&omap2420_l4_core__timer9,
-	&omap2420_l4_core__timer10,
-	&omap2420_l4_core__timer11,
-	&omap2420_l4_core__timer12,
+	&omap2xxx_l4_core__timer2,
+	&omap2xxx_l4_core__timer3,
+	&omap2xxx_l4_core__timer4,
+	&omap2xxx_l4_core__timer5,
+	&omap2xxx_l4_core__timer6,
+	&omap2xxx_l4_core__timer7,
+	&omap2xxx_l4_core__timer8,
+	&omap2xxx_l4_core__timer9,
+	&omap2xxx_l4_core__timer10,
+	&omap2xxx_l4_core__timer11,
+	&omap2xxx_l4_core__timer12,
 	&omap2420_l4_wkup__wd_timer2,
-	&omap2420_l4_core__dss,
-	&omap2420_l4_core__dss_dispc,
-	&omap2420_l4_core__dss_rfbi,
-	&omap2420_l4_core__dss_venc,
+	&omap2xxx_l4_core__dss,
+	&omap2xxx_l4_core__dss_dispc,
+	&omap2xxx_l4_core__dss_rfbi,
+	&omap2xxx_l4_core__dss_venc,
 	&omap2420_l4_wkup__gpio1,
 	&omap2420_l4_wkup__gpio2,
 	&omap2420_l4_wkup__gpio3,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 8b04938..23ca551 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -524,32 +524,6 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
  */
 
 /* L3 -> L4_CORE interface */
-static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
-	.master	= &omap2xxx_l3_main_hwmod,
-	.slave	= &omap2xxx_l4_core_hwmod,
-	.user	= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* MPU -> L3 interface */
-static struct omap_hwmod_ocp_if omap2430_mpu__l3_main = {
-	.master = &omap2xxx_mpu_hwmod,
-	.slave	= &omap2xxx_l3_main_hwmod,
-	.user	= OCP_USER_MPU,
-};
-
-/* DSS -> l3 */
-static struct omap_hwmod_ocp_if omap2430_dss__l3 = {
-	.master		= &omap2xxx_dss_core_hwmod,
-	.slave		= &omap2xxx_l3_main_hwmod,
-	.fw = {
-		.omap2 = {
-			.l3_perm_bit  = OMAP2_L3_CORE_FW_CONNID_DSS,
-			.flags	= OMAP_FIREWALL_L3,
-		}
-	},
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_core -> usbhsotg  interface */
 static struct omap_hwmod_ocp_if omap2430_usbhsotg__l3 = {
 	.master		= &omap2430_usbhsotg_hwmod,
@@ -576,40 +550,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__i2c2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* L4_CORE -> L4_WKUP interface */
-static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
-	.master	= &omap2xxx_l4_core_hwmod,
-	.slave	= &omap2xxx_l4_wkup_hwmod,
-	.user	= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* L4 CORE -> UART1 interface */
-static struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_uart1_hwmod,
-	.clk		= "uart1_ick",
-	.addr		= omap2xxx_uart1_addr_space,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* L4 CORE -> UART2 interface */
-static struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_uart2_hwmod,
-	.clk		= "uart2_ick",
-	.addr		= omap2xxx_uart2_addr_space,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* L4 PER -> UART3 interface */
-static struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_uart3_hwmod,
-	.clk		= "uart3_ick",
-	.addr		= omap2xxx_uart3_addr_space,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 static struct omap_hwmod_addr_space omap2430_usbhsotg_addrs[] = {
 	{
 		.pa_start	= OMAP243X_HS_BASE,
@@ -646,24 +586,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4 core -> mcspi1 interface */
-static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi1 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_mcspi1_hwmod,
-	.clk		= "mcspi1_ick",
-	.addr		= omap2_mcspi1_addr_space,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 core -> mcspi2 interface */
-static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi2 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_mcspi2_hwmod,
-	.clk		= "mcspi2_ick",
-	.addr		= omap2_mcspi2_addr_space,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4 core -> mcspi3 interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi3 = {
 	.master		= &omap2xxx_l4_core_hwmod,
@@ -699,105 +621,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_wkup__timer1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_core -> timer2 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer2 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer2_hwmod,
-	.clk		= "gpt2_ick",
-	.addr		= omap2xxx_timer2_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer3 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer3 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer3_hwmod,
-	.clk		= "gpt3_ick",
-	.addr		= omap2xxx_timer3_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer4 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer4 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer4_hwmod,
-	.clk		= "gpt4_ick",
-	.addr		= omap2xxx_timer4_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer5 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer5 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer5_hwmod,
-	.clk		= "gpt5_ick",
-	.addr		= omap2xxx_timer5_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer6 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer6 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer6_hwmod,
-	.clk		= "gpt6_ick",
-	.addr		= omap2xxx_timer6_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer7 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer7 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer7_hwmod,
-	.clk		= "gpt7_ick",
-	.addr		= omap2xxx_timer7_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer8 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer8 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer8_hwmod,
-	.clk		= "gpt8_ick",
-	.addr		= omap2xxx_timer8_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer9 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer9 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer9_hwmod,
-	.clk		= "gpt9_ick",
-	.addr		= omap2xxx_timer9_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer10 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer10 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer10_hwmod,
-	.clk		= "gpt10_ick",
-	.addr		= omap2_timer10_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer11 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer11 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer11_hwmod,
-	.clk		= "gpt11_ick",
-	.addr		= omap2_timer11_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> timer12 */
-static struct omap_hwmod_ocp_if omap2430_l4_core__timer12 = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_timer12_hwmod,
-	.clk		= "gpt12_ick",
-	.addr		= omap2xxx_timer12_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_wkup -> wd_timer2 */
 static struct omap_hwmod_addr_space omap2430_wd_timer2_addrs[] = {
 	{
@@ -816,43 +639,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_wkup__wd_timer2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_core -> dss */
-static struct omap_hwmod_ocp_if omap2430_l4_core__dss = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_dss_core_hwmod,
-	.clk		= "dss_ick",
-	.addr		= omap2_dss_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> dss_dispc */
-static struct omap_hwmod_ocp_if omap2430_l4_core__dss_dispc = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_dss_dispc_hwmod,
-	.clk		= "dss_ick",
-	.addr		= omap2_dss_dispc_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> dss_rfbi */
-static struct omap_hwmod_ocp_if omap2430_l4_core__dss_rfbi = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_dss_rfbi_hwmod,
-	.clk		= "dss_ick",
-	.addr		= omap2_dss_rfbi_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> dss_venc */
-static struct omap_hwmod_ocp_if omap2430_l4_core__dss_venc = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2xxx_dss_venc_hwmod,
-	.clk		= "dss_ick",
-	.addr		= omap2_dss_venc_addrs,
-	.flags		= OCPIF_SWSUP_IDLE,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_wkup -> gpio1 */
 static struct omap_hwmod_addr_space omap2430_gpio1_addr_space[] = {
 	{
@@ -1044,40 +830,40 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp5 = {
 };
 
 static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp_ifs[] __initdata = {
-	&omap2430_l3_main__l4_core,
-	&omap2430_mpu__l3_main,
-	&omap2430_dss__l3,
+	&omap2xxx_l3_main__l4_core,
+	&omap2xxx_mpu__l3_main,
+	&omap2xxx_dss__l3,
 	&omap2430_usbhsotg__l3,
 	&omap2430_l4_core__i2c1,
 	&omap2430_l4_core__i2c2,
-	&omap2430_l4_core__l4_wkup,
+	&omap2xxx_l4_core__l4_wkup,
 	&omap2_l4_core__uart1,
 	&omap2_l4_core__uart2,
 	&omap2_l4_core__uart3,
 	&omap2430_l4_core__usbhsotg,
 	&omap2430_l4_core__mmc1,
 	&omap2430_l4_core__mmc2,
-	&omap2430_l4_core__mcspi1,
-	&omap2430_l4_core__mcspi2,
+	&omap2xxx_l4_core__mcspi1,
+	&omap2xxx_l4_core__mcspi2,
 	&omap2430_l4_core__mcspi3,
 	&omap2430_l3__iva,
 	&omap2430_l4_wkup__timer1,
-	&omap2430_l4_core__timer2,
-	&omap2430_l4_core__timer3,
-	&omap2430_l4_core__timer4,
-	&omap2430_l4_core__timer5,
-	&omap2430_l4_core__timer6,
-	&omap2430_l4_core__timer7,
-	&omap2430_l4_core__timer8,
-	&omap2430_l4_core__timer9,
-	&omap2430_l4_core__timer10,
-	&omap2430_l4_core__timer11,
-	&omap2430_l4_core__timer12,
+	&omap2xxx_l4_core__timer2,
+	&omap2xxx_l4_core__timer3,
+	&omap2xxx_l4_core__timer4,
+	&omap2xxx_l4_core__timer5,
+	&omap2xxx_l4_core__timer6,
+	&omap2xxx_l4_core__timer7,
+	&omap2xxx_l4_core__timer8,
+	&omap2xxx_l4_core__timer9,
+	&omap2xxx_l4_core__timer10,
+	&omap2xxx_l4_core__timer11,
+	&omap2xxx_l4_core__timer12,
 	&omap2430_l4_wkup__wd_timer2,
-	&omap2430_l4_core__dss,
-	&omap2430_l4_core__dss_dispc,
-	&omap2430_l4_core__dss_rfbi,
-	&omap2430_l4_core__dss_venc,
+	&omap2xxx_l4_core__dss,
+	&omap2xxx_l4_core__dss_dispc,
+	&omap2xxx_l4_core__dss_rfbi,
+	&omap2xxx_l4_core__dss_venc,
 	&omap2430_l4_wkup__gpio1,
 	&omap2430_l4_wkup__gpio2,
 	&omap2430_l4_wkup__gpio3,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 4f3547c..5178e40 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -15,10 +15,12 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
+#include <plat/l3_2xxx.h>
+#include <plat/l4_2xxx.h>
 
 #include "omap_hwmod_common_data.h"
 
-struct omap_hwmod_addr_space omap2xxx_uart1_addr_space[] = {
+static struct omap_hwmod_addr_space omap2xxx_uart1_addr_space[] = {
 	{
 		.pa_start	= OMAP2_UART1_BASE,
 		.pa_end		= OMAP2_UART1_BASE + SZ_8K - 1,
@@ -27,7 +29,7 @@ struct omap_hwmod_addr_space omap2xxx_uart1_addr_space[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2xxx_uart2_addr_space[] = {
+static struct omap_hwmod_addr_space omap2xxx_uart2_addr_space[] = {
 	{
 		.pa_start	= OMAP2_UART2_BASE,
 		.pa_end		= OMAP2_UART2_BASE + SZ_1K - 1,
@@ -36,7 +38,7 @@ struct omap_hwmod_addr_space omap2xxx_uart2_addr_space[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2xxx_uart3_addr_space[] = {
+static struct omap_hwmod_addr_space omap2xxx_uart3_addr_space[] = {
 	{
 		.pa_start	= OMAP2_UART3_BASE,
 		.pa_end		= OMAP2_UART3_BASE + SZ_1K - 1,
@@ -45,7 +47,7 @@ struct omap_hwmod_addr_space omap2xxx_uart3_addr_space[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2xxx_timer2_addrs[] = {
+static struct omap_hwmod_addr_space omap2xxx_timer2_addrs[] = {
 	{
 		.pa_start	= 0x4802a000,
 		.pa_end		= 0x4802a000 + SZ_1K - 1,
@@ -54,7 +56,7 @@ struct omap_hwmod_addr_space omap2xxx_timer2_addrs[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2xxx_timer3_addrs[] = {
+static struct omap_hwmod_addr_space omap2xxx_timer3_addrs[] = {
 	{
 		.pa_start	= 0x48078000,
 		.pa_end		= 0x48078000 + SZ_1K - 1,
@@ -63,7 +65,7 @@ struct omap_hwmod_addr_space omap2xxx_timer3_addrs[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2xxx_timer4_addrs[] = {
+static struct omap_hwmod_addr_space omap2xxx_timer4_addrs[] = {
 	{
 		.pa_start	= 0x4807a000,
 		.pa_end		= 0x4807a000 + SZ_1K - 1,
@@ -72,7 +74,7 @@ struct omap_hwmod_addr_space omap2xxx_timer4_addrs[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2xxx_timer5_addrs[] = {
+static struct omap_hwmod_addr_space omap2xxx_timer5_addrs[] = {
 	{
 		.pa_start	= 0x4807c000,
 		.pa_end		= 0x4807c000 + SZ_1K - 1,
@@ -81,7 +83,7 @@ struct omap_hwmod_addr_space omap2xxx_timer5_addrs[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2xxx_timer6_addrs[] = {
+static struct omap_hwmod_addr_space omap2xxx_timer6_addrs[] = {
 	{
 		.pa_start	= 0x4807e000,
 		.pa_end		= 0x4807e000 + SZ_1K - 1,
@@ -90,7 +92,7 @@ struct omap_hwmod_addr_space omap2xxx_timer6_addrs[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2xxx_timer7_addrs[] = {
+static struct omap_hwmod_addr_space omap2xxx_timer7_addrs[] = {
 	{
 		.pa_start	= 0x48080000,
 		.pa_end		= 0x48080000 + SZ_1K - 1,
@@ -99,7 +101,7 @@ struct omap_hwmod_addr_space omap2xxx_timer7_addrs[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2xxx_timer8_addrs[] = {
+static struct omap_hwmod_addr_space omap2xxx_timer8_addrs[] = {
 	{
 		.pa_start	= 0x48082000,
 		.pa_end		= 0x48082000 + SZ_1K - 1,
@@ -108,7 +110,7 @@ struct omap_hwmod_addr_space omap2xxx_timer8_addrs[] = {
 	{ }
 };
 
-struct omap_hwmod_addr_space omap2xxx_timer9_addrs[] = {
+static struct omap_hwmod_addr_space omap2xxx_timer9_addrs[] = {
 	{
 		.pa_start	= 0x48084000,
 		.pa_end		= 0x48084000 + SZ_1K - 1,
@@ -127,4 +129,246 @@ struct omap_hwmod_addr_space omap2xxx_mcbsp2_addrs[] = {
 	{ }
 };
 
+/*
+ * Common interconnect data
+ */
+
+/* L3 -> L4_CORE interface */
+struct omap_hwmod_ocp_if omap2xxx_l3_main__l4_core = {
+	.master	= &omap2xxx_l3_main_hwmod,
+	.slave	= &omap2xxx_l4_core_hwmod,
+	.user	= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* MPU -> L3 interface */
+struct omap_hwmod_ocp_if omap2xxx_mpu__l3_main = {
+	.master = &omap2xxx_mpu_hwmod,
+	.slave	= &omap2xxx_l3_main_hwmod,
+	.user	= OCP_USER_MPU,
+};
+
+/* DSS -> l3 */
+struct omap_hwmod_ocp_if omap2xxx_dss__l3 = {
+	.master		= &omap2xxx_dss_core_hwmod,
+	.slave		= &omap2xxx_l3_main_hwmod,
+	.fw = {
+		.omap2 = {
+			.l3_perm_bit  = OMAP2_L3_CORE_FW_CONNID_DSS,
+			.flags	= OMAP_FIREWALL_L3,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4_CORE -> L4_WKUP interface */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__l4_wkup = {
+	.master	= &omap2xxx_l4_core_hwmod,
+	.slave	= &omap2xxx_l4_wkup_hwmod,
+	.user	= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> UART1 interface */
+struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_uart1_hwmod,
+	.clk		= "uart1_ick",
+	.addr		= omap2xxx_uart1_addr_space,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> UART2 interface */
+struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_uart2_hwmod,
+	.clk		= "uart2_ick",
+	.addr		= omap2xxx_uart2_addr_space,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> UART3 interface */
+struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_uart3_hwmod,
+	.clk		= "uart3_ick",
+	.addr		= omap2xxx_uart3_addr_space,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4 core -> mcspi1 interface */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi1 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_mcspi1_hwmod,
+	.clk		= "mcspi1_ick",
+	.addr		= omap2_mcspi1_addr_space,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4 core -> mcspi2 interface */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi2 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_mcspi2_hwmod,
+	.clk		= "mcspi2_ick",
+	.addr		= omap2_mcspi2_addr_space,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer2 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer2 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer2_hwmod,
+	.clk		= "gpt2_ick",
+	.addr		= omap2xxx_timer2_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer3 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer3 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer3_hwmod,
+	.clk		= "gpt3_ick",
+	.addr		= omap2xxx_timer3_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer4 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer4 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer4_hwmod,
+	.clk		= "gpt4_ick",
+	.addr		= omap2xxx_timer4_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer5 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer5 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer5_hwmod,
+	.clk		= "gpt5_ick",
+	.addr		= omap2xxx_timer5_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer6 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer6 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer6_hwmod,
+	.clk		= "gpt6_ick",
+	.addr		= omap2xxx_timer6_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer7 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer7 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer7_hwmod,
+	.clk		= "gpt7_ick",
+	.addr		= omap2xxx_timer7_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer8 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer8 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer8_hwmod,
+	.clk		= "gpt8_ick",
+	.addr		= omap2xxx_timer8_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer9 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer9 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer9_hwmod,
+	.clk		= "gpt9_ick",
+	.addr		= omap2xxx_timer9_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer10 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer10 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer10_hwmod,
+	.clk		= "gpt10_ick",
+	.addr		= omap2_timer10_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer11 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer11 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer11_hwmod,
+	.clk		= "gpt11_ick",
+	.addr		= omap2_timer11_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> timer12 */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__timer12 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_timer12_hwmod,
+	.clk		= "gpt12_ick",
+	.addr		= omap2xxx_timer12_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> dss */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__dss = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_core_hwmod,
+	.clk		= "dss_ick",
+	.addr		= omap2_dss_addrs,
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_CORE_REGION,
+			.flags	= OMAP_FIREWALL_L4,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> dss_dispc */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_dispc = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_dispc_hwmod,
+	.clk		= "dss_ick",
+	.addr		= omap2_dss_dispc_addrs,
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_DISPC_REGION,
+			.flags	= OMAP_FIREWALL_L4,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> dss_rfbi */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_rfbi = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_rfbi_hwmod,
+	.clk		= "dss_ick",
+	.addr		= omap2_dss_rfbi_addrs,
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_CORE_REGION,
+			.flags	= OMAP_FIREWALL_L4,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_core -> dss_venc */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_venc = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_dss_venc_hwmod,
+	.clk		= "dss_ick",
+	.addr		= omap2_dss_venc_addrs,
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_VENC_REGION,
+			.flags	= OMAP_FIREWALL_L4,
+		}
+	},
+	.flags		= OCPIF_SWSUP_IDLE,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 65757f3..7aa9156 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -19,18 +19,6 @@
 #include "display.h"
 
 /* Common address space across OMAP2xxx */
-extern struct omap_hwmod_addr_space omap2xxx_uart1_addr_space[];
-extern struct omap_hwmod_addr_space omap2xxx_uart2_addr_space[];
-extern struct omap_hwmod_addr_space omap2xxx_uart3_addr_space[];
-extern struct omap_hwmod_addr_space omap2xxx_timer2_addrs[];
-extern struct omap_hwmod_addr_space omap2xxx_timer3_addrs[];
-extern struct omap_hwmod_addr_space omap2xxx_timer4_addrs[];
-extern struct omap_hwmod_addr_space omap2xxx_timer5_addrs[];
-extern struct omap_hwmod_addr_space omap2xxx_timer6_addrs[];
-extern struct omap_hwmod_addr_space omap2xxx_timer7_addrs[];
-extern struct omap_hwmod_addr_space omap2xxx_timer8_addrs[];
-extern struct omap_hwmod_addr_space omap2xxx_timer9_addrs[];
-extern struct omap_hwmod_addr_space omap2xxx_timer12_addrs[];
 extern struct omap_hwmod_addr_space omap2xxx_mcbsp2_addrs[];
 
 /* Common address space across OMAP2xxx/3xxx */
@@ -87,6 +75,32 @@ extern struct omap_hwmod omap2xxx_gpio4_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi1_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi2_hwmod;
 
+/* Common interface data across OMAP2xxx */
+extern struct omap_hwmod_ocp_if omap2xxx_l3_main__l4_core;
+extern struct omap_hwmod_ocp_if omap2xxx_mpu__l3_main;
+extern struct omap_hwmod_ocp_if omap2xxx_dss__l3;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__l4_wkup;
+extern struct omap_hwmod_ocp_if omap2_l4_core__uart1;
+extern struct omap_hwmod_ocp_if omap2_l4_core__uart2;
+extern struct omap_hwmod_ocp_if omap2_l4_core__uart3;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi1;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi2;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer2;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer3;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer4;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer5;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer6;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer7;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer8;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer9;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer10;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer11;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer12;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_dispc;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_rfbi;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_venc;
+
 /* Common IP block data */
 extern struct omap_hwmod_dma_info omap2_uart1_sdma_reqs[];
 extern struct omap_hwmod_dma_info omap2_uart2_sdma_reqs[];
@@ -126,6 +140,7 @@ extern struct omap_hwmod_irq_info omap2_gpio4_irqs[];
 extern struct omap_hwmod_irq_info omap2_dma_system_irqs[];
 extern struct omap_hwmod_irq_info omap2_mcspi1_mpu_irqs[];
 extern struct omap_hwmod_irq_info omap2_mcspi2_mpu_irqs[];
+extern struct omap_hwmod_addr_space omap2xxx_timer12_addrs[];
 
 /* OMAP hwmod classes - forward declarations */
 extern struct omap_hwmod_class l3_hwmod_class;
