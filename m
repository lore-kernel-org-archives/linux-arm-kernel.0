From: ivan.khoronzhuk@ti.com (Khoronzhuk, Ivan)
Date: Mon, 11 Nov 2013 17:12:24 +0000
Subject: [PATCH 11/12] mtd: nand: davinci: don't request AEMIF address range
In-Reply-To: <1384187188-5776-12-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-12-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <4F5844B3A985794BA902E12C070812375F8D64@DNCE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AEMIF driver registers are used to setup timings for each chip
select. The same registers range is used to setup NAND settings.
The AEMIF and NAND drivers not use the same registers in this range.

In case with AEMIF driver, the memory address range is requested
already by AEMIF, so we cannot request it twice, just ioremap.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 drivers/mtd/nand/davinci_nand.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 879e915..bb6b7e5 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -639,9 +639,11 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
        if (IS_ERR(vaddr))
                return PTR_ERR(vaddr);

-       base = devm_ioremap_resource(&pdev->dev, res2);
-       if (IS_ERR(base))
-               return PTR_ERR(base);
+       base = devm_ioremap(&pdev->dev, res2->start, resource_size(res2));
+       if (!base) {
+               dev_err(&pdev->dev, "ioremap failed for resource %pR\n", res2);
+               return -EADDRNOTAVAIL;
+       }

        info->dev               = &pdev->dev;
        info->base              = base;
--
1.7.9.5
