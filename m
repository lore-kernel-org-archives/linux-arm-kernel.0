From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 29 Mar 2017 21:38:54 +0200
Subject: [PATCH v2 2/2] base: soc: Allow early registration of a single SoC
 device
In-Reply-To: <1490816334-14568-1-git-send-email-geert+renesas@glider.be>
References: <1490816334-14568-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1490816334-14568-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1da1b3628df34a2a ("base: soc: Early register bus when needed")
added support for early registration of SoC devices from a
core_initcall().  However, some drivers need to check the SoC revision
from an early_initcall(), which is even earlier.

A specific example is the Renesas R-Car SYSC driver, which manages PM
Domains and thus needs to be initialized from an early_initcall.
Preproduction versions of the R-Car H3 SoC have an additional power
area, which no longer exists on H3 ES2.0, so the R-Car SYSC driver needs
to check the exact SoC revision before instantiating a PM Domain for
that power area.

While registering the SoC bus and device, and using soc_device_match(),
from an early_initcall() do work, the "soc" directory and the "soc0"
file end up wrongly in the sysfs root, as the "bus" resp. "devices"
directories haven't been created yet.

To fix this, allow to register a single SoC device early on.
As long as the SoC bus isn't registered, soc_device_match() just
matches against this early device.
When the SoC bus is registered later, the early device is registered for
real.

Note that soc_device_register() returns NULL (no error, but also not a
valid pointer) when registering an early device.  Hence platform devices
cannot be instantiated as children of the "soc0" node representing an
early SoC device.  This should not be an issue, as that practice has
been deprecated for new platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Drop RFC state,
  - Add more explanation,
  - Add Acked-by.
---
 drivers/base/soc.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 50033081834a9ccd..909dedae4c4e1d48 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -109,15 +109,18 @@ static void soc_release(struct device *dev)
 	kfree(soc_dev);
 }
 
+static struct soc_device_attribute *early_soc_dev_attr;
+
 struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
 {
 	struct soc_device *soc_dev;
 	int ret;
 
 	if (!soc_bus_type.p) {
-		ret = bus_register(&soc_bus_type);
-		if (ret)
-			goto out1;
+		if (early_soc_dev_attr)
+			return ERR_PTR(-EBUSY);
+		early_soc_dev_attr = soc_dev_attr;
+		return NULL;
 	}
 
 	soc_dev = kzalloc(sizeof(*soc_dev), GFP_KERNEL);
@@ -159,45 +162,53 @@ void soc_device_unregister(struct soc_device *soc_dev)
 	ida_simple_remove(&soc_ida, soc_dev->soc_dev_num);
 
 	device_unregister(&soc_dev->dev);
+	early_soc_dev_attr = NULL;
 }
 
 static int __init soc_bus_register(void)
 {
-	if (soc_bus_type.p)
-		return 0;
+	int ret;
 
-	return bus_register(&soc_bus_type);
+	ret = bus_register(&soc_bus_type);
+	if (ret)
+		return ret;
+
+	if (early_soc_dev_attr)
+		return PTR_ERR(soc_device_register(early_soc_dev_attr));
+
+	return 0;
 }
 core_initcall(soc_bus_register);
 
-static int soc_device_match_one(struct device *dev, void *arg)
+static int soc_device_match_attr(const struct soc_device_attribute *attr,
+				 const struct soc_device_attribute *match)
 {
-	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
-	const struct soc_device_attribute *match = arg;
-
 	if (match->machine &&
-	    (!soc_dev->attr->machine ||
-	     !glob_match(match->machine, soc_dev->attr->machine)))
+	    (!attr->machine || !glob_match(match->machine, attr->machine)))
 		return 0;
 
 	if (match->family &&
-	    (!soc_dev->attr->family ||
-	     !glob_match(match->family, soc_dev->attr->family)))
+	    (!attr->family || !glob_match(match->family, attr->family)))
 		return 0;
 
 	if (match->revision &&
-	    (!soc_dev->attr->revision ||
-	     !glob_match(match->revision, soc_dev->attr->revision)))
+	    (!attr->revision || !glob_match(match->revision, attr->revision)))
 		return 0;
 
 	if (match->soc_id &&
-	    (!soc_dev->attr->soc_id ||
-	     !glob_match(match->soc_id, soc_dev->attr->soc_id)))
+	    (!attr->soc_id || !glob_match(match->soc_id, attr->soc_id)))
 		return 0;
 
 	return 1;
 }
 
+static int soc_device_match_one(struct device *dev, void *arg)
+{
+	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
+
+	return soc_device_match_attr(soc_dev->attr, arg);
+}
+
 /*
  * soc_device_match - identify the SoC in the machine
  * @matches: zero-terminated array of possible matches
@@ -230,6 +241,9 @@ const struct soc_device_attribute *soc_device_match(
 			break;
 		ret = bus_for_each_dev(&soc_bus_type, NULL, (void *)matches,
 				       soc_device_match_one);
+		if (ret < 0 && early_soc_dev_attr)
+			ret = soc_device_match_attr(early_soc_dev_attr,
+						    matches);
 		if (ret < 0)
 			return NULL;
 		if (!ret)
-- 
2.7.4
