From: dianders@chromium.org (Doug Anderson)
Date: Tue, 13 Jan 2015 09:51:37 -0800
Subject: [PATCH] mmc: dw_mmc: rockchip: Add DW_MCI_QUIRK_RETRY_DELAY
Message-ID: <1421171497-9440-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've seen at least one card that can get confused during all the
errors generated during tuning on rk3288.  These errors seem to go
away with DW_MCI_QUIRK_RETRY_DELAY.  That quirk is documented to be
for 2.11a and on rk3288 I believe we have 2.70a, but it seems to be
the same type of problem.

Specifically it looks like in certain error conditions (I saw this
with Response CRC errors) that data keeps showing up in the FIFO even
after the error is reported and the CD (command done) bit is set.  If
we don't wait for this data to finish transferring then it confuses
the next transaction.  In the specific failure case I ran into I found
that I could monitor the data_state_mc_busy bit and wait for it to
clear, but in other failure cases this bit was stuck at busy when we
saw an error.  Hence a generic big delay seems like the only option.

I have seen this on rk3288, but adding it as a quirk for all Rockchip
IP for now since most previous quirks have shown up on older IP as
well.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
NOTES:
* This is based atop Addy's patch (mmc: dw_mmc: add quirk for broken
data transfer over scheme) at
<https://patchwork.kernel.org/patch/5565431/>, but it would be trivial
to apply this patch without that one if that were desirable.
* If someone has a better solution to this problem, I'm all ears.

 drivers/mmc/host/dw_mmc-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index ba92ebd..b4caf1a 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -74,7 +74,8 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	host->sdio_id0 = 8;
 
 	/* It needs this quirk on all Rockchip SoCs */
-	host->pdata->quirks |= DW_MCI_QUIRK_BROKEN_DTO;
+	host->pdata->quirks |= DW_MCI_QUIRK_BROKEN_DTO |
+		DW_MCI_QUIRK_RETRY_DELAY;
 
 	return 0;
 }
-- 
2.2.0.rc0.207.ga3a616c
