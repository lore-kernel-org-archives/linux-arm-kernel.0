From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:32:07 +0000
Subject: [PATCH 06/33] MFD: ucb1x00-core: fix gpiolib direction_output handling
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3tP-0000Xz-2r@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpiolib drivers should first set the output data before setting the
direction to avoid putting glitches on an output signal.  As an
additional bonus, we tweak the code to avoid unnecessary register
writes to the output and direction registers if they have no need
to be updated.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 8ebda97..febc90c 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -148,16 +148,22 @@ static int ucb1x00_gpio_direction_output(struct gpio_chip *chip, unsigned offset
 {
 	struct ucb1x00 *ucb = container_of(chip, struct ucb1x00, gpio);
 	unsigned long flags;
+	unsigned old, mask = 1 << offset;
 
 	spin_lock_irqsave(&ucb->io_lock, flags);
-	ucb->io_dir |= (1 << offset);
-	ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
-
+	old = ucb->io_out;
 	if (value)
-		ucb->io_out |= 1 << offset;
+		ucb->io_out |= mask;
 	else
-		ucb->io_out &= ~(1 << offset);
-	ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
+		ucb->io_out &= ~mask;
+
+	if (old != ucb->io_out)
+		ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
+
+	if (!(ucb->io_dir & mask)) {
+		ucb->io_dir |= mask;
+		ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
+	}
 	spin_unlock_irqrestore(&ucb->io_lock, flags);
 
 	return 0;
-- 
1.7.4.4
