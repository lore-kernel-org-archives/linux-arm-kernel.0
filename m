From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Oct 2016 09:53:37 +0200
Subject: [PATCH 6/6] misc: q8-hardwaremgr: Add quirk handling
In-Reply-To: <20161014075337.10452-1-hdegoede@redhat.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
Message-ID: <20161014075337.10452-7-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some models require some special handling, e.g. one q8 tablet I've needs
esp,crystal-26M-en = <1> in the sdio_wifi dt node for the wifi to work
properly.

Add a q8_hardwaremgr_apply_quirks() helper function which identifies the
tablet based on the detected soc, touchscreen, accelerometer combo and
applies model specific quirks where necessary.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/q8-hardwaremgr.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/misc/q8-hardwaremgr.c b/drivers/misc/q8-hardwaremgr.c
index 95cdaf2..cbf4f61 100644
--- a/drivers/misc/q8-hardwaremgr.c
+++ b/drivers/misc/q8-hardwaremgr.c
@@ -715,6 +715,28 @@ static void q8_hardwaremgr_apply_accelerometer(struct q8_hardwaremgr_data *data)
 	of_node_put(np);
 }
 
+static void q8_hardwaremgr_apply_quirks(struct q8_hardwaremgr_data *data)
+{
+	struct device_node *np;
+	struct of_changeset cset;
+
+	/* This A33 tzx-723q4 PCB tablet with esp8089 needs crystal_26M_en=1 */
+	if (data->soc == a33 && data->touchscreen.model == gsl1680_b482 &&
+	    data->accelerometer.model == dmard09 && !data->has_rda599x) {
+		dev_info(data->dev, "Applying crystal_26M_en=1 sdio_wifi quirk\n");
+		np = of_find_node_by_name(of_root, "sdio_wifi");
+		if (!np) {
+			dev_warn(data->dev, "Could not find sdio_wifi dt node\n");
+			return;
+		}
+		of_changeset_init(&cset);
+		of_changeset_add_property_u32(&cset, np,
+					      "esp,crystal-26M-en", 1);
+		of_changeset_apply(&cset);
+		of_node_put(np);
+	}
+}
+
 static int q8_hardwaremgr_do_probe(struct q8_hardwaremgr_data *data,
 				   struct q8_hardwaremgr_device *dev,
 				   const char *prefix, bus_probe_func func)
@@ -846,6 +868,7 @@ static int q8_hardwaremgr_probe(struct platform_device *pdev)
 
 	q8_hardwaremgr_apply_touchscreen(data);
 	q8_hardwaremgr_apply_accelerometer(data);
+	q8_hardwaremgr_apply_quirks(data);
 
 error:
 	kfree(data);
-- 
2.9.3
