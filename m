From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Jun 2016 09:51:12 +0200
Subject: [GIT PULL 1/4] ARM: exynos: Mach updates for v4.8, part 2
In-Reply-To: <1467273075-13747-1-git-send-email-k.kozlowski@samsung.com>
References: <1467273075-13747-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1467273075-13747-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Mostly endian-related cleanup/fixes, on top of previous pull.
Expected conflicts:

diff --cc arch/arm/mach-exynos/exynos.c
index a8620c6eb723,bdaf81c46d74..9c51b6dcb551
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@@ -25,8 -25,10 +25,9 @@@
  #include <asm/mach/map.h>
  
  #include <mach/map.h>
+ #include <plat/cpu.h>
  
  #include "common.h"
 -#include "mfc.h"
  
  static struct map_desc exynos4_iodesc[] __initdata = {
        {
diff --cc drivers/soc/samsung/pm_domains.c
index f60515eefb66,0e075d96ccd4..4822346aadc6
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@@ -74,13 -69,13 +74,13 @@@ static int exynos_pd_power(struct gener
                }
        }
  
 -      pwr = power_on ? INT_LOCAL_PWR_EN : 0;
 +      pwr = power_on ? pd->local_pwr_cfg : 0;
-       __raw_writel(pwr, base);
+       writel_relaxed(pwr, base);
  
        /* Wait max 1ms */
        timeout = 10;
  
-       while ((__raw_readl(base + 0x4) & pd->local_pwr_cfg) != pwr) {
 -      while ((readl_relaxed(base + 0x4) & INT_LOCAL_PWR_EN) != pwr) {
++      while ((readl_relaxed(base + 0x4) & pd->local_pwr_cfg) != pwr) {
                if (!timeout) {
                        op = (power_on) ? "enable" : "disable";
                        pr_err("Power domain %s %s failed\n", domain->name, op);
@@@ -207,7 -185,7 +207,7 @@@ static __init int exynos4_pm_init_power
                        clk_put(pd->oscclk);
  
  no_clk:
-               on = __raw_readl(pd->base + 0x4) & pd->local_pwr_cfg;
 -              on = readl_relaxed(pd->base + 0x4) & INT_LOCAL_PWR_EN;
++              on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
  
                pm_genpd_init(&pd->pd, NULL, !on);
                of_genpd_add_provider_simple(np, &pd->pd);



Best regards,
Krzysztof


The following changes since commit da81593a5a0d93fcca45baa15d0628ba8405695b:

  ARM: s3c24xx: Sort cpufreq tables (2016-06-03 13:54:36 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.8-2

for you to fetch changes up to 1c03274d68f4744afe582fcff1c2e5b1c5c34b5b:

  MAINTAINERS: Extend Samsung SoC entry with S3C/S5P drivers (2016-06-23 08:12:08 +0200)

----------------------------------------------------------------
Samsung mach/soc update for v4.8, part 2:
1. Endian-friendly fixes.
2. Maintainers update.

----------------------------------------------------------------
Ben Dooks (7):
      ARM: EXYNOS: Fixup debug macros for big-endian
      ARM: SAMSUNG: Fixup endian issues in CPU detection
      ARM: EXYNOS: Fixups for big-endian operation
      ARM: EXYNOS: Fixup endian in pm/pmu
      ARM: SAMSUNG: Fixup usage of __raw IO in PM
      ARM: EXYNOS: Fixup for __raw operations in suspend.c
      ARM: SAMSUNG: Fix missing s5p_init_cpu() declaration

Joonyoung Shim (1):
      ARM: EXYNOS: Fix UART address selection for DEBUG_LL

Krzysztof Kozlowski (1):
      MAINTAINERS: Extend Samsung SoC entry with S3C/S5P drivers

 MAINTAINERS                              |  6 ++++--
 arch/arm/include/debug/exynos.S          |  6 +++++-
 arch/arm/include/debug/samsung.S         |  8 ++++++++
 arch/arm/mach-exynos/common.h            |  5 ++---
 arch/arm/mach-exynos/exynos.c            |  1 +
 arch/arm/mach-exynos/firmware.c          | 18 +++++++++---------
 arch/arm/mach-exynos/headsmp.S           |  3 +++
 arch/arm/mach-exynos/platsmp.c           |  4 ++--
 arch/arm/mach-exynos/pm.c                |  6 +++---
 arch/arm/mach-exynos/pm_domains.c        |  6 +++---
 arch/arm/mach-exynos/suspend.c           | 12 ++++++------
 arch/arm/plat-samsung/cpu.c              |  8 ++++----
 arch/arm/plat-samsung/include/plat/cpu.h |  1 +
 arch/arm/plat-samsung/pm-common.c        |  8 ++++----
 14 files changed, 55 insertions(+), 37 deletions(-)
