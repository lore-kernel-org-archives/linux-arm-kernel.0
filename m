From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 17 May 2017 17:00:08 +0530
Subject: [PATCH 2/3] iommu: of: Ignore all errors except EPROBE_DEFER
In-Reply-To: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
References: <1495020609-13397-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1495020609-13397-2-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While deferring the probe of iommu masters,
xlate and add_device callback can pass back error values
like -ENODEV, which means iommu cannot be connected
with that master for real reasons. So rather than
killing the master's probe for such errors, just
ignore the errors and let the master work without
an iommu.

Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Magnus Damn <magnus.damn@gmail.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/of_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e6e9bec..2ec2f0b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -237,6 +237,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			ops = ERR_PTR(err);
 	}
 
+	/* Ignore all other errors apart from EPROBE_DEFER */
+	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
+		dev_info(dev, "Adding to iommu failed: %ld\n", PTR_ERR(ops));
+		ops = NULL;
+	}
+
 	return ops;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
