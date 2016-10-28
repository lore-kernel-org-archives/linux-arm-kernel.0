From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 28 Oct 2016 09:18:24 +0100
Subject: [PATCH v2] ASoC: hdmi-codec: Fix hdmi_of_xlate_dai_name when
 #sound-dai-cells = <0>
In-Reply-To: <20161027141956.GL25322@sirena.org.uk>
References: <1477568568.2908.14.camel@linaro.org>
 <20161027141956.GL25322@sirena.org.uk>
Message-ID: <1477642704.3083.1.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a DAI specifies "#sound-dai-cells = <0>" in device-tree then
hdmi_of_xlate_dai_name() will be called with zero args, which it isn't
implemented to cope with. The resulting use of an uninitialised variable
for the id will usually result in an error like:

  asoc-simple-card sound: parse error -11
  asoc-simple-card: probe of sound failed with error -11

Fix this by using and id of zero if no arg is provided.

Fixes: 9731f82d6016 ("ASoC: hdmi-codec: enable multi probe for same device")

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

Changes since v1
- Replace ternary ?: operator with if/else

 sound/soc/codecs/hdmi-codec.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b904492..90b5948 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -364,7 +364,12 @@ static int hdmi_of_xlate_dai_name(struct snd_soc_component *component,
 				  struct of_phandle_args *args,
 				  const char **dai_name)
 {
-	int id = args->args[0];
+	int id;
+
+	if (args->args_count)
+		id = args->args[0];
+	else
+		id = 0;
 
 	if (id < ARRAY_SIZE(hdmi_dai_name)) {
 		*dai_name = hdmi_dai_name[id];
-- 
2.1.4
