From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Oct 2012 16:18:50 +0300
Subject: [PATCH v2 5/8] i2c: omap: in case of VERSION_2 read IRQSTATUS_RAW but
 write to IRQSTATUS
In-Reply-To: <1350899218-13624-6-git-send-email-balbi@ti.com>
References: <1350899218-13624-6-git-send-email-balbi@ti.com>
Message-ID: <1350911930-13809-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on OMAP4+ we want to read IRQSTATUS_RAW register,
instead of IRQSTATUS. The reason being that IRQSTATUS
will only contain the bits which were enabled on
IRQENABLE_SET and that will break when we need to
poll for a certain bit which wasn't enabled as an
IRQ source.

One such case is after we finish converting to
deferred stop bit, we will have to poll for ARDY
bit before returning control for the client driver
in order to prevent us from trying to start a
transfer on a bus which is already busy.

Note, however, that omap-i2c.c needs a big rework
on register definition and register access. Such
work will be done in a separate series of patches.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 6219522..ba4e910 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -271,8 +271,18 @@ static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
 
 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 {
-	return __raw_readw(i2c_dev->base +
+	/* if we are OMAP_I2C_IP_VERSION_2, we need to read from
+	 * IRQSTATUS_RAW, but write to IRQSTATUS
+	 */
+	if ((i2c_dev->dtrev == OMAP_I2C_IP_VERSION_2) &&
+			(reg == OMAP_I2C_STAT_REG)) {
+		return __raw_readw(i2c_dev->base +
+				((i2c_dev->regs[reg] - 0x04)
+				 << i2c_dev->reg_shift));
+	} else {
+		return __raw_readw(i2c_dev->base +
 				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
+	}
 }
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
-- 
1.8.0.rc0
