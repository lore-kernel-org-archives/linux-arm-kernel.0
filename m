From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 28 Nov 2014 20:20:08 +0530
Subject: [PATCH RFT 1/2] drivers: bus: check cci device tree node status
Message-ID: <1417186209-5256-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm-cci driver completes the probe sequence even if the cci node is
marked as disabled. Add a check in the driver to honour the cci status
in the device tree.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/bus/arm-cci.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 860da40..0ce5e2d 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -1312,6 +1312,9 @@ static int cci_probe(void)
 	if (!np)
 		return -ENODEV;
 
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
 	cci_config = of_match_node(arm_cci_matches, np)->data;
 	if (!cci_config)
 		return -ENODEV;
-- 
1.7.9.5
