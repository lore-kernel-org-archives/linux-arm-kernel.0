From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 9 Aug 2011 13:24:17 +0200
Subject: [PATCH] ARM: fix perf build with uclibc toolchains
Message-ID: <201108091324.17750.florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

libio.h is not provided by uClibc, in order to be able to test the
definition of __UCLIBC__ we need to include stdlib.h, which also
includes stddef.h, providing the definition of 'NULL'.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/tools/perf/arch/arm/util/dwarf-regs.c b/tools/perf/arch/arm/util/dwarf-regs.c
index fff6450..e8d5c55 100644
--- a/tools/perf/arch/arm/util/dwarf-regs.c
+++ b/tools/perf/arch/arm/util/dwarf-regs.c
@@ -8,7 +8,10 @@
  * published by the Free Software Foundation.
  */
 
+#include <stdlib.h>
+#ifndef __UCLIBC__
 #include <libio.h>
+#endif
 #include <dwarf-regs.h>
 
 struct pt_regs_dwarfnum {
-- 
1.7.4.1
