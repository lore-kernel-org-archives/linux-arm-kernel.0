From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:40 +0000
Subject: [PATCH 43/46] ARM: ux500: Pass regulator platform data using the new
 format
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-44-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regulator platform data is now passed though a single structure
as opposed to the old way where four separate struct elements
were required. This patch makes use of the new format.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    5 +----
 include/linux/mfd/abx500/ab8500.h  |   11 ++---------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index b034578..b1124bd 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -198,10 +198,7 @@ static struct platform_device snowball_sbnet_dev = {
 
 struct ab8500_platform_data ab8500_platdata = {
 	.irq_base	= MOP500_AB8500_IRQ_BASE,
-	.regulator_reg_init = ab8500_regulator_reg_init,
-	.num_regulator_reg_init	= ARRAY_SIZE(ab8500_regulator_reg_init),
-	.regulator	= ab8500_regulators,
-	.num_regulator	= ARRAY_SIZE(ab8500_regulators),
+	.regulator	= &ab8500_regulator_plat_data,
 	.gpio		= &ab8500_gpio_pdata,
 	.codec		= &ab8500_codec_pdata,
 };
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 9db0bda..84f4494 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -364,8 +364,7 @@ struct ab8500 {
 	const int *irq_reg_offset;
 };
 
-struct regulator_reg_init;
-struct regulator_init_data;
+struct ab8500_regulator_platform_data;
 struct ab8500_gpio_platform_data;
 struct ab8500_codec_platform_data;
 struct ab8500_sysctrl_platform_data;
@@ -375,19 +374,13 @@ struct ab8500_sysctrl_platform_data;
  * @irq_base: start of AB8500 IRQs, AB8500_NR_IRQS will be used
  * @pm_power_off: Should machine pm power off hook be registered or not
  * @init: board-specific initialization after detection of ab8500
- * @num_regulator_reg_init: number of regulator init registers
- * @regulator_reg_init: regulator init registers
- * @num_regulator: number of regulators
  * @regulator: machine-specific constraints for regulators
  */
 struct ab8500_platform_data {
 	int irq_base;
 	bool pm_power_off;
 	void (*init) (struct ab8500 *);
-	int num_regulator_reg_init;
-	struct ab8500_regulator_reg_init *regulator_reg_init;
-	int num_regulator;
-	struct regulator_init_data *regulator;
+	struct ab8500_regulator_platform_data *regulator;
 	struct abx500_gpio_platform_data *gpio;
 	struct ab8500_codec_platform_data *codec;
 	struct ab8500_sysctrl_platform_data *sysctrl;
-- 
1.7.10.4
