From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 21 Mar 2013 14:49:44 +0100
Subject: [PATCH] mfd: ab8500-core: Ignore masked out interrupts
Message-ID: <1363873784-27378-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AB8500 asserts LATCH bits for masked out interrupts.  This patch
explicitly masks those out using the cached mask value to prevent
handle_nested_irq() being called for masked IRQ on the same register as
unmasked ones.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---

Hello Samuel, Anton,

this is a small fix for the AB8500 irq generation code.  As this depends
on Lee's patches already merged in the battery tree, this patch is based
on Anton's repository, and should apply cleanly on it and on next.

Samuel, does it make sense to get your ack for this patch and have it
merged with the others in the battery tree?

Thanks,
Fabio

 drivers/mfd/ab8500-core.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index f276352..36751f3 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -458,22 +458,23 @@ static void update_latch_offset(u8 *offset, int i)
 static int ab8500_handle_hierarchical_line(struct ab8500 *ab8500,
 					int latch_offset, u8 latch_val)
 {
-	int int_bit = __ffs(latch_val);
-	int line, i;
+	int int_bit, line, i;
 
-	do {
-		int_bit = __ffs(latch_val);
+	for (i = 0; i < ab8500->mask_size; i++)
+		if (ab8500->irq_reg_offset[i] == latch_offset)
+			break;
 
-		for (i = 0; i < ab8500->mask_size; i++)
-			if (ab8500->irq_reg_offset[i] == latch_offset)
-				break;
+	if (i >= ab8500->mask_size) {
+		dev_err(ab8500->dev, "Register offset 0x%2x not declared\n",
+				latch_offset);
+		return -ENXIO;
+	}
 
-		if (i >= ab8500->mask_size) {
-			dev_err(ab8500->dev, "Register offset 0x%2x not declared\n",
-					latch_offset);
-			return -ENXIO;
-		}
+	/* ignore masked out interrupts */
+	latch_val &= ~ab8500->mask[i];
 
+	while (latch_val) {
+		int_bit = __ffs(latch_val);
 		line = (i << 3) + int_bit;
 		latch_val &= ~(1 << int_bit);
 
@@ -491,7 +492,7 @@ static int ab8500_handle_hierarchical_line(struct ab8500 *ab8500,
 			line += 1;
 
 		handle_nested_irq(ab8500->irq_base + line);
-	} while (latch_val);
+	}
 
 	return 0;
 }
-- 
1.8.1.3
