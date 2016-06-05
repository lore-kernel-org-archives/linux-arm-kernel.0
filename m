From: hdegoede@redhat.com (Hans de Goede)
Date: Sun,  5 Jun 2016 16:59:33 +0200
Subject: [PATCH v3 1/4] USB: Fix of_usb_get_dr_mode_by_phy with a shared phy
 block
Message-ID: <1465138776-6003-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs have a single phy-hw-block with multiple phys, this is
modelled by a single phy dts node, so we end up with multiple
controller nodes with a phys property pointing to the phy-node
of the otg-phy.

Only one of these controllers typically is an otg controller, yet we
were checking the first controller who uses a phy from the block and
then end up looking for a dr_mode property in e.g. the ehci controller.

This commit fixes this by adding an arg0 parameter to
of_usb_get_dr_mode_by_phy and make of_usb_get_dr_mode_by_phy
check that this matches the phandle args[0] value when looking for
the otg controller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add a args0 parameter instead of looking for nodes with a dr_mode property
Changes in v3:
-No changes
---
 drivers/usb/common/common.c  | 31 ++++++++++++++++++-------------
 drivers/usb/phy/phy-am335x.c |  2 +-
 include/linux/usb/of.h       |  4 ++--
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index e3d0161..bd716f4 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -131,32 +131,37 @@ EXPORT_SYMBOL_GPL(usb_get_dr_mode);
  * of_usb_get_dr_mode_by_phy - Get dual role mode for the controller device
  * which is associated with the given phy device_node
  * @np:	Pointer to the given phy device_node
+ * @arg0: phandle args[0] for phy's with #phy-cells >= 1
  *
  * In dts a usb controller associates with phy devices.  The function gets
  * the string from property 'dr_mode' of the controller associated with the
  * given phy device node, and returns the correspondig enum usb_dr_mode.
  */
-enum usb_dr_mode of_usb_get_dr_mode_by_phy(struct device_node *phy_np)
+enum usb_dr_mode of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0)
 {
 	struct device_node *controller = NULL;
-	struct device_node *phy;
+	struct of_phandle_args args;
 	const char *dr_mode;
 	int index;
 	int err;
+	bool found = false;
 
 	do {
 		controller = of_find_node_with_property(controller, "phys");
-		index = 0;
-		do {
-			phy = of_parse_phandle(controller, "phys", index);
-			of_node_put(phy);
-			if (phy == phy_np)
-				goto finish;
-			index++;
-		} while (phy);
-	} while (controller);
-
-finish:
+		for (index = 0; !found; index++) {
+			err = of_parse_phandle_with_args(controller, "phys",
+					"#phy-cells", index, &args);
+			if (err)
+				break;
+
+			if (args.np == np && (args.args_count == 0 ||
+					      args.args[0] == arg0))
+				found = true;
+
+			of_node_put(args.np);
+		}
+	} while (controller && !found);
+
 	err = of_property_read_string(controller, "dr_mode", &dr_mode);
 	of_node_put(controller);
 
diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
index a262a43..7e5aece 100644
--- a/drivers/usb/phy/phy-am335x.c
+++ b/drivers/usb/phy/phy-am335x.c
@@ -54,7 +54,7 @@ static int am335x_phy_probe(struct platform_device *pdev)
 		return am_phy->id;
 	}
 
-	am_phy->dr_mode = of_usb_get_dr_mode_by_phy(pdev->dev.of_node);
+	am_phy->dr_mode = of_usb_get_dr_mode_by_phy(pdev->dev.of_node, -1);
 
 	ret = usb_phy_gen_create_phy(dev, &am_phy->usb_phy_gen, NULL);
 	if (ret)
diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
index de3237f..5ff9032 100644
--- a/include/linux/usb/of.h
+++ b/include/linux/usb/of.h
@@ -12,7 +12,7 @@
 #include <linux/usb/phy.h>
 
 #if IS_ENABLED(CONFIG_OF)
-enum usb_dr_mode of_usb_get_dr_mode_by_phy(struct device_node *phy_np);
+enum usb_dr_mode of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0);
 bool of_usb_host_tpl_support(struct device_node *np);
 int of_usb_update_otg_caps(struct device_node *np,
 			struct usb_otg_caps *otg_caps);
@@ -20,7 +20,7 @@ struct device_node *usb_of_get_child_node(struct device_node *parent,
 			int portnum);
 #else
 static inline enum usb_dr_mode
-of_usb_get_dr_mode_by_phy(struct device_node *phy_np)
+of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0)
 {
 	return USB_DR_MODE_UNKNOWN;
 }
-- 
2.7.4
