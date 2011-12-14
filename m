From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 14 Dec 2011 13:48:30 +0200
Subject: [PATCH 2/7] remoteproc: avoid registering a virtio device if not
 supported
In-Reply-To: <1323863315-8159-1-git-send-email-ohad@wizery.com>
References: <1323863315-8159-1-git-send-email-ohad@wizery.com>
Message-ID: <1323863315-8159-3-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Grosen <mgrosen@ti.com>

Let remoteproc know when the firmware doesn't support any virtio
functionality, so registering a virtio device can be avoided.

This is needed for remote processors that doesn't require any
virtio-based communications, but are still controlled via remoteproc.

[ohad at wizery.com: write commit log]

Signed-off-by: Mark Grosen <mgrosen@ti.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/remoteproc/remoteproc_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 0d9a955..080c056 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -695,7 +695,7 @@ static int
 rproc_handle_virtio_rsc(struct rproc *rproc, struct fw_resource *rsc, int len)
 {
 	struct device *dev = rproc->dev;
-	int ret = 0;
+	int ret = -ENODEV;
 
 	for (; len >= sizeof(*rsc); rsc++, len -= sizeof(*rsc))
 		if (rsc->type == RSC_VIRTIO_DEV) {
-- 
1.7.5.4
