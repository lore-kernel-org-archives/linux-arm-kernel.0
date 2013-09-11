From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 11 Sep 2013 11:38:05 +0530
Subject: [PATCH 3/3] ASoC: Update pointer to account for pending dma transfers.
In-Reply-To: <1378879685-5352-1-git-send-email-padma.v@samsung.com>
References: <1378879685-5352-1-git-send-email-padma.v@samsung.com>
Message-ID: <1378879685-5352-4-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dylan Reid <dgreid@chromium.org>

Make dma_pointer check how much of the current dma transfer has
completed.  This improves the accuracy of the pointer operation, which
previously was only updated once a period.  Before this change calling
snd_pcm_avail() right before a dma transfer completed would indicate
that the entire transfer was still pending, now it will indicate the
actual count of free frames.

If the dma being used doesn't support the residue operation to query a
pending transfer, then assume that no bytes have been transfered.  This
leads to the same behavior as before the change.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 sound/soc/samsung/dma.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 21b7926..6b2e55d 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -271,13 +271,24 @@ dma_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct runtime_data *prtd = runtime->private_data;
-	unsigned long res;
+	unsigned long offset;
+	unsigned long xfd; /* Number of bytes transfered by current dma. */
+	unsigned int ret = 0;
 
 	pr_debug("Entered %s\n", __func__);
 
-	res = prtd->dma_pos - prtd->dma_start;
+	/* If we can inspect how much of the transfer is left, use that for a
+	 * more accurate number.  Otherwise, assume no bytes have been
+	 * transfered.
+	 */
+	if (prtd->params->ops->residue)
+		ret = prtd->params->ops->residue(prtd->params->ch);
+
+	spin_lock(&prtd->lock);
+	xfd = prtd->dma_period - ret;
 
-	pr_debug("Pointer offset: %lu\n", res);
+	offset = prtd->dma_pos + xfd - prtd->dma_start;
+	spin_unlock(&prtd->lock);
 
 	/* we seem to be getting the odd error from the pcm library due
 	 * to out-of-bounds pointers. this is maybe due to the dma engine
@@ -285,12 +296,12 @@ dma_pointer(struct snd_pcm_substream *substream)
 	 * called... (todo - fix )
 	 */
 
-	if (res >= snd_pcm_lib_buffer_bytes(substream)) {
-		if (res == snd_pcm_lib_buffer_bytes(substream))
-			res = 0;
-	}
+	if (offset >= snd_pcm_lib_buffer_bytes(substream))
+		offset = 0;
+
+	pr_debug("Pointer offset: %lu\n", offset);
 
-	return bytes_to_frames(substream->runtime, res);
+	return bytes_to_frames(substream->runtime, offset);
 }
 
 static int dma_open(struct snd_pcm_substream *substream)
-- 
1.7.4.4
