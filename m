From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 14 Dec 2011 13:48:29 +0200
Subject: [PATCH 1/7] remoteproc: do not require an iommu
In-Reply-To: <1323863315-8159-1-git-send-email-ohad@wizery.com>
References: <1323863315-8159-1-git-send-email-ohad@wizery.com>
Message-ID: <1323863315-8159-2-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Grosen <mgrosen@ti.com>

Not all remote processors employ an IOMMU, so do not error out
on !iommu_present().

Note: we currently still use iommu_present() to tell whether we need
to configure an IOMMU or not. That works for simple cases, but will
easily fail with more complicated ones (e.g. where an IOMMU exists,
but not all remote processors use it). When those use cases show up,
we will solve them by introducing something like remoteproc hw
capabilities.

[ohad at wizery.com: write commit log]

Signed-off-by: Mark Grosen <mgrosen@ti.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/remoteproc/remoteproc_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ad93d7d..0d9a955 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -105,8 +105,8 @@ static int rproc_enable_iommu(struct rproc *rproc)
 	 * that will be set by the remoteproc driver.
 	 */
 	if (!iommu_present(dev->bus)) {
-		dev_err(dev, "iommu not found\n");
-		return -ENODEV;
+		dev_dbg(dev, "iommu not found\n");
+		return 0;
 	}
 
 	domain = iommu_domain_alloc(dev->bus);
-- 
1.7.5.4
