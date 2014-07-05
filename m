From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:38:02 +0100
Subject: [PATCH RFC 02/15] component: ignore multiple additions of the same
 component
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NM2-00009o-AB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Permit masters to call component_master_add_child() and match the same
child multiple times.  This may happen if there's multiple connections
to a single component device from other devices.  In such scenarios,
we should not return a failure, but instead ignore the attempt.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/component.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index d0ebd4431736..55813e91bf0d 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -69,6 +69,11 @@ static void component_detach_master(struct master *master, struct component *c)
 	c->master = NULL;
 }
 
+/*
+ * Add a component to a master, finding the component via the compare
+ * function and compare data.  This is safe to call for duplicate matches
+ * and will not result in the same component being added multiple times.
+ */
 int component_master_add_child(struct master *master,
 	int (*compare)(struct device *, void *), void *compare_data)
 {
@@ -76,11 +81,12 @@ int component_master_add_child(struct master *master,
 	int ret = -ENXIO;
 
 	list_for_each_entry(c, &component_list, node) {
-		if (c->master)
+		if (c->master && c->master != master)
 			continue;
 
 		if (compare(c->dev, compare_data)) {
-			component_attach_master(master, c);
+			if (!c->master)
+				component_attach_master(master, c);
 			ret = 0;
 			break;
 		}
-- 
1.8.3.1
