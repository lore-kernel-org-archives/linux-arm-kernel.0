From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:37 +0530
Subject: [PATCH V2 17/69] ST SPEAr: Adding machine support for rtc-spear
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <e2cf9bba6b6d7bd899a127aa2736237f67e4dd3c.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |    1 +
 arch/arm/mach-spear13xx/spear13xx.c            |   19 +++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear3xx/spear300_evb.c          |    1 +
 arch/arm/mach-spear3xx/spear310_evb.c          |    1 +
 arch/arm/mach-spear3xx/spear320_evb.c          |    1 +
 arch/arm/mach-spear3xx/spear3xx.c              |   19 +++++++++++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c          |    1 +
 arch/arm/mach-spear6xx/spear6xx.c              |   19 +++++++++++++++++++
 11 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 5c0f042..bf032f6 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -30,6 +30,7 @@
 
 /* Add spear13xx family device structure declarations here */
 extern struct amba_device spear13xx_uart_device;
+extern struct platform_device spear13xx_rtc_device;
 extern struct sys_timer spear13xx_timer;
 
 /* Add spear1300 machine device structure declarations here */
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 9a83d61..2fce2ec 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -22,6 +22,7 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	&spear13xx_rtc_device,
 };
 
 static void __init spear1300_evb_init(void)
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 8e3cdb7..5de0fd9 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -37,6 +37,25 @@ struct amba_device spear13xx_uart_device = {
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
 /* Do spear13xx familiy common initialization part here */
 void __init spear13xx_init(void)
 {
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index d76ee98..408bb8d 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -33,6 +33,7 @@
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device gpio_device;
 extern struct amba_device uart_device;
+extern struct platform_device rtc_device;
 extern struct sys_timer spear3xx_timer;
 
 /* Add spear3xx family function declarations here */
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 3bb7fbc..392ee4a 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -44,6 +44,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&rtc_device,
 
 	/* spear300 specific devices */
 };
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 7dd93bd..15ca8fc 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -50,6 +50,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&rtc_device,
 
 	/* spear310 specific devices */
 	&plgpio_device,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 82f4e76..48155cc 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -48,6 +48,7 @@ static struct amba_device *amba_devs[] __initdata = {
 
 static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
+	&rtc_device,
 
 	/* spear320 specific devices */
 	&plgpio_device,
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 34de574..64147c9 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -54,6 +54,25 @@ struct amba_device uart_device = {
 	.irq = {IRQ_UART, NO_IRQ},
 };
 
+/* rtc device registration */
+static struct resource rtc_resources[] = {
+	{
+		.start = SPEAR3XX_ICM3_RTC_BASE,
+		.end = SPEAR3XX_ICM3_RTC_BASE + SZ_4K - 1,
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
 /* Do spear3xx familiy common initialization part here */
 void __init spear3xx_init(void)
 {
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index d6a04f2..674b16c 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -32,6 +32,7 @@
 extern struct amba_device clcd_device;
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
+extern struct platform_device rtc_device;
 extern struct sys_timer spear6xx_timer;
 
 /* Add spear6xx family function declarations here */
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index 88e69f4..861e83d 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -26,6 +26,7 @@ static struct amba_device *amba_devs[] __initdata = {
 };
 
 static struct platform_device *plat_devs[] __initdata = {
+	&rtc_device,
 };
 
 static void __init spear600_evb_init(void)
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index ebb504f..45bc4ec 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -121,6 +121,25 @@ struct amba_device gpio_device[] = {
 	}
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
