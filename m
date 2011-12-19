From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:47 -0500
Subject: [PATCH 18/20] ARM: mach-tegra: properly disable CPU idle call
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-19-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-tegra/common.c              |    3 ++-
 arch/arm/mach-tegra/include/mach/system.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 20f396d740..ca0a297b72 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -25,7 +25,6 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include <mach/iomap.h>
-#include <mach/system.h>
 
 #include "board.h"
 #include "clock.h"
@@ -74,6 +73,8 @@ static void __init tegra_init_cache(void)
 
 void __init tegra_init_early(void)
 {
+	disable_hlt();  /* idle WFI usage needs to be confirmed */
+
 	tegra_init_fuse();
 	tegra_init_clock();
 	tegra_clk_init_from_table(common_clk_init_table);
diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
index a312988bf6..968ea2b052 100644
--- a/arch/arm/mach-tegra/include/mach/system.h
+++ b/arch/arm/mach-tegra/include/mach/system.h
@@ -23,6 +23,7 @@
 
 static inline void arch_idle(void)
 {
+	cpu_do_idle();
 }
 
 #endif
-- 
1.7.7.1.431.g10b2a
