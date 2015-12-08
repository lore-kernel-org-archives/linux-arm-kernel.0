From: lho@apm.com (Loc Ho)
Date: Mon,  7 Dec 2015 17:16:13 -0700
Subject: [PATCH 1/2] acpi:apd: Add APM X-Gene ACPI I2C device support
In-Reply-To: <1449533774-22672-1-git-send-email-lho@apm.com>
References: <1449533774-22672-1-git-send-email-lho@apm.com>
Message-ID: <1449533774-22672-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add APM X-Gene ACPI I2C device support by hooks into existent
ACPI apd driver. To fully enable support, require another
patch to add the X-Gene ACPI node into the DW I2C driver.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/acpi/acpi_apd.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index a450e7a..6a9cb8d 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -51,7 +51,7 @@ struct apd_private_data {
 	const struct apd_device_desc *dev_desc;
 };
 
-#ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
+#if defined(CONFIG_X86_AMD_PLATFORM_DEVICE) || defined(CONFIG_ARM64)
 #define APD_ADDR(desc)	((unsigned long)&desc)
 
 static int acpi_apd_setup(struct apd_private_data *pdata)
@@ -76,6 +76,11 @@ static struct apd_device_desc cz_i2c_desc = {
 	.fixed_clk_rate = 133000000,
 };
 
+static struct apd_device_desc xgene_i2c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 100000000,
+};
+
 static struct apd_device_desc cz_uart_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 48000000,
@@ -135,6 +140,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "AMD0010", APD_ADDR(cz_i2c_desc) },
 	{ "AMD0020", APD_ADDR(cz_uart_desc) },
 	{ "AMD0030", },
+	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
 	{ }
 };
 
-- 
1.7.1
