From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:56:12 +0530
Subject: [PATCH V5 34/63] SPEAr320: Adding support for CAN
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <e1780204cdf01daaa0da1ab855f342a5193df493.1295499395.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    2 +
 arch/arm/mach-spear3xx/spear320.c             |   37 +++++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear320_evb.c         |    2 +
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index b45b85a..c373f6d 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -188,6 +188,8 @@ extern struct amba_device clcd_device;
 extern struct amba_device ssp_device[];
 extern struct amba_device uart1_device;
 extern struct amba_device uart2_device;
+extern struct platform_device can0_device;
+extern struct platform_device can1_device;
 extern struct platform_device i2c1_device;
 extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index e506203..3c90d47 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -473,6 +473,43 @@ struct amba_device uart2_device = {
 	.irq = {VIRQ_UART2, NO_IRQ},
 };
 
+/* CAN device registeration */
+static struct resource can0_resources[] = {
+	{
+		.start = SPEAR320_CAN0_BASE,
+		.end = SPEAR320_CAN0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
+	}, {
+		.start = VIRQ_CANU,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device can0_device = {
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
+		.start = VIRQ_CANL,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device can1_device = {
+	.name = "c_can_platform",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(can1_resources),
+	.resource = can1_resources,
+};
+
 /* i2c1 device registeration */
 static struct resource i2c1_resources[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 518802e..8c15571 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -65,6 +65,8 @@ static struct platform_device *plat_devs[] __initdata = {
 	&rtc_device,
 
 	/* spear320 specific devices */
+	&can0_device,
+	&can1_device,
 	&i2c1_device,
 	&plgpio_device,
 	&pwm_device,
-- 
1.7.3.4
