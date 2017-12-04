From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon,  4 Dec 2017 23:18:19 +0530
Subject: [PATCH 3/7 v2] can: xilinx: Fix platform_get_irq's error checking
In-Reply-To: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512409703-20881-4-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             commit message was not correct.

 drivers/net/can/xilinx_can.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 89aec07..1b859af 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1111,6 +1111,10 @@ static int xcan_probe(struct platform_device *pdev)
 
 	/* Get IRQ for the device */
 	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq <= 0) {
+		ret = ndev->irq ? ndev->irq : -ENODEV;
+		goto err_free;
+	}
 	ndev->flags |= IFF_ECHO;	/* We support local echo */
 
 	platform_set_drvdata(pdev, ndev);
-- 
2.7.4
