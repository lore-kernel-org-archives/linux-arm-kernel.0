From: dianders@chromium.org (Doug Anderson)
Date: Wed, 11 Mar 2015 15:15:14 -0700
Subject: [PATCH v4 1/4] mmc: dw_mmc: Don't try to enable the CD until we're
 sure we're not deferring
Message-ID: <1426112117-18220-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If dw_mci_init_slot() returns that we got a probe deferral then it may
leave slot->mmc as NULL.  That will cause dw_mci_enable_cd() to crash
when it calls mmc_gpio_get_cd().

Fix this by moving the call of dw_mci_enable_cd() until we're sure
that we're good.  Note that if we have more than one slot and one
defers (but the others don't) things won't work so well.  ...but
that's not a new thing and everyone has already agreed that multislot
support ought to be removed from dw_mmc eventually anyway since it is
unused, untested, and you can see several bugs like this by inspecting
the code.

Fixes: bcafaf5470f0 ("mmc: dw_mmc: Only enable CD after setup and only if needed")
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v4:
- Defer vs. card detect fix patch new for v4.

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 47dfd0e..e2811cf 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2863,9 +2863,6 @@ int dw_mci_probe(struct dw_mci *host)
 			init_slots++;
 	}
 
-	/* Now that slots are all setup, we can enable card detect */
-	dw_mci_enable_cd(host);
-
 	if (init_slots) {
 		dev_info(host->dev, "%d slots initialized\n", init_slots);
 	} else {
@@ -2874,6 +2871,9 @@ int dw_mci_probe(struct dw_mci *host)
 		goto err_dmaunmap;
 	}
 
+	/* Now that slots are all setup, we can enable card detect */
+	dw_mci_enable_cd(host);
+
 	if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
 		dev_info(host->dev, "Internal DMAC interrupt fix enabled.\n");
 
-- 
2.2.0.rc0.207.ga3a616c
