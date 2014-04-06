From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sun,  6 Apr 2014 21:38:05 +0200
Subject: [PATCH] arm/twd: use smp_twd clock even with DT
Message-ID: <1396813085-15363-1-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting Linux 3.14 on Pandaboard currently gets the following
message displayed:

smp_twd: clock not found -2

Whereas an "smp_twd" clock exists for omap4. The following change
avoids this.

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/kernel/smp_twd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 6591e26..67754af 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -246,7 +246,7 @@ static void twd_get_clock(struct device_node *np)
 
 	if (np)
 		twd_clk = of_clk_get(np, 0);
-	else
+	if (np == NULL || IS_ERR(twd_clk))
 		twd_clk = clk_get_sys("smp_twd", NULL);
 
 	if (IS_ERR(twd_clk)) {
-- 
1.7.10.4
