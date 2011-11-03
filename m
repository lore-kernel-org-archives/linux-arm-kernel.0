From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 3 Nov 2011 16:55:41 +0100
Subject: [PATCH V2] spi/pl022: Enable clock in probe
Message-ID: <1320335741-5309-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure we enable the clock before leaving probe.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---

Changes in v2:
	-Remove runtime_idle

---
 drivers/spi/spi-pl022.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f103e47..5559b22 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2184,6 +2184,12 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		goto  err_clk_prep;
 	}
 
+	status = clk_enable(pl022->clk);
+	if (status) {
+		dev_err(&adev->dev, "could not enable SSP/SPI bus clock\n");
+		goto err_no_clk_en;
+	}
+
 	/* Disable SSP */
 	writew((readw(SSP_CR1(pl022->virtbase)) & (~SSP_CR1_MASK_SSE)),
 	       SSP_CR1(pl022->virtbase));
@@ -2237,6 +2243,8 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 
 	free_irq(adev->irq[0], pl022);
  err_no_irq:
+	clk_disable(pl022->clk);
+ err_no_clk_en:
 	clk_unprepare(pl022->clk);
  err_clk_prep:
 	clk_put(pl022->clk);
-- 
1.7.5.4
