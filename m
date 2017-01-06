From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:19:00 +0100
Subject: [PATCH 5/5] ARM: shmobile: rcar-gen2: Remove unused
 rcar_gen2_read_mode_pins()
In-Reply-To: <cover.1483701101.git.horms+renesas@verge.net.au>
References: <cover.1483701101.git.horms+renesas@verge.net.au>
Message-ID: <70def3e53694a65c5583fb5f411491a5074bab18.1483701101.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

After
  1. commit 9f5ce39ddb8f68b3 ("ARM: shmobile: rcar-gen2: Obtain extal
     frequency from DT"),
  2. commit 80951f04c3f92533 ("ARM: shmobile: rcar-gen2: Stop passing
     mode pins state to clock driver"),
  3. and handling of debug resource reset,
there are no more users of rcar_gen2_read_mode_pins() left.
Remove the function and its support definitions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/rcar-gen2.h       |  2 --
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 18 ------------------
 2 files changed, 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/rcar-gen2.h b/arch/arm/mach-shmobile/rcar-gen2.h
index 8a66b4aae035..6792e249cf56 100644
--- a/arch/arm/mach-shmobile/rcar-gen2.h
+++ b/arch/arm/mach-shmobile/rcar-gen2.h
@@ -2,8 +2,6 @@
 #define __ASM_RCAR_GEN2_H__
 
 void rcar_gen2_timer_init(void);
-#define MD(nr) BIT(nr)
-u32 rcar_gen2_read_mode_pins(void);
 void rcar_gen2_reserve(void);
 void rcar_gen2_pm_init(void);
 
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index ac63fa407b64..52d466b75973 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -29,24 +29,6 @@
 #include "common.h"
 #include "rcar-gen2.h"
 
-#define MODEMR 0xe6160060
-
-u32 rcar_gen2_read_mode_pins(void)
-{
-	static u32 mode;
-	static bool mode_valid;
-
-	if (!mode_valid) {
-		void __iomem *modemr = ioremap_nocache(MODEMR, 4);
-		BUG_ON(!modemr);
-		mode = ioread32(modemr);
-		iounmap(modemr);
-		mode_valid = true;
-	}
-
-	return mode;
-}
-
 static unsigned int __init get_extal_freq(void)
 {
 	struct device_node *cpg, *extal;
-- 
2.7.0.rc3.207.g0ac5344
