From: lho@apm.com (Loc Ho)
Date: Thu,  1 Oct 2015 18:51:52 -0600
Subject: [PATCH RFC] apei: xgene: Add ACPI APEI support for X-Gene
Message-ID: <1443747112-24814-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ACPI APEI support for X-Gene platform. This patch requires [1] to 
configiure and build.

[1] http://marc.info/?l=linux-kernel&m=143955588312730&w=2 

Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/edac/Kconfig      |    7 +++
 drivers/edac/Makefile     |    2 +
 drivers/edac/xgene_apei.c |  120 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100644 drivers/edac/xgene_apei.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index ef25000..f489852 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -390,4 +390,11 @@ config EDAC_XGENE
 	  Support for error detection and correction on the
 	  APM X-Gene family of SOCs.
 
+config EDAC_XGENE_APEI
+	tristate "APM X-Gene SoC APEI"
+	depends on ACPI_APEI && (ARM64 || COMPILE_TEST)
+	help
+	  APEI interface support for error detection and correction on the
+	  APM X-Gene family of SOCs.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index dbf53e0..27dbae1 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -70,3 +70,5 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
 obj-$(CONFIG_EDAC_ALTERA_MC)		+= altera_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
+obj-$(CONFIG_EDAC_XGENE_APEI)		+= xgene_apei.o
+
diff --git a/drivers/edac/xgene_apei.c b/drivers/edac/xgene_apei.c
new file mode 100644
index 0000000..6ec416f
--- /dev/null
+++ b/drivers/edac/xgene_apei.c
@@ -0,0 +1,120 @@
+/*
+ * AppliedMicro X-Gene APEI Driver
+ *
+ * Copyright (c) 2015, Applied Micro Circuits Corporation
+ * Author: Tuan Phan <tphan@apm.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * This driver provides the interrupt hook up with the UEFI FW for the X-Gene
+ * SoC processor under the following conditions:
+ *
+ * 1. No interrupt GPIO available or don't want to use one and no EL3 support
+ * 2. With EL3 support, but no mean to interrupt the Linux OS that an event
+ *    has occurred.
+ *
+ */
+#include <linux/acpi.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define AGENT_DB_STATUS_OFFSET		0x20
+
+struct xgene_apei_dev {
+	void  __iomem	*csr_base;
+	struct device	*dev;
+	u32		irq;
+	acpi_handle	evt_handle;
+};
+
+static const struct acpi_device_id xgene_apei_acpi_match[] = {
+	{ "APMC0D50", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, xgene_apei_acpi_match);
+
+static irqreturn_t xgene_apei_irq_handler(int irq, void *data)
+{
+	struct xgene_apei_dev *ctx = (struct xgene_apei_dev *) data;
+	u32 val;
+
+	/* Clear the interrupt */
+	val = readl(ctx->csr_base + AGENT_DB_STATUS_OFFSET);
+	writel(val, ctx->csr_base + AGENT_DB_STATUS_OFFSET);
+
+	/* Send error event */
+	acpi_execute_simple_method(ctx->evt_handle, NULL, 0);
+
+	return IRQ_HANDLED;
+}
+
+static int xgene_apei_probe(struct platform_device *pdev)
+{
+	struct xgene_apei_dev *ctx;
+	struct resource *res;
+	acpi_handle evt_handle;
+	int rc;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->dev = &pdev->dev;
+	platform_set_drvdata(pdev, ctx);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctx->csr_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctx->csr_base)) {
+		dev_err(&pdev->dev, "No CSR resource\n");
+		return PTR_ERR(ctx->csr_base);
+	}
+
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq < 0) {
+		dev_err(&pdev->dev, "No IRQ resource\n");
+		return ctx->irq;
+	}
+
+	dev_dbg(&pdev->dev, "APM X-Gene APEI IRQ %d", ctx->irq);
+
+	rc = devm_request_irq(&pdev->dev, ctx->irq, xgene_apei_irq_handler, 0,
+			      dev_name(&pdev->dev), ctx);
+	if (rc) {
+		dev_err(&pdev->dev, "Could not request IRQ %d\n", ctx->irq);
+		return rc;
+	}
+
+	if (!ACPI_SUCCESS(acpi_get_handle(ACPI_HANDLE(ctx->dev), "_EVT",
+					  &evt_handle)))
+		return AE_BAD_PARAMETER;
+
+	ctx->evt_handle = evt_handle;
+
+	return rc;
+}
+
+static struct platform_driver xgene_apei_driver = {
+	.probe = xgene_apei_probe,
+	.driver = {
+		.name = "xgene-apei",
+		.acpi_match_table = ACPI_PTR(xgene_apei_acpi_match),
+	},
+};
+module_platform_driver(xgene_apei_driver);
+
+MODULE_DESCRIPTION("APM X-Gene APEI driver");
+MODULE_AUTHOR("Tuan Phan <tphan@apm.com>");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("0.1");
-- 
1.7.1
