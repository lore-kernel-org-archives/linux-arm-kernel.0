From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 05 Sep 2009 08:30:31 +0000 (GMT)
Subject: [PATCH 2/3] s3c64xx: Fix fclk source
Message-ID: <3146299.529361252139431583.JavaMail.weblogic@epml18>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch fixes fclk source from mpll to apll.
According to 'Fig 3-2. The block diagram of clock generator' of 6400/6410 UM,
the source of ARM_CLK is APLL, that goes through MUX_APLL and DIV_APLL.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 9745852..a898325 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -663,6 +663,7 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
        unsigned long mpll;
        unsigned int ptr;
        u32 clkdiv0;
+       u32 clkdiv0_arm;

        printk(KERN_DEBUG "%s: registering clocks\n", __func__);

@@ -681,7 +682,9 @@ void __init_or_cpufreq s3c6400_setup_clocks(void)
        mpll = s3c6400_get_pll(xtal, __raw_readl(S3C_MPLL_CON));
        apll = s3c6400_get_pll(xtal, __raw_readl(S3C_APLL_CON));

-       fclk = mpll;
+       /* DIVarm clk divider mask starts at bit0, so no need to shift */
+       clkdiv0_arm = clkdiv0 & armclk_mask;
+       fclk = apll / (clkdiv0_arm + 1);

        printk(KERN_INFO "S3C64XX: PLL settings, A=%ld, M=%ld, E=%ld\n",
               apll, mpll, epll);
-- 
1.5.3.4
