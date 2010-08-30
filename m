From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:53 +0530
Subject: [PATCH 26/74] ST SPEAr: Adding Watchdog support
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <8ef93bd8c369ea63d3ed6ac61ab9d310a56be6e3.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear13xx/clock.c               |    3 ++-
 arch/arm/mach-spear3xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear3xx/spear300_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear310_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear3xx.c             |   12 ++++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c         |    1 +
 arch/arm/mach-spear6xx/spear6xx.c             |   12 ++++++++++++
 9 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index c48b779..5280657 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -263,7 +263,8 @@ static struct clk gpt3_clk = {
 /* watch dog timer clock */
 static struct clk wdt_clk = {
 	.flags = ALWAYS_ENABLED,
-	.pclk = &apb_clk,
+	.pclk = &cpu_clk,
+	.div_factor = 2,
 	.recalc = &follow_parent,
 };
 
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 9317af8..91c0c09 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -33,6 +33,7 @@
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device gpio_device;
 extern struct amba_device uart_device;
+extern struct amba_device wdt_device;
 extern struct platform_device ehci_device;
 extern struct platform_device i2c_device;
 extern struct platform_device ohci0_device;
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index c948289..7bd8963 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -38,6 +38,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
 	&uart_device,
+	&wdt_device,
 
 	/* spear300 specific devices */
 	&clcd_device,
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 2a88cd2..cd076c9 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -45,6 +45,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
 	&uart_device,
+	&wdt_device,
 
 	/* spear310 specific devices */
 };
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index d0cfd96..7f7b5dd 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -42,6 +42,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&gpio_device,
 	&uart_device,
+	&wdt_device,
 
 	/* spear320 specific devices */
 	&clcd_device,
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index ab78396..b15fd27 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -54,6 +54,18 @@ struct amba_device uart_device = {
 	.irq = {IRQ_UART, NO_IRQ},
 };
 
+/* watchdog device registeration */
+struct amba_device wdt_device = {
+	.dev = {
+		.init_name = "wdt",
+	},
+	.res = {
+		.start = SPEAR3XX_ICM3_WDT_BASE,
+		.end = SPEAR3XX_ICM3_WDT_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
 /* i2c device registeration */
 static struct resource i2c_resources[] = {
 	{
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 8aee3ad..f885898 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -32,6 +32,7 @@
 extern struct amba_device clcd_device;
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
+extern struct amba_device wdt_device;
 extern struct platform_device ehci0_device;
 extern struct platform_device ehci1_device;
 extern struct platform_device i2c_device;
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index bd4be34..0eb5f50 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -24,6 +24,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	&gpio_device[2],
 	&uart_device[0],
 	&uart_device[1],
+	&wdt_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index e3313e6..4987597 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -118,6 +118,18 @@ struct amba_device gpio_device[] = {
 	}
 };
 
+/* watchdog device registeration */
+struct amba_device wdt_device = {
+	.dev = {
+		.init_name = "wdt",
+	},
+	.res = {
+		.start = SPEAR6XX_ICM3_WDT_BASE,
+		.end = SPEAR6XX_ICM3_WDT_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
 /* i2c device registeration */
 static struct resource i2c_resources[] = {
 	{
-- 
1.7.2.2
