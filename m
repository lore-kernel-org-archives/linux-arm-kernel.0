From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 5 May 2011 13:14:23 +0200
Subject: [PATCH 2/2] mmci: fixup sg buffer handling in mmci_pio_irq.
Message-ID: <1304594063-19408-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>

Earlier code was expecting that mmci_pio_write() returns
not more than 'remain' bytes transferred. It is not the case
for buffers which are not multiple of 4 bytes length.

The patch fix the problem by checking result of mmci_pio_write().

The fault was introduced in the change:
	I2e506ec1f5a7fadf9780c18d8d31573eaf048273
	MMCI: Fixup sg buffer handling in pio_write

Signed-off-by: Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 6e27433..e238462 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -753,7 +753,10 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		if (status & MCI_TXACTIVE)
 			len = mmci_pio_write(host, buffer, remain, status);
 
-		sg_miter->consumed = len;
+		if (len > sg_miter->consumed)
+			len = sg_miter->consumed;
+		else
+			sg_miter->consumed = len;
 
 		host->size -= len;
 		remain -= len;
-- 
1.7.3.2
