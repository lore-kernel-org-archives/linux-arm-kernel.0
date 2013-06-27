From: dsd@laptop.org (Daniel Drake)
Date: Thu, 27 Jun 2013 13:51:18 -0400 (EDT)
Subject: [PATCH] mmp: irq: Don't clear unused interrupt enable bits
Message-ID: <20130627175118.8A9FEFAACF@dev.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When enabling/masking interrupts, the existing MMP2 code clears
a mask of 0x7f in the interrupt enable register.
The lower 5 bits here are not directly used by Linux:
 0:3 is interrupt priority
 4 determines whether the interrupt gets delivered to the Security Processor

In the OLPC case, a special firmware is running on the SP, and we do not
want to mask it from receiving the interrupts it has already unmasked.

Refine the mask to only deal with the bits that are of specific interest
to Linux running on the main CPU.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 arch/arm/mach-mmp/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/irq.c b/arch/arm/mach-mmp/irq.c
index ac92433..21cc0b5 100644
--- a/arch/arm/mach-mmp/irq.c
+++ b/arch/arm/mach-mmp/irq.c
@@ -190,7 +190,7 @@ static struct mmp_intc_conf mmp_conf = {
 static struct mmp_intc_conf mmp2_conf = {
 	.conf_enable	= 0x20,
 	.conf_disable	= 0x0,
-	.conf_mask	= 0x7f,
+	.conf_mask	= 0x60,
 };
 
 /* MMP (ARMv5) */
-- 
1.8.1.4
