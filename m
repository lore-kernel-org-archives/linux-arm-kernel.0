From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 05 Jul 2014 11:37:57 +0100
Subject: [PATCH RFC 01/15] component: fix missed cleanup in case of devres
 failure
In-Reply-To: <20140705103724.GN21766@n2100.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
Message-ID: <E1X3NLx-00009k-74@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In try_to_bring_up_master(), we tear down the master's component list
for each error case, except for devres group failure.  Fix this
oversight by making the code less prone to such mistakes.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/component.c | 62 ++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index c4778995cd72..d0ebd4431736 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -113,44 +113,44 @@ static void master_remove_components(struct master *master)
 static int try_to_bring_up_master(struct master *master,
 	struct component *component)
 {
-	int ret = 0;
+	int ret;
 
-	if (!master->bound) {
-		/*
-		 * Search the list of components, looking for components that
-		 * belong to this master, and attach them to the master.
-		 */
-		if (master->ops->add_components(master->dev, master)) {
-			/* Failed to find all components */
-			master_remove_components(master);
-			ret = 0;
-			goto out;
-		}
+	if (master->bound)
+		return 0;
 
-		if (component && component->master != master) {
-			master_remove_components(master);
-			ret = 0;
-			goto out;
-		}
+	/*
+	 * Search the list of components, looking for components that
+	 * belong to this master, and attach them to the master.
+	 */
+	if (master->ops->add_components(master->dev, master)) {
+		/* Failed to find all components */
+		ret = 0;
+		goto out;
+	}
 
-		if (!devres_open_group(master->dev, NULL, GFP_KERNEL)) {
-			ret = -ENOMEM;
-			goto out;
-		}
+	if (component && component->master != master) {
+		ret = 0;
+		goto out;
+	}
 
-		/* Found all components */
-		ret = master->ops->bind(master->dev);
-		if (ret < 0) {
-			devres_release_group(master->dev, NULL);
-			dev_info(master->dev, "master bind failed: %d\n", ret);
-			master_remove_components(master);
-			goto out;
-		}
+	if (!devres_open_group(master->dev, NULL, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-		master->bound = true;
-		ret = 1;
+	/* Found all components */
+	ret = master->ops->bind(master->dev);
+	if (ret < 0) {
+		devres_release_group(master->dev, NULL);
+		dev_info(master->dev, "master bind failed: %d\n", ret);
+		goto out;
 	}
+
+	master->bound = true;
+	return 1;
+
 out:
+	master_remove_components(master);
 
 	return ret;
 }
-- 
1.8.3.1
