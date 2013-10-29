From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 29 Oct 2013 10:07:57 +0800
Subject: [PATCH] clk: tegra: fix return value check in
 tegra_clk_register_pllc()
Message-ID: <CAPgLHd-wYa3Z7J93LmC0rvRPKsrjK+8DEZR+2f+e14RN+p_fPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function __clk_lookup() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clk/tegra/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 197074a..a99bef7 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1507,7 +1507,7 @@ struct clk *tegra_clk_register_pllc(const char *name, const char *parent_name,
 		return ERR_PTR(-EINVAL);
 
 	parent = __clk_lookup(parent_name);
-	if (IS_ERR(parent)) {
+	if (!parent) {
 		WARN(1, "parent clk %s of %s must be registered first\n",
 			name, parent_name);
 		return ERR_PTR(-EINVAL);
