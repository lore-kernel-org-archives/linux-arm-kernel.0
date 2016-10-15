From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 15 Oct 2016 16:55:47 +0200
Subject: [PATCH 3/7] ASoC: rockchip: constify snd_soc_ops structures
In-Reply-To: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1476543351-17858-4-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for snd_soc_ops structures that are only stored in the ops field of a
snd_soc_dai_link structure.  This field is declared const, so snd_soc_ops
structures that have this property can be declared as const also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct snd_soc_ops i at p = { ... };

@ok1@
identifier r.i;
struct snd_soc_dai_link e;
position p;
@@
e.ops = &i at p;

@ok2@
identifier r.i, e;
position p;
@@
struct snd_soc_dai_link e[] = { ..., { .ops = &i at p, }, ..., };

@bad@
position p != {r.p,ok1.p,ok2.p};
identifier r.i;
struct snd_soc_ops e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct snd_soc_ops i = { ... };
// </smpl>

The effect on the layout of the .o files is shown by the following output
of the size command, first before then after the transformation:

   text    data     bss     dec     hex filename
   5027    2488     416    7931    1efb sound/soc/rockchip/rk3399_gru_sound.o
   5219    2312     416    7947    1f0b sound/soc/rockchip/rk3399_gru_sound.o

   text    data     bss     dec     hex filename
   3499    1648     384    5531    159b sound/soc/rockchip/rockchip_max98090.o
   3563    1584     384    5531    159b sound/soc/rockchip/rockchip_max98090.o

   text    data     bss     dec     hex filename
   3455    1536     384    5375    14ff sound/soc/rockchip/rockchip_rt5645.o
   3519    1480     384    5383    1507 sound/soc/rockchip/rockchip_rt5645.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/rockchip/rk3399_gru_sound.c  |    6 +++---
 sound/soc/rockchip/rockchip_max98090.c |    2 +-
 sound/soc/rockchip/rockchip_rt5645.c   |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff -u -p a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -228,15 +228,15 @@ static int rockchip_sound_da7219_init(st
 	return 0;
 }
 
-static struct snd_soc_ops rockchip_sound_max98357a_ops = {
+static const struct snd_soc_ops rockchip_sound_max98357a_ops = {
 	.hw_params = rockchip_sound_max98357a_hw_params,
 };
 
-static struct snd_soc_ops rockchip_sound_rt5514_ops = {
+static const struct snd_soc_ops rockchip_sound_rt5514_ops = {
 	.hw_params = rockchip_sound_rt5514_hw_params,
 };
 
-static struct snd_soc_ops rockchip_sound_da7219_ops = {
+static const struct snd_soc_ops rockchip_sound_da7219_ops = {
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
diff -u -p a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -119,7 +119,7 @@ static int rk_aif1_hw_params(struct snd_
 	return ret;
 }
 
-static struct snd_soc_ops rk_aif1_ops = {
+static const struct snd_soc_ops rk_aif1_ops = {
 	.hw_params = rk_aif1_hw_params,
 };
 
diff -u -p a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -135,7 +135,7 @@ static int rk_init(struct snd_soc_pcm_ru
 				     &headset_jack);
 }
 
-static struct snd_soc_ops rk_aif1_ops = {
+static const struct snd_soc_ops rk_aif1_ops = {
 	.hw_params = rk_aif1_hw_params,
 };
 
