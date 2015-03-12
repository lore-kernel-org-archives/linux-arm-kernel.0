From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 12 Mar 2015 10:06:28 +0200
Subject: [RESEND 4/7] ARM: davinci: devices-da8xx: Add support for McASP2 on
 da830
In-Reply-To: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
References: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1426147591-31764-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

da830 has three McASP blocks.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/asp.h           |  7 ++++++
 arch/arm/mach-davinci/devices-da8xx.c | 41 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/mach-davinci/asp.h b/arch/arm/mach-davinci/asp.h
index d9b2acd12393..1128e1d8e4b4 100644
--- a/arch/arm/mach-davinci/asp.h
+++ b/arch/arm/mach-davinci/asp.h
@@ -21,6 +21,9 @@
 /* Bases of da830 McASP1 register banks */
 #define DAVINCI_DA830_MCASP1_REG_BASE	0x01D04000
 
+/* Bases of da830 McASP2 register banks */
+#define DAVINCI_DA830_MCASP2_REG_BASE	0x01D08000
+
 /* EDMA channels of dm644x and dm355 */
 #define DAVINCI_DMA_ASP0_TX	2
 #define DAVINCI_DMA_ASP0_RX	3
@@ -40,6 +43,10 @@
 #define DAVINCI_DA830_DMA_MCASP1_AREVT	2
 #define DAVINCI_DA830_DMA_MCASP1_AXEVT	3
 
+/* EDMA channels of da830 McASP2 */
+#define DAVINCI_DA830_DMA_MCASP2_AREVT	4
+#define DAVINCI_DA830_DMA_MCASP2_AXEVT	5
+
 /* Interrupts */
 #define DAVINCI_ASP0_RX_INT	IRQ_MBRINT
 #define DAVINCI_ASP0_TX_INT	IRQ_MBXINT
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index fdc3219ba684..ddfdd820e6f2 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -489,6 +489,41 @@ static struct platform_device da830_mcasp1_device = {
 	.resource	= da830_mcasp1_resources,
 };
 
+static struct resource da830_mcasp2_resources[] = {
+	{
+		.name	= "mpu",
+		.start	= DAVINCI_DA830_MCASP2_REG_BASE,
+		.end	= DAVINCI_DA830_MCASP2_REG_BASE + (SZ_1K * 12) - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	/* TX event */
+	{
+		.name	= "tx",
+		.start	= DAVINCI_DA830_DMA_MCASP2_AXEVT,
+		.end	= DAVINCI_DA830_DMA_MCASP2_AXEVT,
+		.flags	= IORESOURCE_DMA,
+	},
+	/* RX event */
+	{
+		.name	= "rx",
+		.start	= DAVINCI_DA830_DMA_MCASP2_AREVT,
+		.end	= DAVINCI_DA830_DMA_MCASP2_AREVT,
+		.flags	= IORESOURCE_DMA,
+	},
+	{
+		.name	= "common",
+		.start	= IRQ_DA8XX_MCASPINT,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device da830_mcasp2_device = {
+	.name		= "davinci-mcasp",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(da830_mcasp2_resources),
+	.resource	= da830_mcasp2_resources,
+};
+
 static struct resource da850_mcasp_resources[] = {
 	{
 		.name	= "mpu",
@@ -539,6 +574,12 @@ void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
 			return;
 		pdev = &da830_mcasp1_device;
 		break;
+	case 2:
+		/* Valid for DA830/OMAP-L137 only */
+		if (!cpu_is_davinci_da830())
+			return;
+		pdev = &da830_mcasp2_device;
+		break;
 	default:
 		return;
 	}
-- 
2.3.0
