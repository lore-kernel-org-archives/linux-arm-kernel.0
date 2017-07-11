From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 11 Jul 2017 16:29:29 -0500
Subject: [PATCH] pinctrl: nomadik: abx500: constify gpio_chip structure
Message-ID: <20170711212929.GA1037@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This structure is only used to copy into another structure, so declare
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
  17545    5376       0   22921    5989 drivers/pinctrl/nomadik/pinctrl-abx500.o

after:
            bss     dec     hex filename
  17273    5320       0   22593    5841 drivers/pinctrl/nomadik/pinctrl-abx500.o

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/pinctrl/nomadik/pinctrl-abx500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index f95001b..b32c0d6 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -647,7 +647,7 @@ static inline void abx500_gpio_dbg_show_one(struct seq_file *s,
 #define abx500_gpio_dbg_show	NULL
 #endif
 
-static struct gpio_chip abx500gpio_chip = {
+static const struct gpio_chip abx500gpio_chip = {
 	.label			= "abx500-gpio",
 	.owner			= THIS_MODULE,
 	.request		= gpiochip_generic_request,
-- 
2.5.0
