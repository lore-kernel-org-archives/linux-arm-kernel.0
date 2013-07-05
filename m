From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 5 Jul 2013 14:41:27 +0200
Subject: [PATCH v3 2/6] misc: sram: add ability to mark sram sections as
 reserved
In-Reply-To: <201307051440.19428.heiko@sntech.de>
References: <201307051440.19428.heiko@sntech.de>
Message-ID: <201307051441.27605.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs need parts of their sram for special purposes. So while being part
of the periphal, it should not be part of the genpool controlling the sram.

Threfore add an option mmio-sram-reserved to keep arbitary portions of the
sram from being part of the pool.

Suggested-by: Rob Herring <robherring2@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
---
 Documentation/devicetree/bindings/misc/sram.txt |    8 +++
 drivers/misc/sram.c                             |   80 +++++++++++++++++++++--
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/misc/sram.txt
index 4d0a00e..eae080e 100644
--- a/Documentation/devicetree/bindings/misc/sram.txt
+++ b/Documentation/devicetree/bindings/misc/sram.txt
@@ -8,9 +8,17 @@ Required properties:
 
 - reg : SRAM iomem address range
 
+Optional properties:
+
+- mmio-sram-reserved: ordered list of reserved chunks inside the sram that
+  should not become part of the genalloc pool.
+  Format is <base size>, <base size>, ...; with base being relative to the
+  reg property base.
+
 Example:
 
 sram: sram at 5c000000 {
 	compatible = "mmio-sram";
 	reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
+	mmio-sram-reserved = <0x0 0x100>; /* reserve 0x5c000000-0x5c000100 */
 };
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index afe66571..9131e4a 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -42,6 +42,13 @@ static int sram_probe(struct platform_device *pdev)
 	struct sram_dev *sram;
 	struct resource *res;
 	unsigned long size;
+	const __be32 *reserved_list = NULL;
+	int reserved_size = 0;
+	unsigned int cur_start = 0;
+	unsigned int cur_size;
+	unsigned int rstart;
+	unsigned int rsize;
+	int i;
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -65,12 +72,73 @@ static int sram_probe(struct platform_device *pdev)
 	if (!sram->pool)
 		return -ENOMEM;
 
-	ret = gen_pool_add_virt(sram->pool, (unsigned long)virt_base,
-				res->start, size, -1);
-	if (ret < 0) {
-		if (sram->clk)
-			clk_disable_unprepare(sram->clk);
-		return ret;
+	if (pdev->dev.of_node) {
+		reserved_list = of_get_property(pdev->dev.of_node,
+						"mmio-sram-reserved",
+						&reserved_size);
+		if (reserved_list) {
+			reserved_size /= sizeof(*reserved_list);
+			if (!reserved_size || reserved_size % 2) {
+				dev_warn(&pdev->dev, "wrong number of arguments in mmio-sram-reserved\n");
+				reserved_list = NULL;
+			}
+		}
+	}
+
+	if (!reserved_list)
+		reserved_size = 0;
+
+	for (i = 0; i < (reserved_size + 2); i += 2) {
+		if (i < reserved_size) {
+			/* get the next reserved block */
+			rstart = be32_to_cpu(*reserved_list++);
+			rsize = be32_to_cpu(*reserved_list++);
+
+			/* catch unsorted list entries */
+			if (rstart < cur_start) {
+				dev_err(&pdev->dev,
+					"unsorted reserved list (0x%x before current 0x%x)\n",
+					rstart, cur_start);
+				if (sram->clk)
+					clk_disable_unprepare(sram->clk);
+				return -EINVAL;
+			}
+
+			dev_dbg(&pdev->dev,
+				"found reserved block 0x%x-0x%x\n",
+				rstart, rstart + rsize);
+		} else {
+			/* the last chunk extends to the end of the region */
+			rstart = size;
+			rsize = 0;
+		}
+
+		/* current start is in a reserved block */
+		if (rstart <= cur_start) {
+			cur_start = rstart + rsize;
+			continue;
+		}
+
+		/*
+		 * allocate the space between the current starting
+		 * address and the following reserved block, or the
+		 * end of the region.
+		 */
+		cur_size = rstart - cur_start;
+
+		dev_dbg(&pdev->dev, "adding chunk 0x%x-0x%x\n",
+			cur_start, cur_start + cur_size);
+		ret = gen_pool_add_virt(sram->pool,
+				(unsigned long)virt_base + cur_start,
+				res->start + cur_start, cur_size, -1);
+		if (ret < 0) {
+			if (sram->clk)
+				clk_disable_unprepare(sram->clk);
+			return ret;
+		}
+
+		/* next allocation after this reserved block */
+		cur_start = rstart + rsize;
 	}
 
 	platform_set_drvdata(pdev, sram);
-- 
1.7.10.4
