From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 09:29:17 +0100
Subject: [PATCH 8/9] clk: timer-sp: convert to clk_prepare()/clk_unprepare()
Message-ID: <E1R8T2T-0003wn-NA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/timer-sp.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 41df478..2393b5b 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -41,9 +41,17 @@ static long __init sp804_get_clock_rate(const char *name)
 		return PTR_ERR(clk);
 	}
 
+	err = clk_prepare(clk);
+	if (err) {
+		pr_err("sp804: %s clock failed to prepare: %d\n", name, err);
+		clk_put(clk);
+		return err;
+	}
+
 	err = clk_enable(clk);
 	if (err) {
 		pr_err("sp804: %s clock failed to enable: %d\n", name, err);
+		clk_unprepare(clk);
 		clk_put(clk);
 		return err;
 	}
@@ -52,6 +60,7 @@ static long __init sp804_get_clock_rate(const char *name)
 	if (rate < 0) {
 		pr_err("sp804: %s clock failed to get rate: %ld\n", name, rate);
 		clk_disable(clk);
+		clk_unprepare(clk);
 		clk_put(clk);
 	}
 
-- 
1.7.4.4
