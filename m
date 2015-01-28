From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:25:10 +0100
Subject: [PATCH] spi/rockchip: avoid uninitialized-use warning
Message-ID: <1957186.KORYFIrP42@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently get a warning about potentially uninitialized variables
in the rockchip spi driver, at least in certain toolchain versions:

spi/spi-rockchip.c: In function 'rockchip_spi_prepare_dma':
include/linux/dmaengine.h:796:2: warning: 'txdesc' may be used uninitialized in this function
include/linux/dmaengine.h:796:2: warning: 'rxdesc' may be used uninitialized in this function

The reason seems to be that gcc cannot know whether the value
of the rs->rx and rs->tx variables change between the two points
these are accessed.

The code is actually correct, but to make this clearer to the
compiler, this changes the conditionals to test for the local
rxdesc/txdesc variables instead, which it knows won't change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index daabbabd26b0..1a777dc261d6 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -437,6 +437,7 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	rs->state &= ~TXBUSY;
 	spin_unlock_irqrestore(&rs->lock, flags);
 
+	rxdesc = NULL;
 	if (rs->rx) {
 		rxconf.direction = rs->dma_rx.direction;
 		rxconf.src_addr = rs->dma_rx.addr;
@@ -453,6 +454,7 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		rxdesc->callback_param = rs;
 	}
 
+	txdesc = NULL;
 	if (rs->tx) {
 		txconf.direction = rs->dma_tx.direction;
 		txconf.dst_addr = rs->dma_tx.addr;
@@ -470,7 +472,7 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	}
 
 	/* rx must be started before tx due to spi instinct */
-	if (rs->rx) {
+	if (rxdesc) {
 		spin_lock_irqsave(&rs->lock, flags);
 		rs->state |= RXBUSY;
 		spin_unlock_irqrestore(&rs->lock, flags);
@@ -478,7 +480,7 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
 
-	if (rs->tx) {
+	if (txdesc) {
 		spin_lock_irqsave(&rs->lock, flags);
 		rs->state |= TXBUSY;
 		spin_unlock_irqrestore(&rs->lock, flags);
