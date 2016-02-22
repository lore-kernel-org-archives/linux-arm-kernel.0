From: majun258@huawei.com (MaJun)
Date: Mon, 22 Feb 2016 19:00:10 +0800
Subject: [PATCH] Irq/mbigen:Promote the mbigen driver register timing
Message-ID: <1456138810-24008-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

Using module_platform_driver() to register mbigen driver is
too late for some driver to apply irq, because the mbigen irq
domain is not created yet. 

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/irq-mbigen.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 4dd3eb8..4df359c 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -289,7 +289,14 @@ static struct platform_driver mbigen_platform_driver = {
 	.probe			= mbigen_device_probe,
 };
 
-module_platform_driver(mbigen_platform_driver);
+static __init int mbigen_init(void)
+
+{
+	return platform_driver_register(&mbigen_platform_driver);
+
+}
+
+arch_initcall(mbigen_init);
 
 MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
 MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
-- 
1.7.1
