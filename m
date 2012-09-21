From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 21 Sep 2012 14:14:25 +0800
Subject: [PATCH] ARM: imx: fix the return value check in imx_clk_busy_divider()
Message-ID: <CAPgLHd-0wYjWxWrmLdc+an0RVfEicv3QBEtvsuvQtphti3phdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_register() returns ERR_PTR()
no NULL pointer. The NULL test in the return value check should
be replaced with IS_ERR().

dpatch engine is used to auto generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-imx/clk-busy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-busy.c
index 1a7a8dd..1ab91b5 100644
--- a/arch/arm/mach-imx/clk-busy.c
+++ b/arch/arm/mach-imx/clk-busy.c
@@ -108,7 +108,7 @@ struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
 	busy->div.hw.init = &init;
 
 	clk = clk_register(NULL, &busy->div.hw);
-	if (!clk)
+	if (IS_ERR(clk))
 		kfree(busy);
 
 	return clk;
