From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 13 Feb 2017 18:50:40 -0800
Subject: [RFC/PATCH] of: Mark property::value as const
Message-ID: <20170214025040.23955-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'blob' we pass into populate_properties() is marked as const,
but we cast that const away when we assign the result of
fdt_getprop_by_offset() to pp->value. Let's mark value as const
instead, so that code can't mistakenly write to the value of the
property that we've so far advertised as const.

Unfortunately, this exposes a problem with the fdt resolver code,
where we overwrite the value member of properties of phandles to
update them with their final value. Add a comment for now to
indicate where we're potentially writing over const data.

You can see the problem here by loading an overlay dtb into
the kernel via the request firmware helper method (not direct
loading) and then passing that tree to the resolver on an arm64
device. In this case, the firmware data is vmapped with KERNEL_PAGE_RO
and the code crashes when attempting to write to the blob to update
the phandle properties.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

I was thinking perhaps it would work to store another __be32 variant
of the phandle in each device node, but then we still have a problem
with properties that have phandles inside them at some offset that we
need to update. I guess the only real solution is to deep copy the
property in that case and then save around some info to free the
duplicated property later on?

 drivers/of/base.c     |  2 +-
 drivers/of/fdt.c      | 12 ++++++------
 drivers/of/resolver.c |  3 +++
 include/linux/of.h    |  2 +-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index fb6bb855714e..8e5f29b814c9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1156,7 +1156,7 @@ EXPORT_SYMBOL_GPL(of_property_count_elems_of_size);
  * property data is too small or too large.
  *
  */
-static void *of_find_property_value_of_size(const struct device_node *np,
+static const void *of_find_property_value_of_size(const struct device_node *np,
 			const char *propname, u32 min, u32 max, size_t *len)
 {
 	struct property *prop = of_find_property(np, propname, NULL);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index c9b5cac03b36..0635ef5dabf3 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -222,7 +222,7 @@ static void populate_properties(const void *blob,
 
 		pp->name   = (char *)pname;
 		pp->length = sz;
-		pp->value  = (__be32 *)val;
+		pp->value  = val;
 		*pprev     = pp;
 		pprev      = &pp->next;
 	}
@@ -232,6 +232,7 @@ static void populate_properties(const void *blob,
 	 */
 	if (!has_name) {
 		const char *p = nodename, *ps = p, *pa = NULL;
+		char *b;
 		int len;
 
 		while (*p) {
@@ -250,13 +251,12 @@ static void populate_properties(const void *blob,
 		if (!dryrun) {
 			pp->name   = "name";
 			pp->length = len;
-			pp->value  = pp + 1;
+			pp->value  = b = (char *)(pp + 1);
 			*pprev     = pp;
 			pprev      = &pp->next;
-			memcpy(pp->value, ps, len - 1);
-			((char *)pp->value)[len - 1] = 0;
-			pr_debug("fixed up name for %s -> %s\n",
-				 nodename, (char *)pp->value);
+			memcpy(b, ps, len - 1);
+			b[len - 1] = 0;
+			pr_debug("fixed up name for %s -> %s\n", nodename, b);
 		}
 	}
 
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 8bf12e904fd2..6d88f8100318 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -93,6 +93,7 @@ static void adjust_overlay_phandles(struct device_node *overlay,
 		if (phandle == OF_PHANDLE_ILLEGAL)
 			continue;
 
+		/* This is bad because we cast away const */
 		*(uint32_t *)prop->value = cpu_to_be32(overlay->phandle);
 	}
 
@@ -154,6 +155,7 @@ static int update_usages_of_a_phandle_reference(struct device_node *overlay,
 			goto err_fail;
 		}
 
+		/* This is bad because we cast away const */
 		*(__be32 *)(prop->value + offset) = cpu_to_be32(phandle);
 	}
 
@@ -222,6 +224,7 @@ static int adjust_local_phandle_references(struct device_node *local_fixups,
 
 			phandle = be32_to_cpu(*(__be32 *)(prop->value + off));
 			phandle += phandle_delta;
+			/* This is bad because we cast away const */
 			*(__be32 *)(prop->value + off) = cpu_to_be32(phandle);
 		}
 	}
diff --git a/include/linux/of.h b/include/linux/of.h
index f22d4a83ca07..b0253886ef46 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -35,7 +35,7 @@ typedef u32 ihandle;
 struct property {
 	char	*name;
 	int	length;
-	void	*value;
+	const void *value;
 	struct property *next;
 	unsigned long _flags;
 	unsigned int unique_id;
-- 
2.10.0.297.gf6727b0
