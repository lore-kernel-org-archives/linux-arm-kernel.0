From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 14:59:22 +1200
Subject: [PATCH v3 13/23] at91: Make PWM device common
In-Reply-To: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1304045972-19319-14-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the individual PWM code for each at91 variant with a single
implementation in devices.c

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/at91cap9_devices.c    |   56 +++++-------------------------
 arch/arm/mach-at91/at91sam9263_devices.c |   55 +++++------------------------
 arch/arm/mach-at91/at91sam9g45_devices.c |   55 +++++------------------------
 arch/arm/mach-at91/at91sam9rl_devices.c  |   55 +++++------------------------
 arch/arm/mach-at91/devices.c             |   55 +++++++++++++++++++++++++++++
 arch/arm/mach-at91/devices.h             |    7 ++++
 6 files changed, 98 insertions(+), 185 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 754a562..30889ec 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -302,56 +302,17 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
  *  PWM
  * --------------------------------------------------------------------*/
 
-#if defined(CONFIG_ATMEL_PWM)
-static u32 pwm_mask;
-
-static struct resource pwm_resources[] = {
-	[0] = {
-		.start	= AT91CAP9_BASE_PWMC,
-		.end	= AT91CAP9_BASE_PWMC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91CAP9_ID_PWMC,
-		.end	= AT91CAP9_ID_PWMC,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_pwm device_pwm __initdata = {
+	.mmio_base	= AT91CAP9_BASE_PWMC,
+	.irq		= AT91CAP9_ID_PWMC,
+	.pwm_pins	= {
+		{AT91_PIN_PB19, AT91_PIN_PERIPH_A, 1, 0, 0},
+		{AT91_PIN_PB8,  AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PC29, AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PA11, AT91_PIN_PERIPH_B, 1, 0, 0},
 	},
 };
 
-static struct platform_device at91cap9_pwm0_device = {
-	.name	= "atmel_pwm",
-	.id	= -1,
-	.dev	= {
-		.platform_data		= &pwm_mask,
-	},
-	.resource	= pwm_resources,
-	.num_resources	= ARRAY_SIZE(pwm_resources),
-};
-
-void __init at91_add_device_pwm(u32 mask)
-{
-	if (mask & (1 << AT91_PWM0))
-		at91_set_A_periph(AT91_PIN_PB19, 1);	/* enable PWM0 */
-
-	if (mask & (1 << AT91_PWM1))
-		at91_set_B_periph(AT91_PIN_PB8, 1);	/* enable PWM1 */
-
-	if (mask & (1 << AT91_PWM2))
-		at91_set_B_periph(AT91_PIN_PC29, 1);	/* enable PWM2 */
-
-	if (mask & (1 << AT91_PWM3))
-		at91_set_B_periph(AT91_PIN_PA11, 1);	/* enable PWM3 */
-
-	pwm_mask = mask;
-
-	platform_device_register(&at91cap9_pwm0_device);
-}
-#else
-void __init at91_add_device_pwm(u32 mask) {}
-#endif
-
-
-
 /* --------------------------------------------------------------------
  *  AC97
  * -------------------------------------------------------------------- */
@@ -679,6 +640,7 @@ static struct at91_device_table at91cap9_device_table __initdata = {
 	.uart[0]	= &device_uart0,
 	.uart[1]	= &device_uart1,
 	.uart[2]	= &device_uart2,
+	.pwm		= &device_pwm,
 };
 
 void __init at91cap9_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 1bc3da2..ff490bc 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -536,55 +536,17 @@ static struct at91_dev_table_rtt device_rtt1 __initdata = {
  *  PWM
  * --------------------------------------------------------------------*/
 
-#if defined(CONFIG_ATMEL_PWM)
-static u32 pwm_mask;
-
-static struct resource pwm_resources[] = {
-	[0] = {
-		.start	= AT91SAM9263_BASE_PWMC,
-		.end	= AT91SAM9263_BASE_PWMC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9263_ID_PWMC,
-		.end	= AT91SAM9263_ID_PWMC,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_pwm device_pwm __initdata = {
+	.mmio_base	= AT91SAM9263_BASE_PWMC,
+	.irq		= AT91SAM9263_ID_PWMC,
+	.pwm_pins	= {
+		{AT91_PIN_PB7,  AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PB8,  AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PC29, AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PB29, AT91_PIN_PERIPH_B, 1, 0, 0},
 	},
 };
 
-static struct platform_device at91sam9263_pwm0_device = {
-	.name	= "atmel_pwm",
-	.id	= -1,
-	.dev	= {
-		.platform_data		= &pwm_mask,
-	},
-	.resource	= pwm_resources,
-	.num_resources	= ARRAY_SIZE(pwm_resources),
-};
-
-void __init at91_add_device_pwm(u32 mask)
-{
-	if (mask & (1 << AT91_PWM0))
-		at91_set_B_periph(AT91_PIN_PB7, 1);	/* enable PWM0 */
-
-	if (mask & (1 << AT91_PWM1))
-		at91_set_B_periph(AT91_PIN_PB8, 1);	/* enable PWM1 */
-
-	if (mask & (1 << AT91_PWM2))
-		at91_set_B_periph(AT91_PIN_PC29, 1);	/* enable PWM2 */
-
-	if (mask & (1 << AT91_PWM3))
-		at91_set_B_periph(AT91_PIN_PB29, 1);	/* enable PWM3 */
-
-	pwm_mask = mask;
-
-	platform_device_register(&at91sam9263_pwm0_device);
-}
-#else
-void __init at91_add_device_pwm(u32 mask) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
@@ -787,6 +749,7 @@ static struct at91_device_table at91sam9263_device_table __initdata = {
 	.uart[0]	= &device_uart0,
 	.uart[1]	= &device_uart1,
 	.uart[2]	= &device_uart2,
+	.pwm		= &device_pwm,
 };
 
 void __init at91sam9263_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index be9435b..17eb984 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -569,55 +569,17 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
  *  PWM
  * --------------------------------------------------------------------*/
 
-#if defined(CONFIG_ATMEL_PWM) || defined(CONFIG_ATMEL_PWM_MODULE)
-static u32 pwm_mask;
-
-static struct resource pwm_resources[] = {
-	[0] = {
-		.start	= AT91SAM9G45_BASE_PWMC,
-		.end	= AT91SAM9G45_BASE_PWMC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9G45_ID_PWMC,
-		.end	= AT91SAM9G45_ID_PWMC,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_pwm device_pwm __initdata = {
+	.mmio_base	= AT91SAM9G45_BASE_PWMC,
+	.irq		= AT91SAM9G45_ID_PWMC,
+	.pwm_pins	= {
+		{AT91_PIN_PD24, AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PD31, AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PD26, AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PD0,  AT91_PIN_PERIPH_B, 1, 0, 0},
 	},
 };
 
-static struct platform_device at91sam9g45_pwm0_device = {
-	.name	= "atmel_pwm",
-	.id	= -1,
-	.dev	= {
-		.platform_data		= &pwm_mask,
-	},
-	.resource	= pwm_resources,
-	.num_resources	= ARRAY_SIZE(pwm_resources),
-};
-
-void __init at91_add_device_pwm(u32 mask)
-{
-	if (mask & (1 << AT91_PWM0))
-		at91_set_B_periph(AT91_PIN_PD24, 1);	/* enable PWM0 */
-
-	if (mask & (1 << AT91_PWM1))
-		at91_set_B_periph(AT91_PIN_PD31, 1);	/* enable PWM1 */
-
-	if (mask & (1 << AT91_PWM2))
-		at91_set_B_periph(AT91_PIN_PD26, 1);	/* enable PWM2 */
-
-	if (mask & (1 << AT91_PWM3))
-		at91_set_B_periph(AT91_PIN_PD0, 1);	/* enable PWM3 */
-
-	pwm_mask = mask;
-
-	platform_device_register(&at91sam9g45_pwm0_device);
-}
-#else
-void __init at91_add_device_pwm(u32 mask) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
@@ -836,6 +798,7 @@ static struct at91_device_table at91sam9g45_device_table __initdata = {
 	.uart[1]	= &device_uart1,
 	.uart[2]	= &device_uart2,
 	.uart[3]	= &device_uart3,
+	.pwm		= &device_pwm,
 };
 
 void __init at91sam9g45_init_devices(void)
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 8f43d23..76aa9b6 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -447,55 +447,17 @@ static struct at91_dev_table_rtt device_rtt __initdata = {
  *  PWM
  * --------------------------------------------------------------------*/
 
-#if defined(CONFIG_ATMEL_PWM)
-static u32 pwm_mask;
-
-static struct resource pwm_resources[] = {
-	[0] = {
-		.start	= AT91SAM9RL_BASE_PWMC,
-		.end	= AT91SAM9RL_BASE_PWMC + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AT91SAM9RL_ID_PWMC,
-		.end	= AT91SAM9RL_ID_PWMC,
-		.flags	= IORESOURCE_IRQ,
+static struct at91_dev_table_pwm device_pwm __initdata = {
+	.mmio_base	= AT91SAM9RL_BASE_PWMC,
+	.irq		= AT91SAM9RL_ID_PWMC,
+	.pwm_pins	= {
+		{AT91_PIN_PB8, AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PB9, AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PD5, AT91_PIN_PERIPH_B, 1, 0, 0},
+		{AT91_PIN_PD8, AT91_PIN_PERIPH_B, 1, 0, 0},
 	},
 };
 
-static struct platform_device at91sam9rl_pwm0_device = {
-	.name	= "atmel_pwm",
-	.id	= -1,
-	.dev	= {
-		.platform_data		= &pwm_mask,
-	},
-	.resource	= pwm_resources,
-	.num_resources	= ARRAY_SIZE(pwm_resources),
-};
-
-void __init at91_add_device_pwm(u32 mask)
-{
-	if (mask & (1 << AT91_PWM0))
-		at91_set_B_periph(AT91_PIN_PB8, 1);	/* enable PWM0 */
-
-	if (mask & (1 << AT91_PWM1))
-		at91_set_B_periph(AT91_PIN_PB9, 1);	/* enable PWM1 */
-
-	if (mask & (1 << AT91_PWM2))
-		at91_set_B_periph(AT91_PIN_PD5, 1);	/* enable PWM2 */
-
-	if (mask & (1 << AT91_PWM3))
-		at91_set_B_periph(AT91_PIN_PD8, 1);	/* enable PWM3 */
-
-	pwm_mask = mask;
-
-	platform_device_register(&at91sam9rl_pwm0_device);
-}
-#else
-void __init at91_add_device_pwm(u32 mask) {}
-#endif
-
-
 /* --------------------------------------------------------------------
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
@@ -711,6 +673,7 @@ static struct at91_device_table at91sam9rl_device_table __initdata = {
 	.uart[1]	= &device_uart1,
 	.uart[2]	= &device_uart2,
 	.uart[3]	= &device_uart3,
+	.pwm		= &device_pwm,
 };
 
 void __init at91sam9rl_init_devices(void)
diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
index b759187..a8eb0bb 100644
--- a/arch/arm/mach-at91/devices.c
+++ b/arch/arm/mach-at91/devices.c
@@ -1300,6 +1300,61 @@ void __init at91_set_serial_console(unsigned portnr) {}
 void __init at91_add_device_serial(void) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  PWM
+ * --------------------------------------------------------------------*/
+
+#if defined(CONFIG_ATMEL_PWM)
+static u32 pwm_mask;
+
+static struct resource pwm_resources[] = {
+	[0] = {
+		.end	= SZ_16K,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91_pwm_device = {
+	.name	= "atmel_pwm",
+	.id	= -1,
+	.dev	= {
+		.platform_data		= &pwm_mask,
+	},
+	.resource	= pwm_resources,
+	.num_resources	= ARRAY_SIZE(pwm_resources),
+};
+
+void __init at91_add_device_pwm(u32 mask)
+{
+	struct at91_dev_table_pwm *info = devices->pwm;
+
+	BUG_ON(!info);
+	init_resource_mem(&pwm_resources[0], info->mmio_base);
+	init_resource_irq(&pwm_resources[1], info->irq);
+
+	if (mask & (1 << AT91_PWM0))
+		at91_config_pins(&info->pwm_pins[0], 1); /* enable PWM0 */
+
+	if (mask & (1 << AT91_PWM1))
+		at91_config_pins(&info->pwm_pins[1], 1); /* enable PWM1 */
+
+	if (mask & (1 << AT91_PWM2))
+		at91_config_pins(&info->pwm_pins[2], 1); /* enable PWM2 */
+
+	if (mask & (1 << AT91_PWM3))
+		at91_config_pins(&info->pwm_pins[3], 1); /* enable PWM3 */
+
+	pwm_mask = mask;
+
+	platform_device_register(&at91_pwm_device);
+}
+#else
+void __init at91_add_device_pwm(u32 mask) {}
+#endif
+
 static int __init at91_add_standard_devices(void)
 {
 	at91_add_device_tc();
diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
index c535f58..52563be 100644
--- a/arch/arm/mach-at91/devices.h
+++ b/arch/arm/mach-at91/devices.h
@@ -122,6 +122,12 @@ struct at91_dev_table_uart {
 	struct at91_pin_config	dsr_pin;
 };
 
+struct at91_dev_table_pwm {
+	unsigned		mmio_base;
+	int			irq;
+	struct at91_pin_config	pwm_pins[4];
+};
+
 struct at91_device_table {
 	struct at91_dev_table_ethernet		*ethernet;
 	struct at91_dev_table_usb_ohci		*usbh_ohci;
@@ -135,6 +141,7 @@ struct at91_device_table {
 	struct at91_dev_table_rtt		*rtt[2];
 	struct at91_dev_table_uart		*dbgu;
 	struct at91_dev_table_uart		*uart[6];
+	struct at91_dev_table_pwm		*pwm;
 };
 
 extern void __init at91_init_devices(struct at91_device_table *device_table);
-- 
1.7.0.4
