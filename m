From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Thu,  1 Jan 2015 18:55:12 +0100
Subject: [PATCH] arch: arm: mach-rpc: ecard:  Remove some unused functions
Message-ID: <1420134912-1742-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removes some functions that are not used anywhere:
ecard_disablefiq() ecard_enablefiq()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/mach-rpc/ecard.c |   29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index fcb1d59..e5c8caf 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -462,35 +462,6 @@ static struct irq_chip ecard_chip = {
 	.irq_unmask	= ecard_irq_unmask,
 };
 
-void ecard_enablefiq(unsigned int fiqnr)
-{
-	ecard_t *ec = slot_to_ecard(fiqnr);
-
-	if (ec) {
-		if (!ec->ops)
-			ec->ops = &ecard_default_ops;
-
-		if (ec->claimed && ec->ops->fiqenable)
-			ec->ops->fiqenable(ec, fiqnr);
-		else
-			printk(KERN_ERR "ecard: rejecting request to "
-				"enable FIQs for %d\n", fiqnr);
-	}
-}
-
-void ecard_disablefiq(unsigned int fiqnr)
-{
-	ecard_t *ec = slot_to_ecard(fiqnr);
-
-	if (ec) {
-		if (!ec->ops)
-			ec->ops = &ecard_default_ops;
-
-		if (ec->ops->fiqdisable)
-			ec->ops->fiqdisable(ec, fiqnr);
-	}
-}
-
 static void ecard_dump_irq_state(void)
 {
 	ecard_t *ec;
-- 
1.7.10.4
