From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:47 +0530
Subject: [PATCH 09/14] ux500: reorganize i2c devices
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-10-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move common i2c devices to devices.c and DB8500-specific I2C
devices to devices-db8500.c.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c         |   50 +++++----------------------
 arch/arm/mach-ux500/devices-db8500.c       |   40 ++++++++++++++++++++++
 arch/arm/mach-ux500/devices.c              |   30 ++++++++++++++++
 arch/arm/mach-ux500/include/mach/devices.h |    7 ++++
 arch/arm/mach-ux500/include/mach/irqs.h    |    1 +
 5 files changed, 88 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 0e595bf..cd0bd36 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -70,27 +70,8 @@ static struct pl022_ssp_controller ssp0_platform_data = {
 	.num_chipselect = 5,
 };
 
-#define U8500_I2C_RESOURCES(id, size)		\
-static struct resource u8500_i2c_resources_##id[] = {	\
-	[0] = {					\
-		.start	= U8500_I2C##id##_BASE,	\
-		.end	= U8500_I2C##id##_BASE + size - 1, \
-		.flags	= IORESOURCE_MEM,	\
-	},					\
-	[1] = {					\
-		.start	= IRQ_I2C##id,		\
-		.end	= IRQ_I2C##id,		\
-		.flags	= IORESOURCE_IRQ	\
-	}					\
-}
-
-U8500_I2C_RESOURCES(0, SZ_4K);
-U8500_I2C_RESOURCES(1, SZ_4K);
-U8500_I2C_RESOURCES(2, SZ_4K);
-U8500_I2C_RESOURCES(3, SZ_4K);
-
 #define U8500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, _sm) \
-static struct nmk_i2c_controller u8500_i2c_##id = { \
+static struct nmk_i2c_controller u8500_i2c##id##_data = { \
 	/*				\
 	 * slave data setup time, which is	\
 	 * 250 ns,100ns,10ns which is 14,6,2	\
@@ -118,22 +99,6 @@ U8500_I2C_CONTROLLER(1, 0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
 U8500_I2C_CONTROLLER(2,	0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
 U8500_I2C_CONTROLLER(3,	0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
 
-#define U8500_I2C_PDEVICE(cid)		\
-static struct platform_device i2c_controller##cid = { \
-	.name = "nmk-i2c",		\
-	.id	 = cid,			\
-	.num_resources = 2,		\
-	.resource = u8500_i2c_resources_##cid,	\
-	.dev = {			\
-		.platform_data = &u8500_i2c_##cid \
-	}				\
-}
-
-U8500_I2C_PDEVICE(0);
-U8500_I2C_PDEVICE(1);
-U8500_I2C_PDEVICE(2);
-U8500_I2C_PDEVICE(3);
-
 static struct amba_device *amba_devs[] __initdata = {
 	&ux500_uart0_device,
 	&ux500_uart1_device,
@@ -143,16 +108,21 @@ static struct amba_device *amba_devs[] __initdata = {
 
 /* add any platform devices here - TODO */
 static struct platform_device *platform_devs[] __initdata = {
-	&i2c_controller0,
-	&i2c_controller1,
-	&i2c_controller2,
-	&i2c_controller3,
+	&u8500_i2c0_device,
+	&ux500_i2c1_device,
+	&ux500_i2c2_device,
+	&ux500_i2c3_device,
 };
 
 static void __init u8500_init_machine(void)
 {
 	int i;
 
+	u8500_i2c0_device.dev.platform_data = &u8500_i2c0_data;
+	ux500_i2c1_device.dev.platform_data = &u8500_i2c1_data;
+	ux500_i2c2_device.dev.platform_data = &u8500_i2c2_data;
+	ux500_i2c3_device.dev.platform_data = &u8500_i2c3_data;
+
 	u8500_ssp0_device.dev.platform_data = &ssp0_platform_data;
 
 	/* Register the active AMBA devices on this board */
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index f4a2dda..397f862 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -28,3 +28,43 @@ struct amba_device u8500_ssp0_device = {
 	/* ST-Ericsson modified id */
 	.periphid = SSP_PER_ID,
 };
+
+static struct resource u8500_i2c0_resources[] = {
+	[0] = {
+		.start	= U8500_I2C0_BASE,
+		.end	= U8500_I2C0_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_I2C0,
+		.end	= IRQ_I2C0,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device u8500_i2c0_device = {
+	.name		= "nmk-i2c",
+	.id		= 0,
+	.resource	= u8500_i2c0_resources,
+	.num_resources	= ARRAY_SIZE(u8500_i2c0_resources),
+};
+
+static struct resource u8500_i2c4_resources[] = {
+	[0] = {
+		.start	= U8500_I2C4_BASE,
+		.end	= U8500_I2C4_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_I2C4,
+		.end	= IRQ_I2C4,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device u8500_i2c4_device = {
+	.name		= "nmk-i2c",
+	.id		= 4,
+	.resource	= u8500_i2c4_resources,
+	.num_resources	= ARRAY_SIZE(u8500_i2c4_resources),
+};
diff --git a/arch/arm/mach-ux500/devices.c b/arch/arm/mach-ux500/devices.c
index 374fcce..8a26889 100644
--- a/arch/arm/mach-ux500/devices.c
+++ b/arch/arm/mach-ux500/devices.c
@@ -47,6 +47,36 @@ struct amba_device ux500_uart2_device = {
 	.irq = {IRQ_UART2, NO_IRQ},
 };
 
+#define UX500_I2C_RESOURCES(id, size)				\
+static struct resource ux500_i2c##id##_resources[] = {		\
+	[0] = {							\
+		.start	= UX500_I2C##id##_BASE,			\
+		.end	= UX500_I2C##id##_BASE + size - 1,	\
+		.flags	= IORESOURCE_MEM,			\
+	},							\
+	[1] = {							\
+		.start	= IRQ_I2C##id,				\
+		.end	= IRQ_I2C##id,				\
+		.flags	= IORESOURCE_IRQ			\
+	}							\
+}
+
+UX500_I2C_RESOURCES(1, SZ_4K);
+UX500_I2C_RESOURCES(2, SZ_4K);
+UX500_I2C_RESOURCES(3, SZ_4K);
+
+#define UX500_I2C_PDEVICE(cid)					\
+struct platform_device ux500_i2c##cid##_device = {		\
+	.name		= "nmk-i2c",				\
+	.id		= cid,					\
+	.num_resources	= 2,					\
+	.resource	= ux500_i2c##cid##_resources,		\
+}
+
+UX500_I2C_PDEVICE(1);
+UX500_I2C_PDEVICE(2);
+UX500_I2C_PDEVICE(3);
+
 void __init amba_add_devices(struct amba_device *devs[], int num)
 {
 	int i;
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index 7cc4983..251b4eb 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -16,4 +16,11 @@ extern struct amba_device ux500_uart0_device;
 extern struct amba_device ux500_uart1_device;
 extern struct amba_device ux500_uart2_device;
 
+extern struct platform_device ux500_i2c1_device;
+extern struct platform_device ux500_i2c2_device;
+extern struct platform_device ux500_i2c3_device;
+
+extern struct platform_device u8500_i2c0_device;
+extern struct platform_device u8500_i2c4_device;
+
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index 8a1f697..7970684 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -42,6 +42,7 @@
 #define IRQ_AB4500		(IRQ_SHPI_START + 40)
 #define IRQ_DISP		(IRQ_SHPI_START + 48)
 #define IRQ_SiPI3		(IRQ_SHPI_START + 49)
+#define IRQ_I2C4		(IRQ_SHPI_START + 51)
 #define IRQ_SSP1		(IRQ_SHPI_START + 52)
 #define IRQ_I2C2		(IRQ_SHPI_START + 55)
 #define IRQ_SDMMC0		(IRQ_SHPI_START + 60)
-- 
1.7.0
