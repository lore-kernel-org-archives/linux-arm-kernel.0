From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  5 Sep 2013 09:29:18 +0200
Subject: [PATCH v2] ARM: omap2: throw the die id into the entropy pool
Message-ID: <1378366158-31183-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Atleast eight bytes of this number are totally unique for the device
it seems, so this is a perfect candidate for feeding the entropy
pool. One byte more or less of constants does not matter so feed in
the entire OID struct.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Paul Walmsley <paul@pwsan.com>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use omap_device_initcall() to avoid calling on non-OMAPs.
---
 arch/arm/mach-omap2/id.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 2dc62a2..9260d09 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 
 #ifdef CONFIG_SOC_BUS
@@ -130,6 +131,17 @@ void omap_get_die_id(struct omap_die_id *odi)
 	odi->id_3 = read_tap_reg(OMAP_TAP_DIE_ID_3);
 }
 
+static int __init omap_feed_randpool(void)
+{
+	struct omap_die_id odi;
+
+	/* Throw the die ID into the entropy pool at boot */
+	omap_get_die_id(&odi);
+	add_device_randomness(&odi, sizeof(odi));
+	return 0;
+}
+omap_device_initcall(omap_feed_randpool);
+
 void __init omap2xxx_check_revision(void)
 {
 	int i, j;
-- 
1.8.1.4
