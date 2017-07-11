From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 11 Jul 2017 13:03:39 -0500
Subject: [PATCH] pinctrl: bcm2835: constify gpio_chip structure
Message-ID: <20170711180339.GA17806@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This structure is only used to copy into other structure, so declare
it as const.

This issue was detected using Coccinelle and the following semantic patch:

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

In the following log you can see a significant difference in the code size
and data segment, hence in the dec segment. This log is the output
of the size command, before and after the code change:

before:
   text    data     bss     dec     hex filename
  18958    9000     128   28086    6db6 drivers/pinctrl/bcm/pinctrl-bcm2835.o

after:
   text    data     bss     dec     hex filename
  18764    8912     128   27804    6c9c drivers/pinctrl/bcm/pinctrl-bcm2835.o

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 2308831..7203f35 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -353,7 +353,7 @@ static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
 	return pinctrl_gpio_direction_output(chip->base + offset);
 }
 
-static struct gpio_chip bcm2835_gpio_chip = {
+static const struct gpio_chip bcm2835_gpio_chip = {
 	.label = MODULE_NAME,
 	.owner = THIS_MODULE,
 	.request = gpiochip_generic_request,
-- 
2.5.0
