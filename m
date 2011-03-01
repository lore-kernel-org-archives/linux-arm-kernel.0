From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:29 +0530
Subject: [PATCH V6 01/17] ST SPEAr13xx: Added ARM PL061 GPIO Support
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <07f4182950e29b0710f317f2e0d7e03535bf1671.1298977727.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/include/mach/gpio.h    |   18 +++++++++++
 arch/arm/mach-spear13xx/include/mach/irqs.h    |   10 +++++-
 arch/arm/mach-spear13xx/spear1300_evb.c        |    2 +
 arch/arm/mach-spear13xx/spear1310_evb.c        |    2 +
 arch/arm/mach-spear13xx/spear13xx.c            |   38 ++++++++++++++++++++++++
 6 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index a75de93..de9de17 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -221,6 +221,7 @@ extern struct pmx_dev pmx_uart1_modem;
 #define SPEAR_GPT0_CHAN1_IRQ	IRQ_GPT0_TMR1
 
 /* Add spear13xx family device structure declarations here */
+extern struct amba_device spear13xx_gpio_device[];
 extern struct amba_device spear13xx_uart_device;
 extern struct sys_timer spear13xx_timer;
 
diff --git a/arch/arm/mach-spear13xx/include/mach/gpio.h b/arch/arm/mach-spear13xx/include/mach/gpio.h
index 43fa541..2f8ad23 100644
--- a/arch/arm/mach-spear13xx/include/mach/gpio.h
+++ b/arch/arm/mach-spear13xx/include/mach/gpio.h
@@ -16,4 +16,22 @@
 
 #include <plat/gpio.h>
 
+#define GPIO0_0			0
+#define GPIO0_1			1
+#define GPIO0_2			2
+#define GPIO0_3			3
+#define GPIO0_4			4
+#define GPIO0_5			5
+#define GPIO0_6			6
+#define GPIO0_7			7
+
+#define GPIO1_0			8
+#define GPIO1_1			9
+#define GPIO1_2			10
+#define GPIO1_3			11
+#define GPIO1_4			12
+#define GPIO1_5			13
+#define GPIO1_6			14
+#define GPIO1_7			15
+
 #endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
index c175175..c4f0c9d 100644
--- a/arch/arm/mach-spear13xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -123,6 +123,14 @@
 
 #define IRQ_GIC_END		(IRQ_SHPI_START + 128)
 
-#define NR_IRQS			IRQ_GIC_END
+#define VIRQ_START		IRQ_GIC_END
+
+/* GPIO pins virtual irqs */
+#define SPEAR_GPIO0_INT_BASE	(VIRQ_START + 0)
+#define SPEAR_GPIO1_INT_BASE	(SPEAR_GPIO0_INT_BASE + 8)
+#define SPEAR_GPIO_INT_END	(SPEAR_GPIO1_INT_BASE + 8)
+
+#define VIRQ_END		SPEAR_GPIO_INT_END
+#define NR_IRQS			VIRQ_END
 
 #endif /* __MACH_IRQS_H */
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 2e966cf..cba0fee 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -37,6 +37,8 @@ static struct pmx_dev *pmx_devs[] = {
 };
 
 static struct amba_device *amba_devs[] __initdata = {
+	&spear13xx_gpio_device[0],
+	&spear13xx_gpio_device[1],
 	&spear13xx_uart_device,
 };
 
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index 42625c8..62af911 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -44,6 +44,8 @@ static struct pmx_dev *pmx_devs[] = {
 
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear13xx specific devices */
+	&spear13xx_gpio_device[0],
+	&spear13xx_gpio_device[1],
 	&spear13xx_uart_device,
 
 	/* spear1310 specific devices */
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 7832c1a..35582a6 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/amba/pl061.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
 #include <asm/hardware/gic.h>
@@ -25,6 +26,43 @@
 #include <mach/irqs.h>
 
 /* Add spear13xx machines common devices here */
+/* gpio device registeration */
+static struct pl061_platform_data gpio_plat_data[] = {
+	{
+		.gpio_base	= 0,
+		.irq_base	= SPEAR_GPIO0_INT_BASE,
+	}, {
+		.gpio_base	= 8,
+		.irq_base	= SPEAR_GPIO1_INT_BASE,
+	},
+};
+
+struct amba_device spear13xx_gpio_device[] = {
+	{
+		.dev = {
+			.init_name = "gpio0",
+			.platform_data = &gpio_plat_data[0],
+		},
+		.res = {
+			.start = SPEAR13XX_GPIO0_BASE,
+			.end = SPEAR13XX_GPIO0_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_GPIO0, NO_IRQ},
+	}, {
+		.dev = {
+			.init_name = "gpio1",
+			.platform_data = &gpio_plat_data[1],
+		},
+		.res = {
+			.start = SPEAR13XX_GPIO1_BASE,
+			.end = SPEAR13XX_GPIO1_BASE + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+		.irq = {IRQ_GPIO1, NO_IRQ},
+	}
+};
+
 /* uart device registeration */
 struct amba_device spear13xx_uart_device = {
 	.dev = {
-- 
1.7.2.2
