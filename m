From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 16 May 2013 21:30:59 +0100
Subject: [PATCH 1/9] I2C: mv64xxx: work around signals causing I2C
 transactions to be aborted
In-Reply-To: <20130516202921.GW18614@n2100.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
Message-ID: <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not use interruptible waits in an I2C driver; if a process uses
signals (eg, Xorg uses SIGALRM and SIGPIPE) then these signals can
cause the I2C driver to abort a transaction in progress by another
driver, which can cause that driver to fail.  I2C drivers are not
expected to abort transactions on signals.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8b20ef8..8d4c0a0 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -252,7 +252,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
 		drv_data->block = 0;
-		wake_up_interruptible(&drv_data->waitq);
+		wake_up(&drv_data->waitq);
 		break;
 
 	case MV64XXX_I2C_ACTION_CONTINUE:
@@ -300,7 +300,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
 		drv_data->block = 0;
-		wake_up_interruptible(&drv_data->waitq);
+		wake_up(&drv_data->waitq);
 		break;
 
 	case MV64XXX_I2C_ACTION_INVALID:
@@ -315,7 +315,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
 		drv_data->block = 0;
-		wake_up_interruptible(&drv_data->waitq);
+		wake_up(&drv_data->waitq);
 		break;
 	}
 }
@@ -381,7 +381,7 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
 	unsigned long	flags;
 	char		abort = 0;
 
-	time_left = wait_event_interruptible_timeout(drv_data->waitq,
+	time_left = wait_event_timeout(drv_data->waitq,
 		!drv_data->block, drv_data->adapter.timeout);
 
 	spin_lock_irqsave(&drv_data->lock, flags);
-- 
1.7.4.4
