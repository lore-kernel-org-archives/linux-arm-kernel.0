From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Oct 2015 13:52:32 +0100
Subject: [PATCH 3/3] mtd: physmap_of: handle the new "partition-type"
In-Reply-To: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
References: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1446123152-22666-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We defined a new device tree binding for partitions, and if they
are found these need to be translated into a string array of
Linux partitions. Reuse the string-to-array split function and
support "arm,arm-flash-structure" by splitting "afs" into
{"afs", NULL} and passing that along.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/maps/physmap_of.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 1b66ca66206b..8c09d7e23b6e 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -105,7 +105,7 @@ static struct mtd_info *obsolete_probe(struct platform_device *dev,
 	}
 }
 
-/* When partitions are set we look for a linux,part-probe property which
+/* When partitions are set we look for a partition-type property which
    specifies the list of partition probers to use. If none is given then the
    default is use. These take precedence over other device tree
    information. */
@@ -150,9 +150,25 @@ static const char * const *of_get_probes(struct device_node *dp)
 	int cplen;
 	int ret;
 
+	/*
+	 * The proper device tree bindings take precedence.
+	 */
+	ret = of_property_read_string(dp, "partition-type", &cp);
+	if (!ret) {
+		pr_info("check for partition type \"%s\"\n", cp);
+		if (!strcmp(cp, "arm,arm-flash-structure"))
+			return string_to_array("afs", 1);
+	}
+
+	/*
+	 * Else look for the deprecated binding, or fall back to
+	 * defaults.
+	 */
 	cp = of_get_property(dp, "linux,part-probe", &cplen);
 	if (cp == NULL)
 		return part_probe_types_def;
+	pr_info("DT is using the deprecated \"linux,part-probe\" binding\n");
+	pr_info("please move to the standard \"partition-type\" binding\n");
 	return string_to_array(cp, cplen);
 }
 
-- 
2.4.3
