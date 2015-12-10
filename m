From: lho@apm.com (Loc Ho)
Date: Thu, 10 Dec 2015 14:19:16 -0700
Subject: [PATCH v2 1/2] acpi:apd: Add APM X-Gene ACPI I2C device support
In-Reply-To: <1449782357-22982-1-git-send-email-lho@apm.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
Message-ID: <1449782357-22982-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APM X-Gene ACPI I2C device support by hooks into existent
ACPI apd driver. To fully enable support, require another
patch to add the X-Gene ACPI node into the DW I2C driver.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/acpi/acpi_apd.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index a450e7a..d507cf6 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -51,7 +51,7 @@ struct apd_private_data {
 	const struct apd_device_desc *dev_desc;
 };
 
-#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
+#if defined(CONFIG_X86_AMD_PLATFORM_DEVICE) || defined(CONFIG_ARM64)
 #define APD_ADDR(desc)	((unsigned long)&desc)
 
 static int acpi_apd_setup(struct apd_private_data *pdata)
@@ -71,6 +71,7 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 	return 0;
 }
 
+#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
 static struct apd_device_desc cz_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
@@ -80,6 +81,14 @@ static struct apd_device_desc cz_uart_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 48000000,
 };
+#endif
+
+#ifdef CONFIG_ARM64
+static struct apd_device_desc xgene_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 100000000,
+};
+#endif
 
 #else
 
@@ -132,9 +141,14 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 
 static const struct acpi_device_id acpi_apd_device_ids[] = {
 	/* Generic apd devices */
+#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
 	{ "AMD0010", APD_ADDR(cz_i2c_desc) },
 	{ "AMD0020", APD_ADDR(cz_uart_desc) },
 	{ "AMD0030", },
+#endif
+#ifdef CONFIG_ARM64
+	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
+#endif
 	{ }
 };
 
-- 
1.7.1
