From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 14 Nov 2014 11:52:04 +0100
Subject: [PATCH v4 3/6] ARM: zynq: Move slcr.h and smp.h to generic location
In-Reply-To: <cover.1415962281.git.michal.simek@xilinx.com>
References: <cover.1415962281.git.michal.simek@xilinx.com>
Message-ID: <104ae4ce194398e02f5e031365269c4054339391.1415962281.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include/soc/zynq/ is the right location for this header
to be able to share information from this header with other
drivers which require it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v4:
- Move only slcr.h and smp.h and keep common.h in platform
  which is not needed by OCMC driver
  Based on Arnd request: https://lkml.org/lkml/2014/10/20/268
  Not all symbols from slcr.h/smp.h will be used by OCMC driver
  - no problem to remove them if it is needed
- Add record to MAINTAINERS file

Changes in v3: None
Changes in v2:
- Update pm.c added in 3.17 too - Soren pointed on it

 MAINTAINERS                                     | 1 +
 arch/arm/mach-zynq/common.c                     | 4 ++--
 arch/arm/mach-zynq/platsmp.c                    | 5 +++--
 arch/arm/mach-zynq/slcr.c                       | 3 ++-
 {arch/arm/mach-zynq => include/soc/zynq}/slcr.h | 0
 {arch/arm/mach-zynq => include/soc/zynq}/smp.h  | 0
 6 files changed, 8 insertions(+), 5 deletions(-)
 rename {arch/arm/mach-zynq => include/soc/zynq}/slcr.h (100%)
 rename {arch/arm/mach-zynq => include/soc/zynq}/smp.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60b1163dba28..279e87eef71c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1551,6 +1551,7 @@ S:	Supported
 F:	arch/arm/mach-zynq/
 F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/block/xsysace.c
+F:	include/soc/zynq/
 N:	zynq
 N:	xilinx
 F:	drivers/clocksource/cadence_ttc_timer.c
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 947e72b79496..d30ecc1a7641 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -43,8 +43,8 @@
 #include <asm/hardware/cache-l2x0.h>

 #include "common.h"
-#include "slcr.h"
-#include "smp.h"
+#include <soc/zynq/slcr.h>
+#include <soc/zynq/smp.h>

 #define ZYNQ_DEVCFG_MCTRL		0x80
 #define ZYNQ_DEVCFG_PS_VERSION_SHIFT	28
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index 717ba2b922b1..6d2b8a16b6c3 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -25,9 +25,10 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_scu.h>
 #include <linux/irqchip/arm-gic.h>
+
 #include "common.h"
-#include "slcr.h"
-#include "smp.h"
+#include <soc/zynq/slcr.h>
+#include <soc/zynq/smp.h>

 /*
  * Store number of cores in the system
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 40f8d7420334..b77e42d999c8 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -20,7 +20,8 @@
 #include <linux/regmap.h>
 #include <linux/clk/zynq.h>
 #include "common.h"
-#include "slcr.h"
+#include <soc/zynq/slcr.h>
+#include <soc/zynq/smp.h>

 /* register offsets */
 #define SLCR_UNLOCK_OFFSET		0x8   /* SCLR unlock register */
diff --git a/arch/arm/mach-zynq/slcr.h b/include/soc/zynq/slcr.h
similarity index 100%
rename from arch/arm/mach-zynq/slcr.h
rename to include/soc/zynq/slcr.h
diff --git a/arch/arm/mach-zynq/smp.h b/include/soc/zynq/smp.h
similarity index 100%
rename from arch/arm/mach-zynq/smp.h
rename to include/soc/zynq/smp.h
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/97a071e8/attachment.sig>
