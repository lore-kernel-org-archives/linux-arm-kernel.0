From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 10 Mar 2010 11:29:53 -0600
Subject: [PATCH] locomo.c: i2c spin_unlock_irqrestore bugfix
Message-ID: <0D753D10438DA54287A00B027084269763683A720E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function locomo_m62332_senddata sends a three byte i2c message to
a M62332 DAC. This entire function is guarded with a spin_lock_irqsave
at the start of the function and a spin_unlock_irqrestore at the end.

As each byte is transferred, the i2c ACK from the DAC is checked.
Currently, if the ACK is missing the function simply returns without
the unlock. It also leaves the i2c bus in an invalid state since the
last byte transferred did not have a "stop" condition and leave the
bus idle.

Fix this by adding an exit path using goto.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Eric Miao <eric.y.miao@gmail.com>

---

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 90ae00b..cb070cf 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -707,7 +707,7 @@ void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
 	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
 		printk(KERN_WARNING "locomo: m62332_senddata Error 1\n");
-		return;
+		goto out;
 	}
 
 	/* Send Sub address (LSB is channel select) */
@@ -735,7 +735,7 @@ void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
 	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
 		printk(KERN_WARNING "locomo: m62332_senddata Error 2\n");
-		return;
+		goto out;
 	}
 
 	/* Send DAC data */
@@ -760,9 +760,9 @@ void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int
 	udelay(DAC_SCL_HIGH_HOLD_TIME);	/* 4.7 usec */
 	if (locomo_readl(mapbase + LOCOMO_DAC) & LOCOMO_DAC_SDAOEB) {	/* High is error */
 		printk(KERN_WARNING "locomo: m62332_senddata Error 3\n");
-		return;
 	}
 
+out:
 	/* stop */
 	r = locomo_readl(mapbase + LOCOMO_DAC);
 	r &=  ~(LOCOMO_DAC_SCLOEB);
