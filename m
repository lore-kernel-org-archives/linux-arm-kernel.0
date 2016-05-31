From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:20 +0900
Subject: [PATCH 14/17] pinctrl: uniphier: add System Bus pin-mux settings
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-15-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to get access to UniPhier System Bus (external bus).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 23 ++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 27 ++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 39 ++++++++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 39 ++++++++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 11 +++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 27 ++++++++++++++++
 6 files changed, 166 insertions(+)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 6692e80..7437483 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -567,6 +567,18 @@ static const unsigned nand_cs1_pins[] = {22, 23};
 static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {44, 45, 46, 47, 48, 49, 50, 51, 52};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned system_bus_pins[] = {16, 17, 18, 19, 20, 165, 166, 167,
+					   168, 169, 170, 171, 172, 173};
+static const int system_bus_muxvals[] = {0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1,
+					 -1, -1, -1};
+static const unsigned system_bus_cs0_pins[] = {155};
+static const int system_bus_cs0_muxvals[] = {1};
+static const unsigned system_bus_cs1_pins[] = {174};
+static const int system_bus_cs1_muxvals[] = {-1};
+static const unsigned system_bus_cs2_pins[] = {64};
+static const int system_bus_cs2_muxvals[] = {1};
+static const unsigned system_bus_cs3_pins[] = {156};
+static const int system_bus_cs3_muxvals[] = {1};
 static const unsigned uart0_pins[] = {85, 88};
 static const int uart0_muxvals[] = {1, 1};
 static const unsigned uart1_pins[] = {155, 156};
@@ -650,6 +662,11 @@ static const struct uniphier_pinctrl_group uniphier_ld4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(system_bus),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs0),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs2),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs3),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart1),
 	UNIPHIER_PINCTRL_GROUP(uart1b),
@@ -808,6 +825,11 @@ static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const system_bus_groups[] = {"system_bus",
+						 "system_bus_cs0",
+						 "system_bus_cs1",
+						 "system_bus_cs2",
+						 "system_bus_cs3"};
 static const char * const uart0_groups[] = {"uart0"};
 static const char * const uart1_groups[] = {"uart1", "uart1b"};
 static const char * const uart2_groups[] = {"uart2"};
@@ -864,6 +886,7 @@ static const struct uniphier_pinmux_function uniphier_ld4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 638b342e..d575194 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -760,6 +760,20 @@ static const unsigned nand_cs1_pins[] = {37, 38};
 static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {47, 48, 49, 50, 51, 52, 53, 54, 55};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned system_bus_pins[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
+					   11, 12, 13};
+static const int system_bus_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+					 0};
+static const unsigned system_bus_cs1_pins[] = {14};
+static const int system_bus_cs1_muxvals[] = {0};
+static const unsigned system_bus_cs2_pins[] = {37};
+static const int system_bus_cs2_muxvals[] = {6};
+static const unsigned system_bus_cs3_pins[] = {38};
+static const int system_bus_cs3_muxvals[] = {6};
+static const unsigned system_bus_cs4_pins[] = {115};
+static const int system_bus_cs4_muxvals[] = {6};
+static const unsigned system_bus_cs5_pins[] = {55};
+static const int system_bus_cs5_muxvals[] = {6};
 static const unsigned uart0_pins[] = {135, 136};
 static const int uart0_muxvals[] = {3, 3};
 static const unsigned uart0b_pins[] = {11, 12};
@@ -866,6 +880,12 @@ static const struct uniphier_pinctrl_group uniphier_ld6b_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(system_bus),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs2),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs3),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs4),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs5),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart0b),
 	UNIPHIER_PINCTRL_GROUP(uart1),
@@ -1137,6 +1157,12 @@ static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const system_bus_groups[] = {"system_bus",
+						 "system_bus_cs1",
+						 "system_bus_cs2",
+						 "system_bus_cs3",
+						 "system_bus_cs4",
+						 "system_bus_cs5"};
 static const char * const uart0_groups[] = {"uart0", "uart0b"};
 static const char * const uart1_groups[] = {"uart1", "uart1b"};
 static const char * const uart2_groups[] = {"uart2", "uart2b"};
@@ -1221,6 +1247,7 @@ static const struct uniphier_pinmux_function uniphier_ld6b_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index e973dd8..35c5c51 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1033,6 +1033,26 @@ static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned sd1_pins[] = {319, 320, 321, 322, 323, 324, 325, 326,
 				    327};
 static const int sd1_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned system_bus_pins[] = {25, 26, 27, 28, 29, 30, 31, 32, 33,
+					   34, 35, 36, 37, 38};
+static const int system_bus_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+					 0};
+static const unsigned system_bus_cs0_pins[] = {318};
+static const int system_bus_cs0_muxvals[] = {5};
+static const unsigned system_bus_cs1_pins[] = {24};
+static const int system_bus_cs1_muxvals[] = {0};
+static const unsigned system_bus_cs2_pins[] = {315};
+static const int system_bus_cs2_muxvals[] = {5};
+static const unsigned system_bus_cs3_pins[] = {313};
+static const int system_bus_cs3_muxvals[] = {5};
+static const unsigned system_bus_cs4_pins[] = {305};
+static const int system_bus_cs4_muxvals[] = {5};
+static const unsigned system_bus_cs5_pins[] = {303};
+static const int system_bus_cs5_muxvals[] = {6};
+static const unsigned system_bus_cs6_pins[] = {307};
+static const int system_bus_cs6_muxvals[] = {6};
+static const unsigned system_bus_cs7_pins[] = {312};
+static const int system_bus_cs7_muxvals[] = {6};
 static const unsigned uart0_pins[] = {127, 128};
 static const int uart0_muxvals[] = {0, 0};
 static const unsigned uart1_pins[] = {129, 130};
@@ -1144,6 +1164,15 @@ static const struct uniphier_pinctrl_group uniphier_pro4_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(sd),
 	UNIPHIER_PINCTRL_GROUP(sd1),
+	UNIPHIER_PINCTRL_GROUP(system_bus),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs0),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs2),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs3),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs4),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs5),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs6),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs7),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart1),
 	UNIPHIER_PINCTRL_GROUP(uart2),
@@ -1418,6 +1447,15 @@ static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
 static const char * const sd1_groups[] = {"sd1"};
+static const char * const system_bus_groups[] = {"system_bus",
+						 "system_bus_cs0",
+						 "system_bus_cs1",
+						 "system_bus_cs2",
+						 "system_bus_cs3",
+						 "system_bus_cs4",
+						 "system_bus_cs5",
+						 "system_bus_cs6",
+						 "system_bus_cs7"};
 static const char * const uart0_groups[] = {"uart0"};
 static const char * const uart1_groups[] = {"uart1"};
 static const char * const uart2_groups[] = {"uart2"};
@@ -1506,6 +1544,7 @@ static const struct uniphier_pinmux_function uniphier_pro4_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
 	UNIPHIER_PINMUX_FUNCTION(sd1),
+	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index 191c200..f94eb42 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -817,6 +817,26 @@ static const unsigned nand_cs1_pins[] = {26, 27};
 static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {250, 251, 252, 253, 254, 255, 256, 257, 258};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned system_bus_pins[] = {4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
+					   14, 15, 16, 17};
+static const int system_bus_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+					 0};
+static const unsigned system_bus_cs0_pins[] = {105};
+static const int system_bus_cs0_muxvals[] = {1};
+static const unsigned system_bus_cs1_pins[] = {18};
+static const int system_bus_cs1_muxvals[] = {0};
+static const unsigned system_bus_cs2_pins[] = {106};
+static const int system_bus_cs2_muxvals[] = {1};
+static const unsigned system_bus_cs3_pins[] = {100};
+static const int system_bus_cs3_muxvals[] = {1};
+static const unsigned system_bus_cs4_pins[] = {101};
+static const int system_bus_cs4_muxvals[] = {1};
+static const unsigned system_bus_cs5_pins[] = {102};
+static const int system_bus_cs5_muxvals[] = {1};
+static const unsigned system_bus_cs6_pins[] = {69};
+static const int system_bus_cs6_muxvals[] = {5};
+static const unsigned system_bus_cs7_pins[] = {70};
+static const int system_bus_cs7_muxvals[] = {5};
 static const unsigned uart0_pins[] = {47, 48};
 static const int uart0_muxvals[] = {0, 0};
 static const unsigned uart0b_pins[] = {227, 228};
@@ -930,6 +950,15 @@ static const struct uniphier_pinctrl_group uniphier_pro5_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(i2c5c),
 	UNIPHIER_PINCTRL_GROUP(i2c6),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(system_bus),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs0),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs2),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs3),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs4),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs5),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs6),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs7),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart0b),
 	UNIPHIER_PINCTRL_GROUP(uart1),
@@ -1210,6 +1239,15 @@ static const char * const i2c5_groups[] = {"i2c5", "i2c5b", "i2c5c"};
 static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const system_bus_groups[] = {"system_bus",
+						 "system_bus_cs0",
+						 "system_bus_cs1",
+						 "system_bus_cs2",
+						 "system_bus_cs3",
+						 "system_bus_cs4",
+						 "system_bus_cs5",
+						 "system_bus_cs6",
+						 "system_bus_cs7"};
 static const char * const uart0_groups[] = {"uart0", "uart0b"};
 static const char * const uart1_groups[] = {"uart1"};
 static const char * const uart2_groups[] = {"uart2"};
@@ -1298,6 +1336,7 @@ static const struct uniphier_pinmux_function uniphier_pro5_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c6),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index 4349e99ff..c879be3 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -750,6 +750,12 @@ static const unsigned nand_cs1_pins[] = {37, 38};
 static const int nand_cs1_muxvals[] = {8, 8};
 static const unsigned sd_pins[] = {47, 48, 49, 50, 51, 52, 53, 54, 55};
 static const int sd_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8};
+static const unsigned system_bus_pins[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
+					   11, 12, 13};
+static const int system_bus_muxvals[] = {8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
+					 8};
+static const unsigned system_bus_cs1_pins[] = {14};
+static const int system_bus_cs1_muxvals[] = {8};
 static const unsigned uart0_pins[] = {217, 218};
 static const int uart0_muxvals[] = {8, 8};
 static const unsigned uart0b_pins[] = {179, 180};
@@ -857,6 +863,8 @@ static const struct uniphier_pinctrl_group uniphier_pxs2_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(system_bus),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart0b),
 	UNIPHIER_PINCTRL_GROUP(uart1),
@@ -1129,6 +1137,8 @@ static const char * const i2c5_groups[] = {"i2c5"};
 static const char * const i2c6_groups[] = {"i2c6"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const system_bus_groups[] = {"system_bus",
+						 "system_bus_cs1"};
 static const char * const uart0_groups[] = {"uart0", "uart0b"};
 static const char * const uart1_groups[] = {"uart1"};
 static const char * const uart2_groups[] = {"uart2"};
@@ -1215,6 +1225,7 @@ static const struct uniphier_pinmux_function uniphier_pxs2_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c6),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index 1bda223..096a460 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -495,6 +495,20 @@ static const unsigned nand_cs1_pins[] = {22, 23};
 static const int nand_cs1_muxvals[] = {0, 0};
 static const unsigned sd_pins[] = {32, 33, 34, 35, 36, 37, 38, 39, 40};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned system_bus_pins[] = {136, 137, 138, 139, 140, 141, 142,
+					   143, 144, 145, 146, 147, 148, 149};
+static const int system_bus_muxvals[] = {-1, -1, -1, -1, -1, -1, -1, -1, -1,
+					 -1, -1, -1, -1, -1};
+static const unsigned system_bus_cs1_pins[] = {150};
+static const int system_bus_cs1_muxvals[] = {-1};
+static const unsigned system_bus_cs2_pins[] = {10};
+static const int system_bus_cs2_muxvals[] = {1};
+static const unsigned system_bus_cs3_pins[] = {11};
+static const int system_bus_cs3_muxvals[] = {1};
+static const unsigned system_bus_cs4_pins[] = {12};
+static const int system_bus_cs4_muxvals[] = {1};
+static const unsigned system_bus_cs5_pins[] = {13};
+static const int system_bus_cs5_muxvals[] = {1};
 static const unsigned uart0_pins[] = {70, 71};
 static const int uart0_muxvals[] = {3, 3};
 static const unsigned uart1_pins[] = {114, 115};
@@ -582,6 +596,12 @@ static const struct uniphier_pinctrl_group uniphier_sld8_groups[] = {
 	UNIPHIER_PINCTRL_GROUP(nand),
 	UNIPHIER_PINCTRL_GROUP(nand_cs1),
 	UNIPHIER_PINCTRL_GROUP(sd),
+	UNIPHIER_PINCTRL_GROUP(system_bus),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs1),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs2),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs3),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs4),
+	UNIPHIER_PINCTRL_GROUP(system_bus_cs5),
 	UNIPHIER_PINCTRL_GROUP(uart0),
 	UNIPHIER_PINCTRL_GROUP(uart1),
 	UNIPHIER_PINCTRL_GROUP(uart2),
@@ -731,6 +751,12 @@ static const char * const i2c2_groups[] = {"i2c2"};
 static const char * const i2c3_groups[] = {"i2c3"};
 static const char * const nand_groups[] = {"nand", "nand_cs1"};
 static const char * const sd_groups[] = {"sd"};
+static const char * const system_bus_groups[] = {"system_bus",
+						 "system_bus_cs1",
+						 "system_bus_cs2",
+						 "system_bus_cs3",
+						 "system_bus_cs4",
+						 "system_bus_cs5"};
 static const char * const uart0_groups[] = {"uart0"};
 static const char * const uart1_groups[] = {"uart1"};
 static const char * const uart2_groups[] = {"uart2"};
@@ -787,6 +813,7 @@ static const struct uniphier_pinmux_function uniphier_sld8_functions[] = {
 	UNIPHIER_PINMUX_FUNCTION(i2c3),
 	UNIPHIER_PINMUX_FUNCTION(nand),
 	UNIPHIER_PINMUX_FUNCTION(sd),
+	UNIPHIER_PINMUX_FUNCTION(system_bus),
 	UNIPHIER_PINMUX_FUNCTION(uart0),
 	UNIPHIER_PINMUX_FUNCTION(uart1),
 	UNIPHIER_PINMUX_FUNCTION(uart2),
-- 
1.9.1
