From: niej0001@gmail.com (Jun Nie)
Date: Thu, 19 Nov 2009 17:02:03 +0800
Subject: [PATCH 6/8] pxa: add gpio expander on pxa168 aspenite platform
In-Reply-To: <7c34ac520911160134s50f387a3s91485a797a37ce0a@mail.gmail.com>
References: <7c34ac520911160134s50f387a3s91485a797a37ce0a@mail.gmail.com>
Message-ID: <7c34ac520911190102o5e797181geb40b19d99cdec91@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/16 Jun Nie <niej0001@gmail.com>:
> From: Jun Nie <njun@marvell.com>
> Date: Fri, 13 Nov 2009 14:19:05 +0800
> Subject: [PATCH] pxa: add gpio expander on pxa168 aspenite platform
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> ?arch/arm/mach-mmp/aspenite.c | ? 46 ++++++++++++++++++++++++++++++++++++++++++
> ?drivers/gpio/pca953x.c ? ? ? | ? ?1 +
> ?2 files changed, 47 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
> index 115f728..21cecfc 100644
> --- a/arch/arm/mach-mmp/aspenite.c
> +++ b/arch/arm/mach-mmp/aspenite.c
> @@ -16,6 +16,7 @@
> ?#include <linux/mtd/mtd.h>
> ?#include <linux/mtd/partitions.h>
> ?#include <linux/mtd/nand.h>
> +#include <linux/i2c/pca953x.h>
>
> ?#include <asm/mach-types.h>
> ?#include <asm/mach/arch.h>
> @@ -24,9 +25,14 @@
> ?#include <mach/pxa168.h>
> ?#include <mach/gpio.h>
> ?#include <plat/pxa3xx_nand.h>
> +#include <video/pxa168fb.h>
>
> ?#include "common.h"
>
> +/*used by expander max7312, 16 pins gpio expander */
> +#define GPIO_EXT0(x) ? ? ? ? ? (NR_BUILTIN_GPIO + (x))
> +#define GPIO_EXT1(x) ? ? ? ? ? (NR_BUILTIN_GPIO + 16 + (x))
> +
> ?static unsigned long common_pin_config[] __initdata = {
> ? ? ? ?/* Data Flash Interface */
> ? ? ? ?GPIO0_DFI_D15,
> @@ -134,6 +140,44 @@ static void __init apn_init_nand(void)
> ?static void __init apn_init_nand(void) {}
> ?#endif
>
> +static struct i2c_pxa_platform_data pwri2c_info __initdata = {
> + ? ? ? .use_pio ? ? ? ? ? ? ? ?= 1,
> +};
> +
> +#if defined(CONFIG_GPIO_PCA953X)
> +/* GPIO expander max7312 could reuse PCA953X */
> +static struct pca953x_platform_data max7312_data[] = {
> + ? ? ? /* two max7312 in system */
> +
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .gpio_base ? ? ?= GPIO_EXT0(0),
> + ? ? ? },
> +
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .gpio_base ? ? ?= GPIO_EXT1(0),
> + ? ? ? },
> +};
> +#endif
> +
> +static struct i2c_board_info aspenite_i2c_board_info[] = {
> +
> +#if defined(CONFIG_GPIO_PCA953X)
> + ? ? ? {
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = "max7312",
> + ? ? ? ? ? ? ? .addr ? ? ? ? ? = 0x10, ? ? ? ? ? ? ? ? /* 0x20/0x21 */
> + ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= IRQ_GPIO(122),
> + ? ? ? ? ? ? ? .platform_data ?= &max7312_data[0],
> + ? ? ? },
> +
> + ? ? ? {
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = "max7312",
> + ? ? ? ? ? ? ? .addr ? ? ? ? ? = 0x20, ? ? ? ? ? ? ? ? /* 0x40/0x41 */
> + ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= IRQ_GPIO(120),
> + ? ? ? ? ? ? ? .platform_data ?= &max7312_data[1],
> + ? ? ? },
> +#endif
> +};
> +
> ?static void __init common_init(void)
> ?{
> ? ? ? ?mfp_config(ARRAY_AND_SIZE(common_pin_config));
> @@ -142,6 +186,8 @@ static void __init common_init(void)
> ? ? ? ?pxa168_add_uart(1);
>
> ? ? ? ?apn_init_nand();
> + ? ? ? pxa168_add_twsi(0, &pwri2c_info,
> + ? ? ? ? ? ? ? ? ? ? ? ARRAY_AND_SIZE(aspenite_i2c_board_info));
>
> ? ? ? ?/* off-chip devices */
> ? ? ? ?platform_device_register(&smc91x_device);
> diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
> index 6a2fb3f..7822684 100644
> --- a/drivers/gpio/pca953x.c
> +++ b/drivers/gpio/pca953x.c
> @@ -39,6 +39,7 @@ static const struct i2c_device_id pca953x_id[] = {
> ? ? ? ?{ "pca9557", 8, },
>
> ? ? ? ?{ "max7310", 8, },
> + ? ? ? { "max7312", 16, },
> ? ? ? ?{ "max7315", 8, },
> ? ? ? ?{ "pca6107", 8, },
> ? ? ? ?{ "tca6408", 8, },
> --
> 1.5.4.3
>

rebased

From: Jun Nie <njun@marvell.com>
Date: Tue, 17 Nov 2009 19:49:19 +0800
Subject: [PATCH] pxa: add gpio expander on pxa168 aspenite platform

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c |   46 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/pca953x.c       |    1 +
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 4562452..cc211d2 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -13,7 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/smc91x.h>
+#include <linux/i2c/pca953x.h>

+#include <video/pxa168fb.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
@@ -23,6 +25,10 @@

 #include "common.h"

+/*used by expander max7312, 16 pins gpio expander */
+#define GPIO_EXT0(x)		(NR_BUILTIN_GPIO + (x))
+#define GPIO_EXT1(x)		(NR_BUILTIN_GPIO + 16 + (x))
+
 static unsigned long common_pin_config[] __initdata = {
 	/* Data Flash Interface */
 	GPIO0_DFI_D15,
@@ -85,12 +91,52 @@ static struct platform_device smc91x_device = {
 	.resource	= smc91x_resources,
 };

+static struct i2c_pxa_platform_data pwri2c_info __initdata = {
+	.use_pio		= 1,
+};
+
+#if defined(CONFIG_GPIO_PCA953X)
+/* GPIO expander max7312 could reuse PCA953X */
+static struct pca953x_platform_data max7312_data[] = {
+	/* two max7312 in system */
+
+	[0] = {
+		.gpio_base      = GPIO_EXT0(0),
+	},
+
+	[1] = {
+		.gpio_base      = GPIO_EXT1(0),
+	},
+};
+#endif
+
+static struct i2c_board_info aspenite_i2c_board_info[] = {
+
+#if defined(CONFIG_GPIO_PCA953X)
+	{
+		.type           = "max7312",
+		.addr           = 0x10,                 /* 0x20/0x21 */
+		.irq            = IRQ_GPIO(122),
+		.platform_data  = &max7312_data[0],
+	},
+
+	{
+		.type           = "max7312",
+		.addr           = 0x20,                 /* 0x40/0x41 */
+		.irq            = IRQ_GPIO(120),
+		.platform_data  = &max7312_data[1],
+	},
+#endif
+};
+
 static void __init common_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(common_pin_config));

 	/* on-chip devices */
 	pxa168_add_uart(1);
+	pxa168_add_twsi(0, &pwri2c_info,
+			ARRAY_AND_SIZE(aspenite_i2c_board_info));

 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 6a2fb3f..7822684 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -39,6 +39,7 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "pca9557", 8, },

 	{ "max7310", 8, },
+	{ "max7312", 16, },
 	{ "max7315", 8, },
 	{ "pca6107", 8, },
 	{ "tca6408", 8, },
-- 
1.5.4.3
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0006-pxa-add-gpio-expander-on-pxa168-aspenite-platform.patch
Type: text/x-diff
Size: 2693 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091119/e56c296f/attachment-0001.bin>
