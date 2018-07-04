From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Jul 2018 15:35:24 +0100
Subject: Applied "ASoC: qdsp6: q6asm-dai: do not close port if its not opened"
 to the asoc tree
In-Reply-To: <20180704094944.16440-7-srinivas.kandagatla@linaro.org>
Message-ID: <E1faisO-0003OI-Mz@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qdsp6: q6asm-dai: do not close port if its not opened

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5dffc1752cabde6396fca28ff8343febfa524512 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 4 Jul 2018 10:49:44 +0100
Subject: [PATCH] ASoC: qdsp6: q6asm-dai: do not close port if its not opened

asm ports are open as part of prepare, so for use cases like
"aplay sample.wav" were sample.wav is not present. This would
call port close eventhough port was never opened. DSP would
return errors for such use cases.

Avoid doing this by checking the port state.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 349c6a883c63..360936703b3d 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -390,7 +390,9 @@ static int q6asm_dai_close(struct snd_pcm_substream *substream)
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
 
 	if (prtd->audio_client) {
-		q6asm_cmd(prtd->audio_client, CMD_CLOSE);
+		if (prtd->state)
+			q6asm_cmd(prtd->audio_client, CMD_CLOSE);
+
 		q6asm_unmap_memory_regions(substream->stream,
 					   prtd->audio_client);
 		q6asm_audio_client_free(prtd->audio_client);
-- 
2.18.0.rc2
