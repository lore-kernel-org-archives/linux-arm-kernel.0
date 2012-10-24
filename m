From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Wed, 24 Oct 2012 19:58:31 +0900
Subject: [PATCH 5/5] i2c: i2c-sh_mobile: fix spurious transfer request timed
 out
In-Reply-To: <5087C93F.6080601@renesas.com>
References: <5087C93F.6080601@renesas.com>
Message-ID: <5087C9D7.1040108@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that any of preceding register write operations to the I2C
hardware block reached the module, and the write data is reflected
in the registers, before leaving the interrupt handler.

Otherwise, we'll suffer from spurious WAIT interrupts that lead to
'Transfer request timed out' message, and the transaction failed.

Tracked-down-by: Teppei Kamijou <teppei.kamijou.yb@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 4c28358..9411c1b 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -469,6 +469,9 @@ static irqreturn_t sh_mobile_i2c_isr(int irq, void *dev_id)
 		wake_up(&pd->wait);
 	}
 
+	/* defeat write posting to avoid spurious WAIT interrupts */
+	iic_rd(pd, ICSR);
+
 	return IRQ_HANDLED;
 }
 
-- 
1.7.12.4
