From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 17:00:59 +0530
Subject: [PATCH V6 10/17] ST SPEAr: adding support for synopsis i2c designware
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <5221da925bacb9d431982e9a8c92c42fd6a76fa9.1298977728.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    3 ++
 arch/arm/mach-spear13xx/spear1300_evb.c        |    4 +++
 arch/arm/mach-spear13xx/spear1310.c            |   22 ++++++++++++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c        |    5 ++++
 arch/arm/mach-spear13xx/spear13xx.c            |   22 ++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    3 ++
 arch/arm/mach-spear3xx/spear300_evb.c          |    4 +++
 arch/arm/mach-spear3xx/spear310_evb.c          |    4 +++
 arch/arm/mach-spear3xx/spear320.c              |   22 ++++++++++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c          |    5 ++++
 arch/arm/mach-spear3xx/spear3xx.c              |   22 ++++++++++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h  |    2 +
 arch/arm/mach-spear6xx/spear600_evb.c          |    4 +++
 arch/arm/mach-spear6xx/spear6xx.c              |   22 ++++++++++++++++++
 arch/arm/plat-spear/Makefile                   |    7 +++++
 arch/arm/plat-spear/i2c_eval_board.c           |   29 ++++++++++++++++++++++++
 16 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-spear/i2c_eval_board.c

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index b598236..991abda 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -223,10 +223,12 @@ extern struct pmx_dev pmx_uart1_modem;
 /* Add spear13xx family device structure declarations here */
 extern struct amba_device spear13xx_gpio_device[];
 extern struct amba_device spear13xx_uart_device;
+extern struct platform_device spear13xx_i2c_device;
 extern struct platform_device spear13xx_rtc_device;
 extern struct sys_timer spear13xx_timer;
 
 /* Add spear13xx family function declarations here */
+void __init i2c_register_default_devices(void);
 void __init spear13xx_clk_init(void);
 void __init spear_setup_timer(void);
 void __init spear13xx_map_io(void);
@@ -252,6 +254,7 @@ extern struct amba_device spear1310_uart4_device;
 extern struct amba_device spear1310_uart5_device;
 extern struct platform_device spear1310_can0_device;
 extern struct platform_device spear1310_can1_device;
+extern struct platform_device spear1310_i2c1_device;
 
 /* Add spear1310 machine function declarations here */
 void __init spear1310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 796d04c..69accb2 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -44,6 +44,7 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	&spear13xx_i2c_device,
 	&spear13xx_rtc_device,
 };
 
@@ -84,6 +85,9 @@ static void __init spear1300_evb_init(void)
 	pcie_init(spear1300_pcie_port_is_host);
 #endif
 
+	/* Register slave devices on the I2C buses */
+	i2c_register_default_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 21ec388..18e38c9 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -458,6 +458,28 @@ struct platform_device spear1310_can1_device = {
 	.resource = can1_resources,
 };
 
+/* i2c1 device registeration */
+static struct resource i2c1_resources[] = {
+	{
+		.start = SPEAR1310_I2C1_BASE,
+		.end = SPEAR1310_I2C1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_I2C_CNTR,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear1310_i2c1_device = {
+	.name = "i2c_designware",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.num_resources = ARRAY_SIZE(i2c1_resources),
+	.resource = i2c1_resources,
+};
+
 /* Following will create 1310 specific static virtual/physical mappings */
 struct map_desc spear1310_io_desc[] __initdata = {
 	{
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index 1eea995..891018e 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -59,11 +59,13 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear13xx specific devices */
+	&spear13xx_i2c_device,
 	&spear13xx_rtc_device,
 
 	/* spear1310 specific devices */
 	&spear1310_can0_device,
 	&spear1310_can1_device,
+	&spear1310_i2c1_device,
 };
 
 #ifdef CONFIG_PCIEPORTBUS
@@ -103,6 +105,9 @@ static void __init spear1310_evb_init(void)
 	pcie_init(spear1310_pcie_port_is_host);
 #endif
 
+	/* Register slave devices on the I2C buses */
+	i2c_register_default_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index e9ba888..1ee23e6 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -76,6 +76,28 @@ struct amba_device spear13xx_uart_device = {
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
index 73f3f3b..97e9235 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -34,10 +34,12 @@
 extern struct amba_device spear3xx_gpio_device;
 extern struct amba_device spear3xx_uart_device;
 extern struct amba_device spear3xx_wdt_device;
+extern struct platform_device spear3xx_i2c_device;
 extern struct platform_device spear3xx_rtc_device;
 extern struct sys_timer spear3xx_timer;
 
 /* Add spear3xx family function declarations here */
+void __init i2c_register_default_devices(void);
 void __init spear3xx_clk_init(void);
 void __init spear_setup_timer(void);
 void __init spear3xx_map_io(void);
@@ -178,6 +180,7 @@ extern struct amba_device spear320_uart1_device;
 extern struct amba_device spear320_uart2_device;
 extern struct platform_device spear320_can0_device;
 extern struct platform_device spear320_can1_device;
+extern struct platform_device spear320_i2c1_device;
 extern struct platform_device spear320_plgpio_device;
 extern struct platform_device spear320_pwm_device;
 
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index e4a9a4f..0d2b365 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -44,6 +44,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&spear3xx_i2c_device,
 	&spear3xx_rtc_device,
 
 	/* spear300 specific devices */
@@ -57,6 +58,9 @@ static void __init spear300_evb_init(void)
 	spear300_init(&spear300_photo_frame_mode, pmx_devs,
 			ARRAY_SIZE(pmx_devs));
 
+	/* Register slave devices on the I2C buses */
+	i2c_register_default_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 97c9551..59f69d5 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -87,6 +87,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&spear3xx_i2c_device,
 	&spear3xx_rtc_device,
 
 	/* spear310 specific devices */
@@ -104,6 +105,9 @@ static void __init spear310_evb_init(void)
 	/* Initialize emi regiters */
 	emi_init(SPEAR310_EMI_REG_BASE, 0, EMI_FLASH_WIDTH32);
 
+	/* Register slave devices on the I2C buses */
+	i2c_register_default_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 3f058c7..047dcae 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -775,6 +775,28 @@ struct platform_device spear320_can1_device = {
 	.resource = can1_resources,
 };
 
+/* i2c1 device registeration */
+static struct resource i2c1_resources[] = {
+	{
+		.start = SPEAR320_I2C_BASE,
+		.end = SPEAR320_I2C_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = SPEAR320_VIRQ_I2C1 ,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear320_i2c1_device = {
+	.name = "i2c_designware",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.num_resources = ARRAY_SIZE(i2c1_resources),
+	.resource = i2c1_resources,
+};
+
 /* plgpio device registeration */
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 17248f4..40d62ae 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -81,11 +81,13 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&spear3xx_i2c_device,
 	&spear3xx_rtc_device,
 
 	/* spear320 specific devices */
 	&spear320_can0_device,
 	&spear320_can1_device,
+	&spear320_i2c1_device,
 	&spear320_emi_nor_device,
 	&spear320_plgpio_device,
 	&spear320_pwm_device,
@@ -102,6 +104,9 @@ static void __init spear320_evb_init(void)
 	/* Initialize emi regiters */
 	emi_init(SPEAR320_EMI_CTRL_BASE, 0, EMI_FLASH_WIDTH16);
 
+	/* Register slave devices on the I2C buses */
+	i2c_register_default_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 6e8bcd0..f9b5bb1 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -66,6 +66,28 @@ struct amba_device spear3xx_wdt_device = {
 	},
 };
 
+/* i2c device registeration */
+static struct resource i2c_resources[] = {
+	{
+		.start = SPEAR3XX_ICM1_I2C_BASE,
+		.end = SPEAR3XX_ICM1_I2C_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = SPEAR3XX_IRQ_I2C,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear3xx_i2c_device = {
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
index 9b7a758..fee7f69 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -32,10 +32,12 @@
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
 extern struct amba_device wdt_device;
+extern struct platform_device i2c_device;
 extern struct platform_device rtc_device;
 extern struct sys_timer spear6xx_timer;
 
 /* Add spear6xx family function declarations here */
+void __init i2c_register_default_devices(void);
 void __init spear_setup_timer(void);
 void __init spear6xx_map_io(void);
 void __init spear6xx_init_irq(void);
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index 2b8cd87..d8af2bd 100644
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
+	i2c_register_default_devices();
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index f976377..fb0a46b 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -111,6 +111,28 @@ struct amba_device wdt_device = {
 	},
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
index 636678a..44923e9 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -11,3 +11,10 @@ obj-$(CONFIG_MACH_SPEAR310)	+= plgpio.o
 obj-$(CONFIG_MACH_SPEAR320)	+= plgpio.o
 
 obj-$(CONFIG_SPEAR_PWM)		+= pwm.o
+
+obj-$(CONFIG_BOARD_SPEAR1300_EVB)	+= i2c_eval_board.o
+obj-$(CONFIG_BOARD_SPEAR1310_EVB)	+= i2c_eval_board.o
+obj-$(CONFIG_BOARD_SPEAR300_EVB)	+= i2c_eval_board.o
+obj-$(CONFIG_BOARD_SPEAR310_EVB)	+= i2c_eval_board.o
+obj-$(CONFIG_BOARD_SPEAR320_EVB)	+= i2c_eval_board.o
+obj-$(CONFIG_BOARD_SPEAR600_EVB)	+= i2c_eval_board.o
diff --git a/arch/arm/plat-spear/i2c_eval_board.c b/arch/arm/plat-spear/i2c_eval_board.c
new file mode 100644
index 0000000..869d9c9
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
+void __init i2c_register_default_devices(void)
+{
+	i2c_register_board_info(0, i2c_board_info,
+				ARRAY_SIZE(i2c_board_info));
+}
-- 
1.7.2.2
