From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat,  1 Sep 2012 05:55:58 +0200
Subject: [PATCH 6/6 v2] ARM: integrator: convert platform devices to Device
 Tree
In-Reply-To: <1346471760-23993-5-git-send-email-linus.walleij@linaro.org>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-5-git-send-email-linus.walleij@linaro.org>
Message-ID: <1346471760-23993-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the physmap flash and SMSC91x ethernet devices
over to the device tree, moving the static board code down
into the #ifndef CONFIG_OF section.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts       |  5 ++
 arch/arm/boot/dts/integratorcp.dts       | 12 +++++
 arch/arm/mach-integrator/integrator_ap.c | 36 ++++++-------
 arch/arm/mach-integrator/integrator_cp.c | 92 ++++++++++++++++----------------
 4 files changed, 82 insertions(+), 63 deletions(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index de51bcf..044c72b 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -49,6 +49,11 @@
 		valid-mask = <0x003fffff>;
 	};
 
+	flash: flash at 24000000 {
+		compatible = "cfi-flash";
+		reg = <0x24000000 0x02000000>;
+	};
+
 	fpga {
 		compatible = "arm,amba-bus", "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index 3265b25..8584241 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -67,6 +67,18 @@
 		valid-mask = <0x00000fff>;
 	};
 
+	flash: flash at 24000000 {
+		compatible = "cfi-flash";
+		reg = <0x24000000 0x02000000>;
+	};
+
+	ethernet: ethernet at c8000000 {
+		compatible = "smsc,lan91c111";
+		reg = <0xc8000000 0x10>;
+		interrupt-parent = <&pic>;
+		interrupts = <27>;
+	};
+
 	fpga {
 		compatible = "arm,amba-bus", "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 990ce85..aaa6b01 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -256,22 +256,6 @@ static struct physmap_flash_data ap_flash_data = {
 	.set_vpp	= ap_flash_set_vpp,
 };
 
-static struct resource cfi_flash_resource = {
-	.start		= INTEGRATOR_FLASH_BASE,
-	.end		= INTEGRATOR_FLASH_BASE + INTEGRATOR_FLASH_SIZE - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device cfi_flash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &ap_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &cfi_flash_resource,
-};
-
 /*
  * Where is the timer (VA)?
  */
@@ -476,6 +460,8 @@ static struct of_dev_auxdata ap_auxdata_lookup[] __initdata = {
 		"kmi0", NULL),
 	OF_DEV_AUXDATA("arm,primecell", KMI1_BASE,
 		"kmi1", NULL),
+	OF_DEV_AUXDATA("cfi-flash", INTEGRATOR_FLASH_BASE,
+		"physmap-flash", &ap_flash_data),
 	{ /* sentinel */ },
 };
 
@@ -487,8 +473,6 @@ static void __init ap_init_of(void)
 	of_platform_populate(NULL, of_default_bus_match_table,
 			ap_auxdata_lookup, NULL);
 
-	platform_device_register(&cfi_flash_device);
-
 	sc_dec = readl(VA_SC_BASE + INTEGRATOR_SC_DEC_OFFSET);
 	for (i = 0; i < 4; i++) {
 		struct lm_device *lmdev;
@@ -535,6 +519,22 @@ MACHINE_END
  * for eventual deletion.
  */
 
+static struct resource cfi_flash_resource = {
+	.start		= INTEGRATOR_FLASH_BASE,
+	.end		= INTEGRATOR_FLASH_BASE + INTEGRATOR_FLASH_SIZE - 1,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device cfi_flash_device = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &ap_flash_data,
+	},
+	.num_resources	= 1,
+	.resource	= &cfi_flash_resource,
+};
+
 static void __init ap_init_timer(void)
 {
 	struct clk *clk;
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 1b07aa6..1f4a7be 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -52,12 +52,9 @@
 #include "common.h"
 
 #define INTCP_PA_FLASH_BASE		0x24000000
-#define INTCP_FLASH_SIZE		SZ_32M
 
 #define INTCP_PA_CLCD_BASE		0xc0000000
 
-#define INTCP_ETH_SIZE			0x10
-
 #define INTCP_VA_CTRL_BASE		IO_ADDRESS(INTEGRATOR_CP_CTL_BASE)
 #define INTCP_FLASHPROG			0x04
 #define CINTEGRATOR_FLASHPROG_FLVPPEN	(1 << 0)
@@ -184,47 +181,6 @@ static struct physmap_flash_data intcp_flash_data = {
 	.set_vpp	= intcp_flash_set_vpp,
 };
 
-static struct resource intcp_flash_resource = {
-	.start		= INTCP_PA_FLASH_BASE,
-	.end		= INTCP_PA_FLASH_BASE + INTCP_FLASH_SIZE - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device intcp_flash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &intcp_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &intcp_flash_resource,
-};
-
-static struct resource smc91x_resources[] = {
-	[0] = {
-		.start	= INTEGRATOR_CP_ETH_BASE,
-		.end	= INTEGRATOR_CP_ETH_BASE + INTCP_ETH_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_CP_ETHINT,
-		.end	= IRQ_CP_ETHINT,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device smc91x_device = {
-	.name		= "smc91x",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(smc91x_resources),
-	.resource	= smc91x_resources,
-};
-
-static struct platform_device *intcp_devs[] __initdata = {
-	&intcp_flash_device,
-	&smc91x_device,
-};
-
 /*
  * It seems that the card insertion interrupt remains active after
  * we've acknowledged it.  We therefore ignore the interrupt, and
@@ -375,6 +331,8 @@ static struct of_dev_auxdata intcp_auxdata_lookup[] __initdata = {
 		"aaci", &mmc_data),
 	OF_DEV_AUXDATA("arm,primecell", INTCP_PA_CLCD_BASE,
 		"clcd", &clcd_data),
+	OF_DEV_AUXDATA("cfi-flash", INTCP_PA_FLASH_BASE,
+		"physmap-flash", &intcp_flash_data),
 	{ /* sentinel */ },
 };
 
@@ -382,7 +340,6 @@ static void __init intcp_init_of(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table,
 			intcp_auxdata_lookup, NULL);
-	platform_add_devices(intcp_devs, ARRAY_SIZE(intcp_devs));
 }
 
 static const char * intcp_dt_board_compat[] = {
@@ -410,6 +367,51 @@ MACHINE_END
  * for eventual deletion.
  */
 
+#define INTCP_FLASH_SIZE		SZ_32M
+
+static struct resource intcp_flash_resource = {
+	.start		= INTCP_PA_FLASH_BASE,
+	.end		= INTCP_PA_FLASH_BASE + INTCP_FLASH_SIZE - 1,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device intcp_flash_device = {
+	.name		= "physmap-flash",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &intcp_flash_data,
+	},
+	.num_resources	= 1,
+	.resource	= &intcp_flash_resource,
+};
+
+#define INTCP_ETH_SIZE			0x10
+
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start	= INTEGRATOR_CP_ETH_BASE,
+		.end	= INTEGRATOR_CP_ETH_BASE + INTCP_ETH_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_CP_ETHINT,
+		.end	= IRQ_CP_ETHINT,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(smc91x_resources),
+	.resource	= smc91x_resources,
+};
+
+static struct platform_device *intcp_devs[] __initdata = {
+	&intcp_flash_device,
+	&smc91x_device,
+};
+
 #define INTCP_VA_CIC_BASE		__io_address(INTEGRATOR_HDR_BASE + 0x40)
 #define INTCP_VA_PIC_BASE		__io_address(INTEGRATOR_IC_BASE)
 #define INTCP_VA_SIC_BASE		__io_address(INTEGRATOR_CP_SIC_BASE)
-- 
1.7.11.4
