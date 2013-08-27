From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 28 Aug 2013 01:35:22 +0530
Subject: [PATCH v3 5/7] ARM: davinci: da8xx: gpio device creation
In-Reply-To: <1376803143-13738-6-git-send-email-prabhakar.csengg@gmail.com>
References: <1376803143-13738-1-git-send-email-prabhakar.csengg@gmail.com>
 <1376803143-13738-6-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <521D0682.4020908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/18/2013 10:49 AM, Lad, Prabhakar wrote:
> From: Philip Avinash <avinashphilip@ti.com>
> 
> Create davinci gpio device and remove references in davinci_soc_info
> structure. Also rearrange header file inclusion in group basis.
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-davinci/board-da830-evm.c     |   28 ++++++++++++++++-----------
>  arch/arm/mach-davinci/board-da850-evm.c     |   16 ++++++++++-----
>  arch/arm/mach-davinci/board-omapl138-hawk.c |   10 ++++++++--
>  arch/arm/mach-davinci/da830.c               |   21 +++++++++++++++-----
>  arch/arm/mach-davinci/da850.c               |   27 ++++++++++++++++++--------
>  arch/arm/mach-davinci/include/mach/da8xx.h  |   22 +++++++++++----------
>  6 files changed, 83 insertions(+), 41 deletions(-)
> 

>  #define DA850_EVM_PHY_ID		"davinci_mdio-0:00"
>  #define DA850_LCD_PWR_PIN		GPIO_TO_PIN(2, 8)
> @@ -1439,6 +1441,10 @@ static __init void da850_evm_init(void)
>  {
>  	int ret;
>  
> +	ret = da850_register_gpio();
> +	if (ret)
> +		pr_warn("da850_evm_init: GPIO init failed: %d\n", ret);

Changed this to use __func__ for function name print to remain 
consistent with rest of this function.

> +int __init da830_register_gpio()

This should be da830_register_gpio(void). Please check the patches you 
submit for compilation warnings.

> +int __init da850_register_gpio()

Same problem here too.

Here is the updated patch. Now with just the board updates.

Thanks,
Sekhar

---8<---
>From daa3db9c70850578e041bb57d3ae8cc6d17ef7f3 Mon Sep 17 00:00:00 2001
From: Philip Avinash <avinashphilip@ti.com>
Date: Sun, 18 Aug 2013 10:49:01 +0530
Subject: [PATCH 5/7] ARM: davinci: da8xx boards: gpio device creation

Register  gpio platform device on DA8XX boards.

While at it, rearrange header files to group related header
files together and sort them in alphabetic order within the
group. This will help avoid duplicate inclusions in future.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
[nsekhar at ti.com: remove SoC specific parts from this file.
		 fix compile warnings]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-davinci/board-da830-evm.c     |   28 ++++++++++++++++-----------
 arch/arm/mach-davinci/board-da850-evm.c     |   16 ++++++++++-----
 arch/arm/mach-davinci/board-omapl138-hawk.c |   10 ++++++++--
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index c4bdc0a..54a8690 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -9,30 +9,32 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/console.h>
-#include <linux/interrupt.h>
 #include <linux/gpio.h>
-#include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pcf857x.h>
 #include <linux/i2c/at24.h>
+#include <linux/i2c/pcf857x.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/spi/spi.h>
+#include <linux/platform_data/gpio-davinci.h>
+#include <linux/platform_data/mtd-davinci.h>
+#include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/platform_data/spi-davinci.h>
+#include <linux/platform_data/usb-davinci.h>
+#include <linux/platform_device.h>
 #include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <mach/common.h>
 #include <mach/cp_intc.h>
-#include <mach/mux.h>
-#include <linux/platform_data/mtd-davinci.h>
 #include <mach/da8xx.h>
-#include <linux/platform_data/usb-davinci.h>
-#include <linux/platform_data/mtd-davinci-aemif.h>
-#include <linux/platform_data/spi-davinci.h>
+#include <mach/mux.h>
 
 #define DA830_EVM_PHY_ID		""
 /*
@@ -591,6 +593,10 @@ static __init void da830_evm_init(void)
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	int ret;
 
+	ret = da830_register_gpio();
+	if (ret)
+		pr_warn("da830_evm_init: GPIO init failed: %d\n", ret);
+
 	ret = da830_register_edma(da830_edma_rsv);
 	if (ret)
 		pr_warning("da830_evm_init: edma registration failed: %d\n",
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 9afd687..31d55a1 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -15,29 +15,31 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/init.h>
 #include <linux/input.h>
 #include <linux/input/tps6507x-ts.h>
+#include <linux/kernel.h>
 #include <linux/mfd/tps6507x.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
-#include <linux/platform_device.h>
+#include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/uio_pruss.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/tps6507x.h>
-#include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <linux/wl12xx.h>
 
+#include <mach/common.h>
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
 #include <mach/mux.h>
@@ -47,8 +49,8 @@
 #include <asm/mach/arch.h>
 #include <asm/system_info.h>
 
-#include <media/tvp514x.h>
 #include <media/adv7343.h>
+#include <media/tvp514x.h>
 
 #define DA850_EVM_PHY_ID		"davinci_mdio-0:00"
 #define DA850_LCD_PWR_PIN		GPIO_TO_PIN(2, 8)
@@ -1439,6 +1441,10 @@ static __init void da850_evm_init(void)
 {
 	int ret;
 
+	ret = da850_register_gpio();
+	if (ret)
+		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
+
 	ret = pmic_tps65070_init();
 	if (ret)
 		pr_warn("%s: TPS65070 PMIC init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index ab98c75..0e0b998 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -9,14 +9,16 @@
  * version 2. This program is licensed "as is" without any warranty of
  * any kind, whether express or implied.
  */
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/console.h>
 #include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_data/gpio-davinci.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <mach/common.h>
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
 #include <mach/mux.h>
@@ -290,6 +292,10 @@ static __init void omapl138_hawk_init(void)
 {
 	int ret;
 
+	ret = da850_register_gpio();
+	if (ret)
+		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
+
 	davinci_serial_init(da8xx_serial_device);
 
 	omapl138_hawk_config_emac();
-- 
1.7.10.1
