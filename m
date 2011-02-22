From: henry.nestler@gmail.com (Henry Nestler)
Date: Tue, 22 Feb 2011 22:29:42 +0100
Subject: [PATCHv2 2/2] DM9000B: Fix PHY power for network down/up
In-Reply-To: <20110222.102410.260079835.davem@davemloft.net>
References: <4D618B5D.5040001@henry.nestler.mail.gmail.com>
	<4D62491F.4050602@ru.mvista.com>
	<4D62D323.7010403@henry.nestler.mail.gmail.com>
	<20110222.102410.260079835.davem@davemloft.net>
Message-ID: <4D642AC6.6050101@henry.nestler.mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DM9000 revision B needs 1 ms delay after PHY power-on.
PHY must be powered on by writing 0 into register DM9000_GPR before
all other settings will change (see Davicom spec and example code).

Remember, that register DM9000_GPR was not changed by reset sequence.

Without this fix the FIFO is out of sync and sends wrong data after
sequence of "ifconfig ethX down ; ifconfig ethX up".
---
Kernel version 2.6.38-rc5

 drivers/net/dm9000.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dm9000.c b/drivers/net/dm9000.c
index 2d4c4fc..5925569 100644
--- a/drivers/net/dm9000.c
+++ b/drivers/net/dm9000.c
@@ -802,10 +802,7 @@ dm9000_init_dm9000(struct net_device *dev)
 	/* Checksum mode */
 	dm9000_set_rx_csum_unlocked(dev, db->rx_csum);

-	/* GPIO0 on pre-activate PHY */
-	iow(db, DM9000_GPR, 0);	/* REG_1F bit0 activate phyxcer */
 	iow(db, DM9000_GPCR, GPCR_GEP_CNTL);	/* Let GPIO0 output */
-	iow(db, DM9000_GPR, 0);	/* Enable PHY */

 	ncr = (db->flags & DM9000_PLATF_EXT_PHY) ? NCR_EXT_PHY : 0;

@@ -1194,6 +1191,10 @@ dm9000_open(struct net_device *dev)
 	if (request_irq(dev->irq, dm9000_interrupt, irqflags, dev->name, dev))
 		return -EAGAIN;

+	/* GPIO0 on pre-activate PHY, Reg 1F is not set by reset */
+	iow(db, DM9000_GPR, 0);	/* REG_1F bit0 activate phyxcer */
+	mdelay(1); /* delay needs by DM9000B */
+
 	/* Initialize DM9000 board */
 	dm9000_reset(db);
 	dm9000_init_dm9000(dev);
