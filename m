From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 21 Aug 2017 19:35:28 +0530
Subject: [PATCH] ARM: pxa: make matrix_keymap_data const
Message-ID: <1503324328-32007-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only stored in the const fields of
pxa27x_keypad_platform_data or matrix_keypad_platform_data structures.
Done using Coccinelle:

@match disable optional_qualifier@
identifier s;
@@
static struct matrix_keymap_data s = {...};

@ref@
position p;
identifier match.s;
@@
s at p

@good1@
identifier y;
position ref.p;
identifier match.s;
@@
struct matrix_keypad_platform_data y = {...,.keymap_data=&s at p,...};

@good2@
struct matrix_keypad_platform_data y;
identifier match.s;
position ref.p;
@@
y.keymap_data = &s at p

@good3@
identifier y;
position ref.p;
identifier match.s;
@@
struct pxa27x_keypad_platform_data y =
{...,.matrix_keymap_data=&s at p,...};

@good4@
struct pxa27x_keypad_platform_data y;
identifier match.s;
position ref.p;
@@
y.matrix_keymap_data = &s at p

@bad depends on  !good1 && !good2 && !good3 && !good4@
position ref.p;
identifier match.s;
@@
s at p

@depends on forall !bad disable optional_qualifier@
identifier match.s;
@@
static
+ const
struct matrix_keymap_data s;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/arm/mach-pxa/corgi.c     |  2 +-
 arch/arm/mach-pxa/em-x270.c   |  4 ++--
 arch/arm/mach-pxa/ezx.c       | 12 ++++++------
 arch/arm/mach-pxa/littleton.c |  2 +-
 arch/arm/mach-pxa/mainstone.c |  2 +-
 arch/arm/mach-pxa/mioa701.c   |  2 +-
 arch/arm/mach-pxa/palmld.c    |  2 +-
 arch/arm/mach-pxa/palmt5.c    |  2 +-
 arch/arm/mach-pxa/palmtreo.c  |  4 ++--
 arch/arm/mach-pxa/palmtx.c    |  2 +-
 arch/arm/mach-pxa/palmz72.c   |  2 +-
 arch/arm/mach-pxa/tavorevb.c  |  2 +-
 arch/arm/mach-pxa/tosa.c      |  2 +-
 arch/arm/mach-pxa/z2.c        |  2 +-
 arch/arm/mach-pxa/zylonite.c  |  2 +-
 15 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 7270f0d..4393b9b 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -380,7 +380,7 @@ struct platform_device corgiscoop_device = {
 	KEY(7, 4, CORGI_KEY_EXJOGUP),
 };
 
-static struct matrix_keymap_data corgikbd_keymap_data = {
+static const struct matrix_keymap_data corgikbd_keymap_data = {
 	.keymap		= corgikbd_keymap,
 	.keymap_size	= ARRAY_SIZE(corgikbd_keymap),
 };
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 811a731..8619140 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -846,7 +846,7 @@ static inline void em_x270_init_ac97(void) {}
 	KEY(0, 1, KEY_C), KEY(1, 2, KEY_DOWN), KEY(2, 2, KEY_D),
 };
 
-static struct matrix_keymap_data em_x270_matrix_keymap_data = {
+static const struct matrix_keymap_data em_x270_matrix_keymap_data = {
 	.keymap			= em_x270_module_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(em_x270_module_matrix_keys),
 };
@@ -900,7 +900,7 @@ struct pxa27x_keypad_platform_data em_x270_module_keypad_info = {
 	KEY(7, 6, 0), KEY(7, 7, 0),
 };
 
-static struct matrix_keymap_data em_x270_exeda_matrix_keymap_data = {
+static const struct matrix_keymap_data em_x270_exeda_matrix_keymap_data = {
 	.keymap			= em_x270_exeda_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(em_x270_exeda_matrix_keys),
 };
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index a057cf9..e87f137 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -429,7 +429,7 @@
 	KEY(4, 4, KEY_DOWN),
 };
 
-static struct matrix_keymap_data a780_matrix_keymap_data = {
+static const struct matrix_keymap_data a780_matrix_keymap_data = {
 	.keymap			= a780_key_map,
 	.keymap_size		= ARRAY_SIZE(a780_key_map),
 };
@@ -464,7 +464,7 @@
 	KEY(2, 3, KEY_KPENTER),
 };
 
-static struct matrix_keymap_data e680_matrix_keymap_data = {
+static const struct matrix_keymap_data e680_matrix_keymap_data = {
 	.keymap			= e680_key_map,
 	.keymap_size		= ARRAY_SIZE(e680_key_map),
 };
@@ -526,7 +526,7 @@
 	KEY(4, 5, KEY_RESERVED),
 };
 
-static struct matrix_keymap_data a1200_matrix_keymap_data = {
+static const struct matrix_keymap_data a1200_matrix_keymap_data = {
 	.keymap			= a1200_key_map,
 	.keymap_size		= ARRAY_SIZE(a1200_key_map),
 };
@@ -578,7 +578,7 @@
 	KEY(4, 5, KEY_PREVIOUSSONG),
 };
 
-static struct matrix_keymap_data e6_keymap_data = {
+static const struct matrix_keymap_data e6_keymap_data = {
 	.keymap			= e6_key_map,
 	.keymap_size		= ARRAY_SIZE(e6_key_map),
 };
@@ -630,7 +630,7 @@
 	KEY(4, 5, KEY_RESERVED),
 };
 
-static struct matrix_keymap_data a910_matrix_keymap_data = {
+static const struct matrix_keymap_data a910_matrix_keymap_data = {
 	.keymap			= a910_key_map,
 	.keymap_size		= ARRAY_SIZE(a910_key_map),
 };
@@ -682,7 +682,7 @@
 	KEY(4, 5, KEY_RESERVED),
 };
 
-static struct matrix_keymap_data e2_matrix_keymap_data = {
+static const struct matrix_keymap_data e2_matrix_keymap_data = {
 	.keymap			= e2_key_map,
 	.keymap_size		= ARRAY_SIZE(e2_key_map),
 };
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index fae38fd..0f4046a 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -249,7 +249,7 @@ static inline void littleton_init_spi(void) {}
 	KEY(3, 1, KEY_F23),	/* soft2 */
 };
 
-static struct matrix_keymap_data littleton_matrix_keymap_data = {
+static const struct matrix_keymap_data littleton_matrix_keymap_data = {
 	.keymap			= littleton_matrix_key_map,
 	.keymap_size		= ARRAY_SIZE(littleton_matrix_key_map),
 };
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index a2d851a..5f87398 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -482,7 +482,7 @@ static void mainstone_irda_transceiver_mode(struct device *dev, int mode)
 	KEY(4, 6, KEY_SELECT),
 };
 
-static struct matrix_keymap_data mainstone_matrix_keymap_data = {
+static const struct matrix_keymap_data mainstone_matrix_keymap_data = {
 	.keymap			= mainstone_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(mainstone_matrix_keys),
 };
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 8a5d049..e882a8e 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -240,7 +240,7 @@ static void mioa701_lcd_power(int on, struct fb_var_screeninfo *si)
 	KEY(2, 2, KEY_CAMERA)	/* Camera key */
 };
 
-static struct matrix_keymap_data mioa701_matrix_keymap_data = {
+static const struct matrix_keymap_data mioa701_matrix_keymap_data = {
 	.keymap			= mioa701_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(mioa701_matrix_keys),
 };
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 980f284..da796c6 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -190,7 +190,7 @@ static inline void palmld_nor_init(void) {}
 	KEY(3, 2, KEY_LEFT),
 };
 
-static struct matrix_keymap_data palmld_matrix_keymap_data = {
+static const struct matrix_keymap_data palmld_matrix_keymap_data = {
 	.keymap			= palmld_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(palmld_matrix_keys),
 };
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 876144a..6bb10c0 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -124,7 +124,7 @@
 	KEY(3, 2, KEY_LEFT),
 };
 
-static struct matrix_keymap_data palmt5_matrix_keymap_data = {
+static const struct matrix_keymap_data palmt5_matrix_keymap_data = {
 	.keymap			= palmt5_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(palmt5_matrix_keys),
 };
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 4cc05ec..08400fa 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -286,12 +286,12 @@
 	KEY(7, 5, KEY_I),
 };
 
-static struct matrix_keymap_data treo680_matrix_keymap_data = {
+static const struct matrix_keymap_data treo680_matrix_keymap_data = {
 	.keymap			= treo680_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(treo680_matrix_keys),
 };
 
-static struct matrix_keymap_data centro_matrix_keymap_data = {
+static const struct matrix_keymap_data centro_matrix_keymap_data = {
 	.keymap			= centro_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(centro_matrix_keys),
 };
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 3664697..22dd32a 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -192,7 +192,7 @@ static inline void palmtx_nor_init(void) {}
 	KEY(3, 2, KEY_LEFT),
 };
 
-static struct matrix_keymap_data palmtx_matrix_keymap_data = {
+static const struct matrix_keymap_data palmtx_matrix_keymap_data = {
 	.keymap			= palmtx_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(palmtx_matrix_keys),
 };
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 2963006..4241c37 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -156,7 +156,7 @@
 	KEY(3, 2, KEY_LEFT),
 };
 
-static struct matrix_keymap_data almz72_matrix_keymap_data = {
+static const struct matrix_keymap_data almz72_matrix_keymap_data = {
 	.keymap			= palmz72_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(palmz72_matrix_keys),
 };
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 4b38e82..d8c6845 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -148,7 +148,7 @@
 	KEY(3, 3, KEY_F23),	/* soft2 */
 };
 
-static struct matrix_keymap_data tavorevb_matrix_keymap_data = {
+static const struct matrix_keymap_data tavorevb_matrix_keymap_data = {
 	.keymap		= tavorevb_matrix_key_map,
 	.keymap_size	= ARRAY_SIZE(tavorevb_matrix_key_map),
 };
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 13de660..9115665 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -452,7 +452,7 @@ static void tosa_irda_shutdown(struct device *dev)
 	KEY(6, 7, KEY_RIGHT),
 };
 
-static struct matrix_keymap_data tosakbd_keymap_data = {
+static const struct matrix_keymap_data tosakbd_keymap_data = {
 	.keymap		= tosakbd_keymap,
 	.keymap_size	= ARRAY_SIZE(tosakbd_keymap),
 };
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 510e533..212ac2f 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -412,7 +412,7 @@ static inline void z2_leds_init(void) {}
 	KEY(5, 7, KEY_DOT),
 };
 
-static struct matrix_keymap_data z2_matrix_keymap_data = {
+static const struct matrix_keymap_data z2_matrix_keymap_data = {
 	.keymap			= z2_matrix_keys,
 	.keymap_size		= ARRAY_SIZE(z2_matrix_keys),
 };
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 4268552..7ae3ee6 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -313,7 +313,7 @@ static inline void zylonite_init_mmc(void) {}
 	KEY(0, 3, KEY_AUX),	/* contact */
 };
 
-static struct matrix_keymap_data zylonite_matrix_keymap_data = {
+static const struct matrix_keymap_data zylonite_matrix_keymap_data = {
 	.keymap			= zylonite_matrix_key_map,
 	.keymap_size		= ARRAY_SIZE(zylonite_matrix_key_map),
 };
-- 
1.9.1
