From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 30 May 2014 13:26:36 +0100
Subject: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
In-Reply-To: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the I2C framework insists on devices supplying an I2C ID
table.  Many of the devices which do so unnecessarily adding quite a
few wasted lines to kernel code.  This patch allows drivers a means
to 'not' supply the aforementioned table and match on either DT
and/or ACPI match tables instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/i2c-core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 7c7f4b8..703da9e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -260,13 +260,25 @@ static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
 	struct i2c_driver	*driver;
+	const struct of_device_id *of_match	= dev->driver->of_match_table;
+	const struct acpi_device_id *acpi_match	= dev->driver->acpi_match_table;
 	int status;
 
 	if (!client)
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
+	 */
+	if (!driver->id_table &&
+	    !of_match_device(of_match, dev) &&
+	    !acpi_match_device(acpi_match, dev))
 		return -ENODEV;
 
 	if (!device_can_wakeup(&client->dev))
@@ -275,7 +287,12 @@ static int i2c_device_probe(struct device *dev)
 	dev_dbg(dev, "probe\n");
 
 	acpi_dev_pm_attach(&client->dev, true);
-	status = driver->probe(client, i2c_match_id(driver->id_table, client));
+
+	if (!driver->id_table)
+		status = driver->probe(client, NULL);
+	else
+		status = driver->probe(client,
+				       i2c_match_id(driver->id_table, client));
 	if (status)
 		acpi_dev_pm_detach(&client->dev, true);
 
-- 
1.8.3.2
