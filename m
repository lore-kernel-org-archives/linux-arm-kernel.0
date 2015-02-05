From: balbi@ti.com (Felipe Balbi)
Date: Thu, 5 Feb 2015 12:01:06 -0600
Subject: [RFC/PATCH 2/2] of: allow for boolean flags to have value
In-Reply-To: <1423159266-25561-1-git-send-email-balbi@ti.com>
References: <1423159266-25561-1-git-send-email-balbi@ti.com>
Message-ID: <1423159266-25561-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

allowing values to boolean flags lets us setup
defaults on DTSI which can get disabled later
at board DTS if, for whatever reason, board can't
use that default.

One such example is DM81xx EVM where we can't use
MUSB's multipoint feature even though SoC supports
it. Something at the board level prevents us from
using the feature.

Instead of removing "multipoint;" from DTSI and
adding it to all board DTS just so we can remove
it from our quirky board seems like overkill when
we could just add:

	multipoint = <0>;

to that quirky board's DTS.

Note that the description here is but one example
and it's likely many others have faced something
similar.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 include/linux/of.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 76c055b20fef..c5ee9320f237 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -792,14 +792,32 @@ static inline int of_property_read_u32(const struct device_node *np,
  * @propname:	name of the property to be searched.
  *
  * Search for a property in a device node.
- * Returns true if the property exist false otherwise.
+ * Returns true if the property exist and has a value greater than zero,
+ * fals otherwise.
  */
 static inline bool of_property_read_bool(const struct device_node *np,
 					 const char *propname)
 {
 	struct property *prop = of_find_property(np, propname, NULL);
+	int rc;
+	u32 val;
 
-	return prop ? true : false;
+	if (!prop)
+		return false;
+
+	rc = of_property_read_u32(np, propname, &val);
+
+	/*
+	 * if property doesn't have a value, or prop->length == 0 and
+	 * we overflow, treat it as simple value-less flag.
+	 */
+	if (rc == -ENODATA || rc == -EOVERFLOW)
+		return true;
+	if (WARN(rc < 0, "failed to read '%s' value -> %d\n",
+				propname, rc))
+		return false;
+
+	return !!val;
 }
 
 static inline int of_property_read_s32(const struct device_node *np,
-- 
2.3.0-rc1
