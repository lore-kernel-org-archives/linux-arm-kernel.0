From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 21 Sep 2012 14:28:23 +0800
Subject: [PATCH] OMAPDSS: fix return value check in create_dss_pdev()
Message-ID: <CAPgLHd-G9Otuu2KT3e8WuW+yxLrHH68vj3dEgOXOZFo70=YFnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function omap_device_alloc() returns ERR_PTR()
not NULL pointer. The NULL test in the return value check should
be replaced with IS_ERR().

dpatch engine is used to auto generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index af1ed7d..eb1bd01 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -221,7 +221,7 @@ static struct platform_device *create_dss_pdev(const char *pdev_name,
 
 	ohs[0] = oh;
 	od = omap_device_alloc(pdev, ohs, 1, NULL, 0);
-	if (!od) {
+	if (IS_ERR(od)) {
 		pr_err("Could not alloc omap_device for %s\n", pdev_name);
 		r = -ENOMEM;
 		goto err;
