From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 17:52:06 +0100
Subject: [PATCH] ARM: pxa: cm-x2xx: avoid duplicate macro warnings
Message-ID: <5126103.CuC5iMSqYG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In an old commit, we worked around the duplicate definition of
GPIO24_SSP1_SFRM in cm-x2xx.c, which includes files for both
pxa25x and pxa27x. Apparently the problem has come back and we
now have four additional duplicate symbols that cause warnings:

In file included from /git/arm-soc/arch/arm/mach-pxa/pxa27x.h:7:0,
                 from /git/arm-soc/arch/arm/mach-pxa/cm-x2xx.c:27:
/git/arm-soc/arch/arm/mach-pxa/mfp-pxa27x.h:21:0: warning: "GPIO86_GPIO" redefined
 #define GPIO86_GPIO  MFP_CFG_IN(GPIO86, AF0)

This uses the same hack as before and undefines all symbols that
are defined more than once. Fortunately, cm-x2xx does not need
any of these.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index f2d801160079..7202022ee243 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -24,7 +24,16 @@
 
 #include "pxa25x.h"
 #undef GPIO24_SSP1_SFRM
+#undef GPIO86_GPIO
+#undef GPIO87_GPIO
+#undef GPIO88_GPIO
+#undef GPIO89_GPIO
 #include "pxa27x.h"
+#undef GPIO24_SSP1_SFRM
+#undef GPIO86_GPIO
+#undef GPIO87_GPIO
+#undef GPIO88_GPIO
+#undef GPIO89_GPIO
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <mach/smemc.h>
