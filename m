From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Feb 2011 10:41:29 -0700
Subject: [PATCH v2] ARM: Tegra: Make tegra_dma_init a postcore_initcall
Message-ID: <1298482889-21841-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following commit makes the Tegra APB DMA engine fail to initialize
correctly: 0cf6230af909a86f81907455eca2a5c9b8f68fe6
ARM: tegra: Move tegra_common_init to tegra_init_early

The reason is that tegra_init_early_ calls tegra_dma_init which calls
request_threaded_irq, which fails since the IRQ hasn't yet been marked
valid; that only happens in tegra_init_irq, which gets called after
tegra_init_early.

This used to work OK, since tegra_init_early was tegra_common_init, which
got called after tegra_init_irq, basically from the beginning of
tegra_harmony_init.

Solve this by converting tegra_dma_init to a postcore_initcall. This makes
it execute late enough that IRQs are marked valid, and avoids having to
add it back to every machine's init function.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Dropped include of mach/dma.h from common.c

 arch/arm/mach-tegra/common.c |    4 ----
 arch/arm/mach-tegra/dma.c    |    1 +
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 516e100..d5e3f89 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -25,7 +25,6 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include <mach/iomap.h>
-#include <mach/dma.h>
 #include <mach/system.h>
 
 #include "board.h"
@@ -81,7 +80,4 @@ void __init tegra_init_early(void)
 	tegra_init_clock();
 	tegra_clk_init_from_table(common_clk_init_table);
 	tegra_init_cache();
-#ifdef CONFIG_TEGRA_SYSTEM_DMA
-	tegra_dma_init();
-#endif
 }
diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
index 2d720f2..bd4f62a 100644
--- a/arch/arm/mach-tegra/dma.c
+++ b/arch/arm/mach-tegra/dma.c
@@ -743,6 +743,7 @@ fail:
 	}
 	return ret;
 }
+postcore_initcall(tegra_dma_init);
 
 #ifdef CONFIG_PM
 static u32 apb_dma[5*TEGRA_SYSTEM_DMA_CH_NR + 3];
-- 
1.7.1
