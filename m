From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:54 -0600
Subject: [PATCH 10/16] drm/msm: Add msm_mmu features
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-11-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a few simple support functions to support a bitmask of
features that a specific MMU implementation supports. The
first feature will be per-instance pagetables coming in the
following patch.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/msm_mmu.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index aa2c5d4580c8..85df78d71398 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -35,6 +35,7 @@ struct msm_mmu {
 	struct device *dev;
 	int (*handler)(void *arg, unsigned long iova, int flags);
 	void *arg;
+	unsigned long features;
 };
 
 static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
@@ -54,4 +55,16 @@ static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
 	mmu->handler = handler;
 }
 
+static inline void msm_mmu_set_feature(struct msm_mmu *mmu,
+		unsigned long feature)
+{
+	mmu->features |= feature;
+}
+
+static inline bool msm_mmu_has_feature(struct msm_mmu *mmu,
+		unsigned long feature)
+{
+	return (mmu->features & feature) ? true : false;
+}
+
 #endif /* __MSM_MMU_H__ */
-- 
2.17.0
