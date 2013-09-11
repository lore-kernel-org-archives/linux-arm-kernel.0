From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 11 Sep 2013 18:32:33 +0300
Subject: [PATCH v2 2/9] i2c: attach/detach I2C client device to the ACPI power
 domain
In-Reply-To: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <1378913560-2752-3-git-send-email-mika.westerberg@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lv Zheng <lv.zheng@intel.com>

If the I2C client device is enumerated from ACPI namespace it might have
ACPI methods that needs to be called in order to transition the device to
different power states (such as _PSx).

Implement this for I2C client devices by checking if the device has an ACPI
handle and if that's the case, attach it to the ACPI power domain. In
addition we make sure that the device is fully powered when its ->probe()
function gets called.

For non-ACPI devices this patch is a no-op.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/i2c/i2c-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 44374b4..ac4ea1f 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -251,6 +251,9 @@ static int i2c_device_probe(struct device *dev)
 	/* Make sure the adapter is active */
 	pm_runtime_get_sync(&client->adapter->dev);
 
+	if (ACPI_HANDLE(&client->dev))
+		acpi_dev_pm_attach(&client->dev, true);
+
 	/*
 	 * Enable runtime PM for the client device. If the client wants to
 	 * participate on runtime PM it should call pm_runtime_put() in its
@@ -268,6 +271,9 @@ static int i2c_device_probe(struct device *dev)
 		pm_runtime_disable(&client->dev);
 		pm_runtime_set_suspended(&client->dev);
 		pm_runtime_put_noidle(&client->dev);
+
+		if (ACPI_HANDLE(&client->dev))
+			acpi_dev_pm_detach(&client->dev, true);
 	}
 
 	pm_runtime_put(&client->adapter->dev);
@@ -304,6 +310,9 @@ static int i2c_device_remove(struct device *dev)
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
+	if (ACPI_HANDLE(&client->dev))
+		acpi_dev_pm_detach(&client->dev, true);
+
 	pm_runtime_put(&client->adapter->dev);
 	return status;
 }
-- 
1.8.4.rc3
