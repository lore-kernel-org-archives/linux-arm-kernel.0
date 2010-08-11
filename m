From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 16:19:28 +0300
Subject: [RFC/PATCH 4/6] sdio: add general runtime PM support
In-Reply-To: <1281532770-27545-1-git-send-email-ohad@wizery.com>
References: <1281532770-27545-1-git-send-email-ohad@wizery.com>
Message-ID: <1281532770-27545-5-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add generic Runtime PM handlers to sdio.

When a runtime pm event kicks in, those handlers call the
runtime pm handlers of the relevant SDIO function drivers.

Runtime PM is still disabled by default, so this patch alone
has no immediate effect.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/sdio_bus.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 4a890dc..2e417f9 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/sdio_func.h>
@@ -154,6 +155,14 @@ static int sdio_bus_remove(struct device *dev)
 	return 0;
 }
 
+static const struct dev_pm_ops sdio_bus_pm_ops = {
+	SET_RUNTIME_PM_OPS(
+		pm_generic_runtime_suspend,
+		pm_generic_runtime_resume,
+		pm_generic_runtime_idle
+	)
+};
+
 static struct bus_type sdio_bus_type = {
 	.name		= "sdio",
 	.dev_attrs	= sdio_dev_attrs,
@@ -161,6 +170,7 @@ static struct bus_type sdio_bus_type = {
 	.uevent		= sdio_bus_uevent,
 	.probe		= sdio_bus_probe,
 	.remove		= sdio_bus_remove,
+	.pm		= &sdio_bus_pm_ops,
 };
 
 int sdio_register_bus(void)
-- 
1.7.0.4
