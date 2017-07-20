From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 20 Jul 2017 09:17:58 -0500
Subject: [PATCH] staging: bcm2835-audio: constify snd_pcm_ops structures
Message-ID: <20170720141758.GA9574@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for snd_pcm_ops structures that are only stored in the ops field of
a snd_soc_platform_driver structure or passed as the third argument to
snd_pcm_set_ops. The corresponding field or parameter is declared const,
so snd_pcm_ops structures that have this property can be declared as
const also.

This issue was detected using Coccinelle and the following semantic patch:

@r disable optional_qualifier@
identifier i;
position p;
@@
static struct snd_pcm_ops i at p = { ... };

@ok1@
identifier r.i;
struct snd_soc_platform_driver e;
position p;
@@
e.ops = &i at p;

@ok2@
identifier r.i;
expression e1, e2; position p;
@@
snd_pcm_set_ops(e1, e2, &i at p)

@bad@
position p != {r.p,ok1.p,ok2.p};
identifier r.i;
struct snd_pcm_ops e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
struct snd_pcm_ops i = { ... };

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 3637ddf..1bf34ce 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -438,7 +438,7 @@ static int snd_bcm2835_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 }
 
 /* operators */
-static struct snd_pcm_ops snd_bcm2835_playback_ops = {
+static const struct snd_pcm_ops snd_bcm2835_playback_ops = {
 	.open = snd_bcm2835_playback_open,
 	.close = snd_bcm2835_playback_close,
 	.ioctl = snd_bcm2835_pcm_lib_ioctl,
@@ -450,7 +450,7 @@ static struct snd_pcm_ops snd_bcm2835_playback_ops = {
 	.ack = snd_bcm2835_pcm_ack,
 };
 
-static struct snd_pcm_ops snd_bcm2835_playback_spdif_ops = {
+static const struct snd_pcm_ops snd_bcm2835_playback_spdif_ops = {
 	.open = snd_bcm2835_playback_spdif_open,
 	.close = snd_bcm2835_playback_close,
 	.ioctl = snd_bcm2835_pcm_lib_ioctl,
-- 
2.5.0
