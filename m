From: bhumirks@gmail.com (Bhumika Goyal)
Date: Tue, 10 Jan 2017 23:42:06 +0530
Subject: [PATCH] pwm: constify pwm_ops structures
Message-ID: <1484071926-21582-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare pwm_ops structures as const as they are only stored in the ops
field of a pwm_chip structure. This field is of type const struct pwm_ops
*, so pwm_ops structures having this property can be declared as const.
Done using Coccinelle:

@r1 disable optional_qualifier@
identifier i;
position p;
@@
static struct pwm_ops i at p={...};

@ok1@
identifier r1.i;
position p;
struct pxa_pwm_chip pwm;
struct bfin_pwm_chip bwm;
struct vt8500_chip vp;
struct imx_chip icp;
@@
(
pwm.chip.ops=&i at p
|
bwm.chip.ops=&i at p
|
vp.chip.ops=&i at p
|
icp.chip.ops=&i at p
)

@bad@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i at p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct pwm_ops i;

File size details:

   text	   data	    bss	    dec	    hex	filename
   1646	    328	      0	   1974	    7b6	drivers/pwm/pwm-imx.o
   1742	    224	      0	   1966	    7ae	drivers/pwm/pwm-imx.o

   1941	    296	      0	   2237	    8bd	drivers/pwm/pwm-pxa.o
   2037	    192	      0	   2229	    8b5	drivers/pwm/pwm-pxa.o

   1946	    296	      0	   2242	    8c2	drivers/pwm/pwm-vt8500.o
   2050	    192	      0	   2242	    8c2	drivers/pwm/pwm-vt8500.o

The drivers/pwm/pwm-bfin.o file did not compile.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
File: drivers/pwm/pwm-bfin.c is not tested

 drivers/pwm/pwm-bfin.c   | 2 +-
 drivers/pwm/pwm-imx.c    | 2 +-
 drivers/pwm/pwm-pxa.c    | 2 +-
 drivers/pwm/pwm-vt8500.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-bfin.c b/drivers/pwm/pwm-bfin.c
index 7631ef1..d2ed0a2 100644
--- a/drivers/pwm/pwm-bfin.c
+++ b/drivers/pwm/pwm-bfin.c
@@ -103,7 +103,7 @@ static void bfin_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	disable_gptimer(priv->pin);
 }
 
-static struct pwm_ops bfin_pwm_ops = {
+static const struct pwm_ops bfin_pwm_ops = {
 	.request = bfin_pwm_request,
 	.free = bfin_pwm_free,
 	.config = bfin_pwm_config,
diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d600fd5..177fb81 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -240,7 +240,7 @@ static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(imx->clk_per);
 }
 
-static struct pwm_ops imx_pwm_ops = {
+static const struct pwm_ops imx_pwm_ops = {
 	.enable = imx_pwm_enable,
 	.disable = imx_pwm_disable,
 	.config = imx_pwm_config,
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 58b709f..4143a46 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -118,7 +118,7 @@ static void pxa_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(pc->clk);
 }
 
-static struct pwm_ops pxa_pwm_ops = {
+static const struct pwm_ops pxa_pwm_ops = {
 	.config = pxa_pwm_config,
 	.enable = pxa_pwm_enable,
 	.disable = pxa_pwm_disable,
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index cdb58fd..8141a49 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -184,7 +184,7 @@ static int vt8500_pwm_set_polarity(struct pwm_chip *chip,
 	return 0;
 }
 
-static struct pwm_ops vt8500_pwm_ops = {
+static const struct pwm_ops vt8500_pwm_ops = {
 	.enable = vt8500_pwm_enable,
 	.disable = vt8500_pwm_disable,
 	.config = vt8500_pwm_config,
-- 
1.9.1
