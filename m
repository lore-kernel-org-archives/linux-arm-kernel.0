From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 17 May 2018 16:47:01 +0100
Subject: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
In-Reply-To: <a64ed431-0f60-2711-4138-eeefc7ba2d8b@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
 <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
 <a64ed431-0f60-2711-4138-eeefc7ba2d8b@arm.com>
Message-ID: <20180517154701.GA20281@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/18 11:56, Sudeep Holla wrote:
> Hi Andy,
> 
> On 15/05/18 20:32, Andy Shevchenko wrote:
>> On Tue, May 15, 2018 at 8:15 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
>>> On 05/11/2018 06:57 PM, Jeremy Linton wrote:
>>
>>>>   -     cache_size = of_get_property(this_leaf->of_node, propname, NULL);
>>>> +       cache_size = of_get_property(np, propname, NULL);
>>>>         if (cache_size)
>>>>                 this_leaf->size = of_read_number(cache_size, 1);
>>
>> Can't you switch to of_read_property_uXX() variant here?
>>
> 
> This patch is just changing the first argument to the calls. So if we
> need to change, it has to be separate patch.
> 
> Now, we can use of_property_read_u64() but is there any particular
> reason you mention that ? One reason I can see is that we can avoid
> making explicit of_get_property call. Just wanted to the motive before I
> can write the patch.
> 

Is below patch does what you were looking for ?

Regards,
Sudeep

--
>From 71f1c10ddb5915a92fa74d38a4e2406d0ab27845 Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 16 May 2018 13:45:53 +0100
Subject: [PATCH] drivers: base: cacheinfo: use OF property_read_u64 instead of
 get_property,read_number

of_property_read_u64 searches for a property in a device node and read
a 64-bit value from it. Instead of using of_get_property to get the
property and then read 64-bit value using of_read_number, we can make
use of of_property_read_u64.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 2880e2ab01f5..56715014f07b 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -74,22 +74,21 @@ static inline int get_cacheinfo_idx(enum cache_type type)
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
+	u64 line_size;
 	int i, lim, ct_idx;
 
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
@@ -99,27 +98,26 @@ static void cache_get_line_size(struct cacheinfo *this_leaf,
 		const char *propname;
 
 		propname = cache_type_info[ct_idx].line_size_props[i];
-		line_size = of_get_property(np, propname, NULL);
-		if (line_size)
+		line_size = of_property_read_u64(np, propname, &line_size);
+		if (line_size) {
+			this_leaf->coherency_line_size = line_size;
 			break;
+		}
 	}
 
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
