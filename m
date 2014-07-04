From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Jul 2014 17:07:41 +0200
Subject: [PATCH] ASoC: sirf: provide pm-runtime functions when needed
Message-ID: <6778119.KeB0KTehn3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced sirf-usp driver defines sirf_usp_pcm_{suspend,resume}
functions only when PM_RUNTIME is enabled, but also uses them when that
is disabled and only PM_SLEEP is turned on, resulting in this error:

../sound/soc/sirf/sirf-usp.c: In function 'sirf_usp_pcm_suspend':
../sound/soc/sirf/sirf-usp.c:308:3: error: implicit declaration of function 'sirf_usp_pcm_runtime_suspend' [-Werror=implicit-function-declaration]
   sirf_usp_pcm_runtime_suspend(dev);
   ^
../sound/soc/sirf/sirf-usp.c: In function 'sirf_usp_pcm_resume':
../sound/soc/sirf/sirf-usp.c:319:3: error: implicit declaration of function 'sirf_usp_pcm_runtime_resume' [-Werror=implicit-function-declaration]
   ret = sirf_usp_pcm_runtime_resume(dev);
   ^
cc1: some warnings being treated as errors

To fix that, this patch changes the #ifdef to CONFIG_PM, which
is enabled when at least one of PM_SLEEP or PM_RUNTIME are enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/sirf/sirf-usp.c b/sound/soc/sirf/sirf-usp.c
index bdf6aae..9693bc2 100644
--- a/sound/soc/sirf/sirf-usp.c
+++ b/sound/soc/sirf/sirf-usp.c
@@ -282,7 +282,7 @@ static struct snd_soc_dai_driver sirf_usp_pcm_dai = {
 	.ops = &sirf_usp_pcm_dai_ops,
 };
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int sirf_usp_pcm_runtime_suspend(struct device *dev)
 {
 	struct sirf_usp *usp = dev_get_drvdata(dev);
