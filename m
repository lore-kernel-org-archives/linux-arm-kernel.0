From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Sep 2016 14:14:39 +0200
Subject: [PATCH 3/6] pinctrl: mediatek: constify gpio_chip structures
In-Reply-To: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1473596082-32690-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1473596082-32690-4-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These structures are only used to copy into other structures, so declare
them as const.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct gpio_chip i at p = { ... };

@ok@
identifier r.i;
expression e;
position p;
@@
e = i at p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct gpio_chip e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct gpio_chip i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index ba2b03d..f9aef2a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1054,7 +1054,7 @@ static int mtk_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
 	return 0;
 }
 
-static struct gpio_chip mtk_gpio_chip = {
+static const struct gpio_chip mtk_gpio_chip = {
 	.owner			= THIS_MODULE,
 	.request		= gpiochip_generic_request,
 	.free			= gpiochip_generic_free,
