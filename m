From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 30 Oct 2013 13:23:21 +0800
Subject: [PATCH] ARM: OMAP3: Beagle: fix return value check in
 beagle_opp_init()
Message-ID: <CAPgLHd_DZkrzaSa9cdYYUBL=p18s=P=5RFyTJTT+toFgTqNZGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function get_cpu_device() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/board-omap3beagle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index a516c1b..d6ed819 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -510,7 +510,7 @@ static int __init beagle_opp_init(void)
 		mpu_dev = get_cpu_device(0);
 		iva_dev = omap_device_get_by_hwmod_name("iva");
 
-		if (IS_ERR(mpu_dev) || IS_ERR(iva_dev)) {
+		if (!mpu_dev || IS_ERR(iva_dev)) {
 			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
 				__func__, mpu_dev, iva_dev);
 			return -ENODEV;
