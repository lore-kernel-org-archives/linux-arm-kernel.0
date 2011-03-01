From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:37 +0530
Subject: [PATCH V6 09/17] ST SPEAr: Adding machine support for rtc-spear
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <312adfc617f57a1bcd35cb598ef93f7651df0024.1298977728.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |    1 +
 arch/arm/mach-spear13xx/spear1310_evb.c        |    1 +
 arch/arm/mach-spear13xx/spear13xx.c            |   19 +++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear3xx/spear300_evb.c          |    1 +
 arch/arm/mach-spear3xx/spear310_evb.c          |    1 +
 arch/arm/mach-spear3xx/spear320_evb.c          |    1 +
 arch/arm/mach-spear3xx/spear3xx.c              |   19 +++++++++++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c          |    1 +
 arch/arm/mach-spear6xx/spear6xx.c              |   19 +++++++++++++++++++
 12 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index de9de17..b598236 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -223,6 +223,7 @@ extern struct pmx_dev pmx_uart1_modem;
 /* Add spear13xx family device structure declarations here */
 extern struct amba_device spear13xx_gpio_device[];
 extern struct amba_device spear13xx_uart_device;
+extern struct platform_device spear13xx_rtc_device;
 extern struct sys_timer spear13xx_timer;
 
 /* Add spear13xx family function declarations here */
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 4799ae1..796d04c 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -44,6 +44,7 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	&spear13xx_rtc_device,
 };
 
 #ifdef CONFIG_PCIEPORTBUS
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index 2e74879..1eea995 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -59,6 +59,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear13xx specific devices */
+	&spear13xx_rtc_device,
 
 	/* spear1310 specific devices */
 	&spear1310_can0_device,
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 6c2525a..e9ba888 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -76,6 +76,25 @@ struct amba_device spear13xx_uart_device = {
 	.irq = {IRQ_UART, NO_IRQ},
 };
 
+/* rtc device registration */
+static struct resource rtc_resources[] = {
+	{
+		.start = SPEAR13XX_RTC_BASE,
+		.end = SPEAR13XX_RTC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_RTC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear13xx_rtc_device = {
+	.name = "rtc-spear",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(rtc_resources),
+	.resource = rtc_resources,
+};
+
 #ifdef CONFIG_PCIEPORTBUS
 /* PCIE0 clock always needs to be enabled if any of the three PCIE port
  * have to be used. So call this function from the board initilization
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index e8dfbb5..73f3f3b 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -34,6 +34,7 @@
 extern struct amba_device spear3xx_gpio_device;
 extern struct amba_device spear3xx_uart_device;
 extern struct amba_device spear3xx_wdt_device;
+extern struct platform_device spear3xx_rtc_device;
 extern struct sys_timer spear3xx_timer;
 
 /* Add spear3xx family function declarations here */
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index f4fd6db..e4a9a4f 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -44,6 +44,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&spear3xx_rtc_device,
 
 	/* spear300 specific devices */
 };
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 8d5becb..97c9551 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -87,6 +87,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&spear3xx_rtc_device,
 
 	/* spear310 specific devices */
 	&spear310_emi_nor_device,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 8addd5f..17248f4 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -81,6 +81,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&spear3xx_rtc_device,
 
 	/* spear320 specific devices */
 	&spear320_can0_device,
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index b07c659..6e8bcd0 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -66,6 +66,25 @@ struct amba_device spear3xx_wdt_device = {
 	},
 };
 
+/* rtc device registration */
+static struct resource rtc_resources[] = {
+	{
+		.start = SPEAR3XX_ICM3_RTC_BASE,
+		.end = SPEAR3XX_ICM3_RTC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = SPEAR3XX_IRQ_BASIC_RTC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear3xx_rtc_device = {
+	.name = "rtc-spear",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(rtc_resources),
+	.resource = rtc_resources,
+};
+
 /* Do spear3xx familiy common initialization part here */
 void __init spear3xx_init(void)
 {
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 0d17e65..9b7a758 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -32,6 +32,7 @@
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
 extern struct amba_device wdt_device;
+extern struct platform_device rtc_device;
 extern struct sys_timer spear6xx_timer;
 
 /* Add spear6xx family function declarations here */
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index 6730868..2b8cd87 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -26,6 +26,7 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	&rtc_device,
 };
 
 static void __init spear600_evb_init(void)
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 3842545..f976377 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -111,6 +111,25 @@ struct amba_device wdt_device = {
 	},
 };
 
+/* rtc device registration */
+static struct resource rtc_resources[] = {
+	{
+		.start = SPEAR6XX_ICM3_RTC_BASE,
+		.end = SPEAR6XX_ICM3_RTC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_BASIC_RTC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device rtc_device = {
+	.name = "rtc-spear",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(rtc_resources),
+	.resource = rtc_resources,
+};
+
 /* This will add devices, and do machine specific tasks */
 void __init spear6xx_init(void)
 {
-- 
1.7.2.2
