From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  1 Apr 2015 17:26:23 +0200
Subject: [PATCH v2 1/2] mmc: Add support for marking hpi as broken through
 devicetree
Message-ID: <1427901984-26469-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC on a tablet I've will stop working / communicating as soon as
the kernel executes:

		mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_HPI_MGMT, 1,
 				card->ext_csd.generic_cmd6_time);

There seems to be no way to reliable identify eMMC-s which have a broken
hpi implementation, but at least for eMMC's which are soldered onto a board
we can work around this by specifying that hpi is broken in devicetree.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Fix of_node leakage
---
 Documentation/devicetree/bindings/mmc/mmc-card.txt | 31 ++++++++++++++++++++++
 drivers/mmc/core/mmc.c                             | 10 ++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
new file mode 100644
index 0000000..a70fcd6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.txt
@@ -0,0 +1,31 @@
+mmc-card / eMMC bindings
+------------------------
+
+This documents describes the devicetree bindings for a mmc-host controller
+child node describing a mmc-card / an eMMC, see "Use of Function subnodes"
+in mmc.txt
+
+Required properties:
+-compatible : Must be "mmc-card"
+-reg        : Must be <0>
+
+Optional properties:
+-broken-hpi : Use this to indicate that the mmc-card has a broken hpi
+              implementation, and that hpi should not be used
+
+Example:
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins_a>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+
+	mmccard: mmccard at 0 {
+		reg = <0>;
+		compatible = "mmc-card";
+		broken-hpi;
+	};
+};
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1d41e85..c84131e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
@@ -336,6 +337,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 {
 	int err = 0, idx;
 	unsigned int part_size;
+	struct device_node *np;
+	bool broken_hpi = false;
 
 	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
 	card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
@@ -349,6 +352,11 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		}
 	}
 
+	np = mmc_of_find_child_device(card->host, 0);
+	if (np && of_device_is_compatible(np, "mmc-card"))
+		broken_hpi = of_property_read_bool(np, "broken-hpi");
+	of_node_put(np);
+
 	/*
 	 * The EXT_CSD format is meant to be forward compatible. As long
 	 * as CSD_STRUCTURE does not change, all values for EXT_CSD_REV
@@ -494,7 +502,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		}
 
 		/* check whether the eMMC card supports HPI */
-		if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
+		if (!broken_hpi && (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1)) {
 			card->ext_csd.hpi = 1;
 			if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x2)
 				card->ext_csd.hpi_cmd =	MMC_STOP_TRANSMISSION;
-- 
2.3.4
