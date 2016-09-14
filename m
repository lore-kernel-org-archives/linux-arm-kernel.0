From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 14 Sep 2016 22:21:19 +0800
Subject: [RFC PATCH v2 11/11] irqchip: mbigen: promote mbigen init
In-Reply-To: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1473862879-7769-12-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

mbigen is an irqchip and it needs to be probed before
devices, same logic is used for SMMU and etc., let's
use arch_initcall instead of platform init for mbigen.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ma Jun <majun258@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-mbigen.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index ca6add1..3a33de6 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -374,7 +374,11 @@ static struct platform_driver mbigen_platform_driver = {
 	.probe			= mbigen_device_probe,
 };
 
-module_platform_driver(mbigen_platform_driver);
+static __init int mbigen_init(void)
+{
+	return platform_driver_register(&mbigen_platform_driver);
+}
+arch_initcall(mbigen_init);
 
 MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
 MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
-- 
1.7.12.4
