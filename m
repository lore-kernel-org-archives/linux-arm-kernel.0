From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 12 Oct 2010 19:31:44 +0200
Subject: [PATCH] mx25: fix clock's calculation
Message-ID: <1286904704-6297-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* get_rate_arm : when 400MHz clock is selected (cctl & 1<<14),
ARM clock is 400MHz (MPLL * 3 / 4) and not 800MHz
* get_rate_per : peripherals's clock is derived from AHB and not
from IPG (ref manual : figure 5-1)
* can2_clk : use the correct ID

* without this patch, peripherals getting their clock from PER
clocks work fine because of the 2 errors which fix themselves
(ARM clock x 2 and per clock actually based on IPG which is AHB/2)
but flexcan can't work as it gets its clock from IPG and thus
calculates its bitrate using a reference value which is twice
what it really is.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/clock.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 2179713..9e4a557 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -72,7 +72,7 @@ unsigned long get_rate_arm(struct clk *clk)
 	unsigned long rate = get_rate_mpll();
 
 	if (cctl & (1 << 14))
-		rate = (rate * 3) >> 1;
+		rate = (rate * 3) >> 2;
 
 	return rate / ((cctl >> 30) + 1);
 }
@@ -99,7 +99,7 @@ static unsigned long get_rate_per(int per)
 	if (readl(CRM_BASE + 0x64) & (1 << per))
 		fref = get_rate_upll();
 	else
-		fref = get_rate_ipg(NULL);
+		fref = get_rate_ahb(NULL);
 
 	return fref / (val + 1);
 }
@@ -261,7 +261,7 @@ DEFINE_CLOCK(esdhc2_clk,  1, CCM_CGCR1, 14, get_rate_esdhc2, NULL,
 DEFINE_CLOCK(audmux_clk, 0, CCM_CGCR1, 0, NULL, NULL, NULL);
 DEFINE_CLOCK(csi_clk,    0, CCM_CGCR1,  4, get_rate_csi, NULL,  &csi_per_clk);
 DEFINE_CLOCK(can1_clk,	 0, CCM_CGCR1,  2, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(can2_clk,	 0, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(can2_clk,	 1, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
-- 
1.7.0.4
