From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 18 Jan 2017 14:19:58 +0100
Subject: [PATCH v3 10/13] sata: ahci-da850: add a workaround for controller
 instability
In-Reply-To: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
References: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1484745601-4769-11-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a use case with the da850 SATA controller where at PLL0
frequency of 456MHz (needed to properly service the LCD controller)
the chip becomes unstable and the hardreset operation is ignored the
first time 50% of times.

The sata core driver already retries to resume the link because some
controllers ignore writes to the SControl register, but just retrying
the resume operation doesn't work - we need to issue he phy/wake reset
again to make it work.

Reimplement ahci_hardreset() in the driver and poke the controller a
couple times before really giving up.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/ata/ahci_da850.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 11dd87e..0b2b1a4 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -16,7 +16,8 @@
 #include <linux/ahci_platform.h>
 #include "ahci.h"
 
-#define DRV_NAME "ahci_da850"
+#define DRV_NAME		"ahci_da850"
+#define HARDRESET_RETRIES	5
 
 /* SATA PHY Control Register offset from AHCI base */
 #define SATA_P0PHYCR_REG	0x178
@@ -76,6 +77,29 @@ static int ahci_da850_softreset(struct ata_link *link,
 	return ret;
 }
 
+static int ahci_da850_hardreset(struct ata_link *link,
+				unsigned int *class, unsigned long deadline)
+{
+	int ret, retry = HARDRESET_RETRIES;
+	bool online;
+
+	/*
+	 * In order to correctly service the LCD controller of the da850 SoC,
+	 * we increased the PLL0 frequency to 456MHz from the default 300MHz.
+	 *
+	 * This made the SATA controller unstable and the hardreset operation
+	 * does not always succeed the first time. Before really giving up to
+	 * bring up the link, retry the reset a couple times.
+	 */
+	do {
+		ret = ahci_do_hardreset(link, class, deadline, &online);
+		if (online)
+			return ret;
+	} while (retry--);
+
+	return ret;
+}
+
 static struct ata_port_operations ahci_da850_port_ops = {
 	.inherits = &ahci_platform_ops,
 	.softreset = ahci_da850_softreset,
@@ -83,6 +107,8 @@ static struct ata_port_operations ahci_da850_port_ops = {
 	 * No need to override .pmp_softreset - it's only used for actual
 	 * PMP-enabled ports.
 	 */
+	.hardreset = ahci_da850_hardreset,
+	.pmp_hardreset = ahci_da850_hardreset,
 };
 
 static const struct ata_port_info ahci_da850_port_info = {
-- 
2.9.3
