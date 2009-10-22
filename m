From: utx@penguin.cz (Stanislav Brabec)
Date: Thu, 22 Oct 2009 23:05:03 +0200
Subject: [PATCH] Zaurus: Fix NAND Flash OOB layout for Borzoi
Message-ID: <1256245503.9561.18.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Borzoi, Terrier and Akita use the same NAND Flash OOB layout, which
seems to be different from Spitz for some reason. Here is a fix.

When the code was ported to the platform data, the map was applied just
for Akita.

After this patch, Flash works again on Borzoi. Terrier still has a
problem with partition table? different from Borzoi (unfixable without
reading of the system configuration in flash) and JFFS2 partitions can
be mounted (with some "Empty flash at ... ends at ..." in the syslog).

Signed-off-by: Stanislav Brabec <utx@penguin.cz>

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index ee8d603..c382d14 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -740,11 +783,34 @@ static void __init common_init(void)
 	pxa_set_i2c_info(NULL);
 }
 
+#if defined(CONFIG_MACH_AKITA) || defined(CONFIG_MACH_BORZOI)
+static struct nand_bbt_descr sharpsl_akita_bbt = {
+	.options = 0,
+	.offs = 4,
+	.len = 1,
+	.pattern = scan_ff_pattern
+};
+
+static struct nand_ecclayout akita_oobinfo = {
+	.eccbytes = 24,
+	.eccpos = {
+		   0x5, 0x1, 0x2, 0x3, 0x6, 0x7, 0x15, 0x11,
+		   0x12, 0x13, 0x16, 0x17, 0x25, 0x21, 0x22, 0x23,
+		   0x26, 0x27, 0x35, 0x31, 0x32, 0x33, 0x36, 0x37},
+	.oobfree = {{0x08, 0x09}}
+};
+#endif
+
 #if defined(CONFIG_MACH_SPITZ) || defined(CONFIG_MACH_BORZOI)
 static void __init spitz_init(void)
 {
 	spitz_ficp_platform_data.gpio_pwdown = SPITZ_GPIO_IR_ON;
 
+	if (machine_is_borzoi()) {
+		sharpsl_nand_platform_data.badblock_pattern = &sharpsl_akita_bbt;
+		sharpsl_nand_platform_data.ecc_layout = &akita_oobinfo;
+	}
+
 	platform_scoop_config = &spitz_pcmcia_config;
 
 	common_init();
@@ -769,22 +835,6 @@ static struct i2c_board_info akita_i2c_board_info[] = {
 	},
 };
 
-static struct nand_bbt_descr sharpsl_akita_bbt = {
-	.options = 0,
-	.offs = 4,
-	.len = 1,
-	.pattern = scan_ff_pattern
-};
-
-static struct nand_ecclayout akita_oobinfo = {
-	.eccbytes = 24,
-	.eccpos = {
-		   0x5, 0x1, 0x2, 0x3, 0x6, 0x7, 0x15, 0x11,
-		   0x12, 0x13, 0x16, 0x17, 0x25, 0x21, 0x22, 0x23,
-		   0x26, 0x27, 0x35, 0x31, 0x32, 0x33, 0x36, 0x37},
-	.oobfree = {{0x08, 0x09}}
-};
-
 static void __init akita_init(void)
 {
 	spitz_ficp_platform_data.gpio_pwdown = AKITA_GPIO_IR_ON;



________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
