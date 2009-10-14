From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 14 Oct 2009 09:20:23 +0200
Subject: [PATCH 06/10] [ARM] pxa/cm-x300: enable USB port 2 for PXA300
In-Reply-To: <cover.1255504387.git.mike@compulab.co.il>
References: <cover.1255504387.git.mike@compulab.co.il>
Message-ID: <82bdd7986c7ccde00b7b0efb4f33c68d152735f8.1255504387.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Grinberg <grinberg@compulab.co.il>

Port 2 requires setting of UP2OCR register to function as USB host.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 890c9d4..544758c 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -36,6 +36,7 @@
 #include <asm/setup.h>
 
 #include <mach/pxa300.h>
+#include <mach/pxa27x-udc.h>
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
 #include <mach/ohci.h>
@@ -437,9 +438,19 @@ static inline void cm_x300_init_mmc(void) {}
 #endif
 
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+static int cm_x300_ohci_init(struct device *dev)
+{
+	if (cpu_is_pxa300())
+		UP2OCR = UP2OCR_HXS
+			| UP2OCR_HXOE | UP2OCR_DMPDE | UP2OCR_DPPDE;
+
+	return 0;
+}
+
 static struct pxaohci_platform_data cm_x300_ohci_platform_data = {
 	.port_mode	= PMM_PERPORT_MODE,
-	.flags		= ENABLE_PORT1 | ENABLE_PORT2 | POWER_CONTROL_LOW,
+	.flags		= ENABLE_PORT_ALL | POWER_CONTROL_LOW,
+	.init		= cm_x300_ohci_init,
 };
 
 static void __init cm_x300_init_ohci(void)
-- 
1.6.0.6
