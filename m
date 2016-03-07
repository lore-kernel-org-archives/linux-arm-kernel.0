From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:21:31 +0100
Subject: [PATCH 12/16] mtd: nand: sunxi: disable clks on device removal
In-Reply-To: <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457367695-26420-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1457367695-26420-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mod and ahb clocks are not disabled when the NAND controller device is
removed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sunxi_nand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 22d4d55..931c33d 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1840,6 +1840,8 @@ static int sunxi_nfc_remove(struct platform_device *pdev)
 	struct sunxi_nfc *nfc = platform_get_drvdata(pdev);
 
 	sunxi_nand_chips_cleanup(nfc);
+	clk_disable_unprepare(nfc->mod_clk);
+	clk_disable_unprepare(nfc->ahb_clk);
 
 	return 0;
 }
-- 
2.1.4
