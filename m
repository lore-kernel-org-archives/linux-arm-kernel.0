From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 20 Jun 2014 13:02:29 +0100
Subject: [PATCH 5/9] i2c: Make I2C ID tables non-mandatory for DT'ed devices
In-Reply-To: <1403265753-25851-1-git-send-email-lee.jones@linaro.org>
References: <1403265753-25851-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1403265753-25851-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the I2C framework insists on devices supplying an I2C ID
table.  Many of the devices which do so unnecessarily adding quite a
few wasted lines to kernel code.  This patch allows drivers a means
to 'not' supply the aforementioned table and match on DT match tables
instead.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/i2c-core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a9c97c4..ff2919a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -100,7 +100,7 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
 
 
 	/* Attempt an OF style match */
-	if (of_driver_match_device(dev, drv))
+	if (i2c_of_match_device(drv->of_match_table, client))
 		return 1;
 
 	/* Then ACPI style match */
@@ -268,7 +268,15 @@ static int i2c_device_probe(struct device *dev)
 		return 0;
 
 	driver = to_i2c_driver(dev->driver);
-	if (!driver->probe || !driver->id_table)
+	if (!driver->probe)
+		return -EINVAL;
+
+	/*
+	 * An I2C ID table is not mandatory, if and only if, a suitable Device
+	 * Tree match table entry is supplied for the probing device.
+	 */
+	if (!driver->id_table &&
+	    !i2c_of_match_device(dev->driver->of_match_table, client))
 		return -ENODEV;
 
 	if (!device_can_wakeup(&client->dev))
-- 
1.8.3.2
