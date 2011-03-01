From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:35 +0530
Subject: [PATCH V6 07/17] ST SPEAr320: Adding support for CAN
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <79593af8e6b1ee33a7ba137300eaaa374b7581bd.1298977728.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    2 +
 arch/arm/mach-spear3xx/spear320.c             |   37 +++++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c         |    2 +
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 8925b7b..e8dfbb5 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -175,6 +175,8 @@ void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 /* Add spear320 machine device structure declarations here */
 extern struct amba_device spear320_uart1_device;
 extern struct amba_device spear320_uart2_device;
+extern struct platform_device spear320_can0_device;
+extern struct platform_device spear320_can1_device;
 extern struct platform_device spear320_plgpio_device;
 extern struct platform_device spear320_pwm_device;
 
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 77089a7..3f058c7 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -738,6 +738,43 @@ struct amba_device spear320_uart2_device = {
 	.irq = {SPEAR320_VIRQ_UART2, NO_IRQ},
 };
 
+/* CAN device registeration */
+static struct resource can0_resources[] = {
+	{
+		.start = SPEAR320_CAN0_BASE,
+		.end = SPEAR320_CAN0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
+	}, {
+		.start = SPEAR320_VIRQ_CANU,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear320_can0_device = {
+	.name = "c_can_platform",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(can0_resources),
+	.resource = can0_resources,
+};
+
+static struct resource can1_resources[] = {
+	{
+		.start = SPEAR320_CAN1_BASE,
+		.end = SPEAR320_CAN1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
+	}, {
+		.start = SPEAR320_VIRQ_CANL,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear320_can1_device = {
+	.name = "c_can_platform",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(can1_resources),
+	.resource = can1_resources,
+};
+
 /* plgpio device registeration */
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index ebc4bb9..f2c3cd3 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -52,6 +52,8 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 
 	/* spear320 specific devices */
+	&spear320_can0_device,
+	&spear320_can1_device,
 	&spear320_plgpio_device,
 	&spear320_pwm_device,
 };
-- 
1.7.2.2
