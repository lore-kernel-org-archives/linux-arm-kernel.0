From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Apr 2014 10:14:59 -0500
Subject: [PATCH] power: twl4030_charger: clear IRQs after handling them
Message-ID: <1397661299-31342-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TRM says we *must* write 1 to each bit we're handling
in order to clear the IRQ status and bring IRQ line
low. This patch implements that.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Russell, I don't have HW to test, but this should
solve the problem you saw when not using battery
with Zoom board. Let me know if it doesn't.

cheers

 drivers/power/twl4030_charger.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index f141088..b090842 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -301,12 +301,24 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
 	ret = twl_i2c_read_u8(TWL4030_MODULE_INTERRUPTS, &irqs1,
 			      TWL4030_INTERRUPTS_BCIISR1A);
 	if (ret < 0)
-		return IRQ_HANDLED;
+		return IRQ_NONE;
+
+	/* clear IRQs early */
+	ret = twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, irqs1,
+			TWL4030_INTERRUPTS_BCIISR1A);
+	if (ret < 0)
+		return IRQ_NONE;
 
 	ret = twl_i2c_read_u8(TWL4030_MODULE_INTERRUPTS, &irqs2,
 			      TWL4030_INTERRUPTS_BCIISR2A);
 	if (ret < 0)
-		return IRQ_HANDLED;
+		return IRQ_NONE;
+
+	/* clear IRQs early */
+	ret = twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, irqs2,
+			      TWL4030_INTERRUPTS_BCIISR2A);
+	if (ret < 0)
+		return IRQ_NONE;
 
 	dev_dbg(bci->dev, "BCI irq %02x %02x\n", irqs2, irqs1);
 
-- 
1.9.1.286.g5172cb3
