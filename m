From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 19 Feb 2014 13:01:57 +0100
Subject: [PATCH v6 15/18] ata: ahci_platform: runtime resume the device before
 use
In-Reply-To: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1392811320-3132-16-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roger Quadros <rogerq@ti.com>

On OMAP platforms the device needs to be runtime resumed before
it can be accessed. The OMAP HWMOD framework takes care of
enabling the module and its resources based on the
device's runtime PM state.

In this patch we runtime resume during .probe() and runtime suspend
during .remove() (i.e. ahci_host_stop()).

We also update the runtime PM state during .resume().

CC: Balaji T K <balajitk@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci_platform.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index f8ef780..bb2e7ab 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -24,6 +24,7 @@
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include "ahci.h"
 
 static void ahci_host_stop(struct ata_host *host);
@@ -234,6 +235,9 @@ struct ahci_host_priv *ahci_platform_get_resources(
 		}
 	}
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
 	return hpriv;
 
 free_clk:
@@ -248,6 +252,9 @@ void ahci_platform_put_resources(struct device *dev,
 {
 	int c;
 
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
 	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
 		clk_put(hpriv->clks[c]);
 }
@@ -480,6 +487,11 @@ int ahci_platform_resume(struct device *dev)
 	if (rc)
 		goto disable_resources;
 
+	/* We resumed so update PM runtime state */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return 0;
 
 disable_resources:
-- 
1.8.5.3
