From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 20 Jul 2012 17:20:26 +0800
Subject: [PATCH 3/4] ASoC: sgtl5000: remove unneeded snd_soc_dapm_new_widgets
 in probe
In-Reply-To: <1342776027-31758-1-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
Message-ID: <1342776027-31758-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

There's a driver bug that sgtl5000 dapm widget kcontrols do not work.
e.g. can not select capture mux with amixer tool(no error info prompted).

The root cause is that we still call snd_soc_dapm_new_widgets in
codec driver probe function afer converting to table based widgets.
This will cause the card dapm widgets are instantiated before the
dapm_routes are registered.
Then, no available dapm widget pathes can be found during instantiation
which finally will cause soc_dapm_mux_update_power to fail(can not find
correct path with kcontrol) in snd_soc_dapm_put_enum_double function.

Here we remove the unneeded snd_soc_dapm_new_widgets in codec probe
and let the soc core to handle the register sequence properly.
Then we can fix above issue.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 sound/soc/codecs/sgtl5000.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 8af6a52..5c54b6f 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1357,8 +1357,6 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	if (ret)
 		goto err;
 
-	snd_soc_dapm_new_widgets(&codec->dapm);
-
 	return 0;
 
 err:
-- 
1.7.0.4
