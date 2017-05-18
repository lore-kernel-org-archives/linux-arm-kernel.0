From: sricharan@codeaurora.org (Sricharan R)
Date: Thu, 18 May 2017 20:24:16 +0530
Subject: [PATCH V4 3/4] ACPI/IORT: Ignore all errors except EPROBE_DEFER
In-Reply-To: <1495119257-26724-1-git-send-email-sricharan@codeaurora.org>
References: <1495119257-26724-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1495119257-26724-3-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While deferring the probe of IOMMU masters, xlate and
add_device callbacks called from iort_iommu_configure
can pass back error values like -ENODEV, which means
the IOMMU cannot be connected with that master for real
reasons. Before the IOMMU probe deferral, all such errors
were ignored. Now all those errors are propagated back,
killing the master's probe for such errors. Instead ignore
all the errors except EPROBE_DEFER, which is the only one
of concern and let the master work without IOMMU, thus
restoring the old behavior.

Fixes: 5a1bb638d567 ("drivers: acpi: Handle IOMMU lookup failure with deferred probing or error")
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
[V4] Added this patch newly.

 drivers/acpi/arm64/iort.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c5fecf9..16e101f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -782,6 +782,12 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	if (err)
 		ops = ERR_PTR(err);
 
+	/* Ignore all other errors apart from EPROBE_DEFER */
+	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
+		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
+		ops = NULL;
+	}
+
 	return ops;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
