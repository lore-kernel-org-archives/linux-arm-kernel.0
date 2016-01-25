From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 17:02:24 +0100
Subject: [PATCH] mfd: db8500: avoid uninitialized variable reference
Message-ID: <1453737752-1960326-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prcmu_config_clkout() function ensures that the 'clkout' argument
can only be '0' or '1' using an appropriate BUG_ON(), so the compiler
should know that the div_mask, mask, and bits variables are always
initialized later on. However, it doesn't understand this in gcc-5.2
and produces a false positive warning instead:

drivers/mfd/db8500-prcmu.c: In function 'prcmu_config_clkout':
drivers/mfd/db8500-prcmu.c:762:10: error: 'div_mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (val & div_mask) {
          ^
drivers/mfd/db8500-prcmu.c:769:13: error: 'mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    if ((val & mask & ~div_mask) != bits) {
             ^
drivers/mfd/db8500-prcmu.c:757:7: error: 'bits' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Replacing the switch() statement with an equivalent if() lets
gcc figure this out reliably and avoids the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/db8500-prcmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 12099b09a9a7..c0a86aeb1733 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -739,20 +739,17 @@ int prcmu_config_clkout(u8 clkout, u8 source, u8 div)
 	if (!div && !requests[clkout])
 		return -EINVAL;
 
-	switch (clkout) {
-	case 0:
+	if (clkout == 0) {
 		div_mask = PRCM_CLKOCR_CLKODIV0_MASK;
 		mask = (PRCM_CLKOCR_CLKODIV0_MASK | PRCM_CLKOCR_CLKOSEL0_MASK);
 		bits = ((source << PRCM_CLKOCR_CLKOSEL0_SHIFT) |
 			(div << PRCM_CLKOCR_CLKODIV0_SHIFT));
-		break;
-	case 1:
+	} else {
 		div_mask = PRCM_CLKOCR_CLKODIV1_MASK;
 		mask = (PRCM_CLKOCR_CLKODIV1_MASK | PRCM_CLKOCR_CLKOSEL1_MASK |
 			PRCM_CLKOCR_CLK1TYPE);
 		bits = ((source << PRCM_CLKOCR_CLKOSEL1_SHIFT) |
 			(div << PRCM_CLKOCR_CLKODIV1_SHIFT));
-		break;
 	}
 	bits &= mask;
 
-- 
2.7.0
