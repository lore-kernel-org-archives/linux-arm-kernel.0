From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 19 Aug 2015 16:36:32 -0500
Subject: [PATCH 2/2] USB: ehci-platform: Add ACPI bindings for the EHCI
 platform driver.
In-Reply-To: <1440020192-23754-1-git-send-email-jeremy.linton@arm.com>
References: <1440020192-23754-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1440020192-23754-3-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables USB on the ARM juno board when booted with
an ACPI kernel. The PNP id comes from the PNP/ACPI registry
and describes an EHCI controller without debug.

Tested-by: Huang Shijie <shijie.huang@arm.com>
Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/usb/host/ehci-platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 3ce38c3..9680a5d 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -19,6 +19,7 @@
  *
  * Licensed under the GNU/GPL. See COPYING for details.
  */
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -382,6 +383,12 @@ static const struct of_device_id vt8500_ehci_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
 
+static const struct acpi_device_id ehci_acpi_match[] = {
+	{ "PNP0D20", 0 }, /* EHCI controller without debug */
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, ehci_acpi_match);
+
 static const struct platform_device_id ehci_platform_table[] = {
 	{ "ehci-platform", 0 },
 	{ }
@@ -400,6 +407,7 @@ static struct platform_driver ehci_platform_driver = {
 		.name	= "ehci-platform",
 		.pm	= &ehci_platform_pm_ops,
 		.of_match_table = vt8500_ehci_ids,
+		.acpi_match_table = ACPI_PTR(ehci_acpi_match),
 	}
 };
 
-- 
2.4.3
