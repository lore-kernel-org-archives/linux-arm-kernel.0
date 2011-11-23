From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 23 Nov 2011 15:28:30 +0000
Subject: [PATCH] ARM: vic: register the VIC for ST-modified VIC's
Message-ID: <1322062110-24084-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When probing the VIC, the ST variant has a different probing method to
account for the extra interrupts which meant we didn't previously call
vic_register() which registered the irq_domain.

Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Russell King <rmk+linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---

I _think_ it's just Nomadik affected here which I don't have access to.
I can send an updated pull request or put it in Russell's tracker,
whichever is easiest.

 arch/arm/common/vic.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 6ed41ec..7728750 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -318,7 +318,7 @@ static void __init vic_set_irq_sources(void __iomem *base,
  *  and 020 within the page. We call this "second block".
  */
 static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
-				u32 vic_sources)
+			       u32 vic_sources, struct device_node *node)
 {
 	unsigned int i;
 	int vic_2nd_block = ((unsigned long)base & ~PAGE_MASK) != 0;
@@ -345,6 +345,7 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 	}
 
 	vic_set_irq_sources(base, irq_start, vic_sources);
+	vic_register(base, irq_start, 0, node);
 }
 
 static void __init __vic_init(void __iomem *base, unsigned int irq_start,
@@ -367,7 +368,7 @@ static void __init __vic_init(void __iomem *base, unsigned int irq_start,
 
 	switch(vendor) {
 	case AMBA_VENDOR_ST:
-		vic_init_st(base, irq_start, vic_sources);
+		vic_init_st(base, irq_start, vic_sources, node);
 		return;
 	default:
 		printk(KERN_WARNING "VIC: unknown vendor, continuing anyways\n");
-- 
1.7.4.1
