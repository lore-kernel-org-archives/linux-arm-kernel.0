From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 14:31:25 +0100
Subject: [PATCH 2/6] ASoC: ab8500: Inform SoC Core that we have our own I/O
 arrangements
In-Reply-To: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343741493-17671-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If codec->control_data is not populated SoC Core assumes we want to
use regmap, which fails catastrophically, as we don't have one:

Unable to handle kernel NULL pointer dereference at virtual address 00000080
pgd = c0004000
[00000080] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1    Not tainted  (3.5.0-rc6-00884-g0b2419e-dirty #130)
PC is at regmap_read+0x10/0x5c
LR is at hw_read+0x80/0x90
pc : [<c01a91b8>]    lr : [<c0216804>]    psr: 60000013

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/ab8500-codec.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 3c79592..23b4018 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2406,6 +2406,10 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
 
 	/* Setup AB8500 according to board-settings */
 	pdata = (struct ab8500_platform_data *)dev_get_platdata(dev->parent);
+
+	/* Inform SoC Core that we have our own I/O arrangements. */
+	codec->control_data = (void *)true;
+
 	status = ab8500_audio_setup_mics(codec, &pdata->codec->amics);
 	if (status < 0) {
 		pr_err("%s: Failed to setup mics (%d)!\n", __func__, status);
-- 
1.7.9.5
