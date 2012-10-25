From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 25 Oct 2012 23:02:18 +0800
Subject: [PATCH] ARM i.MX: fix error-valued pointer dereference in
 clk_register_gate2()
Message-ID: <CAPgLHd9Q3bZVth2NSxwH6kBpPsBmRGD+4pfZRpWL69KCw4HY4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The error-valued pointer clk is used for the arg of kfree, it should be
kfree(gate) if clk_register() return ERR_PTR().

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-imx/clk-gate2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index 3c1b8ff..cc49c7a 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -112,7 +112,7 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
 
 	clk = clk_register(dev, &gate->hw);
 	if (IS_ERR(clk))
-		kfree(clk);
+		kfree(gate);
 
 	return clk;
 }
