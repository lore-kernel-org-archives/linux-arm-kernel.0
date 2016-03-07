From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue,  8 Mar 2016 01:30:26 +0200
Subject: [PATCH] ARM: spear: fix check of clk_get_sys() return value
Message-ID: <1457393426-14679-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_get_sys() function returns either a valid pointer to
struct clk or ERR_PTR() error value, this makes invalid a check for
NULL on error path, fix it.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-spear/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index 9ccffc1..4878ba9 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -233,7 +233,7 @@ void __init spear_setup_of_timer(void)
 	}
 
 	gpt_clk = clk_get_sys("gpt0", NULL);
-	if (!gpt_clk) {
+	if (IS_ERR(gpt_clk)) {
 		pr_err("%s:couldn't get clk for gpt\n", __func__);
 		goto err_iomap;
 	}
-- 
2.1.4
