From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 23:14:27 +0100
Subject: [PATCH 1/5] ARM: cns3xxx: make mach header files local
In-Reply-To: <1363299271-8283-1-git-send-email-arnd@arndb.de>
References: <1363299271-8283-1-git-send-email-arnd@arndb.de>
Message-ID: <1363299271-8283-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach/cns3xxx.h and mach/pm.h header files are used only
in the platform code itself, so there is no need to make
them globally visible. This gets us closer to multiplatform
configuration for cns3xxx.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-cns3xxx/cns3420vb.c                  | 5 ++---
 arch/arm/mach-cns3xxx/{include/mach => }/cns3xxx.h | 7 ++-----
 arch/arm/mach-cns3xxx/core.c                       | 2 +-
 arch/arm/mach-cns3xxx/devices.c                    | 5 ++---
 arch/arm/mach-cns3xxx/include/mach/uncompress.h    | 2 +-
 arch/arm/mach-cns3xxx/pcie.c                       | 2 +-
 arch/arm/mach-cns3xxx/pm.c                         | 4 ++--
 arch/arm/mach-cns3xxx/{include/mach => }/pm.h      | 0
 drivers/mmc/host/sdhci-cns3xxx.c                   | 1 -
 9 files changed, 11 insertions(+), 17 deletions(-)
 rename arch/arm/mach-cns3xxx/{include/mach => }/cns3xxx.h (99%)
 rename arch/arm/mach-cns3xxx/{include/mach => }/pm.h (100%)

diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index a71867e..d863d87 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -31,9 +31,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <mach/cns3xxx.h>
-#include <mach/irqs.h>
-#include <mach/pm.h>
+#include "cns3xxx.h"
+#include "pm.h"
 #include "core.h"
 #include "devices.h"
 
diff --git a/arch/arm/mach-cns3xxx/include/mach/cns3xxx.h b/arch/arm/mach-cns3xxx/cns3xxx.h
similarity index 99%
rename from arch/arm/mach-cns3xxx/include/mach/cns3xxx.h
rename to arch/arm/mach-cns3xxx/cns3xxx.h
index 191c8e5..d7d3a8d 100644
--- a/arch/arm/mach-cns3xxx/include/mach/cns3xxx.h
+++ b/arch/arm/mach-cns3xxx/cns3xxx.h
@@ -553,6 +553,8 @@ int cns3xxx_cpu_clock(void);
 /*
  * ARM11 MPCore interrupt sources (primary GIC)
  */
+#define IRQ_TC11MP_GIC_START	32
+
 #define IRQ_CNS3XXX_PMU			(IRQ_TC11MP_GIC_START + 0)
 #define IRQ_CNS3XXX_SDIO		(IRQ_TC11MP_GIC_START + 1)
 #define IRQ_CNS3XXX_L2CC		(IRQ_TC11MP_GIC_START + 2)
@@ -624,9 +626,4 @@ int cns3xxx_cpu_clock(void);
 
 #define NR_IRQS_CNS3XXX			(IRQ_TC11MP_GIC_START + 64)
 
-#if !defined(NR_IRQS) || (NR_IRQS < NR_IRQS_CNS3XXX)
-#undef NR_IRQS
-#define NR_IRQS				NR_IRQS_CNS3XXX
-#endif
-
 #endif	/* __MACH_BOARD_CNS3XXX_H */
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index e698f26..012ffdb 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -17,7 +17,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <mach/cns3xxx.h>
+#include "cns3xxx.h"
 #include "core.h"
 
 static struct map_desc cns3xxx_io_desc[] __initdata = {
diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/devices.c
index 1e40c99..7da78a2 100644
--- a/arch/arm/mach-cns3xxx/devices.c
+++ b/arch/arm/mach-cns3xxx/devices.c
@@ -16,9 +16,8 @@
 #include <linux/compiler.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-#include <mach/cns3xxx.h>
-#include <mach/irqs.h>
-#include <mach/pm.h>
+#include "cns3xxx.h"
+#include "pm.h"
 #include "core.h"
 #include "devices.h"
 
diff --git a/arch/arm/mach-cns3xxx/include/mach/uncompress.h b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
index 7a030b9..e2c642c 100644
--- a/arch/arm/mach-cns3xxx/include/mach/uncompress.h
+++ b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
@@ -8,7 +8,7 @@
  */
 
 #include <asm/mach-types.h>
-#include <mach/cns3xxx.h>
+#include "cns3xxx.h"
 
 #define AMBA_UART_DR(base)	(*(volatile unsigned char *)((base) + 0x00))
 #define AMBA_UART_LCRH(base)	(*(volatile unsigned char *)((base) + 0x2c))
diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 3113283..c7b204b 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -20,7 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
 #include <asm/mach/map.h>
-#include <mach/cns3xxx.h>
+#include "cns3xxx.h"
 #include "core.h"
 
 enum cns3xxx_access_type {
diff --git a/arch/arm/mach-cns3xxx/pm.c b/arch/arm/mach-cns3xxx/pm.c
index 3645808..79e3d47 100644
--- a/arch/arm/mach-cns3xxx/pm.c
+++ b/arch/arm/mach-cns3xxx/pm.c
@@ -11,8 +11,8 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
-#include <mach/cns3xxx.h>
-#include <mach/pm.h>
+#include "cns3xxx.h"
+#include "pm.h"
 #include "core.h"
 
 void cns3xxx_pwr_clk_en(unsigned int block)
diff --git a/arch/arm/mach-cns3xxx/include/mach/pm.h b/arch/arm/mach-cns3xxx/pm.h
similarity index 100%
rename from arch/arm/mach-cns3xxx/include/mach/pm.h
rename to arch/arm/mach-cns3xxx/pm.h
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 30bfdc4..6ba8502 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -16,7 +16,6 @@
 #include <linux/device.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
-#include <mach/cns3xxx.h>
 #include "sdhci-pltfm.h"
 
 static unsigned int sdhci_cns3xxx_get_max_clk(struct sdhci_host *host)
-- 
1.8.1.2
