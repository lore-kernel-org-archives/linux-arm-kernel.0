From: byan@nvidia.com (Bo Yan)
Date: Mon, 5 Mar 2018 14:35:29 -0800
Subject: [PATCH] coresight: etm4x: fix bit shifting
Message-ID: <1520289329-15246-1-git-send-email-byan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ctxid_pid and vmid_val in config are of type u64. When an integer
0xFF is being left shifted more than 32 bits, the behavior is
undefined. The fix is to specify 0xFF as an unsigned long.

Detected by Coverity scan: CID 37650, 37651 (Bad bit shift operation)

Signed-off-by: Bo Yan <byan@nvidia.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 4e6eab53e34e..d21961710713 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1780,7 +1780,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 		 */
 		for (j = 0; j < 8; j++) {
 			if (maskbyte & 1)
-				config->ctxid_pid[i] &= ~(0xFF << (j * 8));
+				config->ctxid_pid[i] &= ~(0xFFUL << (j * 8));
 			maskbyte >>= 1;
 		}
 		/* Select the next ctxid comparator mask value */
@@ -1963,7 +1963,7 @@ static ssize_t vmid_masks_store(struct device *dev,
 		 */
 		for (j = 0; j < 8; j++) {
 			if (maskbyte & 1)
-				config->vmid_val[i] &= ~(0xFF << (j * 8));
+				config->vmid_val[i] &= ~(0xFFUL << (j * 8));
 			maskbyte >>= 1;
 		}
 		/* Select the next vmid comparator mask value */
-- 
2.7.4
