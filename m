From: koro.chen@mediatek.com (Koro Chen)
Date: Wed, 13 May 2015 22:39:03 +0800
Subject: [RFC PATCH] ALSA: pcm: Modify double acknowledged interrupts check
 condition
Message-ID: <1431527943-64178-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently in snd_pcm_update_hw_ptr0 during interrupt,
we consider there were double acknowledged interrupts when:
1. HW reported pointer is smaller than expected, and
2. Time from last update time (hdelta) is over half a buffer time.

However, when HW reported pointer is only a few bytes smaller than
expected, and when hdelta is just a little larger than half a buffer time
(e.g. ping-pong buffer), it wrongly treats this IRQ as double acknowledged.

The condition #2 uses jiffies, but jiffies is not high resolution
since it is integer. We should consider jiffies inaccuracy.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/core/pcm_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index ac6b33f..7d45645 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -339,7 +339,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 		if (delta > new_hw_ptr) {
 			/* check for double acknowledged interrupts */
 			hdelta = curr_jiffies - runtime->hw_ptr_jiffies;
-			if (hdelta > runtime->hw_ptr_buffer_jiffies/2) {
+			if (hdelta > runtime->hw_ptr_buffer_jiffies/2 + 1) {
 				hw_base += runtime->buffer_size;
 				if (hw_base >= runtime->boundary) {
 					hw_base = 0;
-- 
1.8.1.1.dirty
