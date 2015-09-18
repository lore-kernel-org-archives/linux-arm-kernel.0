From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 18 Sep 2015 03:19:44 +0200
Subject: [PATCH v3 21/26] ARM: pxa: magician: Add support for PXA27x UDC
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Message-ID: <55FB66B0.6070405@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A PXA27x SoC supports USB device mode, this patch adds support for that.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 490d79f..76f8399 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -54,6 +54,10 @@
 
 #include <linux/regulator/max1586.h>
 
+#include <linux/platform_data/pxa2xx_udc.h>
+#include <mach/udc.h>
+#include <mach/pxa27x-udc.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -582,6 +586,23 @@ static struct platform_device pasic3 = {
  * PXA UDC
  */
 
+static void magician_udc_command(int cmd)
+{
+	if (cmd == PXA2XX_UDC_CMD_CONNECT)
+		UP2OCR |= UP2OCR_DPPUE | UP2OCR_DPPUBE;
+	else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
+		UP2OCR &= ~(UP2OCR_DPPUE | UP2OCR_DPPUBE);
+}
+
+static struct pxa2xx_udc_mach_info magician_udc_info __initdata = {
+	.udc_command		= magician_udc_command,
+	.gpio_pullup		= GPIO27_MAGICIAN_USBC_PUEN,
+};
+
+/*
+ * USB device VUSB detection
+ */
+
 static struct resource gpio_vbus_resource = {
 	.flags	= IORESOURCE_IRQ,
 	.start	= IRQ_MAGICIAN_VBUS,
@@ -1120,6 +1141,7 @@ static void __init magician_init(void)
 
 	pxa_set_mci_info(&magician_mci_info);
 	pxa_set_ohci_info(&magician_ohci_info);
+	pxa_set_udc_info(&magician_udc_info);
 
 	/* Check LCD type we have */
 	cpld = ioremap_nocache(PXA_CS3_PHYS, 0x1000);
-- 
1.7.12.1
