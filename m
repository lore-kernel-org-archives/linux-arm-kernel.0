From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 23 Feb 2015 16:32:39 +0000
Subject: [PATCH v2] drivers/base: cacheinfo: validate device node for all the
 caches
In-Reply-To: <1424095816-4414-1-git-send-email-sudeep.holla@arm.com>
References: <1424095816-4414-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1424709159-13152-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On architectures that depend on DT for obtaining cache hierarcy, we need
to validate the device node for all the cache indices, failing to do so
might result in wrong information being exposed to the userspace.

This is quite possible on initial/incomplete versions of the device
trees. In such cases, it's better to bail out if all the required device
nodes are not present.

This patch adds checks for the validation of device node for all the
caches and doesn't initialise the cacheinfo if there's any error.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

v1->v2:
 - Updated log information as suggested by Mark
 - Added Mark's ACK

Hi Greg,

Can you please pick this fix for the next rc ?

Without this there's possibility that erroneous information is exposed
to userspace on architecture depending on DT especially if DT lacks
cache hierarcy information.

Regards,
Sudeep

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 6e64563361f0..9c2ba1c97c42 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -62,15 +62,21 @@ static int cache_setup_of_node(unsigned int cpu)
 		return -ENOENT;
 	}
 
-	while (np && index < cache_leaves(cpu)) {
+	while (index < cache_leaves(cpu)) {
 		this_leaf = this_cpu_ci->info_list + index;
 		if (this_leaf->level != 1)
 			np = of_find_next_cache_node(np);
 		else
 			np = of_node_get(np);/* cpu node itself */
+		if (!np)
+			break;
 		this_leaf->of_node = np;
 		index++;
 	}
+
+	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
+		return -ENOENT;
+
 	return 0;
 }
 
@@ -189,8 +195,11 @@ static int detect_cache_attributes(unsigned int cpu)
 	 * will be set up here only if they are not populated already
 	 */
 	ret = cache_shared_cpu_map_setup(cpu);
-	if (ret)
+	if (ret) {
+		pr_warn("Unable to detect cache hierarcy from DT for CPU %d\n",
+			cpu);
 		goto free_ci;
+	}
 	return 0;
 
 free_ci:
-- 
1.9.1
