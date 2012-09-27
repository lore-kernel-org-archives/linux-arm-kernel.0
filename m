From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 27 Sep 2012 13:54:01 +0800
Subject: [PATCH] ARM: imx: fix return value check in imx3_init_l2x0()
Message-ID: <CAPgLHd8Rma5fSWPtjvLr18TEmmC=8kOjmSJtneO0Ecd1bvOrcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function ioremap() returns NULL
not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-imx/mm-imx3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 9d2c843..b5deb05 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -108,9 +108,8 @@ void __init imx3_init_l2x0(void)
 	}
 
 	l2x0_base = ioremap(MX3x_L2CC_BASE_ADDR, 4096);
-	if (IS_ERR(l2x0_base)) {
-		printk(KERN_ERR "remapping L2 cache area failed with %ld\n",
-				PTR_ERR(l2x0_base));
+	if (!l2x0_base) {
+		printk(KERN_ERR "remapping L2 cache area failed\n");
 		return;
 	}
 
