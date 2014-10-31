From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Oct 2014 21:45:58 +0100
Subject: [PATCH 1/2] ARM: at91: rm9200 add system timer resources to watchdog
Message-ID: <1414788359-15759-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to make the watchdog driver independent from the mach/ includes, pass
the system timer register space as a resource.

Also, change the name to avoid conflicting with the at91sam9 watchdog driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91rm9200_devices.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 74f1eaf97801..4add0481adab 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -719,10 +719,19 @@ static void __init at91_add_device_rtc(void) {}
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_AT91RM9200_WATCHDOG) || defined(CONFIG_AT91RM9200_WATCHDOG_MODULE)
+static struct resource wdt_resources[] = {
+	[0] = {
+		.start	= AT91RM9200_BASE_ST,
+		.end	= AT91RM9200_BASE_ST + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static struct platform_device at91rm9200_wdt_device = {
-	.name		= "at91_wdt",
+	.name		= "at91rm9200_wdt",
 	.id		= -1,
-	.num_resources	= 0,
+	.resource	= wdt_resources,
+	.num_resources	= 1,
 };
 
 static void __init at91_add_device_watchdog(void)
-- 
2.1.0
