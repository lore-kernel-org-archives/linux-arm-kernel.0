From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 11 Sep 2013 18:32:40 +0300
Subject: [PATCH v2 9/9] spi: attach/detach SPI device to the ACPI power domain
In-Reply-To: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <1378913560-2752-10-git-send-email-mika.westerberg@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the SPI device is enumerated from ACPI namespace (it has an ACPI handle)
it might have ACPI methods that needs to be called in order to transition
the device to different power states (such as _PSx).

We follow what has been done for platform and I2C buses here and attach the
SPI device to the ACPI power domain if the device has an ACPI handle. This
makes sure that the device is powered on when its ->probe() is called.

For non-ACPI devices this patch is a no-op.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/spi/spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 94ebab9..cac0ca2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -246,6 +246,9 @@ static int spi_drv_probe(struct device *dev)
 	/* Make sure that the master is powered on */
 	pm_runtime_get_sync(&spi->master->dev);
 
+	if (ACPI_HANDLE(&spi->dev))
+		acpi_dev_pm_attach(&spi->dev, true);
+
 	/*
 	 * Enable runtime PM for the SPI device. The SPI device driver can
 	 * participate in runtime PM by calling pm_runtime_put() in its
@@ -260,6 +263,9 @@ static int spi_drv_probe(struct device *dev)
 		pm_runtime_disable(&spi->dev);
 		pm_runtime_set_suspended(&spi->dev);
 		pm_runtime_put_noidle(&spi->dev);
+
+		if (ACPI_HANDLE(&spi->dev))
+			acpi_dev_pm_detach(&spi->dev, true);
 	}
 
 	pm_runtime_put(&spi->master->dev);
@@ -282,6 +288,9 @@ static int spi_drv_remove(struct device *dev)
 	pm_runtime_set_suspended(&spi->dev);
 	pm_runtime_put_noidle(&spi->dev);
 
+	if (ACPI_HANDLE(&spi->dev))
+		acpi_dev_pm_detach(&spi->dev, true);
+
 	pm_runtime_put(&spi->master->dev);
 
 	return ret;
-- 
1.8.4.rc3
