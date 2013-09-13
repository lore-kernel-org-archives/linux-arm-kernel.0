From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Sep 2013 12:25:08 -0600
Subject: [PATCH 4/7] ARM: tegra: move resume vector define to irammap.h
In-Reply-To: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
References: <1379096711-26875-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1379096711-26875-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

irammap.h's purpose is to define the layout/usage of IRAM. As such,
TEGRA_IRAM_CODE_AREA should have been added there rather than iomap.h.
Move the define, and rename it something more descriptive.

Cc: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/iomap.h         | 2 --
 arch/arm/mach-tegra/irammap.h       | 6 ++++++
 arch/arm/mach-tegra/pm.c            | 8 ++++----
 arch/arm/mach-tegra/reset.c         | 2 +-
 arch/arm/mach-tegra/sleep-tegra20.S | 5 +++--
 arch/arm/mach-tegra/sleep-tegra30.S | 5 +++--
 6 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index 3f5fa07..7e0c180 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -24,8 +24,6 @@
 #define TEGRA_IRAM_BASE			0x40000000
 #define TEGRA_IRAM_SIZE			SZ_256K
 
-#define TEGRA_IRAM_CODE_AREA		(TEGRA_IRAM_BASE + SZ_4K)
-
 #define TEGRA_HOST1X_BASE		0x50000000
 #define TEGRA_HOST1X_SIZE		0x24000
 
diff --git a/arch/arm/mach-tegra/irammap.h b/arch/arm/mach-tegra/irammap.h
index 501952a..e32e174 100644
--- a/arch/arm/mach-tegra/irammap.h
+++ b/arch/arm/mach-tegra/irammap.h
@@ -23,4 +23,10 @@
 #define TEGRA_IRAM_RESET_HANDLER_OFFSET	0
 #define TEGRA_IRAM_RESET_HANDLER_SIZE	SZ_1K
 
+/*
+ * This area is used for LPx resume vector, only while LPx power state is
+ * active. At other times, the AVP may use this area for arbitrary purposes
+ */
+#define TEGRA_IRAM_LPx_RESUME_AREA	(TEGRA_IRAM_BASE + SZ_4K)
+
 #endif
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index ed294a0..36ed88a 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -263,10 +263,10 @@ static void tegra_suspend_enter_lp1(void)
 	tegra_pmc_suspend();
 
 	/* copy the reset vector & SDRAM shutdown code into IRAM */
-	memcpy(iram_save_addr, IO_ADDRESS(TEGRA_IRAM_CODE_AREA),
-		iram_save_size);
-	memcpy(IO_ADDRESS(TEGRA_IRAM_CODE_AREA), tegra_lp1_iram.start_addr,
+	memcpy(iram_save_addr, IO_ADDRESS(TEGRA_IRAM_LPx_RESUME_AREA),
 		iram_save_size);
+	memcpy(IO_ADDRESS(TEGRA_IRAM_LPx_RESUME_AREA),
+		tegra_lp1_iram.start_addr, iram_save_size);
 
 	*((u32 *)tegra_cpu_lp1_mask) = 1;
 }
@@ -276,7 +276,7 @@ static void tegra_suspend_exit_lp1(void)
 	tegra_pmc_resume();
 
 	/* restore IRAM */
-	memcpy(IO_ADDRESS(TEGRA_IRAM_CODE_AREA), iram_save_addr,
+	memcpy(IO_ADDRESS(TEGRA_IRAM_LPx_RESUME_AREA), iram_save_addr,
 		iram_save_size);
 
 	*(u32 *)tegra_cpu_lp1_mask = 0;
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index fd0bbf8..568f5bb 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -82,7 +82,7 @@ void __init tegra_cpu_reset_handler_init(void)
 
 #ifdef CONFIG_PM_SLEEP
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_LP1] =
-		TEGRA_IRAM_CODE_AREA;
+		TEGRA_IRAM_LPx_RESUME_AREA;
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_LP2] =
 		virt_to_phys((void *)tegra_resume);
 #endif
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index 5c3bd11..aaaf3ab 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -25,6 +25,7 @@
 #include <asm/cp15.h>
 #include <asm/cache.h>
 
+#include "irammap.h"
 #include "sleep.h"
 #include "flowctrl.h"
 
@@ -235,7 +236,7 @@ ENTRY(tegra20_sleep_core_finish)
 	mov32	r0, tegra20_tear_down_core
 	mov32	r1, tegra20_iram_start
 	sub	r0, r0, r1
-	mov32	r1, TEGRA_IRAM_CODE_AREA
+	mov32	r1, TEGRA_IRAM_LPx_RESUME_AREA
 	add	r0, r0, r1
 
 	mov	pc, r3
@@ -328,7 +329,7 @@ tegra20_iram_start:
  * The physical address of tegra_resume expected to be stored in
  * PMC_SCRATCH41.
  *
- * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_CODE_AREA.
+ * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_LPx_RESUME_AREA.
  */
 ENTRY(tegra20_lp1_reset)
 	/*
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 63fa91b..c6fc15c 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -20,6 +20,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
+#include "irammap.h"
 #include "fuse.h"
 #include "sleep.h"
 #include "flowctrl.h"
@@ -262,7 +263,7 @@ ENTRY(tegra30_sleep_core_finish)
 	mov32	r0, tegra30_tear_down_core
 	mov32	r1, tegra30_iram_start
 	sub	r0, r0, r1
-	mov32	r1, TEGRA_IRAM_CODE_AREA
+	mov32	r1, TEGRA_IRAM_LPx_RESUME_AREA
 	add	r0, r0, r1
 
 	mov	pc, r3
@@ -314,7 +315,7 @@ tegra30_iram_start:
  * The physical address of tegra_resume expected to be stored in
  * PMC_SCRATCH41.
  *
- * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_CODE_AREA.
+ * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_LPx_RESUME_AREA.
  */
 ENTRY(tegra30_lp1_reset)
 	/*
-- 
1.8.1.5
