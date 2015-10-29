From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Oct 2015 13:52:31 +0100
Subject: [PATCH 2/3] mtd: physmap_of: break out array clone code
In-Reply-To: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
References: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1446123152-22666-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a piece of code cloning a string array in the end of
the of_get_probes() function. Break it out, so we can reuse it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/maps/physmap_of.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 3e614e9119d5..1b66ca66206b 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -112,17 +112,18 @@ static struct mtd_info *obsolete_probe(struct platform_device *dev,
 static const char * const part_probe_types_def[] = {
 	"cmdlinepart", "RedBoot", "ofpart", "ofoldpart", NULL };
 
-static const char * const *of_get_probes(struct device_node *dp)
+/**
+ * string_to_array() - split a string into an array
+ *
+ * This takes "a\0string\0array" and splits it into { "a", "string", "array" }
+ * with a newly allocated array of pointers returned. A NULL terminator
+ * is also added at the end of the array.
+ */
+static const char * const *string_to_array(const char *cp, int cplen)
 {
-	const char *cp;
-	int cplen;
+	const char **res;
 	unsigned int l;
 	unsigned int count;
-	const char **res;
-
-	cp = of_get_property(dp, "linux,part-probe", &cplen);
-	if (cp == NULL)
-		return part_probe_types_def;
 
 	count = 0;
 	for (l = 0; l != cplen; l++)
@@ -143,6 +144,18 @@ static const char * const *of_get_probes(struct device_node *dp)
 	return res;
 }
 
+static const char * const *of_get_probes(struct device_node *dp)
+{
+	const char *cp;
+	int cplen;
+	int ret;
+
+	cp = of_get_property(dp, "linux,part-probe", &cplen);
+	if (cp == NULL)
+		return part_probe_types_def;
+	return string_to_array(cp, cplen);
+}
+
 static void of_free_probes(const char * const *probes)
 {
 	if (probes != part_probe_types_def)
-- 
2.4.3
