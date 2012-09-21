From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 21 Sep 2012 14:30:50 +0800
Subject: [PATCH] ARM: OMAP: hsmmc: fix return value check in
 omap_hsmmc_init_one()
Message-ID: <CAPgLHd9RvEA1_dtaHOTCnuoboU3jcwzn_trwucu9kDqqdR1Lcw@mail.gmail.com>
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
 arch/arm/mach-omap2/hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index a9675d8..95179fe 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -522,7 +522,7 @@ static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 	dev_set_name(&pdev->dev, "%s.%d", pdev->name, pdev->id);
 
 	od = omap_device_alloc(pdev, ohs, 1, NULL, 0);
-	if (!od) {
+	if (IS_ERR(od)) {
 		pr_err("Could not allocate od for %s\n", name);
 		goto put_pdev;
 	}
