From: per.forlin@stericsson.com (Per Forlin)
Date: Wed, 1 Jun 2011 10:48:33 +0200
Subject: [PATCH v2 2/2] sdio: report error if pending IRQ but none CCCR_INTx
	bits
In-Reply-To: <1306918113-23872-2-git-send-email-per.forlin@stericsson.com>
References: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
	<1306918113-23872-2-git-send-email-per.forlin@stericsson.com>
Message-ID: <1306918113-23872-3-git-send-email-per.forlin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Forlin <per.forlin@linaro.org>

Return error in case of pending IRQ but none functions bits
in CCCR_INTx are set.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 drivers/mmc/core/sdio_irq.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index df1e946..4288d92 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -50,6 +50,11 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
 		return ret;
 	}
 
+	if (!pending) {
+		printk(KERN_WARNING "%s: pending IRQ but none function bits\n",
+		       mmc_card_id(card));
+		ret = -EINVAL;
+	}
 	count = 0;
 	for (i = 1; i <= 7; i++) {
 		if (pending & (1 << i)) {
-- 
1.7.4.1
