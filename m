From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 12 May 2015 15:14:55 +0100
Subject: [PATCH v4 11/11] drivers: PL011: add ACPI probing for SBSA UART
In-Reply-To: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
References: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1431440095-5146-12-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

Add the necessary driver boilerplate to let the driver be used when
the respective ACPI table is discovered by the ACPI subsystem.

[Andre: change table name, add MODULE_DEVICE_TABLE entry and improve
	commit message]

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cca93d9..79f716c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -58,6 +58,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/sizes.h>
 #include <linux/io.h>
+#include <linux/acpi.h>
 
 #define UART_NR			14
 
@@ -2483,12 +2484,19 @@ static const struct of_device_id sbsa_uart_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
 
+static const struct acpi_device_id sbsa_uart_acpi_match[] = {
+	{ "ARMH0011", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, sbsa_uart_acpi_match);
+
 static struct platform_driver arm_sbsa_uart_platform_driver = {
 	.probe		= sbsa_uart_probe,
 	.remove		= sbsa_uart_remove,
 	.driver	= {
 		.name	= "sbsa-uart",
 		.of_match_table = of_match_ptr(sbsa_uart_of_match),
+		.acpi_match_table = ACPI_PTR(sbsa_uart_acpi_match),
 	},
 };
 
-- 
2.3.5
