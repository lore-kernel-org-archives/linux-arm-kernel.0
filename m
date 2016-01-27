From: jenskuske@gmail.com (Jens Kuske)
Date: Wed, 27 Jan 2016 14:51:13 +0100
Subject: [PATCH] drivers: soc: sunxi: Fix mask generation for SRAM mapping
Message-ID: <1453902673-10734-1-git-send-email-jenskuske@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GENMASK is inclusive on both ends, therefor one has to be
subtracted from the width.
Also fixes the mask for debug output.

Signed-off-by: Jens Kuske <jenskuske@gmail.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index bc52670..99e354c 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -117,7 +117,7 @@ static int sunxi_sram_show(struct seq_file *s, void *data)
 
 			val = readl(base + sram_data->reg);
 			val >>= sram_data->offset;
-			val &= sram_data->width;
+			val &= GENMASK(sram_data->width - 1, 0);
 
 			for (func = sram_data->func; func->func; func++) {
 				seq_printf(s, "\t\t%s%c\n", func->func,
@@ -208,7 +208,8 @@ int sunxi_sram_claim(struct device *dev)
 		return -EBUSY;
 	}
 
-	mask = GENMASK(sram_data->offset + sram_data->width, sram_data->offset);
+	mask = GENMASK(sram_data->offset + sram_data->width - 1,
+		       sram_data->offset);
 	val = readl(base + sram_data->reg);
 	val &= ~mask;
 	writel(val | ((device << sram_data->offset) & mask),
-- 
2.7.0
