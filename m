From: michal.morawiec@tieto.com (Michal Morawiec)
Date: Sat, 21 Nov 2015 14:38:54 +0100
Subject: [PATCH v2 1/1] soc: ti: knav_qmss_queue: Fix linking RAM setup for
 queue managers
Message-ID: <1448113134-7536-1-git-send-email-michal.1.morawiec.ext@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure linking RAM for both queue managers also in case
when only linking RAM 0 is specified in device tree.

Currently hwqueue driver configures linking RAM(s) to be used
cooperatively by the QMs (shared mode). Therefore if both
queue managers are used then both must be configured with
exactly the same linking RAM info (base address and size)
independent of the number of linking RAM(s) specified in the
device tree.
For proper operation only one linking RAM is required and in most
cases this can be internal one as long as it is able to handle
the number of descriptors used in the system.
Current driver code however skips configuration of second
queue manager if second linking RAM is not specified.
If the configuration for the QM2 is missing there will be
a crash when it tries to push/pop descriptors from its queues.

Signed-off-by: Michal Morawiec <michal.1.morawiec.ext@nokia.com>
---
Changes in v2:
 - Make commit message more descriptive about the change reason.

 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6d8646d..a809c30 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1173,7 +1173,7 @@ static int knav_queue_setup_link_ram(struct knav_device *kdev)

		block++;
		if (!block->size)
-			return 0;
+			continue;

		dev_dbg(kdev->dev, "linkram1: phys:%x, virt:%p, size:%x\n",
			block->phys, block->virt, block->size);
--
2.4.6
