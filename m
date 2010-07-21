From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 21 Jul 2010 14:51:13 +0200
Subject: [PATCH] fec: use interrupt for MDIO completion indication
In-Reply-To: <20100715040956.GA7690@jasper.tkos.co.il>
References: <006416d38a8e51ba8dd8631613a991528dc7976a.1278918594.git.baruch@tkos.co.il>
	<4C3E812C.10303@canonical.com>
	<20100715040956.GA7690@jasper.tkos.co.il>
Message-ID: <20100721125113.GA2651@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Thanks for this patch, we tested on our i.MX51 board with Ubuntu. It works 
> > fine.
> > 
> > Wolfram, you can pick up this, too. -;)
> 
> Dave has already applied this patch to his net-next tree.

Bryan, thanks for letting me know, I missed this one.

However, have you guys ever tried pulling the cable off/on or restarting
the interface with 'ifconfig down/up'? This always caused a stalled PHY
for me. This patch helps:

==========================

From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] net/fec: restore interrupt mask after software-reset in fec_stop()

After the change from mdio polling to irq, it became necessary to
restore the interrupt mask after resetting the chip in fec_stop().
Otherwise, with all irqs disabled, no communication with the PHY will be
possible after e.g. un-/replugging the cable and the device gets
stalled.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/fec.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 391a553..768b840 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -118,6 +118,8 @@ static unsigned char	fec_mac_default[] = {
 #define FEC_ENET_MII	((uint)0x00800000)	/* MII interrupt */
 #define FEC_ENET_EBERR	((uint)0x00400000)	/* SDMA bus error */
 
+#define FEC_DEFAULT_IMASK (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII)
+
 /* The FEC stores dest/src/type, data, and checksum for receive packets.
  */
 #define PKT_MAXBUF_SIZE		1518
@@ -1213,8 +1215,7 @@ fec_restart(struct net_device *dev, int duplex)
 	writel(0, fep->hwp + FEC_R_DES_ACTIVE);
 
 	/* Enable interrupts we wish to service */
-	writel(FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII,
-			fep->hwp + FEC_IMASK);
+	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
 }
 
 static void
@@ -1233,8 +1234,8 @@ fec_stop(struct net_device *dev)
 	/* Whack a reset.  We should wait for this. */
 	writel(1, fep->hwp + FEC_ECNTRL);
 	udelay(10);
-
 	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
+	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
 }
 
 static int __devinit
-- 
1.7.1

==========================

BUT, while it helps and may possibly be a quick fix for 2.6.35,
resetting the chip in fec_stop() looks like a wrong thing to do for me.
In the long run, it probably is better to make sure the chip is set up
correctly during initialization, so the reset in fec_stop() is not
needed at all. I had a quick shot at this, but seem to have missed
something as it didn't work. As I will be away from the computers for
two weeks in about 24 hours, I at least wanted to bring up the issue.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100721/852e18a4/attachment-0001.sig>
