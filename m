From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  2 Jun 2014 14:41:03 +0100
Subject: [PATCH 3/3] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
In-Reply-To: <1401716463-23457-1-git-send-email-lee.jones@linaro.org>
References: <1401716463-23457-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1401716463-23457-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the I2C framework insists on devices supplying an I2C ID
table.  Many of the devices which do so unnecessarily adding quite a
few wasted lines to kernel code.  This patch allows drivers a means
to 'not' supply the aforementioned table and match on either DT
and/or ACPI match tables instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/i2c-core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d0c7180..811b78f 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -271,7 +271,18 @@ static int i2c_device_probe(struct device *dev)
 		return 0;
 
 	driver = to_i2c_driver(dev->driver);
-	if (!driver->probe || !driver->id_table)
+	if (!driver->probe)
+		return -EINVAL;
+
+	/*
+	 * An I2C ID table is not madatory, if and only if, a suitable Device
+	 * Tree and/or ACPI match table entry is supplied for the probing
+	 * device.
+	 *
+	 * TODO: Provide 'device type' to 'ACPI node' call and match here.
+	 */
+	if (!driver->id_table &&
+	    !of_match_device(dev->driver->of_match_table, dev))
 		return -ENODEV;
 
 	if (!device_can_wakeup(&client->dev))
-- 
1.8.3.2
