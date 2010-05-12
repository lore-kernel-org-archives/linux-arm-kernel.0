From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:39 -0700
Subject: [PATCH 10/25] msm: update basic board layout for QSD8x50
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-11-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/board-qsd8x50.c |  120 ++++++-------------------------------
 1 files changed, 19 insertions(+), 101 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index a5e862c..ec46066 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -27,106 +27,48 @@
 #include <asm/io.h>
 #include <asm/setup.h>
 
-#include <mach/vreg.h>
-#include <mach/mpp.h>
-#include <mach/gpio.h>
 #include <mach/board.h>
-#include <mach/dma.h>
-#include <mach/memory.h>
+#include <mach/irqs.h>
+#include <mach/sirc.h>
+#include <mach/gpio.h>
 
 #include "devices.h"
-#include "timer.h"
-#include "socinfo.h"
-#include "proc_comm.h"
-
-#define MSM_SHARED_RAM_PHYS	(MSM_SMI_BASE + 0x00100000)
 
-static struct resource smc91x_resources[] = {
-	[0] = {
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags  = IORESOURCE_IRQ,
-	},
-};
+extern struct sys_timer msm_timer;
 
-static struct platform_device smc91x_device = {
-	.name           = "smc91x",
-	.id             = 0,
-	.num_resources  = ARRAY_SIZE(smc91x_resources),
-	.resource       = smc91x_resources,
+static struct msm_gpio uart3_config_data[] = {
+	{ GPIO_CFG(86, 1, GPIO_INPUT,   GPIO_PULL_DOWN, GPIO_2MA), "UART2_Rx"},
+	{ GPIO_CFG(87, 1, GPIO_OUTPUT,  GPIO_PULL_DOWN, GPIO_2MA), "UART2_Tx"},
 };
 
 static struct platform_device *devices[] __initdata = {
-	&smc91x_device,
-	&msm_device_smd,
-	&msm_device_dmov,
-	&msm_device_nand,
+	&msm_device_uart3,
 };
 
-static void __init qsd8x50_init_irq(void)
+static void msm8x50_init_uart3(void)
 {
-	msm_init_irq();
+	msm_gpios_request_enable(uart3_config_data,
+				ARRAY_SIZE(uart3_config_data));
 }
 
-static void __init qsd8x50_init_host(void)
+static void __init qsd8x50_map_io(void)
 {
-	if (machine_is_qsd8x50_ffa() || machine_is_qsd8x50a_ffa())
-		return;
-
-	vreg_usb = vreg_get(NULL, "boost");
-
-	if (IS_ERR(vreg_usb)) {
-		printk(KERN_ERR "%s: vreg get failed (%ld)\n",
-		       __func__, PTR_ERR(vreg_usb));
-		return;
-	}
-
-	platform_device_register(&msm_device_hsusb_otg);
+	msm_map_qsd8x50_io();
+	msm_clock_init(msm_clocks_8x50, msm_num_clocks_8x50);
 }
 
-static void __init qsd8x50_cfg_smc91x(void)
+static void __init qsd8x50_init_irq(void)
 {
-	int rc = 0;
-
-	if (machine_is_qsd8x50_surf() || machine_is_qsd8x50a_surf()) {
-		smc91x_resources[0].start = 0x70000300;
-		smc91x_resources[0].end = 0x700003ff;
-		smc91x_resources[1].start = MSM_GPIO_TO_INT(156);
-		smc91x_resources[1].end = MSM_GPIO_TO_INT(156);
-	} else if (machine_is_qsd8x50_ffa() || machine_is_qsd8x50a_ffa()) {
-		smc91x_resources[0].start = 0x84000300;
-		smc91x_resources[0].end = 0x840003ff;
-		smc91x_resources[1].start = MSM_GPIO_TO_INT(87);
-		smc91x_resources[1].end = MSM_GPIO_TO_INT(87);
-
-		rc = gpio_tlmm_config(GPIO_CFG(87, 0, GPIO_INPUT,
-					       GPIO_PULL_DOWN, GPIO_2MA),
-					       GPIO_ENABLE);
-		if (rc) {
-			printk(KERN_ERR "%s: gpio_tlmm_config=%d\n",
-					__func__, rc);
-		}
-	} else
-		printk(KERN_ERR "%s: invalid machine type\n", __func__);
+	msm_init_irq();
+	msm_init_sirc();
 }
 
 static void __init qsd8x50_init(void)
 {
-	if (socinfo_init() < 0)
-		printk(KERN_ERR "%s: socinfo_init() failed!\n",
-		       __func__);
-	qsd8x50_cfg_smc91x();
+	msm8x50_init_uart3();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
-static void __init qsd8x50_map_io(void)
-{
-	msm_shared_ram_phys = MSM_SHARED_RAM_PHYS;
-	msm_map_qsd8x50_io();
-	msm_clock_init(msm_clocks_8x50, msm_num_clocks_8x50);
-}
-
 MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
 #ifdef CONFIG_MSM_DEBUG_UART
 	.phys_io  = MSM_DEBUG_UART_PHYS,
@@ -139,31 +81,7 @@ MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
 	.timer = &msm_timer,
 MACHINE_END
 
-MACHINE_START(QSD8X50_FFA, "QCT QSD8X50 FFA")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io  = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
-	.boot_params = PHYS_OFFSET + 0x100,
-	.map_io = qsd8x50_map_io,
-	.init_irq = qsd8x50_init_irq,
-	.init_machine = qsd8x50_init,
-	.timer = &msm_timer,
-MACHINE_END
-
-MACHINE_START(QSD8X50A_SURF, "QCT QSD8X50A SURF")
-#ifdef CONFIG_MSM_DEBUG_UART
-	.phys_io  = MSM_DEBUG_UART_PHYS,
-	.io_pg_offst = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-#endif
-	.boot_params = PHYS_OFFSET + 0x100,
-	.map_io = qsd8x50_map_io,
-	.init_irq = qsd8x50_init_irq,
-	.init_machine = qsd8x50_init,
-	.timer = &msm_timer,
-MACHINE_END
-
-MACHINE_START(QSD8X50A_FFA, "QCT QSD8X50A FFA")
+MACHINE_START(QSD8X50A_ST1_5, "QCT QSD8X50A ST1.5")
 #ifdef CONFIG_MSM_DEBUG_UART
 	.phys_io  = MSM_DEBUG_UART_PHYS,
 	.io_pg_offst = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
-- 
1.6.2.3
