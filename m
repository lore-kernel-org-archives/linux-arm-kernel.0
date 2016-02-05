From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri,  5 Feb 2016 14:52:48 -0700
Subject: [PATCH net-next V2 6/8] net: fec: don't disable FEC_ENET_TS_TIMER
 interrupt
In-Reply-To: <1454709170-19527-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454709170-19527-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454709170-19527-7-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the interrupt routine processes this condition.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index bedd28a..195122e 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -375,6 +375,7 @@ struct bufdesc_ex {
 #define FEC_ENET_TS_TIMER       ((uint)0x00008000)
 
 #define FEC_DEFAULT_IMASK (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII | FEC_ENET_TS_TIMER)
+#define FEC_NAPI_IMASK	(FEC_ENET_MII | FEC_ENET_TS_TIMER)
 #define FEC_RX_DISABLED_IMASK (FEC_DEFAULT_IMASK & (~FEC_ENET_RXF))
 
 /* ENET interrupt coalescing macro define */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 712e3bb..ca2708d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1553,7 +1553,7 @@ fec_enet_interrupt(int irq, void *dev_id)
 
 		if (napi_schedule_prep(&fep->napi)) {
 			/* Disable the NAPI interrupts */
-			writel(FEC_ENET_MII, fep->hwp + FEC_IMASK);
+			writel(FEC_NAPI_IMASK, fep->hwp + FEC_IMASK);
 			__napi_schedule(&fep->napi);
 		}
 	}
-- 
2.5.0
