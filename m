From: dhdang@apm.com (Duc Dang)
Date: Fri,  7 Aug 2015 18:03:36 -0700
Subject: [PATCH v4 2/2] usb: Add support for ACPI identification to
 xhci-platform
In-Reply-To: <07fb19170aa7c027f44af634aac7e7918daac7cd.1438994178.git.dhdang@apm.com>
References: <07fb19170aa7c027f44af634aac7e7918daac7cd.1438994178.git.dhdang@apm.com>
Message-ID: <5e302acb5b03c9bf61ecfb9b5b37e8b3b520bed9.1438994178.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the methods to let ACPI identify the need to use
xhci-platform. Change the Kconfig files so the
xhci-plat.o file is selectable during kernel config.

This has been tested on an ARM64 machine with platform XHCI, an
x86_64 machine with XHCI, and an x86_64 machine without XHCI.
There were no regressions or error messages on the machines
without platform XHCI.

[dhdang: regenerate the patch over 4.2-rc5]
Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
Signed-off-by: Duc Dang <dhdang@apm.com>

---
Changes from v3:
	Regenerate the patch over 4.2-rc5
	No code change

Changes from v2
	Replaced tristate with a boolean as the driver doesn't
		compile as a module
	Correct --help-- to ---help---

Changes from v1
	Renamed from "add support for APM X-Gene to xhci-platform"
	Removed changes to arm64/Kconfig
	Made CONFIG_USB_XHCI_PLATFORM a user selectable config option

 drivers/usb/host/Kconfig     |  7 ++++++-
 drivers/usb/host/xhci-plat.c | 11 +++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 8afc3c1..96231ee 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -32,7 +32,12 @@ config USB_XHCI_PCI
        default y
 
 config USB_XHCI_PLATFORM
-	tristate
+	tristate "xHCI platform driver support"
+	---help---
+	  Say 'Y' to enable the support for the xHCI host controller
+	  as a platform device. Many ARM SoCs provide USB this way.
+
+	  If unsure, say 'Y'.
 
 config USB_XHCI_MVEBU
 	tristate "xHCI support for Marvell Armada 375/38x"
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 5d03f8b..14b40d2 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -19,6 +19,7 @@
 #include <linux/usb/phy.h>
 #include <linux/slab.h>
 #include <linux/usb/xhci_pdriver.h>
+#include <linux/acpi.h>
 
 #include "xhci.h"
 #include "xhci-mvebu.h"
@@ -262,6 +263,15 @@ static const struct of_device_id usb_xhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id usb_xhci_acpi_match[] = {
+	/* APM X-Gene USB Controller */
+	{ "PNP0D10", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
+#endif
+
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
@@ -269,6 +279,7 @@ static struct platform_driver usb_xhci_driver = {
 		.name = "xhci-hcd",
 		.pm = DEV_PM_OPS,
 		.of_match_table = of_match_ptr(usb_xhci_of_match),
+		.acpi_match_table = ACPI_PTR(usb_xhci_acpi_match),
 	},
 };
 MODULE_ALIAS("platform:xhci-hcd");
-- 
1.9.1
