From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 6 Aug 2012 16:38:25 -0300
Subject: [PATCH 1/1] mx27_3ds: Add sound support
In-Reply-To: <501FD389.1050105@gmail.com>
References: <1344258447-6162-1-git-send-email-gcembed@gmail.com>
 <CAOMZO5B9ZmTHrYjVc5a7j=uUgUEyfDva54cKxBP3UeCYZsUWRw@mail.gmail.com>
 <501FD389.1050105@gmail.com>
Message-ID: <CAOMZO5C-h214dtpRx6n13=6i2M+epebOeyrctr6zsApUtTgeBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ga?tan,

On Mon, Aug 6, 2012 at 11:24 AM, Ga?tan Carlier <gcembed@gmail.com> wrote:
> Hi Fabio,
> Sorry, I have missed your patch in my email archive. I didn't search the
> right keywords.
> I applied your [patch 1/2] (2/2 is already merged) but I have same effect. I
> use aplay with file k3b_error1.wav (Unsigned 8 bit, Rate 8000 Hz, Mono) and
> alsa/Front_Left.wav (Signed 16 bit Little Endian, Rate 48000 Hz, Mono). Two
> sounds are played too fast.
> It is maybe a bad configuration of Alsa (but this is working with kernel
> 2.6.22 from Freescale).

I have just sent the following patch to the alsa-list which fixes this
mono playback issue.

Regards,

Fabio Estevam

>From bc46087110bd48a41f1f7dcb826853349662c766 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Mon, 6 Aug 2012 16:30:51 -0300
Subject: [PATCH] ASoC: imx-ssi: Fix mono playback

Currently mono playback is played on a faster rate.

Adjust channels_min to 2 channels in order to play it back correctly.

Reported-by: Ga?tan Carlier <gcembed@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-ssi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 28dd76c..c42df31 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -380,7 +380,7 @@ static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
 static struct snd_soc_dai_driver imx_ssi_dai = {
 	.probe = imx_ssi_dai_probe,
 	.playback = {
-		.channels_min = 1,
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_96000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-- 
1.7.1
