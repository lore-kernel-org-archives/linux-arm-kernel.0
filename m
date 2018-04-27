From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 27 Apr 2018 17:06:49 +0300
Subject: [PATCH] firmware: arm_scmi: Use after free in
 scmi_create_protocol_device()
Message-ID: <20180427140649.GD19583@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to return here instead of setting up the freed sdev device as a
transport.

Fixes: 907b6d14911d ("firmware: arm_scmi: add per-protocol channels support using idr objects")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 14b147135a0c..2455be8cbc4f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -778,6 +778,7 @@ scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
 	if (scmi_mbox_chan_setup(info, &sdev->dev, prot_id)) {
 		dev_err(&sdev->dev, "failed to setup transport\n");
 		scmi_device_destroy(sdev);
+		return;
 	}
 
 	/* setup handle now as the transport is ready */
