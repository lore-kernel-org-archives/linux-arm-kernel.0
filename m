From: hdegoede@redhat.com (Hans de Goede)
Date: Thu,  2 Jun 2016 19:31:03 +0200
Subject: [PATCH 1/4] USB: Fix of_usb_get_dr_mode_by_phy with a shared phy block
Message-ID: <1464888666-17728-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs have a single phy-hw-block with multiple phys, this is
modelled by a single phy dts node, so we end up with multiple
controller nodes with a phys property pointing to the phy-node
of the otg-phy.

Only one of these controllers typically is an otg controller, yet we
were checking the first controller who uses a phy from the block and
then end up looking for a dr_mode property in e.g. the ehci controller.

Instead of looking for nodes with a phy property, look for nodes
with a dr_mode property, so that we actually access the dr_mode property
in a node which has it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/common/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index e3d0161..9806433 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -145,7 +145,7 @@ enum usb_dr_mode of_usb_get_dr_mode_by_phy(struct device_node *phy_np)
 	int err;
 
 	do {
-		controller = of_find_node_with_property(controller, "phys");
+		controller = of_find_node_with_property(controller, "dr_mode");
 		index = 0;
 		do {
 			phy = of_parse_phandle(controller, "phys", index);
-- 
2.7.4
