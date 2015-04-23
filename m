From: fkan@apm.com (Feng Kan)
Date: Thu, 23 Apr 2015 11:07:08 -0700
Subject: [PATCH V3 2/4] i2c: busses: xgene: add acpi support for i2c xgene
 SLIMpro driver
In-Reply-To: <1429812430-31631-1-git-send-email-fkan@apm.com>
References: <1429812430-31631-1-git-send-email-fkan@apm.com>
Message-ID: <1429812430-31631-3-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for ACPI for the APM X-Gene I2C SLIMpro proxy
driver.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 drivers/i2c/busses/i2c-xgene-slimpro.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index afe4cf2..0035760 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -22,6 +22,7 @@
  * using the APM X-Gene SLIMpro mailbox driver.
  *
  */
+#include <linux/acpi.h>
 #include <linux/dma-mapping.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -442,12 +443,21 @@ static const struct of_device_id xgene_slimpro_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(of, xgene_slimpro_i2c_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_slimpro_i2c_acpi_ids[] = {
+	{"PRP0001", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, slimpro_acpi_ids);
+#endif
+
 static struct platform_driver xgene_slimpro_i2c_driver = {
 	.probe	= xgene_slimpro_i2c_probe,
 	.remove	= xgene_slimpro_i2c_remove,
 	.driver	= {
 		.name	= "xgene-slimpro-i2c",
-		.of_match_table = of_match_ptr(xgene_slimpro_i2c_id)
+		.of_match_table = of_match_ptr(xgene_slimpro_i2c_id),
+		.acpi_match_table = ACPI_PTR(xgene_slimpro_i2c_acpi_ids)
 	},
 };
 
-- 
1.9.1
