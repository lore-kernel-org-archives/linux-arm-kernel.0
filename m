From: agross@codeaurora.org (Andy Gross)
Date: Tue, 13 May 2014 16:34:42 -0500
Subject: [PATCH 2/4] spi: qup: Correct selection of FIFO/Block mode
In-Reply-To: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
Message-ID: <1400016884-9568-3-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the calculation for determining whether to use FIFO or BLOCK
mode.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/spi/spi-qup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index ea7017b..57b65e9 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -289,7 +289,7 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 	writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
 
 	if (!xfer) {
-		dev_err_ratelimited(controller->dev, "unexpected irq %x08 %x08 %x08\n",
+		dev_err_ratelimited(controller->dev, "unexpected irq %08x %08x %08x\n",
 				    qup_err, spi_err, opflags);
 		return IRQ_HANDLED;
 	}
@@ -368,7 +368,7 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 	n_words = xfer->len / w_size;
 	controller->w_size = w_size;
 
-	if (n_words <= controller->in_fifo_sz) {
+	if (n_words <= (controller->in_fifo_sz / sizeof(u32))) {
 		mode = QUP_IO_M_MODE_FIFO;
 		writel_relaxed(n_words, controller->base + QUP_MX_READ_CNT);
 		writel_relaxed(n_words, controller->base + QUP_MX_WRITE_CNT);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
