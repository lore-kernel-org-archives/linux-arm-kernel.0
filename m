From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:33 +0530
Subject: [PATCH V6 05/17] ST SPEAr: Adding Watchdog support on spear3xx &
	spear6xx machines
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <8adbd36c9bff2532a5a4f6dd26dcf93f393562ca.1298977728.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear3xx/spear300_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear310_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear3xx.c             |   12 ++++++++++++
 arch/arm/mach-spear6xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c         |    1 +
 arch/arm/mach-spear6xx/spear6xx.c             |   12 ++++++++++++
 8 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index f43d104..6d4db44 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -33,6 +33,7 @@
 /* Add spear3xx family device structure declarations here */
 extern struct amba_device spear3xx_gpio_device;
 extern struct amba_device spear3xx_uart_device;
+extern struct amba_device spear3xx_wdt_device;
 extern struct sys_timer spear3xx_timer;
 
 /* Add spear3xx family function declarations here */
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 69006f6..f4fd6db 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -36,6 +36,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&spear3xx_gpio_device,
 	&spear3xx_uart_device,
+	&spear3xx_wdt_device,
 
 	/* spear300 specific devices */
 	&spear300_gpio1_device,
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index f6832c4..9c1b7ca 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -44,6 +44,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&spear3xx_gpio_device,
 	&spear3xx_uart_device,
+	&spear3xx_wdt_device,
 
 	/* spear310 specific devices */
 };
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 6190660..7b12f0c 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -41,6 +41,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&spear3xx_gpio_device,
 	&spear3xx_uart_device,
+	&spear3xx_wdt_device,
 
 	/* spear320 specific devices */
 };
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index c32a186..b07c659 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -54,6 +54,18 @@ struct amba_device spear3xx_uart_device = {
 	.irq = {SPEAR3XX_IRQ_UART, NO_IRQ},
 };
 
+/* watchdog device registeration */
+struct amba_device spear3xx_wdt_device = {
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
 /* Do spear3xx familiy common initialization part here */
 void __init spear3xx_init(void)
 {
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index 183f023..0d17e65 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -31,6 +31,7 @@
 /* Add spear6xx family device structure declarations here */
 extern struct amba_device gpio_device[];
 extern struct amba_device uart_device[];
+extern struct amba_device wdt_device;
 extern struct sys_timer spear6xx_timer;
 
 /* Add spear6xx family function declarations here */
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index f19cefe..6730868 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -22,6 +22,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	&gpio_device[2],
 	&uart_device[0],
 	&uart_device[1],
+	&wdt_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index e0f6628..3842545 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -99,6 +99,18 @@ struct amba_device gpio_device[] = {
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
 /* This will add devices, and do machine specific tasks */
 void __init spear6xx_init(void)
 {
-- 
1.7.2.2
