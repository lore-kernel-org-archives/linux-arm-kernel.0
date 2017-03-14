From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 14 Mar 2017 12:23:39 -0700
Subject: [RFC/PATCH] of: Mark property::value as const
In-Reply-To: <58C4EA3C.4070503@gmail.com>
References: <20170214025040.23955-1-stephen.boyd@linaro.org>
 <58AF6B88.6020709@gmail.com> <58C4EA3C.4070503@gmail.com>
Message-ID: <148951941955.30407.4217812594792852642@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Frank Rowand (2017-03-11 22:27:08)
> Hi Stephen,
> 
> On 02/23/17 15:08, Frank Rowand wrote:
> > On 02/13/17 18:50, Stephen Boyd wrote:
> >> The 'blob' we pass into populate_properties() is marked as const,
> >> but we cast that const away when we assign the result of
> >> fdt_getprop_by_offset() to pp->value. Let's mark value as const
> >> instead, so that code can't mistakenly write to the value of the
> >> property that we've so far advertised as const.
> > 
> > Instead of struct property field value being a pointer into the
> > FDT, I would rather copy the data to newly allocated memory and
> > have value be a pointer to that memory.  This is required if we
> > want to make /sys/firmware/fdt optional, which would allow us to
> > free the memory containing the initial boot FDT.
> > 
> > I also do not want overlay live subtrees to have any pointers
> > into the FDT that was used to populate the overlay, so copying
> > the data solves that problem also.
> > 
> > 
> >> Unfortunately, this exposes a problem with the fdt resolver code,
> >> where we overwrite the value member of properties of phandles to
> >> update them with their final value. Add a comment for now to
> >> indicate where we're potentially writing over const data.
> > 
> > Yes, the resolver code needs to adjust phandle values.
> > 
> > I think I can get rid of the resolver modifying the various phandle
> > values, and instead just modify the phandle value in struct
> > device_node.  At the same time, I think I can also remove all
> > instances of the phandle properties ('linux,phandle', 'ibm,phandle',
> > 'phandle') in the live tree.  These properties should not be
> > accessed directly by any code outside of the device tree framework
> > since the phandle is located in the struct device_node.  A quick
> > grep does not show any such accesses of the phandle properties,
> > but I want to look more closely.
> 
> After reading through a bit of code, I am confident that I can
> modify the resolver code to not modify the various phandle
> property values.  There are a few tentacles reaching out to
> other areas that I will have to fix also.  The biggest task
> for me will be to create some good test code.
> 
> I'll be unavailable this week, so I'll start on it in about
> a week.

Ok. No worries from my side. I'm interested to see how random properties
will be "corrected" without modifying them. I can only assume the plan
is to copy those properties.

The kbuild robot found more cases where marking this as const causes
issues. Please see the updated patch inline.

-----8<-----
From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH] of: Mark property::value as const

The 'blob' we pass into populate_properties() is marked as const,
but we cast that const away when we assign the result of
fdt_getprop_by_offset() to pp->value. Let's mark value as const
instead, so that code can't mistakenly write to the value of the
property that we've so far advertised as const.

Unfortunately, this exposes a problem with the fdt resolver code,
where we overwrite the value member of properties of phandles to
update them with their final value. Add a comment for now to
indicate where we're potentially writing over const data.

You can see such the problem here by loading an overlay dtb into
the kernel via the fw helper method (not direct loading) and
passing that tree to the resolver on an arm64 device. In this
case, the firmware data is vmapped with KERNEL_PAGE_RO and the
resolver code crashes when attempting to write to blob to update
the phandle properties.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/of/base.c     |  2 +-
 drivers/of/fdt.c      | 12 ++++++------
 drivers/of/pdt.c      |  9 +++++----
 drivers/of/resolver.c |  3 +++
 fs/openpromfs/inode.c |  2 +-
 include/linux/of.h    |  2 +-
 6 files changed, 17 insertions(+), 13 deletions(-)

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
 
diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index d2acae825af9..6984717fcfb7 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -94,6 +94,7 @@ static struct property * __init of_pdt_build_one_prop(phandle node, char *prev,
 {
 	static struct property *tmp = NULL;
 	struct property *p;
+	char *s;
 	int err;
 
 	if (tmp) {
@@ -109,8 +110,8 @@ static struct property * __init of_pdt_build_one_prop(phandle node, char *prev,
 	if (special_name) {
 		strcpy(p->name, special_name);
 		p->length = special_len;
-		p->value = prom_early_alloc(special_len);
-		memcpy(p->value, special_val, special_len);
+		p->value = s = prom_early_alloc(special_len);
+		memcpy(s, special_val, special_len);
 	} else {
 		err = of_pdt_prom_ops->nextprop(node, prev, p->name);
 		if (err) {
@@ -123,12 +124,12 @@ static struct property * __init of_pdt_build_one_prop(phandle node, char *prev,
 		} else {
 			int len;
 
-			p->value = prom_early_alloc(p->length + 1);
+			p->value = s = prom_early_alloc(p->length + 1);
 			len = of_pdt_prom_ops->getproperty(node, p->name,
 					p->value, p->length);
 			if (len <= 0)
 				p->length = 0;
-			((unsigned char *)p->value)[p->length] = '\0';
+			s[p->length] = '\0';
 		}
 	}
 	return p;
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
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 13215f26e321..68cbb3fddbc2 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -65,7 +65,7 @@ static int is_string(unsigned char *p, int len)
 static int property_show(struct seq_file *f, void *v)
 {
 	struct property *prop = f->private;
-	void *pval;
+	const void *pval;
 	int len;
 
 	len = prop->length;
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
