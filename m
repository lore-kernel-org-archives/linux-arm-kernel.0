From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 09:29:37 +0100
Subject: [PATCH 9/9] clk: spi-pl022: convert to clk_prepare()/clk_unprepare()
Message-ID: <E1R8T2n-0003wr-Rb@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/spi/spi-pl022.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 3520cf9..1ab2fa0 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2187,6 +2187,13 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		dev_err(&adev->dev, "could not retrieve SSP/SPI bus clock\n");
 		goto err_no_clk;
 	}
+
+	status = clk_prepare(pl022->clk);
+	if (status) {
+		dev_err(&adev->dev, "could not prepare SSP/SPI bus clock\n");
+		goto  err_clk_prep;
+	}
+
 	/* Disable SSP */
 	writew((readw(SSP_CR1(pl022->virtbase)) & (~SSP_CR1_MASK_SSE)),
 	       SSP_CR1(pl022->virtbase));
@@ -2238,6 +2245,8 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	pl022_dma_remove(pl022);
 	free_irq(adev->irq[0], pl022);
  err_no_irq:
+	clk_unprepare(pl022->clk);
+ err_clk_prep:
 	clk_put(pl022->clk);
  err_no_clk:
 	iounmap(pl022->virtbase);
@@ -2271,6 +2280,7 @@ pl022_remove(struct amba_device *adev)
 	pl022_dma_remove(pl022);
 	free_irq(adev->irq[0], pl022);
 	clk_disable(pl022->clk);
+	clk_unprepare(pl022->clk);
 	clk_put(pl022->clk);
 	iounmap(pl022->virtbase);
 	amba_release_regions(adev);
-- 
1.7.4.4
