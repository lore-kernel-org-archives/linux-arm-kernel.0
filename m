From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:55 -0600
Subject: [PATCH 11/16] drm/msm: Add support for iommu-sva PASIDs
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-12-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IOMMU core can support creating multiple pagetables
for a specific domai and making them available to a client
driver that has the means to manage the pagetable itself.

PASIDs are unique indexes to a software created pagetable with
the same format and characteristics as the parent IOMMU device.
The IOMMU driver allocates the pagetable and tracks it with a
unique token (PASID) - it does not touch the actual hardware.
 The client driver is expected to be able to manage the pagetables
and do something interesting with them.

Some flavors of the MSM GPU are able to allow each DRM instance
to have its own pagetable (and virtual memory space) and switch them
asynchronously at the beginning of a command. This protects against
accidental or malicious corruption or copying of buffers from other
instances.

The first step is to add a MMU implementation that can allocate a
PASID and set up a msm_mmu struct to abstract (most) of the details
from the rest of the system.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 190 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h   |   6 +
 2 files changed, 196 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index fdbe1a8372f0..99e6611969d4 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -15,6 +15,9 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/hashtable.h>
+#include <linux/arm-smmu.h>
+
 #include "msm_drv.h"
 #include "msm_mmu.h"
 
@@ -34,12 +37,32 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 	return 0;
 }
 
+static bool msm_iommu_check_per_instance(struct msm_iommu *iommu)
+{
+	int val;
+
+	if (!IS_ENABLED(CONFIG_IOMMU_SVA))
+		return false;
+
+	if (iommu_domain_get_attr(iommu->domain, DOMAIN_ATTR_SPLIT_TABLES,
+		&val))
+		return false;
+
+	return val ? true : false;
+}
+
 static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
 			    int cnt)
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	int ret;
 
+	if (msm_iommu_check_per_instance(iommu)) {
+		if (!iommu_sva_device_init(mmu->dev, 0, (1 << 31), NULL))
+			msm_mmu_set_feature(mmu,
+				MMU_FEATURE_PER_INSTANCE_TABLES);
+	}
+
 	pm_runtime_get_sync(mmu->dev);
 	ret = iommu_attach_device(iommu->domain, mmu->dev);
 	pm_runtime_put_sync(mmu->dev);
@@ -112,3 +135,170 @@ struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
 
 	return &iommu->base;
 }
+
+struct pasid_entry {
+	int pasid;
+	u64 ttbr;
+	u32 asid;
+	struct hlist_node node;
+};
+
+DECLARE_HASHTABLE(pasid_table, 4);
+
+static int install_pasid_cb(int pasid, u64 ttbr, u32 asid, void *data)
+{
+	struct pasid_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+
+	if (!entry)
+		return -ENOMEM;
+
+	entry->pasid = pasid;
+	entry->ttbr = ttbr;
+	entry->asid = asid;
+
+	/* FIXME: Assume that we'll never have a pasid conflict? */
+	/* FIXME: locks? RCU? */
+	hash_add(pasid_table, &entry->node, pasid);
+	return 0;
+}
+
+static void remove_pasid_cb(int pasid, void *data)
+{
+	struct pasid_entry *entry;
+
+	hash_for_each_possible(pasid_table, entry, node, pasid) {
+		if (pasid == entry->pasid) {
+			hash_del(&entry->node);
+			kfree(entry);
+			return;
+		}
+	}
+}
+
+struct msm_iommu_pasid {
+	struct msm_mmu base;
+	struct device *dev;
+	int pasid;
+	u64 ttbr;
+	u32 asid;
+};
+#define to_msm_iommu_pasid(x) container_of(x, struct msm_iommu_pasid, base)
+
+static int msm_iommu_pasid_attach(struct msm_mmu *mmu,
+		const char * const *names, int cnt)
+{
+	return 0;
+}
+
+static int msm_iommu_pasid_map(struct msm_mmu *mmu, uint64_t iova,
+		struct sg_table *sgt, unsigned len, int prot)
+{
+	struct msm_iommu_pasid *pasid = to_msm_iommu_pasid(mmu);
+	int ret;
+
+	ret = iommu_sva_map_sg(pasid->pasid, iova, sgt->sgl, sgt->nents, prot);
+	WARN_ON(ret < 0);
+
+	return (ret == len) ? 0 : -EINVAL;
+}
+
+static int msm_iommu_pasid_unmap(struct msm_mmu *mmu, uint64_t iova,
+		struct sg_table *sgt, unsigned len)
+{
+	struct msm_iommu_pasid *pasid = to_msm_iommu_pasid(mmu);
+
+	iommu_sva_unmap(pasid->pasid, iova, len);
+
+	return 0;
+}
+
+static void msm_iommu_pasid_detach(struct msm_mmu *mmu,
+		const char * const *names, int cnt)
+{
+}
+
+static void msm_iommu_pasid_destroy(struct msm_mmu *mmu)
+{
+	struct msm_iommu_pasid *pasid = to_msm_iommu_pasid(mmu);
+
+	iommu_sva_free_pasid(pasid->pasid, pasid->dev);
+	kfree(pasid);
+}
+
+static const struct msm_mmu_funcs pasid_funcs = {
+		.attach = msm_iommu_pasid_attach,
+		.detach = msm_iommu_pasid_detach,
+		.map = msm_iommu_pasid_map,
+		.unmap = msm_iommu_pasid_unmap,
+		.destroy = msm_iommu_pasid_destroy,
+};
+
+static const struct arm_smmu_pasid_ops msm_iommu_pasid_ops = {
+	.install_pasid = install_pasid_cb,
+	.remove_pasid = remove_pasid_cb,
+};
+
+struct msm_mmu *msm_iommu_pasid_new(struct msm_mmu *parent)
+{
+	struct msm_iommu *parent_iommu = to_msm_iommu(parent);
+	struct msm_iommu_pasid *pasid;
+	int id;
+
+	if (!msm_mmu_has_feature(parent, MMU_FEATURE_PER_INSTANCE_TABLES))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	pasid = kzalloc(sizeof(*pasid), GFP_KERNEL);
+	if (!pasid)
+		return ERR_PTR(-ENOMEM);
+
+	arm_smmu_add_pasid_ops(parent_iommu->domain, &msm_iommu_pasid_ops,
+		NULL);
+
+	id = iommu_sva_alloc_pasid(parent_iommu->domain, parent->dev);
+	if (id < 0) {
+		kfree(pasid);
+		return ERR_PTR(id);
+	}
+
+	pasid->pasid = id;
+	pasid->dev = parent->dev;
+
+	msm_mmu_init(&pasid->base, parent->dev, &pasid_funcs);
+
+	return &pasid->base;
+}
+
+/* Given a pasid return the TTBR and ASID associated with it */
+int msm_iommu_pasid_info(struct msm_mmu *mmu, u64 *ttbr, u32 *asid)
+{
+	struct msm_iommu_pasid *pasid;
+	struct pasid_entry *entry;
+
+	if (mmu->funcs->map != msm_iommu_pasid_map)
+		return -ENODEV;
+
+	pasid = to_msm_iommu_pasid(mmu);
+
+	if (!pasid->ttbr) {
+		/* Find the pasid entry in the hash */
+		hash_for_each_possible(pasid_table, entry, node, pasid->pasid) {
+			if (pasid->pasid == entry->pasid) {
+				pasid->ttbr = entry->ttbr;
+				pasid->asid = entry->asid;
+				goto out;
+			}
+		}
+
+		WARN(1, "Couldn't find the entry for pasid %d\n", pasid->pasid);
+		return -EINVAL;
+	}
+
+out:
+	if (*ttbr)
+		*ttbr = pasid->ttbr;
+
+	if (*asid)
+		*asid = pasid->asid;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index 85df78d71398..29436b9daa73 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -30,6 +30,9 @@ struct msm_mmu_funcs {
 	void (*destroy)(struct msm_mmu *mmu);
 };
 
+/* MMU features */
+#define MMU_FEATURE_PER_INSTANCE_TABLES (1 << 0)
+
 struct msm_mmu {
 	const struct msm_mmu_funcs *funcs;
 	struct device *dev;
@@ -48,6 +51,9 @@ static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
 struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain);
 struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu);
 
+struct msm_mmu *msm_iommu_pasid_new(struct msm_mmu *parent);
+int msm_iommu_pasid_info(struct msm_mmu *mmu, u64 *ttbr, u32 *asid);
+
 static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
 		int (*handler)(void *arg, unsigned long iova, int flags))
 {
-- 
2.17.0
