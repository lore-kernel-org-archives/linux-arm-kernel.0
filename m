From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Mon, 15 Jan 2018 10:41:53 +0000
Subject: [PATCH -next] firmware: arm_sdei: Fix return value check in
 sdei_present_dt()
Message-ID: <1516012913-196560-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of error, the function of_platform_device_create() returns
NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Fixes: 677a60bd2003 ("firmware: arm_sdei: Discover SDEI support via ACPI")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/firmware/arm_sdei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 8f6563c..1ea7164 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1023,7 +1023,7 @@ static bool __init sdei_present_dt(void)
 
 	pdev = of_platform_device_create(np, sdei_driver.driver.name, NULL);
 	of_node_put(np);
-	if (IS_ERR(pdev))
+	if (!pdev)
 		return false;
 
 	return true;
