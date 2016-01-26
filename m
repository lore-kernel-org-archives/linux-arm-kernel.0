From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 26 Jan 2016 17:59:13 +0000
Subject: Problem with component helpers and probe deferral in 4.5-rc1
Message-ID: <1453831153.2850.107.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I believe I've found a problem with the component helpers and/or how
drivers use them. I discovered this whilst trying to get ARM's HDLCD
driver [1] working on 4.5-rc1, however I believe that code is following
a pattern used by drivers already in 4.5 and the problem isn't specific
to it. This is what I have observed...

The master device's probe function uses component_match_add to create a
match list then it passes this to component_master_add_with_match.

That creates a struct master and then calls try_to_bring_up_master
which:
- Calls find_components to attach all components to the master.
- Calls master->ops->bind()

If this bind call fails (with -EPROBE_DEFER due to missing clock in my
case) then this error is returned to component_master_add_with_match
which proceeds to delete the master struct. However, find_components has
already attached components to that deleted master, so I think we also
need something to detach components as well. I've added a patch at the
end of this email which does that directly, but I wonder if instead it's
the responsibility of the driver for the master to call
component_master_del on error?

Finally, with my scenario which has probe deferring, some time later the
original master device will be probed again, repeating all the above.
Except that now find_components doesn't find the components because they
are already attached to a different master (the old master struct which
was deleted) this results in a permanent error. Which is what lead me to
investigate.

[1] https://lkml.org/lkml/2015/12/22/451

The patch to detach components when master is deleted...

-------------------------------------------------------------------------

From: Jon Medhurst <tixy@linaro.org>
Subject: [PATCH] component: Detach components when deleting master struct

component_master_add_with_match calls find_components which, if any
components already exist, it attaches to the master struct. However, if
we later encounter an error the master struct is deleted, leaving
components with a dangling pointer to it.

If the error was a temporary one, e.g. for probe deferral, then when
the master device is re-probed, it will fail to find the required
components as they appear to already be attached to a master.

Fix this by nulling components pointers to the master struct when it is
deleted. This code is factored out into a separate function so it can be
shared with component_master_del.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 drivers/base/component.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 89f5cf68..a3a1394 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -283,6 +283,24 @@ void component_match_add_release(struct device *master,
 }
 EXPORT_SYMBOL(component_match_add_release);
 
+static void free_master(struct master *master)
+{
+	struct component_match *match = master->match;
+	int i;
+
+	list_del(&master->node);
+
+	if (match) {
+		for (i = 0; i < match->num; i++) {
+			struct component *c = match->compare[i].component;
+			if (c)
+				c->master = NULL;
+		}
+	}
+
+	kfree(master);
+}
+
 int component_master_add_with_match(struct device *dev,
 	const struct component_master_ops *ops,
 	struct component_match *match)
@@ -309,11 +327,9 @@ int component_master_add_with_match(struct device *dev,
 
 	ret = try_to_bring_up_master(master, NULL);
 
-	if (ret < 0) {
-		/* Delete off the list if we weren't successful */
-		list_del(&master->node);
-		kfree(master);
-	}
+	if (ret < 0)
+		free_master(master);
+
 	mutex_unlock(&component_mutex);
 
 	return ret < 0 ? ret : 0;
@@ -324,25 +340,12 @@ void component_master_del(struct device *dev,
 	const struct component_master_ops *ops)
 {
 	struct master *master;
-	int i;
 
 	mutex_lock(&component_mutex);
 	master = __master_find(dev, ops);
 	if (master) {
-		struct component_match *match = master->match;
-
 		take_down_master(master);
-
-		list_del(&master->node);
-
-		if (match) {
-			for (i = 0; i < match->num; i++) {
-				struct component *c = match->compare[i].component;
-				if (c)
-					c->master = NULL;
-			}
-		}
-		kfree(master);
+		free_master(master);
 	}
 	mutex_unlock(&component_mutex);
 }
-- 
2.1.4
