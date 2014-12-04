From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 04 Dec 2014 12:26:58 +0000
Subject: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
 drivers
In-Reply-To: <2579924.PPXuLn3o19@wuerfel>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
 <CACxGe6vyMkyE9ZRj_FQzi19ESEo7OV_RQoVV65xBYpdQV8cRGQ@mail.gmail.com>
 <2579924.PPXuLn3o19@wuerfel>
Message-ID: <54805312.6000402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 03/12/14 19:57, Arnd Bergmann wrote:
[...]
>> Good catch. This is not good. The data pointer should be avoided since
>> there are no controls over its use. Until a better solution can be
>> implemented, probably the safest thing to do is add a struct iommu_ops
>> pointer to struct device_node. However, assuming that only a small
>> portion of nodes will actually have iommu_ops set, I'd rather see a
>> separate registry that matches device_nodes to iommu_ops.
>
> Fair enough. Will, can you take a copy of drivers/dma/of-dma.c and
> adapt it as needed? It should be exactly what we need to start
> out and can be extended and generalized later.

I'm quite keen to see this series go in, since I'm depending on it to 
make arm64 IOMMU DMA ops "just work". Will and I came to the conclusion 
the other day that we pretty much need to build up some kind of bus 
abstraction based on the probe data in order to be able to assign IOMMU 
groups correctly, which can also subsume this particular problem in the 
long run. Since I've made a start on that already, I've hacked the 
following short-term fix out of it. Tested on my Juno - admittedly with 
only two SMMUs and one master (EHCI) being probed, but it didn't blow up 
or regress anything.

Regards,
Robin.

--->8---
 From 1f3d2612682c239e53f2c20e2ac5d19ef3f5387c Mon Sep 17 00:00:00 2001
Message-Id: 
<1f3d2612682c239e53f2c20e2ac5d19ef3f5387c.1417695078.git.robin.murphy@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Date: Thu, 4 Dec 2014 11:53:13 +0000
Subject: [PATCH] iommu: store DT-probed IOMMU data privately

Since the data pointer in the DT node is public and may be overwritten
by conflicting code, move the DT-probed IOMMU ops to a private list
where they will be safe.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/iommu/of_iommu.c | 38 ++++++++++++++++++++++++++++++++++++++
  include/linux/of_iommu.h | 12 ++----------
  2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 73236d3..5cd451c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -94,6 +94,44 @@ int of_get_dma_window(struct device_node *dn, const 
char *prefix, int index,
  }
  EXPORT_SYMBOL_GPL(of_get_dma_window);

+struct of_iommu_node {
+	struct hlist_node list;
+	struct device_node *np;
+	const struct iommu_ops *ops;
+};
+static HLIST_HEAD(of_iommu_list);
+static DEFINE_SPINLOCK(of_iommu_lock);
+
+void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops)
+{
+	struct of_iommu_node *iommu = kmalloc(sizeof(*iommu), GFP_KERNEL);
+
+	if (!iommu)
+		return;
+
+	INIT_HLIST_NODE(&iommu->list);
+	iommu->np = np;
+	iommu->ops = ops;
+	spin_lock(&of_iommu_lock);
+	hlist_add_head(&iommu->list, &of_iommu_list);
+	spin_unlock(&of_iommu_lock);
+}
+
+struct iommu_ops *of_iommu_get_ops(struct device_node *np)
+{
+	struct of_iommu_node *node;
+	const struct iommu_ops *ops = NULL;
+
+	spin_lock(&of_iommu_lock);
+	hlist_for_each_entry(node, &of_iommu_list, list)
+		if (node->np == np) {
+			ops = node->ops;
+			break;
+		}
+	spin_unlock(&of_iommu_lock);
+	return (struct iommu_ops *)ops;
+}
+
  struct iommu_ops *of_iommu_configure(struct device *dev)
  {
  	struct of_phandle_args iommu_spec;
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index d03abbb..e27c53a 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -31,16 +31,8 @@ static inline struct iommu_ops 
*of_iommu_configure(struct device *dev)

  #endif	/* CONFIG_OF_IOMMU */

-static inline void of_iommu_set_ops(struct device_node *np,
-				    const struct iommu_ops *ops)
-{
-	np->data = (struct iommu_ops *)ops;
-}
-
-static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
-{
-	return np->data;
-}
+void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
+struct iommu_ops *of_iommu_get_ops(struct device_node *np);

  extern struct of_device_id __iommu_of_table;

-- 
1.9.1
