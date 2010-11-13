From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 12 Nov 2010 19:29:51 -0800
Subject: [PATCH 05/14] msm: iommu: Revise GFX2D0 IOMMU contexts and M2V
	mappings
In-Reply-To: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1289619000-13167-6-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the platform data for the 2D core's IOMMU based on
the revised usage model. Merge the two contexts and their
M2VCBMT mappings, adding the previously-missing mappings to
the newly-formed context.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/devices-msm8x60-iommu.c |   28 ++++++----------------------
 1 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-msm/devices-msm8x60-iommu.c b/arch/arm/mach-msm/devices-msm8x60-iommu.c
index 22d0c7c..8cccb26 100644
--- a/arch/arm/mach-msm/devices-msm8x60-iommu.c
+++ b/arch/arm/mach-msm/devices-msm8x60-iommu.c
@@ -532,16 +532,10 @@ static struct msm_iommu_ctx_dev gfx3d_priv_ctx = {
 		 31, -1}
 };
 
-static struct msm_iommu_ctx_dev gfx2d0_pixv1_ctx = {
-	.name = "gfx2d0_pixv1_smmu",
+static struct msm_iommu_ctx_dev gfx2d0_2d0_ctx = {
+	.name = "gfx2d0_2d0",
 	.num = 0,
-	.mids = {0, 3, 4, -1}
-};
-
-static struct msm_iommu_ctx_dev gfx2d0_texv3_ctx = {
-	.name = "gfx2d0_texv3_smmu",
-	.num = 1,
-	.mids = {1, 6, 7, -1}
+	.mids = {0, 1, 2, 3, 4, 5, 6, 7, -1}
 };
 
 static struct platform_device msm_device_jpegd_src_ctx = {
@@ -696,7 +690,7 @@ static struct platform_device msm_device_gfx3d_priv_ctx = {
 	},
 };
 
-static struct platform_device msm_device_gfx2d0_pixv1_ctx = {
+static struct platform_device msm_device_gfx2d0_2d0_ctx = {
 	.name = "msm_iommu_ctx",
 	.id = 19,
 	.dev = {
@@ -704,14 +698,6 @@ static struct platform_device msm_device_gfx2d0_pixv1_ctx = {
 	},
 };
 
-static struct platform_device msm_device_gfx2d0_texv3_ctx = {
-	.name = "msm_iommu_ctx",
-	.id = 20,
-	.dev = {
-		.parent = &msm_device_iommu_gfx2d0.dev,
-	},
-};
-
 static struct platform_device *msm_iommu_devs[] = {
 	&msm_device_iommu_jpegd,
 	&msm_device_iommu_vpe,
@@ -760,8 +746,7 @@ static struct platform_device *msm_iommu_ctx_devs[] = {
 	&msm_device_vcodec_b_mm2_ctx,
 	&msm_device_gfx3d_user_ctx,
 	&msm_device_gfx3d_priv_ctx,
-	&msm_device_gfx2d0_pixv1_ctx,
-	&msm_device_gfx2d0_texv3_ctx,
+	&msm_device_gfx2d0_2d0_ctx,
 };
 
 static struct msm_iommu_ctx_dev *msm_iommu_ctx_data[] = {
@@ -784,8 +769,7 @@ static struct msm_iommu_ctx_dev *msm_iommu_ctx_data[] = {
 	&vcodec_b_mm2_ctx,
 	&gfx3d_user_ctx,
 	&gfx3d_priv_ctx,
-	&gfx2d0_pixv1_ctx,
-	&gfx2d0_texv3_ctx,
+	&gfx2d0_2d0_ctx,
 };
 
 static int msm8x60_iommu_init(void)
-- 
1.7.0.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
