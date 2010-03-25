From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 25 Mar 2010 18:07:17 -0500
Subject: [PATCH] locomo.c: restore LOCOMO_DAC (I2C bus) to idle state on resume
Message-ID: <0D753D10438DA54287A00B02708426976368F67791@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LOCOMO_DAC register actually controls an I2C bus with a
M62332 DAC on it.  During suspend, a value of 0x00 is written
to the register which causes the SDA and SCL lines to both
be driven low.  This puts the I2C bus in a "wait" condition.

At resume, the SDA and SCL lines should both be restored to
a high state to put the I2C bus back into an "idle" state.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Eric Miao <eric.y.miao@gmail.com>

---

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 9dff07c..422dadb 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -345,6 +345,10 @@ static int locomo_resume(struct platform_device *dev)
 	locomo_writel(r, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
 	locomo_writel(0x1, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KCMD);
 
+	r = locomo_readl(lchip->base + LOCOMO_DAC);
+	r |= LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
+	locomo_writel(r, lchip->base + LOCOMO_DAC);
+
 	spin_unlock_irqrestore(&lchip->lock, flags);
 
 	lchip->saved_state = NULL;
