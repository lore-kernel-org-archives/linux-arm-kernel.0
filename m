From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 7 Jan 2010 19:15:58 +0530
Subject: [PATCH 2/2] ARM U8500: add I2C platform configurations
In-Reply-To: <27f8aa32bf40c690930a76ce5e1ee82cec86b248.1262870858.git.srinidhi.kasagar@stericsson.com>
References: <27f8aa32bf40c690930a76ce5e1ee82cec86b248.1262870858.git.srinidhi.kasagar@stericsson.com>
Message-ID: <2c332b5889f9cbfefcfa13e5af46fd72ceec47f4.1262870858.git.srinidhi.kasagar@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform configurations to support
founr i2c controllers found on early MOP500
platform

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c |   75 ++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index aa5afbc..e4f6dac 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -22,6 +22,7 @@
 #include <asm/mach/arch.h>
 
 #include <plat/mtu.h>
+#include <plat/i2c.h>
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
@@ -108,6 +109,70 @@ static struct amba_device pl022_device = {
 	.periphid = SSP_PER_ID,
 };
 
+#define U8500_I2C_RESOURCES(id, size)		\
+static struct resource u8500_i2c_resources_##id[] = {	\
+	[0] = {					\
+		.start	= U8500_I2C##id##_BASE,	\
+		.end	= U8500_I2C##id##_BASE + size - 1, \
+		.flags	= IORESOURCE_MEM,	\
+	},					\
+	[1] = {					\
+		.start	= IRQ_I2C##id,		\
+		.end	= IRQ_I2C##id,		\
+		.flags	= IORESOURCE_IRQ	\
+	}					\
+}
+
+U8500_I2C_RESOURCES(0, SZ_4K);
+U8500_I2C_RESOURCES(1, SZ_4K);
+U8500_I2C_RESOURCES(2, SZ_4K);
+U8500_I2C_RESOURCES(3, SZ_4K);
+
+#define U8500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, _sm) \
+static struct nmk_i2c_controller u8500_i2c_##id = { \
+	/*				\
+	 * slave data setup time, which is	\
+	 * 250 ns,100ns,10ns which is 14,6,2	\
+	 * respectively for a 48 Mhz	\
+	 * i2c clock			\
+	 */				\
+	.slsu		= _slsu,	\
+	/* Tx FIFO threshold */		\
+	.tft		= _tft,		\
+	/* Rx FIFO threshold */		\
+	.rft		= _rft,		\
+	/* std. mode operation */	\
+	.clk_freq	= clk,		\
+	.sm		= _sm,		\
+}
+
+/*
+ * The board uses 4 i2c controllers, initialize all of
+ * them with slave data setup time of 250 ns,
+ * Tx & Rx FIFO threshold values as 1 and standard
+ * mode of operation
+ */
+U8500_I2C_CONTROLLER(0, 0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
+U8500_I2C_CONTROLLER(1, 0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
+U8500_I2C_CONTROLLER(2,	0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
+U8500_I2C_CONTROLLER(3,	0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
+
+#define U8500_I2C_PDEVICE(cid)		\
+static struct platform_device i2c_controller##cid = { \
+	.name = "nmk-i2c",		\
+	.id	 = cid,			\
+	.num_resources = 2,		\
+	.resource = u8500_i2c_resources_##cid,	\
+	.dev = {			\
+		.platform_data = &u8500_i2c_##cid \
+	}				\
+}
+
+U8500_I2C_PDEVICE(0);
+U8500_I2C_PDEVICE(1);
+U8500_I2C_PDEVICE(2);
+U8500_I2C_PDEVICE(3);
+
 static struct amba_device *amba_devs[] __initdata = {
 	&uart0_device,
 	&uart1_device,
@@ -115,6 +180,14 @@ static struct amba_device *amba_devs[] __initdata = {
 	&pl022_device,
 };
 
+/* add any platform devices here - TODO */
+static struct platform_device *platform_devs[] __initdata = {
+	&i2c_controller0,
+	&i2c_controller1,
+	&i2c_controller2,
+	&i2c_controller3,
+};
+
 static void __init u8500_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
@@ -139,6 +212,8 @@ static void __init u8500_init_machine(void)
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
 
+	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
+
 	spi_register_board_info(u8500_spi_devices,
 			ARRAY_SIZE(u8500_spi_devices));
 
-- 
1.6.3.GIT
