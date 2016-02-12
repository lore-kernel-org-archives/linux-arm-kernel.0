From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Fri, 12 Feb 2016 20:43:40 +0300
Subject: [PATCH v2 9/9] serial: pl011: use SPCR to setup 32-bit access
In-Reply-To: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1455299022-11641-10-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some implementations of ARM SBSA serial port hardware require that access
to the registers should be 32-bit.  Unfortunately, the only way for
the driver to tell if it's the case is to use the data from ACPI SPCR/DBG2
tables.  In this case the value of the 'Interface Type' field of the SPCR
table is ACPI_DBG2_ARM_SBSA_32BIT.

How this value is described in the DBG2 spec:
"(deprecated) ARM SBSA (2.x only) Generic UART supporting only
32-bit accesses"

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Tested-by: Christopher Covington <cov@codeaurora.org>
---
 drivers/acpi/spcr.c             | 29 +++++++++++++++++++++++++++++
 drivers/tty/serial/amba-pl011.c |  2 ++
 include/linux/console.h         |  5 +++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 0475840..df1741f 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -75,3 +75,32 @@ int acpi_console_match(struct console *console, char **options)
 
 	return acpi_table_parse2(ACPI_SIG_SPCR, spcr_table_handler_match, &d);
 }
+
+static int spcr_table_handler_32_bit(struct acpi_table_header *t,
+				     void *data)
+{
+	struct acpi_table_spcr *table = (struct acpi_table_spcr *)t;
+
+	return table->interface_type == ACPI_DBG2_ARM_SBSA_32BIT;
+}
+
+/**
+ * acpi_console_sbsa_32bit - Tell if SPCR specifies 32-bit SBSA.
+ *
+ * Some implementations of ARM SBSA serial port hardware require that access
+ * to the registers should be 32-bit.  Unfortunately, the only way for
+ * the driver to tell if it's the case is to use the data from ACPI SPCR/DBG2
+ * tables.  In this case the value of the 'Interface Type' field of the SPCR
+ * table is ACPI_DBG2_ARM_SBSA_32BIT.
+ *
+ * Return: true if access should be 32-bit wide.
+ */
+bool acpi_console_sbsa_32bit(void)
+{
+	if (acpi_disabled)
+		return false;
+
+	return acpi_table_parse2(ACPI_SIG_SPCR,
+				 spcr_table_handler_32_bit, NULL) > 0;
+}
+EXPORT_SYMBOL(acpi_console_sbsa_32bit);
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index f613bff..699a3ce 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2563,6 +2563,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 		baudrate = 115200;
 	}
 
+	vendor_sbsa.access_32b = acpi_console_sbsa_32bit();
+
 	portnr = pl011_find_free_port();
 	if (portnr < 0)
 		return portnr;
diff --git a/include/linux/console.h b/include/linux/console.h
index dcc2b59..027ef50 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -137,11 +137,16 @@ struct console {
 
 #ifdef CONFIG_ACPI_SPCR_TABLE
 int acpi_console_match(struct console *c, char **options);
+bool acpi_console_sbsa_32bit(void);
 #else
 static inline int acpi_console_match(struct console *c, char **options)
 {
 	return -ENODEV;
 }
+static inline bool acpi_console_sbsa_32bit(void)
+{
+	return false;
+}
 #endif
 
 /*
-- 
2.7.0
