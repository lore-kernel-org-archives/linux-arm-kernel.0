From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:21:54 +0100
Subject: [PATCH 1/1] soc: renesas: Identify R-Car M3-W ES1.1
In-Reply-To: <cover.1512553442.git.horms+renesas@verge.net.au>
References: <cover.1512553442.git.horms+renesas@verge.net.au>
Message-ID: <90f0d2b344313a8a4c366ef60d0df33008d2be84.1512553442.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Product Register of R-Car M3-W ES1.1 incorrectly identifies the SoC
revision as ES2.0.  Add a workaround to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/renesas-soc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 9f4ee2567c72..926b7fd6db2d 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -250,6 +250,9 @@ static int __init renesas_soc_init(void)
 	if (chipid) {
 		product = readl(chipid);
 		iounmap(chipid);
+		/* R-Car M3-W ES1.1 incorrectly identifies as ES2.0 */
+		if ((product & 0x7fff) == 0x5210)
+			product ^= 0x11;
 		if (soc->id && ((product >> 8) & 0xff) != soc->id) {
 			pr_warn("SoC mismatch (product = 0x%x)\n", product);
 			return -ENODEV;
-- 
2.11.0
