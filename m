From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun,  3 Dec 2017 00:56:16 +0530
Subject: [PATCH 04/10] can: xilinx: Handle return value of platform_get_irq
In-Reply-To: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512242782-7134-5-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/net/can/xilinx_can.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 89aec07..e36e2a2 100644
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
