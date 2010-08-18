From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:01:17 +0900
Subject: [PATCH 07/14] ARM: S5PV310: Adds printing ACLK200, ACLK100,
	ACLK160 and ACLK133
In-Reply-To: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282140084-10265-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds log messages of aclk_200, aclk_100, aclk_160, and
aclk_133. And adds clk_p.rate from calculated aclk_100.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index 8ffda6e..cc583c1 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -360,6 +360,10 @@ void __init_or_cpufreq s5pv310_setup_clocks(void)
 	unsigned long xtal;
 	unsigned long armclk;
 	unsigned long sclk_dmc;
+	unsigned long aclk_200;
+	unsigned long aclk_100;
+	unsigned long aclk_160;
+	unsigned long aclk_133;
 	unsigned int ptr;
 
 	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
@@ -392,10 +396,19 @@ void __init_or_cpufreq s5pv310_setup_clocks(void)
 	armclk = clk_get_rate(&clk_armclk.clk);
 	sclk_dmc = clk_get_rate(&clk_sclk_dmc.clk);
 
-	printk(KERN_INFO "S5PV310: ARMCLK=%ld, DMC=%ld\n", armclk, sclk_dmc);
+	aclk_200 = clk_get_rate(&clk_aclk_200.clk);
+	aclk_100 = clk_get_rate(&clk_aclk_100.clk);
+	aclk_160 = clk_get_rate(&clk_aclk_160.clk);
+	aclk_133 = clk_get_rate(&clk_aclk_133.clk);
+
+	printk(KERN_INFO "S5PV310: ARMCLK=%ld, DMC=%ld, ACLK200=%ld\n"
+			 "ACLK100=%ld, ACLK160=%ld, ACLK133=%ld\n",
+			armclk, sclk_dmc, aclk_200,
+			aclk_100, aclk_160, aclk_133);
 
 	clk_f.rate = armclk;
 	clk_h.rate = sclk_dmc;
+	clk_p.rate = aclk_100;
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_set_clksrc(&clksrcs[ptr], true);
-- 
1.6.2.5
