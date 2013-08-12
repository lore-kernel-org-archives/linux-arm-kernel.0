From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 12 Aug 2013 17:40:00 +0800
Subject: [PATCH V3 1/8] ARM: tegra: add common resume handling code for LP1
 resuming
In-Reply-To: <1376300407-14750-1-git-send-email-josephl@nvidia.com>
References: <1376300407-14750-1-git-send-email-josephl@nvidia.com>
Message-ID: <1376300407-14750-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to the Tegra CPU reset vector to detect whether the CPU is
resuming from LP1 suspend state. If it is, branch to the LP1-specific
resume code.

When Tegra enters the LP1 suspend state, the SDRAM controller is placed
into a self-refresh state. For this reason, we must place the LP1 resume
code into IRAM, so that it is accessible before SDRAM access has been
re-enabled.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* no change
V2:
* update the commit message
* move the define of IRAM_CODE_AREA to iomap.h
* move the THUMB marco code before the 'bx' instruction
---
 arch/arm/mach-tegra/iomap.h         |  2 ++
 arch/arm/mach-tegra/reset-handler.S | 13 +++++++++++++
 arch/arm/mach-tegra/reset.c         |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index 399fbca..f2bdcb4 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -24,6 +24,8 @@
 #define TEGRA_IRAM_BASE			0x40000000
 #define TEGRA_IRAM_SIZE			SZ_256K
 
+#define TEGRA_IRAM_CODE_AREA		(TEGRA_IRAM_BASE + SZ_4K)
+
 #define TEGRA_HOST1X_BASE		0x50000000
 #define TEGRA_HOST1X_SIZE		0x24000
 
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 34614bd..f527b2c 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -182,6 +182,19 @@ after_errata:
 1:
 #endif
 
+	/* Waking up from LP1? */
+	ldr	r8, [r12, #RESET_DATA(MASK_LP1)]
+	tst	r8, r11				@ if in_lp1
+	beq	__is_not_lp1
+	cmp	r10, #0
+	bne	__die				@ only CPU0 can be here
+	ldr	lr, [r12, #RESET_DATA(STARTUP_LP1)]
+	cmp	lr, #0
+	bleq	__die				@ no LP1 startup handler
+ THUMB(	add	lr, lr, #1 )			@ switch to Thumb mode
+	bx	lr
+__is_not_lp1:
+
 	/* Waking up from LP2? */
 	ldr	r9, [r12, #RESET_DATA(MASK_LP2)]
 	tst	r9, r11				@ if in_lp2
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index 1ac434e..fd0bbf8 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -81,6 +81,8 @@ void __init tegra_cpu_reset_handler_init(void)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
+	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_LP1] =
+		TEGRA_IRAM_CODE_AREA;
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_LP2] =
 		virt_to_phys((void *)tegra_resume);
 #endif
-- 
1.8.3.4
