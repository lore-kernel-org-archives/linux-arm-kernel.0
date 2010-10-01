From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:38 +0530
Subject: [PATCH V2 18/69] ST SPEAr: adding support for synopsis i2c designware
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <d52d1c1037d6d8f7a319a0fdb680b832fdf05aec.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    2 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |    4 +++
 arch/arm/mach-spear13xx/spear13xx.c            |   23 +++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    3 ++
 arch/arm/mach-spear3xx/include/mach/irqs.h     |    2 +-
 arch/arm/mach-spear3xx/spear300_evb.c          |    4 +++
 arch/arm/mach-spear3xx/spear310_evb.c          |    4 +++
 arch/arm/mach-spear3xx/spear320.c              |   24 +++++++++++++++++++-
 arch/arm/mach-spear3xx/spear320_evb.c          |    5 ++++
 arch/arm/mach-spear3xx/spear3xx.c              |   22 ++++++++++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h  |    2 +
 arch/arm/mach-spear6xx/spear600_evb.c          |    4 +++
 arch/arm/mach-spear6xx/spear6xx.c              |   22 ++++++++++++++++++
 arch/arm/plat-spear/Makefile                   |    6 +++++
 arch/arm/plat-spear/i2c_eval_board.c           |   29 ++++++++++++++++++++++++
 15 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-spear/i2c_eval_board.c

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index bf032f6..b0e25be 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -30,6 +30,7 @@
 
 /* Add spear13xx family device structure declarations here */
 extern struct amba_device spear13xx_uart_device;
+extern struct platform_device spear13xx_i2c_device;
 extern struct platform_device spear13xx_rtc_device;
 extern struct sys_timer spear13xx_timer;
 
@@ -37,6 +38,7 @@ extern struct sys_timer spear13xx_timer;
 
 /* Add spear13xx family function declarations here */
 void __init clk_init(void);
+void __init i2c_register_board_devices(void);
 void __init spear_setup_timer(void);
 void __init spear1300_init(void);
 void __init spear13xx_map_io(void);
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 2fce2ec..4c72b7a 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -22,6 +22,7 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	&spear13xx_i2c_device,
 	&spear13xx_rtc_device,
 };
 
@@ -32,6 +33,9 @@ static void __init spear1300_evb_init(void)
 	/* call spear1300 machine init function */
 	spear1300_init();
 
+	/* Register slave devices on the I2C buses */
+	i2c_register_board_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 5de0fd9..8acf9df 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -24,6 +24,7 @@
 #include <mach/hardware.h>
 
 /* Add spear13xx machines common devices here */
+
 /* uart device registeration */
 struct amba_device spear13xx_uart_device = {
 	.dev = {
@@ -37,6 +38,28 @@ struct amba_device spear13xx_uart_device = {
 	.irq = {IRQ_UART, NO_IRQ},
 };
 
+/* i2c device registeration */
+static struct resource i2c_resources[] = {
+	{
+		.start = SPEAR13XX_I2C_BASE,
+		.end = SPEAR13XX_I2C_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_I2C,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear13xx_i2c_device = {
+	.name = "i2c_designware",
+	.id = 0,
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.num_resources = ARRAY_SIZE(i2c_resources),
+	.resource = i2c_resources,
+};
+
 /* rtc device registration */
 static struct resource rtc_resources[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 408bb8d..162f33b 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -33,11 +33,13 @@
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device gpio_device;
 extern struct amba_device uart_device;
+extern struct platform_device i2c_device;
 extern struct platform_device rtc_device;
 extern struct sys_timer spear3xx_timer;
 
 /* Add spear3xx family function declarations here */
 void __init clk_init(void);
+void __init i2c_register_board_devices(void);
 void __init spear_setup_timer(void);
 void __init spear3xx_map_io(void);
 void __init spear3xx_init_irq(void);
@@ -166,6 +168,7 @@ void __init spear310_init(void);
 #ifdef CONFIG_MACH_SPEAR320
 /* Add spear320 machine device structure declarations here */
 extern struct amba_device clcd_device;
+extern struct platform_device i2c1_device;
 extern struct platform_device plgpio_device;
 
 /* pad mux modes */
diff --git a/arch/arm/mach-spear3xx/include/mach/irqs.h b/arch/arm/mach-spear3xx/include/mach/irqs.h
index f1175b9..5ad7574 100644
--- a/arch/arm/mach-spear3xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear3xx/include/mach/irqs.h
@@ -133,7 +133,7 @@
 #define VIRQ_MII1_SMII1				(VIRQ_START + 13)
 #define VIRQ_WAKEUP_SMII0			(VIRQ_START + 14)
 #define VIRQ_WAKEUP_MII1_SMII1			(VIRQ_START + 15)
-#define VIRQ_I2C				(VIRQ_START + 16)
+#define VIRQ_I2C1				(VIRQ_START + 16)
 
 /* GPIO pins virtual irqs */
 #define SPEAR_GPIO_INT_BASE			(VIRQ_START + 17)
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 392ee4a..083f65c 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -44,6 +44,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&i2c_device,
 	&rtc_device,
 
 	/* spear300 specific devices */
@@ -61,6 +62,9 @@ static void __init spear300_evb_init(void)
 	/* call spear300 machine init function */
 	spear300_init();
 
+	/* Register slave devices on the I2C buses */
+	i2c_register_board_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 15ca8fc..208a68ce1 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -50,6 +50,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&i2c_device,
 	&rtc_device,
 
 	/* spear310 specific devices */
@@ -68,6 +69,9 @@ static void __init spear310_evb_init(void)
 	/* call spear310 machine init function */
 	spear310_init();
 
+	/* Register slave devices on the I2C buses */
+	i2c_register_board_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 2e388dd..bfb21ae 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -409,6 +409,28 @@ static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_count = SPEAR_PLGPIO_COUNT,
 };
 
+/* i2c1 device registeration */
+static struct resource i2c1_resources[] = {
+	{
+		.start = SPEAR320_I2C_BASE,
+		.end = SPEAR320_I2C_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = VIRQ_I2C1 ,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device i2c1_device = {
+	.name = "i2c_designware",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.num_resources = ARRAY_SIZE(i2c1_resources),
+	.resource = i2c1_resources,
+};
+
 static struct resource plgpio_resources[] = {
 	{
 		.start = SPEAR320_SOC_CONFIG_BASE,
@@ -535,7 +557,7 @@ struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 		.status_mask = WAKEUP_MII1_SMII1_IRQ_MASK,
 		.clear_mask = WAKEUP_MII1_SMII1_IRQ_MASK,
 	}, {
-		.virq = VIRQ_I2C,
+		.virq = VIRQ_I2C1,
 		.status_mask = I2C1_IRQ_MASK,
 		.clear_mask = I2C1_IRQ_MASK,
 	},
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 48155cc..90d685e 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -48,9 +48,11 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&i2c_device,
 	&rtc_device,
 
 	/* spear320 specific devices */
+	&i2c1_device,
 	&plgpio_device,
 };
 
@@ -66,6 +68,9 @@ static void __init spear320_evb_init(void)
 	/* call spear320 machine init function */
 	spear320_init();
 
+	/* Register slave devices on the I2C buses */
+	i2c_register_board_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 64147c9..22d172b 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -54,6 +54,28 @@ struct amba_device uart_device = {
 	.irq = {IRQ_UART, NO_IRQ},
 };
 
+/* i2c device registeration */
+static struct resource i2c_resources[] = {
+	{
+		.start = SPEAR3XX_ICM1_I2C_BASE,
+		.end = SPEAR3XX_ICM1_I2C_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_I2C,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device i2c_device = {
+	.name = "i2c_designware",
+	.id = 0,
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.num_resources = ARRAY_SIZE(i2c_resources),
+	.resource = i2c_resources,
+};
+
 /* rtc device registration */
 static struct resource rtc_resources[] = {
 	{
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 674b16c..44a2f99 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -32,10 +32,12 @@
 extern struct amba_device clcd_device;
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
+extern struct platform_device i2c_device;
 extern struct platform_device rtc_device;
 extern struct sys_timer spear6xx_timer;
 
 /* Add spear6xx family function declarations here */
+void __init i2c_register_board_devices(void);
 void __init spear_setup_timer(void);
 void __init spear6xx_map_io(void);
 void __init spear6xx_init_irq(void);
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index 861e83d..6b0cf23 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -26,6 +26,7 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	&i2c_device,
 	&rtc_device,
 };
 
@@ -36,6 +37,9 @@ static void __init spear600_evb_init(void)
 	/* call spear600 machine init function */
 	spear600_init();
 
+	/* Register slave devices on the I2C buses */
+	i2c_register_board_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 45bc4ec..646098f 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -121,6 +121,28 @@ struct amba_device gpio_device[] = {
 	}
 };
 
+/* i2c device registeration */
+static struct resource i2c_resources[] = {
+	{
+		.start = SPEAR6XX_ICM1_I2C_BASE,
+		.end = SPEAR6XX_ICM1_I2C_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_I2C,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device i2c_device = {
+	.name = "i2c_designware",
+	.id = 0,
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.num_resources = ARRAY_SIZE(i2c_resources),
+	.resource = i2c_resources,
+};
+
 /* rtc device registration */
 static struct resource rtc_resources[] = {
 	{
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index e66bc5f..c31892a 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -8,3 +8,9 @@ obj-y	:= clcd.o clock.o time.o
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
 obj-$(CONFIG_MACH_SPEAR310)	+= plgpio.o
 obj-$(CONFIG_MACH_SPEAR320)	+= plgpio.o
+
+obj-$(CONFIG_BOARD_SPEAR1300_EVB)	+= i2c_eval_board.o
+obj-$(CONFIG_BOARD_SPEAR300_EVB)	+= i2c_eval_board.o
+obj-$(CONFIG_BOARD_SPEAR310_EVB)	+= i2c_eval_board.o
+obj-$(CONFIG_BOARD_SPEAR320_EVB)	+= i2c_eval_board.o
+obj-$(CONFIG_BOARD_SPEAR600_EVB)	+= i2c_eval_board.o
diff --git a/arch/arm/plat-spear/i2c_eval_board.c b/arch/arm/plat-spear/i2c_eval_board.c
new file mode 100644
index 0000000..a2473a8
--- /dev/null
+++ b/arch/arm/plat-spear/i2c_eval_board.c
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/plat-spear/i2c_eval_board.c
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+
+static struct i2c_board_info __initdata i2c_board_info[] = {
+	{
+		.type = "eeprom",
+		.addr = 0x50,
+	}, {
+		.type = "eeprom",
+		.addr = 0x51,
+	},
+};
+
+void __init i2c_register_board_devices(void)
+{
+	i2c_register_board_info(0, i2c_board_info,
+				ARRAY_SIZE(i2c_board_info));
+}
-- 
1.7.2.2
