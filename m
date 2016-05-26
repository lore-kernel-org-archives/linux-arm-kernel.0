From: joe@perches.com (Joe Perches)
Date: Thu, 26 May 2016 09:35:03 -0700
Subject: [PATCH 3/3] arm64/numa: fix type info
In-Reply-To: <CAFpQJXWih2V9Ki-vkL+cDni=VoWL0nA-fx5B5XtfNxFsoUso-g@mail.gmail.com>
References: <1464230639-9852-1-git-send-email-thunder.leizhen@huawei.com>
 <1464230639-9852-3-git-send-email-thunder.leizhen@huawei.com>
 <CAFpQJXWih2V9Ki-vkL+cDni=VoWL0nA-fx5B5XtfNxFsoUso-g@mail.gmail.com>
Message-ID: <1464280503.16344.40.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-05-26 at 09:22 -0700, Ganapatrao Kulkarni wrote:
> On Wed, May 25, 2016 at 7:43 PM, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> > numa_init(of_numa_init) may returned error because of numa configuration
> > error. So "No NUMA configuration found" is inaccurate. In fact, specific
> > configuration error information can be immediately printed by the
> > testing branch. So "No NUMA..." only needs to be printed when numa_off.
[]
> > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
[]
> > @@ -362,7 +362,8 @@ static int __init dummy_numa_init(void)
> > ????????int ret;
> > ????????struct memblock_region *mblk;
> > 
> > -???????pr_info("%s\n", "No NUMA configuration found");
> > +???????if (numa_off)
> IIRC, it should be
> if (!numa_off)
> we want to print this message when we failed to find proper numa configuration.
> when numa_off is set, we will not look for any numa configuration.
> 
> > 
> > +???????????????pr_info("%s\n", "No NUMA configuration found");

trivia:

Using printk("%s\n", "string") just makes the object code larger
for no particular benefit.

	pr_info("No NUMA configuration found\n");

would be smaller, faster and more intelligible for humans too.

Maybe something like this:
---
?arch/arm64/mm/numa.c | 41 ++++++++++++++++++++---------------------
?1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 98dc104..2042452 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -17,6 +17,8 @@
? * along with this program.??If not, see <http://www.gnu.org/licenses/>.
? */
?
+#define pr_fmt(fmt) "NUMA: " fmt
+
?#include <linux/bootmem.h>
?#include <linux/memblock.h>
?#include <linux/module.h>
@@ -36,7 +38,7 @@ static __init int numa_parse_early_param(char *opt)
?	if (!opt)
?		return -EINVAL;
?	if (!strncmp(opt, "off", 3)) {
-		pr_info("%s\n", "NUMA turned off");
+		pr_info("NUMA turned off\n");
?		numa_off = 1;
?	}
?	return 0;
@@ -107,7 +109,7 @@ static void __init setup_node_to_cpumask_map(void)
?		set_cpu_numa_node(cpu, NUMA_NO_NODE);
?
?	/* cpumask_of_node() will now work */
-	pr_debug("NUMA: Node to cpumask map for %d nodes\n", nr_node_ids);
+	pr_debug("Node to cpumask map for %d nodes\n", nr_node_ids);
?}
?
?/*
@@ -142,14 +144,14 @@ int __init numa_add_memblk(int nid, u64 start, u64 size)
?
?	ret = memblock_set_node(start, size, &memblock.memory, nid);
?	if (ret < 0) {
-		pr_err("NUMA: memblock [0x%llx - 0x%llx] failed to add on node %d\n",
-			start, (start + size - 1), nid);
+		pr_err("memblock [0x%llx - 0x%llx] failed to add on node %d\n",
+		???????start, (start + size - 1), nid);
?		return ret;
?	}
?
?	node_set(nid, numa_nodes_parsed);
-	pr_info("NUMA: Adding memblock [0x%llx - 0x%llx] on node %d\n",
-			start, (start + size - 1), nid);
+	pr_info("Adding memblock [0x%llx - 0x%llx] on node %d\n",
+		start, (start + size - 1), nid);
?	return ret;
?}
?
@@ -163,19 +165,18 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
?	void *nd;
?	int tnid;
?
-	pr_info("NUMA: Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
-			nid, start_pfn << PAGE_SHIFT,
-			(end_pfn << PAGE_SHIFT) - 1);
+	pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
+		nid, start_pfn << PAGE_SHIFT, (end_pfn << PAGE_SHIFT) - 1);
?
?	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
?	nd = __va(nd_pa);
?
?	/* report and initialize */
-	pr_info("NUMA: NODE_DATA [mem %#010Lx-%#010Lx]\n",
+	pr_info("NODE_DATA [mem %#010Lx-%#010Lx]\n",
?		nd_pa, nd_pa + nd_size - 1);
?	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
?	if (tnid != nid)
-		pr_info("NUMA: NODE_DATA(%d) on node %d\n", nid, tnid);
+		pr_info("NODE_DATA(%d) on node %d\n", nid, tnid);
?
?	node_data[nid] = nd;
?	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
@@ -232,8 +233,7 @@ static int __init numa_alloc_distance(void)
?			numa_distance[i * numa_distance_cnt + j] = i == j ?
?				LOCAL_DISTANCE : REMOTE_DISTANCE;
?
-	pr_debug("NUMA: Initialized distance table, cnt=%d\n",
-			numa_distance_cnt);
+	pr_debug("Initialized distance table, cnt=%d\n", numa_distance_cnt);
?
?	return 0;
?}
@@ -254,20 +254,20 @@ static int __init numa_alloc_distance(void)
?void __init numa_set_distance(int from, int to, int distance)
?{
?	if (!numa_distance) {
-		pr_warn_once("NUMA: Warning: distance table not allocated yet\n");
+		pr_warn_once("Warning: distance table not allocated yet\n");
?		return;
?	}
?
?	if (from >= numa_distance_cnt || to >= numa_distance_cnt ||
?			from < 0 || to < 0) {
-		pr_warn_once("NUMA: Warning: node ids are out of bound, from=%d to=%d distance=%d\n",
-			????from, to, distance);
+		pr_warn_once("Warning: node ids are out of bound, from=%d to=%d distance=%d\n",
+			?????from, to, distance);
?		return;
?	}
?
?	if ((u8)distance != distance ||
?	????(from == to && distance != LOCAL_DISTANCE)) {
-		pr_warn_once("NUMA: Warning: invalid distance parameter, from=%d to=%d distance=%d\n",
+		pr_warn_once("Warning: invalid distance parameter, from=%d to=%d distance=%d\n",
?			?????from, to, distance);
?		return;
?	}
@@ -294,7 +294,7 @@ static int __init numa_register_nodes(void)
?	/* Check that valid nid is set to memblks */
?	for_each_memblock(memory, mblk)
?		if (mblk->nid == NUMA_NO_NODE || mblk->nid >= MAX_NUMNODES) {
-			pr_warn("NUMA: Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
+			pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
?				mblk->nid, mblk->base,
?				mblk->base + mblk->size - 1);
?			return -EINVAL;
@@ -362,9 +362,8 @@ static int __init dummy_numa_init(void)
?	int ret;
?	struct memblock_region *mblk;
?
-	pr_info("%s\n", "No NUMA configuration found");
-	pr_info("NUMA: Faking a node at [mem %#018Lx-%#018Lx]\n",
-	???????0LLU, PFN_PHYS(max_pfn) - 1);
+	pr_info("No NUMA configuration found - faking a node at [mem %#018Lx-%#018Lx]\n",
+		0LLU, PFN_PHYS(max_pfn) - 1);
?
?	for_each_memblock(memory, mblk) {
?		ret = numa_add_memblk(0, mblk->base, mblk->size);
