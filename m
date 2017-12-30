From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Sat, 30 Dec 2017 01:12:43 +0000
Subject: [PATCH 04/33] clk: omap2: change omap2_round_to_table_rate return
 logic
In-Reply-To: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1514596392-22270-5-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the round_rate() logic here to return zero instead of a
negative number on error.

In conjunction with higher-level changes associated with acting on the
return value of clk_ops->round_rate() it is then possible to have
clk_ops->round_rate() return values from 1 Hz to ULONG_MAX Hz instead of
the current limitation of 1 Hz to LONG_MAX Hz.

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
Cc: linux-omap at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index e024600..ce3a33f 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -75,9 +75,9 @@ unsigned long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long *parent_rate)
 {
 	const struct prcm_config *ptr;
-	long highest_rate;
+	unsigned long highest_rate;
 
-	highest_rate = -EINVAL;
+	highest_rate = 0;
 
 	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
 		if (!(ptr->flags & cpu_mask))
-- 
2.7.4
