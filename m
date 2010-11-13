From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 12 Nov 2010 19:29:50 -0800
Subject: [PATCH 04/14] msm: iommu: Revise GFX3D IOMMU contexts and M2V mappings
In-Reply-To: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1289619000-13167-5-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the platform data for the 3D core's IOMMU based on
the revised usage model. Remove unused contexts and rename
the remaining contexts based on their new function. Add the
new M2VCBMT mappings for the updated contexts.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/devices-msm8x60-iommu.c |   45 +++++++++-------------------
 1 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-msm/devices-msm8x60-iommu.c b/arch/arm/mach-msm/devices-msm8x60-iommu.c
index 9e657e0..22d0c7c 100644
--- a/arch/arm/mach-msm/devices-msm8x60-iommu.c
+++ b/arch/arm/mach-msm/devices-msm8x60-iommu.c
@@ -519,22 +519,17 @@ static struct msm_iommu_ctx_dev vcodec_b_mm2_ctx = {
 	.mids = {0, 1, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, -1}
 };
 
-static struct msm_iommu_ctx_dev gfx3d_rbpa_ctx = {
-	.name = "gfx3d_rbpa",
+static struct msm_iommu_ctx_dev gfx3d_user_ctx = {
+	.name = "gfx3d_user",
 	.num = 0,
-	.mids = {-1}
+	.mids = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, -1}
 };
 
-static struct msm_iommu_ctx_dev gfx3d_cpvgttc_ctx = {
-	.name = "gfx3d_cpvgttc",
+static struct msm_iommu_ctx_dev gfx3d_priv_ctx = {
+	.name = "gfx3d_priv",
 	.num = 1,
-	.mids = {0, 1, 2, 3, 4, 5, 6, 7, -1}
-};
-
-static struct msm_iommu_ctx_dev gfx3d_smmu_ctx = {
-	.name = "gfx3d_smmu",
-	.num = 2,
-	.mids = {8, 9, 10, 11, 12, -1}
+	.mids = {16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
+		 31, -1}
 };
 
 static struct msm_iommu_ctx_dev gfx2d0_pixv1_ctx = {
@@ -685,7 +680,7 @@ static struct platform_device msm_device_vcodec_b_mm2_ctx = {
 	},
 };
 
-static struct platform_device msm_device_gfx3d_rbpa_ctx = {
+static struct platform_device msm_device_gfx3d_user_ctx = {
 	.name = "msm_iommu_ctx",
 	.id = 17,
 	.dev = {
@@ -693,7 +688,7 @@ static struct platform_device msm_device_gfx3d_rbpa_ctx = {
 	},
 };
 
-static struct platform_device msm_device_gfx3d_cpvgttc_ctx = {
+static struct platform_device msm_device_gfx3d_priv_ctx = {
 	.name = "msm_iommu_ctx",
 	.id = 18,
 	.dev = {
@@ -701,17 +696,9 @@ static struct platform_device msm_device_gfx3d_cpvgttc_ctx = {
 	},
 };
 
-static struct platform_device msm_device_gfx3d_smmu_ctx = {
-	.name = "msm_iommu_ctx",
-	.id = 19,
-	.dev = {
-		.parent = &msm_device_iommu_gfx3d.dev,
-	},
-};
-
 static struct platform_device msm_device_gfx2d0_pixv1_ctx = {
 	.name = "msm_iommu_ctx",
-	.id = 20,
+	.id = 19,
 	.dev = {
 		.parent = &msm_device_iommu_gfx2d0.dev,
 	},
@@ -719,7 +706,7 @@ static struct platform_device msm_device_gfx2d0_pixv1_ctx = {
 
 static struct platform_device msm_device_gfx2d0_texv3_ctx = {
 	.name = "msm_iommu_ctx",
-	.id = 21,
+	.id = 20,
 	.dev = {
 		.parent = &msm_device_iommu_gfx2d0.dev,
 	},
@@ -771,9 +758,8 @@ static struct platform_device *msm_iommu_ctx_devs[] = {
 	&msm_device_vcodec_a_stream_ctx,
 	&msm_device_vcodec_a_mm1_ctx,
 	&msm_device_vcodec_b_mm2_ctx,
-	&msm_device_gfx3d_rbpa_ctx,
-	&msm_device_gfx3d_cpvgttc_ctx,
-	&msm_device_gfx3d_smmu_ctx,
+	&msm_device_gfx3d_user_ctx,
+	&msm_device_gfx3d_priv_ctx,
 	&msm_device_gfx2d0_pixv1_ctx,
 	&msm_device_gfx2d0_texv3_ctx,
 };
@@ -796,9 +782,8 @@ static struct msm_iommu_ctx_dev *msm_iommu_ctx_data[] = {
 	&vcodec_a_stream_ctx,
 	&vcodec_a_mm1_ctx,
 	&vcodec_b_mm2_ctx,
-	&gfx3d_rbpa_ctx,
-	&gfx3d_cpvgttc_ctx,
-	&gfx3d_smmu_ctx,
+	&gfx3d_user_ctx,
+	&gfx3d_priv_ctx,
 	&gfx2d0_pixv1_ctx,
 	&gfx2d0_texv3_ctx,
 };
-- 
1.7.0.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
