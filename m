From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 4 Jul 2016 14:55:57 +0800
Subject: [PATCH 1/1] firmware: arm_scpi: add missing of_node_put after calling
 of_parse_phandle
Message-ID: <1467615357-440-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Besides, of_address_to_resource always returns -EINVAL for error, delete
the assignment for ret.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/firmware/arm_scpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 7e3e595..fbf10d1 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -683,9 +683,10 @@ static int scpi_probe(struct platform_device *pdev)
 		struct mbox_client *cl = &pchan->cl;
 		struct device_node *shmem = of_parse_phandle(np, "shmem", idx);
 
-		if (of_address_to_resource(shmem, 0, &res)) {
+		ret = of_address_to_resource(shmem, 0, &res);
+		of_node_put(shmem);
+		if (ret) {
 			dev_err(dev, "failed to get SCPI payload mem resource\n");
-			ret = -EINVAL;
 			goto err;
 		}
 
-- 
1.9.1
