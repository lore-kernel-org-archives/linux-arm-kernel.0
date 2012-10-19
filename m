From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Oct 2012 11:47:18 +0200
Subject: [PATCH 2/2] ARM: SMP_TWD: use clk_prepare_enable()
Message-ID: <1350640038-26358-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A minor code refactoring saving a few lines by merging prepare()
and enable() calls.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/smp_twd.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index b22d700..b92d524 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -248,17 +248,9 @@ static struct clk *twd_get_clock(void)
 		return clk;
 	}
 
-	err = clk_prepare(clk);
+	err = clk_prepare_enable(clk);
 	if (err) {
-		pr_err("smp_twd: clock failed to prepare: %d\n", err);
-		clk_put(clk);
-		return ERR_PTR(err);
-	}
-
-	err = clk_enable(clk);
-	if (err) {
-		pr_err("smp_twd: clock failed to enable: %d\n", err);
-		clk_unprepare(clk);
+		pr_err("smp_twd: clock failed to prepare+enable: %d\n", err);
 		clk_put(clk);
 		return ERR_PTR(err);
 	}
-- 
1.7.11.7
