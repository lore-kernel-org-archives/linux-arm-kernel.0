From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 25 Oct 2013 17:31:51 +0800
Subject: [PATCH] ARM: OMAP2+: smsc911x: fix return value check in
 gpmc_smsc911x_init()
Message-ID: <CAPgLHd9V0=GHGYgfuL7cCkzmZT7HVzuNg0iwwsOcipbnJ90bVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function platform_device_register_resndata()
returns ERR_PTR() and never returns NULL. The NULL test in the return
value check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/gpmc-smsc911x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index ef99011..2757504 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -83,7 +83,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
 	pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
 		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
 		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config));
-	if (!pdev) {
+	if (IS_ERR(pdev)) {
 		pr_err("Unable to register platform device\n");
 		gpio_free(gpmc_cfg->gpio_reset);
 		goto free2;
