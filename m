From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:30:50 +0000
Subject: [PATCH 25/31] ARM: amba: bcmring: use common amba device initializers
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoAo6-0005Fy-Tb@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-bcmring/core.c |   23 ++---------------------
 1 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index 6b67b7e..22e4e0a 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -52,27 +52,8 @@
 #include <mach/csp/chipcHw_inline.h>
 #include <mach/csp/tmrHw_reg.h>
 
-#define AMBA_DEVICE(name, initname, base, plat, size)       \
-static struct amba_device name##_device = {     \
-   .dev = {                                     \
-      .coherent_dma_mask = ~0,                  \
-      .init_name = initname,                    \
-      .platform_data = plat                     \
-   },                                           \
-   .res = {                                     \
-      .start = MM_ADDR_IO_##base,               \
-		.end = MM_ADDR_IO_##base + (size) - 1,    \
-      .flags = IORESOURCE_MEM                   \
-   },                                           \
-   .dma_mask = ~0,                              \
-   .irq = {                                     \
-      IRQ_##base                                \
-   }                                            \
-}
-
-
-AMBA_DEVICE(uartA, "uarta", UARTA, NULL, SZ_4K);
-AMBA_DEVICE(uartB, "uartb", UARTB, NULL, SZ_4K);
+static AMBA_APB_DEVICE(uartA, "uarta", MM_ADDR_IO_UARTA, { IRQ_UARTA }, NULL);
+static AMBA_APB_DEVICE(uartB, "uartb", MM_ADDR_IO_UARTB, { IRQ_UARTB }, NULL);
 
 static struct clk pll1_clk = {
 	.name = "PLL1",
-- 
1.7.4.4
