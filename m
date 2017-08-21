From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 21 Aug 2017 19:29:30 +0530
Subject: [PATCH] ARM: mmp: make matrix_keymap_data const
Message-ID: <1503323970-31939-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only stored in the matrix_keymap_data field
of a pxa27x_keypad_platform_data structure, which is const.
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
 arch/arm/mach-mmp/aspenite.c  | 2 +-
 arch/arm/mach-mmp/teton_bga.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 5db0edf..a285951 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -219,7 +219,7 @@ struct pxa168fb_mach_info aspenite_lcd_info = {
 	KEY(4, 7, KEY_ESC),	/* SW 9 */
 };
 
-static struct matrix_keymap_data aspenite_matrix_keymap_data = {
+static const struct matrix_keymap_data aspenite_matrix_keymap_data = {
 	.keymap			= aspenite_matrix_key_map,
 	.keymap_size		= ARRAY_SIZE(aspenite_matrix_key_map),
 };
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index cf038eb..d16010d 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -61,7 +61,7 @@
 	KEY(1, 7, KEY_RIGHT),
 };
 
-static struct matrix_keymap_data teton_bga_matrix_keymap_data = {
+static const struct matrix_keymap_data teton_bga_matrix_keymap_data = {
 	.keymap			= teton_bga_matrix_key_map,
 	.keymap_size		= ARRAY_SIZE(teton_bga_matrix_key_map),
 };
-- 
1.9.1
