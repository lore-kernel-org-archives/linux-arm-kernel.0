From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 12 Nov 2010 19:29:56 -0800
Subject: [PATCH 10/14] msm: iommu: Check if device is already attached
In-Reply-To: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1289619000-13167-11-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An IOMMU device can only be attached to one IOMMU domain at
any given time. Check whether the device is already
attached to a domain before allowing it to be attached to
another domain. If so, return busy.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/iommu.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/iommu.c b/arch/arm/mach-msm/iommu.c
index 74f2157..67e8f53 100644
--- a/arch/arm/mach-msm/iommu.c
+++ b/arch/arm/mach-msm/iommu.c
@@ -241,6 +241,11 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto fail;
 	}
 
+	if (!list_empty(&ctx_drvdata->attached_elm)) {
+		ret = -EBUSY;
+		goto fail;
+	}
+
 	list_for_each_entry(tmp_drvdata, &priv->list_attached, attached_elm)
 		if (tmp_drvdata == ctx_drvdata) {
 			ret = -EBUSY;
-- 
1.7.0.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
