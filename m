From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 4 Jul 2013 21:51:31 +0800
Subject: [PATCH] ARM: u300: fix return value check in __u300_init_boardpower()
Message-ID: <CAPgLHd9cUJtF7WXmY4Sy+53MxjKJRe8RVNNtbfdYLzh6OwbNzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function syscon_node_to_regmap() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-u300/regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-u300/regulator.c b/arch/arm/mach-u300/regulator.c
index bf40cd4..0493a84 100644
--- a/arch/arm/mach-u300/regulator.c
+++ b/arch/arm/mach-u300/regulator.c
@@ -69,9 +69,9 @@ static int __init __u300_init_boardpower(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	regmap = syscon_node_to_regmap(syscon_np);
-	if (!regmap) {
+	if (IS_ERR(regmap)) {
 		pr_crit("U300: could not locate syscon regmap\n");
-		return -ENODEV;
+		return PTR_ERR(regmap);
 	}
 
 	main_power_15 = regulator_get(&pdev->dev, "vana15");
