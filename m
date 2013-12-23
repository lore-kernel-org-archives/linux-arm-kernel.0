From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:16 +0900
Subject: [PATCH 20/26] ARM: shmobile: mackerel: clk_round_rate() can return a
 zero to indicate an error
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <90d423faa0ed53cfda9f12d119f6938dd1ab515d.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Walmsley <pwalmsley@nvidia.com>

Treat both negative and zero return values from clk_round_rate() as
errors.  This is needed since subsequent patches will convert
clk_round_rate()'s return value to be an unsigned type, rather than a
signed type, since some clock sources can generate rates higher than
(2^31)-1 Hz.

Eventually, when calling clk_round_rate(), only a return value of zero
will be considered a error.  All other values will be considered valid
rates.  The comparison against values less than 0 is kept to preserve
the correct behavior in the meantime.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index af06753..d90d2f1 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -548,9 +548,9 @@ static void __init hdmi_init_pm_clock(void)
 		 clk_get_rate(&sh7372_pllc2_clk));
 
 	rate = clk_round_rate(&sh7372_pllc2_clk, 594000000);
-	if (rate < 0) {
+	if (rate <= 0) {
 		pr_err("Cannot get suitable rate: %ld\n", rate);
-		ret = rate;
+		ret = -EINVAL;
 		goto out;
 	}
 
-- 
1.8.4
