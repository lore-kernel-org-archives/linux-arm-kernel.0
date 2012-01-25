From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:38:13 +0000
Subject: [PATCH 24/33] MFD: ucb1x00-core: add missing
 ucb1x00_enable()/ucb1x00_disable()
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3zJ-0000ZN-GM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ucb1x00_enable() and ucb1x00_disable() are used for power saving on the
SIB interface, allowing the host supplied clock to be disabled when not
required.  We require drivers which access the ucb1x00 to ensure that
they have enabled the clock prior to accessing the device, and they
should disable it once they're done.

As we don't expect gpiolib users to be aware of this detail, we must
make these calls in the gpiolib interfaces.  Add them.

Also add them to the resume method, which needs to re-establish the
GPIO pin settings.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 162496d..9f8ea52 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -116,14 +116,22 @@ static void ucb1x00_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	else
 		ucb->io_out &= ~(1 << offset);
 
+	ucb1x00_enable(ucb);
 	ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
+	ucb1x00_disable(ucb);
 	spin_unlock_irqrestore(&ucb->io_lock, flags);
 }
 
 static int ucb1x00_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct ucb1x00 *ucb = container_of(chip, struct ucb1x00, gpio);
-	return ucb1x00_reg_read(ucb, UCB_IO_DATA) & (1 << offset);
+	unsigned val;
+
+	ucb1x00_enable(ucb);
+	val = ucb1x00_reg_read(ucb, UCB_IO_DATA);
+	ucb1x00_disable(ucb);
+
+	return val & (1 << offset);
 }
 
 static int ucb1x00_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -133,7 +141,9 @@ static int ucb1x00_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	spin_lock_irqsave(&ucb->io_lock, flags);
 	ucb->io_dir &= ~(1 << offset);
+	ucb1x00_enable(ucb);
 	ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
+	ucb1x00_disable(ucb);
 	spin_unlock_irqrestore(&ucb->io_lock, flags);
 
 	return 0;
@@ -153,6 +163,7 @@ static int ucb1x00_gpio_direction_output(struct gpio_chip *chip, unsigned offset
 	else
 		ucb->io_out &= ~mask;
 
+	ucb1x00_enable(ucb);
 	if (old != ucb->io_out)
 		ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
 
@@ -160,6 +171,7 @@ static int ucb1x00_gpio_direction_output(struct gpio_chip *chip, unsigned offset
 		ucb->io_dir |= mask;
 		ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
 	}
+	ucb1x00_disable(ucb);
 	spin_unlock_irqrestore(&ucb->io_lock, flags);
 
 	return 0;
@@ -703,8 +715,10 @@ static int ucb1x00_resume(struct mcp *mcp)
 	struct ucb1x00 *ucb = mcp_get_drvdata(mcp);
 	struct ucb1x00_dev *dev;
 
+	ucb1x00_enable(ucb);
 	ucb1x00_reg_write(ucb, UCB_IO_DATA, ucb->io_out);
 	ucb1x00_reg_write(ucb, UCB_IO_DIR, ucb->io_dir);
+	ucb1x00_disable(ucb);
 	mutex_lock(&ucb1x00_mutex);
 	list_for_each_entry(dev, &ucb->devs, dev_node) {
 		if (dev->drv->resume)
-- 
1.7.4.4
