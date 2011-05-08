From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  8 May 2011 16:15:30 +0200
Subject: [PATCH 03/14] [orion] Consolidate the creation of the RTC platform
	data.
In-Reply-To: <1304864141-1121-1-git-send-email-andrew@lunn.ch>
References: <1304864141-1121-1-git-send-email-andrew@lunn.ch>
Message-ID: <1304864141-1121-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/common.c                |   13 +------------
 arch/arm/mach-kirkwood/common.c            |    8 +-------
 arch/arm/mach-kirkwood/include/mach/irqs.h |    1 +
 arch/arm/plat-orion/common.c               |   18 ++++++++++++++++++
 arch/arm/plat-orion/include/plat/common.h  |    3 +++
 5 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index fffa92e..8a414cb 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -205,20 +205,9 @@ void __init dove_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 /*****************************************************************************
  * SoC RTC
  ****************************************************************************/
-static struct resource dove_rtc_resource[] = {
-	{
-		.start	= DOVE_RTC_PHYS_BASE,
-		.end	= DOVE_RTC_PHYS_BASE + 32 - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_DOVE_RTC,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
 void __init dove_rtc_init(void)
 {
-	platform_device_register_simple("rtc-mv", -1, dove_rtc_resource, 2);
+	orion_rtc_init(DOVE_RTC_PHYS_BASE, IRQ_DOVE_RTC);
 }
 
 /*****************************************************************************
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 8cdf9f9..f6868fc 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -326,15 +326,9 @@ void __init kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts,
 /*****************************************************************************
  * SoC RTC
  ****************************************************************************/
-static struct resource kirkwood_rtc_resource = {
-	.start	= RTC_PHYS_BASE,
-	.end	= RTC_PHYS_BASE + SZ_16 - 1,
-	.flags	= IORESOURCE_MEM,
-};
-
 static void __init kirkwood_rtc_init(void)
 {
-	platform_device_register_simple("rtc-mv", -1, &kirkwood_rtc_resource, 1);
+	orion_rtc_init(RTC_PHYS_BASE, IRQ_KIRKWOOD_RTC);
 }
 
 
diff --git a/arch/arm/mach-kirkwood/include/mach/irqs.h b/arch/arm/mach-kirkwood/include/mach/irqs.h
index 9da2eb5..2bf8161 100644
--- a/arch/arm/mach-kirkwood/include/mach/irqs.h
+++ b/arch/arm/mach-kirkwood/include/mach/irqs.h
@@ -51,6 +51,7 @@
 #define IRQ_KIRKWOOD_GPIO_HIGH_16_23	41
 #define IRQ_KIRKWOOD_GE00_ERR	46
 #define IRQ_KIRKWOOD_GE01_ERR	47
+#define IRQ_KIRKWOOD_RTC        53
 
 /*
  * KIRKWOOD General Purpose Pins
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 4eac532..d065591 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -169,3 +169,21 @@ void __init orion_uart3_init(unsigned int membase,
 	uart_complete(&orion_uart3, orion_uart3_data, orion_uart3_resources,
 		      membase, mapbase, irq, uartclk);
 }
+
+/*****************************************************************************
+ * SoC RTC
+ ****************************************************************************/
+static struct resource orion_rtc_resource[2];
+
+void __init orion_rtc_init(unsigned long mapbase,
+			   unsigned long irq)
+{
+	orion_rtc_resource[0].start = mapbase;
+	orion_rtc_resource[0].end = mapbase + SZ_32 - 1;
+	orion_rtc_resource[0].flags = IORESOURCE_MEM;
+	orion_rtc_resource[1].start = irq;
+	orion_rtc_resource[1].end = irq;
+	orion_rtc_resource[1].flags = IORESOURCE_IRQ;
+
+	platform_device_register_simple("rtc-mv", -1, orion_rtc_resource, 2);
+}
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index d57e3bb..7cba5e8 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -30,5 +30,8 @@ void __init orion_uart3_init(unsigned int membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
 			     unsigned int uartclk);
+
+void __init orion_rtc_init(unsigned long mapbase,
+			   unsigned long irq);
 #endif
 
-- 
1.7.4.4
