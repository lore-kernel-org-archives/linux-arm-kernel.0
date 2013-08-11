From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Aug 2013 18:51:42 +0200
Subject: [PATCH 1/16] sound/soc/pxa/mioa701_wm9713.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376239917-15594-2-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
arity of the called function.

The semantic match that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,f;
@@

f(...,
- ARRAY_AND_SIZE(e)
+ e,ARRAY_SIZE(e)
  ,...)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not compiled.

 sound/soc/pxa/mioa701_wm9713.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 97b711e..20fdce6 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -133,10 +133,11 @@ static int mioa701_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 	unsigned short reg;
 
 	/* Add mioa701 specific widgets */
-	snd_soc_dapm_new_controls(dapm, ARRAY_AND_SIZE(mioa701_dapm_widgets));
+	snd_soc_dapm_new_controls(dapm, mioa701_dapm_widgets,
+				  ARRAY_SIZE(mioa701_dapm_widgets));
 
 	/* Set up mioa701 specific audio path audio_mapnects */
-	snd_soc_dapm_add_routes(dapm, ARRAY_AND_SIZE(audio_map));
+	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* Prepare GPIO8 for rear speaker amplifier */
 	reg = codec->driver->read(codec, AC97_GPIO_CFG);
