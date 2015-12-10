From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:17 +0100
Subject: [PATCH v4 33/58] mtd: nand: orion: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-34-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/orion_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 4ed4f67..087a040 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -85,11 +85,11 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	u32 val = 0;
 
 	nc = devm_kzalloc(&pdev->dev,
-			sizeof(struct nand_chip) + sizeof(struct mtd_info),
+			sizeof(struct nand_chip),
 			GFP_KERNEL);
 	if (!nc)
 		return -ENOMEM;
-	mtd = (struct mtd_info *)(nc + 1);
+	mtd = nand_to_mtd(nc);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	io_base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.1.4
