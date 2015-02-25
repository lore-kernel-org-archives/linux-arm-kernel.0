From: dianders@chromium.org (Doug Anderson)
Date: Wed, 25 Feb 2015 10:11:52 -0800
Subject: [PATCH 2/2] mmc: dw_mmc: Don't crash if we get an interrupt before
 slot has initted
In-Reply-To: <1424887912-20015-1-git-send-email-dianders@chromium.org>
References: <1424887912-20015-1-git-send-email-dianders@chromium.org>
Message-ID: <1424887912-20015-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's unlikely that this is really needed on any single-slot systems
where we disable card detects until the end of probe, but it still
seems safer to check to make sure that a slot has been initted before
we try to dereference it to find the SDIO interrupt mask.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 8df2a92..1c909ad 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2156,6 +2156,10 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		/* Handle SDIO Interrupts */
 		for (i = 0; i < host->num_slots; i++) {
 			struct dw_mci_slot *slot = host->slot[i];
+
+			if (!slot)
+				continue;
+
 			if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
 				mci_writel(host, RINTSTS,
 					   SDMMC_INT_SDIO(slot->sdio_id));
-- 
2.2.0.rc0.207.ga3a616c
