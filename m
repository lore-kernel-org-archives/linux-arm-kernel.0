From: anjir@codeaurora.org (Anji jonnala)
Date: Tue, 22 Mar 2011 14:21:48 +0530
Subject: [PATCH] msm: board-msm8960: Add USB peripheral and OTG support
Message-ID: <1300783908-4638-1-git-send-email-anjir@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Anji jonnala <anjir@codeaurora.org>
---
 arch/arm/mach-msm/board-msm8960.c               |   10 +++++
 arch/arm/mach-msm/devices-msm8960.c             |   47 +++++++++++++++++++++++
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h |    2 +
 3 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm8960.c b/arch/arm/mach-msm/board-msm8960.c
index 052cb35..8ee373e 100644
--- a/arch/arm/mach-msm/board-msm8960.c
+++ b/arch/arm/mach-msm/board-msm8960.c
@@ -27,9 +27,15 @@
 
 #include <mach/board.h>
 #include <mach/msm_iomap.h>
+#include <linux/usb/msm_hsusb.h>
 
 #include "devices.h"
 
+static struct msm_otg_platform_data msm_otg_pdata = {
+	.mode			= USB_PERIPHERAL,
+	.otg_control		= OTG_PHY_CONTROL,
+};
+
 static void __init msm8960_map_io(void)
 {
 	msm_map_msm8960_io();
@@ -59,6 +65,8 @@ static void __init msm8960_init_irq(void)
 
 static struct platform_device *sim_devices[] __initdata = {
 	&msm8960_device_uart_gsbi2,
+	&msm_device_otg,
+	&msm_device_hsusb,
 };
 
 static struct platform_device *rumi3_devices[] __initdata = {
@@ -68,6 +76,8 @@ static struct platform_device *rumi3_devices[] __initdata = {
 static void __init msm8960_sim_init(void)
 {
 	msm_clock_init(msm_clocks_8960, msm_num_clocks_8960);
+	msm_device_otg.dev.platform_data = &msm_otg_pdata;
+	msm_device_hsusb.dev.parent = &msm_device_otg.dev;
 	platform_add_devices(sim_devices, ARRAY_SIZE(sim_devices));
 }
 
diff --git a/arch/arm/mach-msm/devices-msm8960.c b/arch/arm/mach-msm/devices-msm8960.c
index 894ff98..8baf4fa 100644
--- a/arch/arm/mach-msm/devices-msm8960.c
+++ b/arch/arm/mach-msm/devices-msm8960.c
@@ -24,6 +24,7 @@
 
 #include <mach/irqs-8960.h>
 #include <mach/board.h>
+#include <mach/msm_iomap.h>
 
 #include "devices.h"
 #include "clock.h"
@@ -89,6 +90,52 @@ struct platform_device msm8960_device_uart_gsbi5 = {
 	.resource	= resources_uart_gsbi5,
 };
 
+static struct resource resources_otg[] = {
+	{
+		.start	= MSM8960_HSUSB_PHYS,
+		.end	= MSM8960_HSUSB_PHYS + MSM8960_HSUSB_SIZE,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= USB1_HS_IRQ,
+		.end	= USB1_HS_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device msm_device_otg = {
+	.name		= "msm_otg",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(resources_otg),
+	.resource	= resources_otg,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+static struct resource resources_hsusb[] = {
+	{
+		.start	= MSM8960_HSUSB_PHYS,
+		.end	= MSM8960_HSUSB_PHYS + MSM8960_HSUSB_SIZE,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= USB1_HS_IRQ,
+		.end	= USB1_HS_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device msm_device_hsusb = {
+	.name		= "msm_hsusb",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(resources_hsusb),
+	.resource	= resources_hsusb,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
 struct clk_lookup msm_clocks_8960[] = {
 	CLK_DUMMY("ce_clk",		CE2_CLK,		NULL, OFF),
 	CLK_DUMMY("gsbi_uart_clk",	GSBI1_UART_CLK,		NULL, OFF),
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8960.h b/arch/arm/mach-msm/include/mach/msm_iomap-8960.h
index 3c9d960..fd0d17e 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8960.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8960.h
@@ -45,4 +45,6 @@
 #define MSM8960_TMR0_PHYS	0x0208A000
 #define MSM8960_TMR0_SIZE	SZ_4K
 
+#define MSM8960_HSUSB_PHYS	0x12500000
+#define MSM8960_HSUSB_SIZE	SZ_256K
 #endif
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
1.7.1.1
