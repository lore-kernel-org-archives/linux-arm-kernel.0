From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue,  5 Apr 2016 19:25:49 -0700
Subject: [PATCH net-next V3 03/16] net: fec: return IRQ_HANDLED if
 fec_ptp_check_pps_event handled it
In-Reply-To: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1459909562-22865-4-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fec_ptp_check_pps_event will return 1 if FEC_T_TF_MASK caused
an interrupt. Don't return IRQ_NONE in this case.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v3: New patch, came from feedback from another patch.
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a011719..7993040 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1579,8 +1579,8 @@ fec_enet_interrupt(int irq, void *dev_id)
 	}
 
 	if (fep->ptp_clock)
-		fec_ptp_check_pps_event(fep);
-
+		if (fec_ptp_check_pps_event(fep))
+			ret = IRQ_HANDLED;
 	return ret;
 }
 
-- 
2.5.0
