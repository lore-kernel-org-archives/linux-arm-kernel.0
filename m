From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:36 +0900
Subject: [PATCH 2/3] irqchip: renesas-intc-irqpin: Fix register bitfield shift
 calculation
In-Reply-To: <cover.1386899269.git.horms+renesas@verge.net.au>
References: <cover.1386899269.git.horms+renesas@verge.net.au>
Message-ID: <e55bc55867585e6628359fd5496316576fe58a2f.1386899269.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The SENSE register bitfield position is incorrectly computed for SoCs
that use 2-bit IRQ sense fields. Fix it.

This has been tested on the Marzen (H1) and Bockw (M1) boards.

This bug has been present since the renesas-intc-irqpin driver was
introduced by 443580486e3b9657 ("irqchip: Renesas INTC External IRQ pin
driver") in v3.10-rc1.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 82cec63..3ee78f02 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -149,8 +149,9 @@ static void intc_irqpin_read_modify_write(struct intc_irqpin_priv *p,
 static void intc_irqpin_mask_unmask_prio(struct intc_irqpin_priv *p,
 					 int irq, int do_mask)
 {
-	int bitfield_width = 4; /* PRIO assumed to have fixed bitfield width */
-	int shift = (7 - irq) * bitfield_width; /* PRIO assumed to be 32-bit */
+	/* The PRIO register is assumed to be 32-bit with fixed 4-bit fields. */
+	int bitfield_width = 4;
+	int shift = 32 - (irq + 1) * bitfield_width;
 
 	intc_irqpin_read_modify_write(p, INTC_IRQPIN_REG_PRIO,
 				      shift, bitfield_width,
@@ -159,8 +160,9 @@ static void intc_irqpin_mask_unmask_prio(struct intc_irqpin_priv *p,
 
 static int intc_irqpin_set_sense(struct intc_irqpin_priv *p, int irq, int value)
 {
+	/* The SENSE register is assumed to be 32-bit. */
 	int bitfield_width = p->config.sense_bitfield_width;
-	int shift = (7 - irq) * bitfield_width; /* SENSE assumed to be 32-bit */
+	int shift = 32 - (irq + 1) * bitfield_width;
 
 	dev_dbg(&p->pdev->dev, "sense irq = %d, mode = %d\n", irq, value);
 
-- 
1.8.4
