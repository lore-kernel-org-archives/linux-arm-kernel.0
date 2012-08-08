From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 8 Aug 2012 20:40:31 +0530
Subject: [PATCH] ASoC: Davinci: McASP: Flush the FIFO before enabling
In-Reply-To: <1344438632-2604-1-git-send-email-gururaja.hebbar@ti.com>
References: <1344438632-2604-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1344438632-2604-2-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

FIFO should be flushed before it is enabled for the first time.
This fixes the I/O errors reported by the ASoC core on a fresh boot

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
This patch was tested on AM18x Board and is based on repo at 
http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;
a=shortlog;h=refs/heads/for-3.6

:100644 100644 95441bf... ce5e5cd... M	sound/soc/davinci/davinci-mcasp.c
 sound/soc/davinci/davinci-mcasp.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 95441bf..ce5e5cd 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -380,14 +380,20 @@ static void mcasp_start_tx(struct davinci_audio_dev *dev)
 static void davinci_mcasp_start(struct davinci_audio_dev *dev, int stream)
 {
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (dev->txnumevt)	/* enable FIFO */
+		if (dev->txnumevt) {	/* enable FIFO */
+			mcasp_clr_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+								FIFO_ENABLE);
 			mcasp_set_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
 								FIFO_ENABLE);
+		}
 		mcasp_start_tx(dev);
 	} else {
-		if (dev->rxnumevt)	/* enable FIFO */
+		if (dev->rxnumevt) {	/* enable FIFO */
+			mcasp_clr_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+								FIFO_ENABLE);
 			mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
 								FIFO_ENABLE);
+		}
 		mcasp_start_rx(dev);
 	}
 }
-- 
1.7.1
