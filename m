From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:56 -0600
Subject: [PATCH 12/16] drm/msm: Add support for per-instance address spaces
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-13-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to allocate a new pasid from a existing
MMU domain and create a per-instance address space.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/msm_drv.h     |  3 +++
 drivers/gpu/drm/msm/msm_gem_vma.c | 37 +++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 897b08135927..d92b009dfef4 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -177,6 +177,9 @@ void msm_gem_address_space_put(struct msm_gem_address_space *aspace);
 struct msm_gem_address_space *
 msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
 		const char *name);
+struct msm_gem_address_space *
+msm_gem_address_space_create_instance(struct msm_mmu *parent, const char *name,
+		u64 start, u64 end);
 
 void msm_gem_submit_free(struct msm_gem_submit *submit);
 int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index ffbec224551b..d75b56119752 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -92,12 +92,11 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 }
 
 struct msm_gem_address_space *
-msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
-		const char *name)
+msm_gem_address_space_new(struct msm_mmu *mmu, const char *name,
+		u64 start, u64 end)
 {
 	struct msm_gem_address_space *aspace;
-	u64 size = domain->geometry.aperture_end -
-		domain->geometry.aperture_start;
+	u64 size = end - start;
 
 	aspace = kzalloc(sizeof(*aspace), GFP_KERNEL);
 	if (!aspace)
@@ -105,12 +104,36 @@ msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
 
 	spin_lock_init(&aspace->lock);
 	aspace->name = name;
-	aspace->mmu = msm_iommu_new(dev, domain);
+	aspace->mmu = mmu;
 
-	drm_mm_init(&aspace->mm, (domain->geometry.aperture_start >> PAGE_SHIFT),
-		size >> PAGE_SHIFT);
+	drm_mm_init(&aspace->mm, (start >> PAGE_SHIFT), size >> PAGE_SHIFT);
 
 	kref_init(&aspace->kref);
 
 	return aspace;
 }
+
+struct msm_gem_address_space *
+msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
+		const char *name)
+{
+	struct msm_mmu *mmu = msm_iommu_new(dev, domain);
+
+	if (IS_ERR(mmu))
+		return ERR_CAST(mmu);
+
+	return msm_gem_address_space_new(mmu, name,
+		domain->geometry.aperture_start,
+		domain->geometry.aperture_end);
+}
+
+struct msm_gem_address_space *
+msm_gem_address_space_create_instance(struct msm_mmu *parent, const char *name,
+		u64 start, u64 end)
+{
+	struct msm_mmu *instance = msm_iommu_pasid_new(parent);
+	if (IS_ERR(instance))
+		return ERR_CAST(instance);
+
+	return msm_gem_address_space_new(instance, name, start, end);
+}
-- 
2.17.0
