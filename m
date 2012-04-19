From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Apr 2012 21:36:43 +0100
Subject: [PATCH 14/15] mfd/db8500-prcmu: Add Device Tree support and enable
 ux500 platforms
In-Reply-To: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334867804-31942-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we see the db8500-prcmu driver obtain DT support. In its
current state, all we have to do is offer a matching compatible
node and the driver will register and initialise correctly. We
Also remove any initialisation completed in platform code to
prevent any device duplication.

CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c |    3 +--
 drivers/mfd/db8500-prcmu.c       |    5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index c97eab7..2512b6a 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -124,7 +124,6 @@ static struct platform_device *platform_devs[] __initdata = {
 static struct platform_device *of_platform_devs[] __initdata = {
 	&u8500_dma40_device,
 	&db8500_pmu_device,
-	&db8500_prcmu_device,
 };
 
 static resource_size_t __initdata db8500_gpio_base[] = {
@@ -234,7 +233,7 @@ struct device * __init u8500_of_init_devices(void)
 	 * Devices to be DT:ed:
 	 *   u8500_dma40_device  = todo
 	 *   db8500_pmu_device   = todo
-	 *   db8500_prcmu_device = todo
+	 *   db8500_prcmu_device = done
 	 */
 	platform_add_devices(of_platform_devs, ARRAY_SIZE(of_platform_devs));
 
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 839e70b..3c2e4a9 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2992,11 +2992,16 @@ static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 no_irq_return:
 	return err;
 }
+static const struct of_device_id db8500_prcmu_match[] = {
+	{ .compatible = "stericsson,db8500-prcmu"},
+	{ },
+};
 
 static struct platform_driver db8500_prcmu_driver = {
 	.driver = {
 		.name = "db8500-prcmu",
 		.owner = THIS_MODULE,
+		.of_match_table = db8500_prcmu_match,
 	},
 	.probe = db8500_prcmu_probe,
 };
-- 
1.7.9.1
