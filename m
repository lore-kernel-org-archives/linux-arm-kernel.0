From: digetx@gmail.com (Dmitry Osipenko)
Date: Mon, 22 Dec 2014 01:52:33 +0300
Subject: [PATCH] ARM: tegra: Use PMC scratch register 40 for tegra_resume()
 location store
Message-ID: <1419202392-1159-1-git-send-email-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7232398abc6a ("ARM: tegra: Convert PMC to a driver") changed tegra_resume()
location storing from late to early and as result broke suspend on tegra20.
PMC scratch register 41 was used by tegra lp1 suspend core code for storing
physical memory address of common resume function and in the same time used by
tegra20 cpuidle driver for storing cpu1 "resettable" status, so it implied
strict order of scratch register use. Fix it by using scratch 40 instead of 41
for tegra_resume() location store.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Fixes: 7232398abc6a (ARM: tegra: Convert PMC to a driver)
Cc: <stable@vger.kernel.org> # v3.17+
---
I see 2 other solutions:

1) Replace PMC driver PM ops with syscore
2) Move tegra_resume() storing back to tegra arch suspend code

For me originally proposed solution looks best, but I'm not aware of any special
use of scratch 40 outside kernel and bootloader, so please let me know if there
is any issue with it. It works just fine on my tablet.

 arch/arm/mach-tegra/sleep-tegra20.S | 4 ++--
 arch/arm/mach-tegra/sleep-tegra30.S | 4 ++--
 arch/arm/mach-tegra/sleep.h         | 1 +
 drivers/soc/tegra/pmc.c             | 6 +++---
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index be4bc5f..3574785 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -327,7 +327,7 @@ tegra20_iram_start:
  * system clock running on the same PLL that it suspended at), and
  * jumps to tegra_resume to restore virtual addressing and PLLX.
  * The physical address of tegra_resume expected to be stored in
- * PMC_SCRATCH41.
+ * PMC_SCRATCH40.
  *
  * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_LPx_RESUME_AREA.
  */
@@ -401,7 +401,7 @@ exit_selfrefresh_loop:
 	str	r1, [r0, #EMC_REQ_CTRL]
 
 	mov32	r0, TEGRA_PMC_BASE
-	ldr	r0, [r0, #PMC_SCRATCH41]
+	ldr	r0, [r0, #PMC_SCRATCH40]
 	ret	r0			@ jump to tegra_resume
 ENDPROC(tegra20_lp1_reset)
 
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 5d8d13a..234959c 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -314,7 +314,7 @@ tegra30_iram_start:
  * system clock running on the same PLL that it suspended at), and
  * jumps to tegra_resume to restore virtual addressing.
  * The physical address of tegra_resume expected to be stored in
- * PMC_SCRATCH41.
+ * PMC_SCRATCH40.
  *
  * NOTE: THIS *MUST* BE RELOCATED TO TEGRA_IRAM_LPx_RESUME_AREA.
  */
@@ -529,7 +529,7 @@ zcal_done:
 __no_dual_emc_chanl:
 
 	mov32	r0, TEGRA_PMC_BASE
-	ldr	r0, [r0, #PMC_SCRATCH41]
+	ldr	r0, [r0, #PMC_SCRATCH40]
 	ret	r0			@ jump to tegra_resume
 ENDPROC(tegra30_lp1_reset)
 
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 92d46ec..23c42d0 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -33,6 +33,7 @@
 #define PMC_SCRATCH37	0x130
 #define PMC_SCRATCH38	0x134
 #define PMC_SCRATCH39	0x138
+#define PMC_SCRATCH40	0x13C
 #define PMC_SCRATCH41	0x140
 
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index a2c0ceb..51bfdeb 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -68,7 +68,7 @@
 #define PMC_CPUPWRGOOD_TIMER		0xc8
 #define PMC_CPUPWROFF_TIMER		0xcc
 
-#define PMC_SCRATCH41			0x140
+#define PMC_SCRATCH40			0x13C
 
 #define IO_DPD_REQ			0x1b8
 #define  IO_DPD_REQ_CODE_IDLE		(0 << 30)
@@ -742,14 +742,14 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int tegra_pmc_suspend(struct device *dev)
 {
-	tegra_pmc_writel(virt_to_phys(tegra_resume), PMC_SCRATCH41);
+	tegra_pmc_writel(virt_to_phys(tegra_resume), PMC_SCRATCH40);
 
 	return 0;
 }
 
 static int tegra_pmc_resume(struct device *dev)
 {
-	tegra_pmc_writel(0x0, PMC_SCRATCH41);
+	tegra_pmc_writel(0x0, PMC_SCRATCH40);
 
 	return 0;
 }
-- 
2.2.0
