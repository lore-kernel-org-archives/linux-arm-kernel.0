From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Sat,  6 Feb 2016 22:24:56 +0800
Subject: [PATCH] ARM: zx: Fix return value check in zx296702_pd_probe()
Message-ID: <1454768696-340-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns
ERR_PTR() and never returns NULL. The NULL test in the return
value check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-zx/zx296702-pm-domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
index e08574d..2037bcb 100644
--- a/arch/arm/mach-zx/zx296702-pm-domain.c
+++ b/arch/arm/mach-zx/zx296702-pm-domain.c
@@ -169,9 +169,9 @@ static int zx296702_pd_probe(struct platform_device *pdev)
 	}
 
 	pcubase = devm_ioremap_resource(&pdev->dev, res);
-	if (!pcubase) {
+	if (IS_ERR(pcubase)) {
 		dev_err(&pdev->dev, "ioremap fail.\n");
-		return -EIO;
+		return PTR_ERR(pcubase);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(zx296702_pm_domains); ++i)
