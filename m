From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 9 Jan 2015 16:53:40 +0800
Subject: [PATCH] ASoC: wm8904: fix runtime warning
Message-ID: <1420793620-2866-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the commit 5fe5b76 (ASoC: dapm: Do not pretend to support
controls for non mixer/mux widgets) remove the fake control.

Then, the wm8904 throw out the following warning at runtime.
--->8---
wm8904 1-001a: Control not supported for path ADCL -> [Left] -> AIFOUTL
wm8904 1-001a: ASoC: no dapm match for ADCL --> Left --> AIFOUTL
wm8904 1-001a: ASoC: Failed to add route ADCL -> Left -> AIFOUTL
wm8904 1-001a: Control not supported for path ADCR -> [Right] -> AIFOUTL
wm8904 1-001a: ASoC: no dapm match for ADCR --> Right --> AIFOUTL
wm8904 1-001a: ASoC: Failed to add route ADCR -> Right -> AIFOUTL
wm8904 1-001a: Control not supported for path ADCL -> [Left] -> AIFOUTR
wm8904 1-001a: ASoC: no dapm match for ADCL --> Left --> AIFOUTR
wm8904 1-001a: ASoC: Failed to add route ADCL -> Left -> AIFOUTR
wm8904 1-001a: Control not supported for path ADCR -> [Right] -> AIFOUTR
wm8904 1-001a: ASoC: no dapm match for ADCR --> Right --> AIFOUTR
wm8904 1-001a: ASoC: Failed to add route ADCR -> Right -> AIFOUTR
wm8904 1-001a: Control not supported for path AIFINR -> [Right] -> DACL
wm8904 1-001a: ASoC: no dapm match for AIFINR --> Right --> DACL
wm8904 1-001a: ASoC: Failed to add route AIFINR -> Right -> DACL
wm8904 1-001a: Control not supported for path AIFINL -> [Left] -> DACL
wm8904 1-001a: ASoC: no dapm match for AIFINL --> Left --> DACL
wm8904 1-001a: ASoC: Failed to add route AIFINL -> Left -> DACL
wm8904 1-001a: Control not supported for path AIFINR -> [Right] -> DACR
wm8904 1-001a: ASoC: no dapm match for AIFINR --> Right --> DACR
wm8904 1-001a: ASoC: Failed to add route AIFINR -> Right -> DACR
wm8904 1-001a: Control not supported for path AIFINL -> [Left] -> DACR
wm8904 1-001a: ASoC: no dapm match for AIFINL --> Left --> DACR
wm8904 1-001a: ASoC: Failed to add route AIFINL -> Left -> DACR
---8<---

This patch is used to remove these warning.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 sound/soc/codecs/wm8904.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 4d2d2b1..38582d7 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1076,10 +1076,10 @@ static const struct snd_soc_dapm_route adc_intercon[] = {
 	{ "Right Capture PGA", NULL, "Right Capture Mux" },
 	{ "Right Capture PGA", NULL, "Right Capture Inverting Mux" },
 
-	{ "AIFOUTL", "Left",  "ADCL" },
-	{ "AIFOUTL", "Right", "ADCR" },
-	{ "AIFOUTR", "Left",  "ADCL" },
-	{ "AIFOUTR", "Right", "ADCR" },
+	{ "AIFOUTL", NULL, "ADCL" },
+	{ "AIFOUTL", NULL, "ADCR" },
+	{ "AIFOUTR", NULL, "ADCL" },
+	{ "AIFOUTR", NULL, "ADCR" },
 
 	{ "ADCL", NULL, "CLK_DSP" },
 	{ "ADCL", NULL, "Left Capture PGA" },
@@ -1089,12 +1089,12 @@ static const struct snd_soc_dapm_route adc_intercon[] = {
 };
 
 static const struct snd_soc_dapm_route dac_intercon[] = {
-	{ "DACL", "Right", "AIFINR" },
-	{ "DACL", "Left",  "AIFINL" },
+	{ "DACL", NULL, "AIFINR" },
+	{ "DACL", NULL, "AIFINL" },
 	{ "DACL", NULL, "CLK_DSP" },
 
-	{ "DACR", "Right", "AIFINR" },
-	{ "DACR", "Left",  "AIFINL" },
+	{ "DACR", NULL, "AIFINR" },
+	{ "DACR", NULL, "AIFINL" },
 	{ "DACR", NULL, "CLK_DSP" },
 
 	{ "Charge pump", NULL, "SYSCLK" },
-- 
2.1.0.24.g4109c28
