From: b32955@freescale.com (Huang Shijie)
Date: Fri, 11 Oct 2013 18:31:00 +0800
Subject: [PATCH 3/4] serial: imx: fix the wrong number of scatterlist entries
 when xmit->head is 0
In-Reply-To: <1381487461-12850-1-git-send-email-b32955@freescale.com>
References: <1381487461-12850-1-git-send-email-b32955@freescale.com>
Message-ID: <1381487461-12850-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the (xmit->tail > xmit->head) is true and the xmit->head is 0,
we only need one DMA scatterlist in actually. Current code uses two DMA
scatterlists in this case, this is obviously wrong.

This patch fixes it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c6c3b16..cadf7e5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -532,7 +532,7 @@ static void dma_tx_work(struct work_struct *w)
 		return;
 	}
 
-	if (xmit->tail > xmit->head) {
+	if (xmit->tail > xmit->head && xmit->head > 0) {
 		sport->dma_tx_nents = 2;
 		sg_init_table(sgl, 2);
 		sg_set_buf(sgl, xmit->buf + xmit->tail,
-- 
1.7.2.rc3
