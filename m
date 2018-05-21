From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 21 May 2018 11:32:29 +0100
Subject: [PATCH] drivers: base: cacheinfo: use OF property_read_u64 instead of
 get_property, read_number
In-Reply-To: <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
References: <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
Message-ID: <1526898749-17263-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_property_read_u64 searches for a property in a device node and read
a 64-bit value from it. Instead of using of_get_property to get the
property and then read 64-bit value using of_read_number, we can
simplify it by using of_property_read_u64.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 2880e2ab01f5..6704563a9339 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -74,52 +74,50 @@ static inline int get_cacheinfo_idx(enum cache_type type)
 static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
 {
 	const char *propname;
-	const __be32 *cache_size;
+	u64 cache_size;
 	int ct_idx;
 
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].size_prop;
 
-	cache_size = of_get_property(np, propname, NULL);
-	if (cache_size)
-		this_leaf->size = of_read_number(cache_size, 1);
+	if (!of_property_read_u64(np, propname, &cache_size))
+		this_leaf->size = cache_size;
 }
 
 /* not cache_line_size() because that's a macro in include/linux/cache.h */
 static void cache_get_line_size(struct cacheinfo *this_leaf,
 				struct device_node *np)
 {
-	const __be32 *line_size;
 	int i, lim, ct_idx;
 
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	lim = ARRAY_SIZE(cache_type_info[ct_idx].line_size_props);
 
 	for (i = 0; i < lim; i++) {
+		int ret;
+		u64 line_size;
 		const char *propname;
 
 		propname = cache_type_info[ct_idx].line_size_props[i];
-		line_size = of_get_property(np, propname, NULL);
-		if (line_size)
+		ret = of_property_read_u64(np, propname, &line_size);
+		if (!ret) {
+			this_leaf->coherency_line_size = line_size;
 			break;
+		}
 	}
-
-	if (line_size)
-		this_leaf->coherency_line_size = of_read_number(line_size, 1);
 }
 
 static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
 {
 	const char *propname;
-	const __be32 *nr_sets;
+	u64 nr_sets;
 	int ct_idx;
 
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].nr_sets_prop;
 
-	nr_sets = of_get_property(np, propname, NULL);
-	if (nr_sets)
-		this_leaf->number_of_sets = of_read_number(nr_sets, 1);
+	if (!of_property_read_u64(np, propname, &nr_sets))
+		this_leaf->number_of_sets = nr_sets;
 }
 
 static void cache_associativity(struct cacheinfo *this_leaf)
-- 
2.7.4
