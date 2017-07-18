From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Tue, 18 Jul 2017 12:17:23 +0200
Subject: [PATCH 2/9] ARM: mmp: allow NULL clock for clk_get_rate
In-Reply-To: <20170718101730.2541-1-jonas.gorski@gmail.com>
References: <20170718101730.2541-1-jonas.gorski@gmail.com>
Message-ID: <20170718101730.2541-3-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the behaviour of clk_get_rate consistent with common clk's
clk_get_rate by accepting NULL clocks as parameter. Some device
drivers rely on this, and will cause an OOPS otherwise.

Fixes: 49cbe78637eb ("[ARM] pxa: add base support for Marvell's PXA168 processor line")
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Reported-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/arm/mach-mmp/clock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
index 28fe64c6e2f5..bdfb113431ec 100644
--- a/arch/arm/mach-mmp/clock.c
+++ b/arch/arm/mach-mmp/clock.c
@@ -83,7 +83,9 @@ unsigned long clk_get_rate(struct clk *clk)
 {
 	unsigned long rate;
 
-	if (clk->ops->getrate)
+	if (!clk)
+		rate = 0;
+	else if (clk->ops->getrate)
 		rate = clk->ops->getrate(clk);
 	else
 		rate = clk->rate;
-- 
2.11.0
