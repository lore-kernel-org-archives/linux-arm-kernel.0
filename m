From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  8 Dec 2011 23:21:32 +0100
Subject: [PATCH] Documentation/pinctrl: various minor fixes
Message-ID: <1323382892-28298-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add some consts
- don't use the group index alone to determine the value to write to
  foo's mux register. For spi and i2c the group index is always 0.
  Additionally using the function index makes much more sense as it
  generates a different value for each function/group pair.
- fix a few syntax errors

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/pinctrl.txt |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
index b04cb7d..27f7759 100644
--- a/Documentation/pinctrl.txt
+++ b/Documentation/pinctrl.txt
@@ -133,8 +133,8 @@ struct foo_group {
 	const unsigned num_pins;
 };
 
-static unsigned int spi0_pins[] = { 0, 8, 16, 24 };
-static unsigned int i2c0_pins[] = { 24, 25 };
+static const unsigned int spi0_pins[] = { 0, 8, 16, 24 };
+static const unsigned int i2c0_pins[] = { 24, 25 };
 
 static const struct foo_group foo_groups[] = {
 	{
@@ -585,7 +585,7 @@ int foo_list_funcs(struct pinctrl_dev *pctldev, unsigned selector)
 
 const char *foo_get_fname(struct pinctrl_dev *pctldev, unsigned selector)
 {
-	return myfuncs[selector].name;
+	return foo_functions[selector].name;
 }
 
 static int foo_get_groups(struct pinctrl_dev *pctldev, unsigned selector,
@@ -600,7 +600,7 @@ static int foo_get_groups(struct pinctrl_dev *pctldev, unsigned selector,
 int foo_enable(struct pinctrl_dev *pctldev, unsigned selector,
 		unsigned group)
 {
-	u8 regbit = (1 << group);
+	u8 regbit = (1 << selector + group);
 
 	writeb((readb(MUX)|regbit), MUX)
 	return 0;
@@ -609,7 +609,7 @@ int foo_enable(struct pinctrl_dev *pctldev, unsigned selector,
 int foo_disable(struct pinctrl_dev *pctldev, unsigned selector,
 		unsigned group)
 {
-	u8 regbit = (1 << group);
+	u8 regbit = (1 << selector);
 
 	writeb((readb(MUX) & ~(regbit)), MUX)
 	return 0;
@@ -683,7 +683,7 @@ spi on the second function mapping:
 
 #include <linux/pinctrl/machine.h>
 
-static struct pinmux_map pmx_mapping[] = {
+static const struct pinmux_map pmx_mapping[] = {
 	{
 		.ctrl_dev_name = "pinctrl.0",
 		.function = "spi0",
@@ -714,7 +714,7 @@ for example if they are not yet instantiated or cumbersome to obtain.
 
 You register this pinmux mapping to the pinmux subsystem by simply:
 
-       ret = pinmux_register_mappings(&pmx_mapping, ARRAY_SIZE(pmx_mapping));
+       ret = pinmux_register_mappings(pmx_mapping, ARRAY_SIZE(pmx_mapping));
 
 Since the above construct is pretty common there is a helper macro to make
 it even more compact which assumes you want to use pinctrl.0 and position
@@ -759,42 +759,42 @@ case), we define a mapping like this:
 
 ...
 {
-	.name "2bit"
+	.name = "2bit"
 	.ctrl_dev_name = "pinctrl.0",
 	.function = "mmc0",
 	.group = "mmc0_0_grp",
 	.dev_name = "foo-mmc.0",
 },
 {
-	.name "4bit"
+	.name = "4bit"
 	.ctrl_dev_name = "pinctrl.0",
 	.function = "mmc0",
 	.group = "mmc0_0_grp",
 	.dev_name = "foo-mmc.0",
 },
 {
-	.name "4bit"
+	.name = "4bit"
 	.ctrl_dev_name = "pinctrl.0",
 	.function = "mmc0",
 	.group = "mmc0_1_grp",
 	.dev_name = "foo-mmc.0",
 },
 {
-	.name "8bit"
+	.name = "8bit"
 	.ctrl_dev_name = "pinctrl.0",
 	.function = "mmc0",
 	.group = "mmc0_0_grp",
 	.dev_name = "foo-mmc.0",
 },
 {
-	.name "8bit"
+	.name = "8bit"
 	.ctrl_dev_name = "pinctrl.0",
 	.function = "mmc0",
 	.group = "mmc0_1_grp",
 	.dev_name = "foo-mmc.0",
 },
 {
-	.name "8bit"
+	.name = "8bit"
 	.ctrl_dev_name = "pinctrl.0",
 	.function = "mmc0",
 	.group = "mmc0_2_grp",
@@ -897,7 +897,7 @@ This is enabled by simply setting the .hog_on_boot field in the map to true,
 like this:
 
 {
-	.name "POWERMAP"
+	.name = "POWERMAP"
 	.ctrl_dev_name = "pinctrl.0",
 	.function = "power_func",
 	.hog_on_boot = true,
-- 
1.7.7.3
