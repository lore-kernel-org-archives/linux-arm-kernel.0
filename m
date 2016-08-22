From: michael.weiser@gmx.de (Michael Weiser)
Date: Mon, 22 Aug 2016 18:42:17 +0200
Subject: [PATCH 3/5] net: ethernet: sun4i-emac: Read rxhdr in CPU byte-order
In-Reply-To: <20160822164219.14272-1-michael.weiser@gmx.de>
References: <20160822164219.14272-1-michael.weiser@gmx.de>
Message-ID: <20160822164219.14272-4-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EMAC EMAC_RX_IO_DATA_REG data register is dual-purpose: On one hand
it is used to move actual packet data off the wire. This will be in
wire-format and accepted as such by higher layers such as IP. Therefore
it is correctly read as-is (i.e. raw) using readsl.

On the other hand it provides metadata about incoming transfers to the
driver such as length and checksum validation status. This data is
little-endian, always and it is interpreted by the driver. Therefore it
needs to be swapped to CPU endianness to make sense to the driver. This
is already done for the "receive header" but not rxhdr.

Read rxhdr using readl in order for sun4i-emac to work correctly when
running a big-endian kernel.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: netdev at vger.kernel.org
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index cd08885..87d0b87 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -592,8 +592,7 @@ static void emac_rx(struct net_device *dev)
 		/* A packet ready now  & Get status/length */
 		good_packet = true;
 
-		emac_inblk_32bit(db->membase + EMAC_RX_IO_DATA_REG,
-				&rxhdr, sizeof(rxhdr));
+		rxhdr = readl(db->membase + EMAC_RX_IO_DATA_REG);
 
 		if (netif_msg_rx_status(db))
 			dev_dbg(db->dev, "rxhdr: %x\n", *((int *)(&rxhdr)));
-- 
2.9.2
