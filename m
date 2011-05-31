From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 31 May 2011 22:33:27 +0200
Subject: [PATCH 1/2] sdio: add function to enable and disable sdio_single_irq
	optimization
In-Reply-To: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
Message-ID: <1306874008-28867-2-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sdio single irq run time configurable, default is disable. This is due
to an issue in libertas where the SDIO device seems to raise interrupt
even if there are none function bits in CCCR_INTx set. This behaviour
is not defined by the SDIO spec.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 drivers/mmc/core/sdio_irq.c |   17 ++++++++++++++++-
 include/linux/mmc/card.h    |    1 +
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 03ead02..2f81ddc 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -204,7 +204,8 @@ static void sdio_single_irq_set(struct mmc_card *card)
 	int i;
 
 	card->sdio_single_irq = NULL;
-	if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
+	if (card->sdio_single_irq_en &&
+	    (card->host->caps & MMC_CAP_SDIO_IRQ) &&
 	    card->host->sdio_irqs == 1)
 		for (i = 0; i < card->sdio_funcs; i++) {
 		       func = card->sdio_func[i];
@@ -302,3 +303,17 @@ int sdio_release_irq(struct sdio_func *func)
 }
 EXPORT_SYMBOL_GPL(sdio_release_irq);
 
+/**
+ *	sdio_single_irq_enable - enable or disable SDIO single IRQ function
+ *	@card: card to enable SDIO single irq
+ *	@value: true to enable SDIO single irq function, false to disable
+ *
+ *	If there is only 1 function interrupt registered and SDIO single IRQ
+ *	is enable, the irq handler is called directly without reading
+ *	the CCCR registers
+ */
+void sdio_single_irq_enable(struct mmc_card *card, bool value)
+{
+	card->sdio_single_irq_en = value;
+}
+EXPORT_SYMBOL_GPL(sdio_single_irq_enable);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 7b4fd7b..f8b0537 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -196,6 +196,7 @@ struct mmc_card {
 	struct sdio_cis		cis;		/* common tuple info */
 	struct sdio_func	*sdio_func[SDIO_MAX_FUNCS]; /* SDIO functions (devices) */
 	struct sdio_func	*sdio_single_irq; /* SDIO function when only one IRQ active */
+	bool			sdio_single_irq_en; /* enable single irq */
 	unsigned		num_info;	/* number of info strings */
 	const char		**info;		/* info strings */
 	struct sdio_func_tuple	*tuples;	/* unknown common tuples */
-- 
1.7.4.1
