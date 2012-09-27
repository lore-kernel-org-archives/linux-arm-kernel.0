From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 27 Sep 2012 13:54:36 +0800
Subject: [PATCH] ARM: OMAP2+: PM: fix return value check in
 omap2_set_init_voltage()
Message-ID: <CAPgLHd-q3rF822NrpJQcMgr2=BNAp=p_rbRdEXp-gSutnjuBFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function voltdm_lookup() returns NULL
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 9cb5ced..ab15e5c 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -176,7 +176,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	}
 
 	voltdm = voltdm_lookup(vdd_name);
-	if (IS_ERR(voltdm)) {
+	if (!voltdm) {
 		pr_err("%s: unable to get vdd pointer for vdd_%s\n",
 			__func__, vdd_name);
 		goto exit;
