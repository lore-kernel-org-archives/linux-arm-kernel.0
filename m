From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  6 Jan 2017 10:42:05 +0100
Subject: [PATCH 1/3] mtd: nand: sunxi: Fix the non-polling case in
 sunxi_nfc_wait_events()
In-Reply-To: <1483695727-17415-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1483695727-17415-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1483695727-17415-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

wait_for_completion_timeout() returns 0 if a timeout occurred, 1
otherwise. Fix the sunxi_nfc_wait_events() accordingly.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index e40482a65de6..ba78e13a3570 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -321,6 +321,10 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
 
 		ret = wait_for_completion_timeout(&nfc->complete,
 						msecs_to_jiffies(timeout_ms));
+		if (!ret)
+			ret = -ETIMEDOUT;
+		else
+			ret = 0;
 
 		writel(0, nfc->regs + NFC_REG_INT);
 	} else {
-- 
2.7.4
