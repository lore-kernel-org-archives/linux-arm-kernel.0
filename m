From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:48 -0700
Subject: [PATCH 19/25] msm: update basic board layout for MSM7x30
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-20-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/board-msm7x30.c |  116 ++++++------------------------------
 1 files changed, 20 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index af132eb..bac1f3c 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -30,96 +30,37 @@
 
 #include <mach/gpio.h>
 #include <mach/board.h>
-#include <mach/camera.h>
 #include <mach/memory.h>
 #include <mach/msm_iomap.h>
-#include <mach/msm_hsusb.h>
 #include <mach/dma.h>
 
 #include <mach/vreg.h>
-
 #include "devices.h"
-#include "timer.h"
-#include "socinfo.h"
-
-static struct resource smc91x_resources[] = {
-	[0] = {
-		.start = 0x8A000300,
-		.end = 0x8A0003ff,
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = MSM_GPIO_TO_INT(156),
-		.end = MSM_GPIO_TO_INT(156),
-		.flags  = IORESOURCE_IRQ,
-	},
-};
+#include "proc_comm.h"
 
-static struct platform_device smc91x_device = {
-	.name           = "smc91x",
-	.id             = 0,
-	.num_resources  = ARRAY_SIZE(smc91x_resources),
-	.resource       = smc91x_resources,
-};
-
-static struct smsc911x_platform_config smsc911x_config = {
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
-	.flags		= SMSC911X_USE_32BIT,
-};
-
-static struct resource smsc911x_resources[] = {
-	[0] = {
-		.start		= 0x8D000000,
-		.end		= 0x8D000100,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= MSM_GPIO_TO_INT(88),
-		.end		= MSM_GPIO_TO_INT(88),
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device smsc911x_device = {
-	.name		= "smsc911x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(smsc911x_resources),
-	.resource	= smsc911x_resources,
-	.dev		= {
-		.platform_data = &smsc911x_config,
-	},
-};
+extern struct sys_timer msm_timer;
 
-static struct msm_gpio smsc911x_gpios[] = {
-    { GPIO_CFG(172, 2, GPIO_OUTPUT, GPIO_PULL_DOWN, GPIO_2MA), "ebi2_addr6" },
-    { GPIO_CFG(173, 2, GPIO_OUTPUT, GPIO_PULL_DOWN, GPIO_2MA), "ebi2_addr5" },
-    { GPIO_CFG(174, 2, GPIO_OUTPUT, GPIO_PULL_DOWN, GPIO_2MA), "ebi2_addr4" },
-    { GPIO_CFG(175, 2, GPIO_OUTPUT, GPIO_PULL_DOWN, GPIO_2MA), "ebi2_addr3" },
-    { GPIO_CFG(176, 2, GPIO_OUTPUT, GPIO_PULL_DOWN, GPIO_2MA), "ebi2_addr2" },
-    { GPIO_CFG(177, 2, GPIO_OUTPUT, GPIO_PULL_DOWN, GPIO_2MA), "ebi2_addr1" },
-    { GPIO_CFG(178, 2, GPIO_OUTPUT, GPIO_PULL_DOWN, GPIO_2MA), "ebi2_addr0" },
-    { GPIO_CFG(88, 2, GPIO_INPUT, GPIO_PULL_UP, GPIO_2MA), "smsc911x_irq"  },
+#ifdef CONFIG_SERIAL_MSM_CONSOLE
+static struct msm_gpio uart2_config_data[] = {
+	{ GPIO_CFG(49, 2, GPIO_OUTPUT,  GPIO_PULL_DOWN, GPIO_2MA), "UART2_RFR"},
+	{ GPIO_CFG(50, 2, GPIO_INPUT,   GPIO_PULL_DOWN, GPIO_2MA), "UART2_CTS"},
+	{ GPIO_CFG(51, 2, GPIO_INPUT,   GPIO_PULL_DOWN, GPIO_2MA), "UART2_Rx"},
+	{ GPIO_CFG(52, 2, GPIO_OUTPUT,  GPIO_PULL_DOWN, GPIO_2MA), "UART2_Tx"},
 };
 
-static void msm7x30_cfg_smsc911x(void)
+static void msm7x30_init_uart2(void)
 {
-	int rc;
+	msm_gpios_request_enable(uart2_config_data,
+			ARRAY_SIZE(uart2_config_data));
 
-	rc = msm_gpios_request_enable(smsc911x_gpios,
-			ARRAY_SIZE(smsc911x_gpios));
-	if (rc)
-		pr_err("%s: unable to enable gpios\n", __func__);
 }
+#endif
 
 static struct platform_device *devices[] __initdata = {
-	&msm_device_smd,
-	&msm_device_dmov,
-	&smc91x_device,
-	&smsc911x_device,
-	&msm_device_nand,
-	&msm_device_uart_dm1,
+#if defined(CONFIG_SERIAL_MSM) || defined(CONFIG_MSM_SERIAL_DEBUGGER)
+        &msm_device_uart2,
+#endif
+
 };
 
 static void __init msm7x30_init_irq(void)
@@ -127,35 +68,18 @@ static void __init msm7x30_init_irq(void)
 	msm_init_irq();
 }
 
-static void __init msm_7x30_init_nand(void)
-{
-	int rc;
-	/* Enable GPIO 86 & 115 */
-	rc = msm_gpios_request_enable(msm_nand_ebi2_cfg_data,
-				ARRAY_SIZE(msm_nand_ebi2_cfg_data));
-	if (rc)
-		printk(KERN_ERR "%s: Failed to enable GPIO 86 & 115\n",
-			 __func__);
-}
-
 static void __init msm7x30_init(void)
 {
-	if (socinfo_init() < 0)
-		printk(KERN_ERR "%s: socinfo_init() failed!\n",
-		       __func__);
-	msm_acpu_clock_init(&msm7x30_clock_data);
-	if (machine_is_msm7x30_surf() || machine_is_msm7x30_fluid())
-		msm7x30_cfg_smsc911x();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
-	msm_7x30_init_nand();
-	buses_init();
+#ifdef CONFIG_SERIAL_MSM_CONSOLE
+	msm7x30_init_uart2();
+#endif
+
 }
 
 static void __init msm7x30_map_io(void)
 {
-	msm_shared_ram_phys = 0x00000000;
 	msm_map_msm7x30_io();
-	msm7x30_allocate_memory_regions();
 	msm_clock_init(msm_clocks_7x30, msm_num_clocks_7x30);
 }
 
-- 
1.6.2.3
