From: 21cnbao@gmail.com (Barry Song)
Date: Sat,  3 Jan 2015 09:36:41 +0800
Subject: [PATCH V2 3/9] ARM: sirf: drop MARCO support in reset controller
 module
In-Reply-To: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
References: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1420249007-8262-4-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

MARCO will not be supported any more. it has been replaced by CSR
atlas7.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/rstc.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index e1f1f86..7c251eb 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -34,36 +34,20 @@ static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
 
 	mutex_lock(&rstc_lock);
 
-	if (of_device_is_compatible(rcdev->of_node, "sirf,prima2-rstc")) {
-		/*
-		 * Writing 1 to this bit resets corresponding block.
-		 * Writing 0 to this bit de-asserts reset signal of the
-		 * corresponding block. datasheet doesn't require explicit
-		 * delay between the set and clear of reset bit. it could
-		 * be shorter if tests pass.
-		 */
-		writel(readl(sirfsoc_rstc_base +
+	/*
+	 * Writing 1 to this bit resets corresponding block.
+	 * Writing 0 to this bit de-asserts reset signal of the
+	 * corresponding block. datasheet doesn't require explicit
+	 * delay between the set and clear of reset bit. it could
+	 * be shorter if tests pass.
+	 */
+	writel(readl(sirfsoc_rstc_base +
 			(reset_bit / 32) * 4) | (1 << reset_bit),
-			sirfsoc_rstc_base + (reset_bit / 32) * 4);
-		msleep(20);
-		writel(readl(sirfsoc_rstc_base +
+		sirfsoc_rstc_base + (reset_bit / 32) * 4);
+	msleep(20);
+	writel(readl(sirfsoc_rstc_base +
 			(reset_bit / 32) * 4) & ~(1 << reset_bit),
-			sirfsoc_rstc_base + (reset_bit / 32) * 4);
-	} else {
-		/*
-		 * For MARCO and POLO
-		 * Writing 1 to SET register resets corresponding block.
-		 * Writing 1 to CLEAR register de-asserts reset signal of the
-		 * corresponding block.
-		 * datasheet doesn't require explicit delay between the set and
-		 * clear of reset bit. it could be shorter if tests pass.
-		 */
-		writel(1 << reset_bit,
-			sirfsoc_rstc_base + (reset_bit / 32) * 8);
-		msleep(20);
-		writel(1 << reset_bit,
-			sirfsoc_rstc_base + (reset_bit / 32) * 8 + 4);
-	}
+		sirfsoc_rstc_base + (reset_bit / 32) * 4);
 
 	mutex_unlock(&rstc_lock);
 
@@ -106,7 +90,6 @@ static int sirfsoc_rstc_probe(struct platform_device *pdev)
 
 static const struct of_device_id rstc_ids[]  = {
 	{ .compatible = "sirf,prima2-rstc" },
-	{ .compatible = "sirf,marco-rstc" },
 	{},
 };
 
-- 
2.2.1
