From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 15 Oct 2015 15:22:30 +0200
Subject: [PATCH] soc: rockchip: power-domain: don't try to print the clock
 name in error case
Message-ID: <1764593.eLkUiZigaK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we never got the the clock-reference, i.e. when IS_ERR(clk) is true,
don't try to print the clock name via %pC as this of course produces a
null-pointer-dereference in __clk_get_name().

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/soc/rockchip/pm_domains.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 8268d5d..534c589 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -265,8 +265,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		if (IS_ERR(clk)) {
 			error = PTR_ERR(clk);
 			dev_err(pmu->dev,
-				"%s: failed to get clk %pC (index %d): %d\n",
-				node->name, clk, i, error);
+				"%s: failed to get clk at index %d: %d\n",
+				node->name, i, error);
 			goto err_out;
 		}
 
-- 
2.6.1
