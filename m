From: kmpark@infradead.org (Kyungmin Park)
Date: Sun, 22 Aug 2010 11:04:26 +0900
Subject: [PATCH 3/3] ARM: S5PV310: Add support HSMMC on SMDKC210 and
	SMDKV310
In-Reply-To: <1282307628-5254-4-git-send-email-kgene.kim@samsung.com>
References: <1282307628-5254-1-git-send-email-kgene.kim@samsung.com>
	<1282307628-5254-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTikmL_mLpmQsmCo0N_fb9hUQR0sE1DFwwEPYr9_R@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 20, 2010 at 9:33 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> From: Hyuk Lee <hyuk1.lee@samsung.com>
>
> This patch adds support HSMMC on SMDKC210 and SMDKV310, and adds
> setup functions for it. S5PV310/S5PC210 can support 4 hsmmc such
> as hsmmc0, hsmmc1, hsmmc2 and hsmmc3.
>
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-s5pv310/Kconfig ? ? ? ? ? ? ?| ? 21 ++++
> ?arch/arm/mach-s5pv310/Makefile ? ? ? ? ? ? | ? ?2 +
> ?arch/arm/mach-s5pv310/cpu.c ? ? ? ? ? ? ? ?| ? ?8 ++
> ?arch/arm/mach-s5pv310/mach-smdkc210.c ? ? ?| ? 50 ++++++++++
> ?arch/arm/mach-s5pv310/mach-smdkv310.c ? ? ?| ? 50 ++++++++++
> ?arch/arm/mach-s5pv310/setup-sdhci-gpio.c ? | ?141 ++++++++++++++++++++++++++++
> ?arch/arm/mach-s5pv310/setup-sdhci.c ? ? ? ?| ? 56 +++++++++++
> ?arch/arm/plat-samsung/include/plat/sdhci.h | ? 58 +++++++++++
> ?8 files changed, 386 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> ?create mode 100644 arch/arm/mach-s5pv310/setup-sdhci.c
>
> diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
> index 9ac29fe..bebad32 100644
> --- a/arch/arm/mach-s5pv310/Kconfig
> +++ b/arch/arm/mach-s5pv310/Kconfig
> @@ -25,6 +25,17 @@ config S5PV310_SETUP_I2C2
> ? ? ? ?help
> ? ? ? ? ?Common setup code for i2c bus 2.
>
> +config S5PV310_SETUP_SDHCI
> + ? ? ? bool
> + ? ? ? select S5PV310_SETUP_SDHCI_GPIO
> + ? ? ? help
> + ? ? ? ? Internal helper functions for S5PV310 based SDHCI systems.
> +
> +config S5PV310_SETUP_SDHCI_GPIO
> + ? ? ? bool
> + ? ? ? help
> + ? ? ? ? Common setup code for SDHCI GPIO.
> +
> ?# machine support
>
> ?menu "S5PC210 Machines"
> @@ -33,6 +44,11 @@ config MACH_SMDKC210
> ? ? ? ?bool "SMDKC210"
> ? ? ? ?select CPU_S5PV310
> ? ? ? ?select ARCH_SPARSEMEM_ENABLE
> + ? ? ? select S3C_DEV_HSMMC
> + ? ? ? select S3C_DEV_HSMMC1
> + ? ? ? select S3C_DEV_HSMMC2
> + ? ? ? select S3C_DEV_HSMMC3
> + ? ? ? select S5PV310_SETUP_SDHCI
> ? ? ? ?help
> ? ? ? ? ?Machine support for Samsung SMDKC210
> ? ? ? ? ?S5PC210(MCP) is one of package option of S5PV310
> @@ -53,6 +69,11 @@ config MACH_SMDKV310
> ? ? ? ?bool "SMDKV310"
> ? ? ? ?select CPU_S5PV310
> ? ? ? ?select ARCH_SPARSEMEM_ENABLE
> + ? ? ? select S3C_DEV_HSMMC
> + ? ? ? select S3C_DEV_HSMMC1
> + ? ? ? select S3C_DEV_HSMMC2
> + ? ? ? select S3C_DEV_HSMMC3
> + ? ? ? select S5PV310_SETUP_SDHCI
> ? ? ? ?help
> ? ? ? ? ?Machine support for Samsung SMDKV310
>
> diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
> index aefb14f..c89b6b0 100644
> --- a/arch/arm/mach-s5pv310/Makefile
> +++ b/arch/arm/mach-s5pv310/Makefile
> @@ -29,3 +29,5 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210) ? ? += mach-universal_c210.o
>
> ?obj-$(CONFIG_S5PV310_SETUP_I2C1) ? ? ? += setup-i2c1.o
> ?obj-$(CONFIG_S5PV310_SETUP_I2C2) ? ? ? += setup-i2c2.o
> +obj-$(CONFIG_S5PV310_SETUP_SDHCI) ? ? ?+= setup-sdhci.o
> +obj-$(CONFIG_S5PV310_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
> diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
> index db4f55a..3514e87 100644
> --- a/arch/arm/mach-s5pv310/cpu.c
> +++ b/arch/arm/mach-s5pv310/cpu.c
> @@ -19,6 +19,7 @@
> ?#include <plat/cpu.h>
> ?#include <plat/clock.h>
> ?#include <plat/s5pv310.h>
> +#include <plat/sdhci.h>
>
> ?#include <mach/regs-irq.h>
>
> @@ -73,6 +74,13 @@ static void s5pv310_idle(void)
> ?void __init s5pv310_map_io(void)
> ?{
> ? ? ? ?iotable_init(s5pv310_iodesc, ARRAY_SIZE(s5pv310_iodesc));
> +
> + ? ? ? /* initialize device information early */
> +
> + ? ? ? s5pv310_default_sdhci0();
> + ? ? ? s5pv310_default_sdhci1();
> + ? ? ? s5pv310_default_sdhci2();
> + ? ? ? s5pv310_default_sdhci3();
> ?}
>
> ?void __init s5pv310_init_clocks(int xtal)
> diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
> index 71a3bec..52c85de 100644
> --- a/arch/arm/mach-s5pv310/mach-smdkc210.c
> +++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
> @@ -9,6 +9,7 @@
> ?*/
>
> ?#include <linux/serial_core.h>
> +#include <linux/gpio.h>
>
> ?#include <asm/mach/arch.h>
> ?#include <asm/mach-types.h>
> @@ -16,7 +17,9 @@
>
> ?#include <plat/regs-serial.h>
> ?#include <plat/s5pv310.h>
> +#include <plat/devs.h>
> ?#include <plat/cpu.h>
> +#include <plat/sdhci.h>
>
> ?#include <mach/map.h>
>
> @@ -65,6 +68,49 @@ static struct s3c2410_uartcfg smdkc210_uartcfgs[] __initdata = {
> ? ? ? ?},
> ?};
>
> +static struct s3c_sdhci_platdata smdkc210_hsmmc0_pdata __initdata = {
> + ? ? ? .max_width ? ? ? ? ? ? ?= 4,
> + ? ? ? .cd_type ? ? ? ? ? ? ? ?= S3C_SDHCI_CD_GPIO,
> + ? ? ? .ext_cd_gpio ? ? ? ? ? ?= S5PV310_GPK0(2),
> + ? ? ? .ext_cd_gpio_invert ? ? = 1,
> +};
> +
> +static struct s3c_sdhci_platdata smdkc210_hsmmc1_pdata __initdata = {
> + ? ? ? .max_width ? ? ? ? ? ? ?= 4,
> + ? ? ? .cd_type ? ? ? ? ? ? ? ?= S3C_SDHCI_CD_GPIO,
> + ? ? ? .ext_cd_gpio ? ? ? ? ? ?= S5PV310_GPK0(2),
> + ? ? ? .ext_cd_gpio_invert ? ? = 1,
> +};
> +
> +static struct s3c_sdhci_platdata smdkc210_hsmmc2_pdata __initdata = {
> + ? ? ? .max_width ? ? ? ? ? ? ?= 4,
> + ? ? ? .cd_type ? ? ? ? ? ? ? ?= S3C_SDHCI_CD_GPIO,
> + ? ? ? .ext_cd_gpio ? ? ? ? ? ?= S5PV310_GPK2(2),
> + ? ? ? .ext_cd_gpio_invert ? ? = 1,
> +};
> +
> +static struct s3c_sdhci_platdata smdkc210_hsmmc3_pdata __initdata = {
> + ? ? ? .max_width ? ? ? ? ? ? ?= 4,
> + ? ? ? .cd_type ? ? ? ? ? ? ? ?= S3C_SDHCI_CD_GPIO,
> + ? ? ? .ext_cd_gpio ? ? ? ? ? ?= S5PV310_GPK2(2),
> + ? ? ? .ext_cd_gpio_invert ? ? = 1,
> +};
> +
> +static void smdkc210_setup_sdhci(void)
> +{
> + ? ? ? s3c_sdhci0_set_platdata(&smdkc210_hsmmc0_pdata);
> + ? ? ? s3c_sdhci1_set_platdata(&smdkc210_hsmmc1_pdata);
> + ? ? ? s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
> + ? ? ? s3c_sdhci3_set_platdata(&smdkc210_hsmmc3_pdata);
> +}
> +
> +static struct platform_device *smdkc210_devices[] __initdata = {
> + ? ? ? &s3c_device_hsmmc0,
> + ? ? ? &s3c_device_hsmmc1,
> + ? ? ? &s3c_device_hsmmc2,
> + ? ? ? &s3c_device_hsmmc3,
> +};
> +
> ?static void __init smdkc210_map_io(void)
> ?{
> ? ? ? ?s5p_init_io(NULL, 0, S5P_VA_CHIPID);
> @@ -77,6 +123,10 @@ static void __init smdkc210_machine_init(void)
> ?#ifdef CONFIG_CACHE_L2X0
> ? ? ? ?l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
> ?#endif
> +
> + ? ? ? smdkc210_setup_sdhci();
> +
> + ? ? ? platform_add_devices(smdkc210_devices, ARRAY_SIZE(smdkc210_devices));
> ?}
>
> ?MACHINE_START(SMDKC210, "SMDKC210")
> diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
> index 0d6ab77..72f03ae 100644
> --- a/arch/arm/mach-s5pv310/mach-smdkv310.c
> +++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
> @@ -9,6 +9,7 @@
> ?*/
>
> ?#include <linux/serial_core.h>
> +#include <linux/gpio.h>
>
> ?#include <asm/mach/arch.h>
> ?#include <asm/mach-types.h>
> @@ -16,7 +17,9 @@
>
> ?#include <plat/regs-serial.h>
> ?#include <plat/s5pv310.h>
> +#include <plat/devs.h>
> ?#include <plat/cpu.h>
> +#include <plat/sdhci.h>
>
> ?#include <mach/map.h>
>
> @@ -65,6 +68,49 @@ static struct s3c2410_uartcfg smdkv310_uartcfgs[] __initdata = {
> ? ? ? ?},
> ?};
>
> +static struct s3c_sdhci_platdata smdkv310_hsmmc0_pdata __initdata = {
> + ? ? ? .max_width ? ? ? ? ? ? ?= 4,
> + ? ? ? .cd_type ? ? ? ? ? ? ? ?= S3C_SDHCI_CD_GPIO,
> + ? ? ? .ext_cd_gpio ? ? ? ? ? ?= S5PV310_GPK0(2),
> + ? ? ? .ext_cd_gpio_invert ? ? = 1,
> +};
> +
> +static struct s3c_sdhci_platdata smdkv310_hsmmc1_pdata __initdata = {
> + ? ? ? .max_width ? ? ? ? ? ? ?= 4,
> + ? ? ? .cd_type ? ? ? ? ? ? ? ?= S3C_SDHCI_CD_GPIO,
> + ? ? ? .ext_cd_gpio ? ? ? ? ? ?= S5PV310_GPK0(2),
> + ? ? ? .ext_cd_gpio_invert ? ? = 1,
> +};
> +
> +static struct s3c_sdhci_platdata smdkv310_hsmmc2_pdata __initdata = {
> + ? ? ? .max_width ? ? ? ? ? ? ?= 4,
> + ? ? ? .cd_type ? ? ? ? ? ? ? ?= S3C_SDHCI_CD_GPIO,
> + ? ? ? .ext_cd_gpio ? ? ? ? ? ?= S5PV310_GPK2(2),
> + ? ? ? .ext_cd_gpio_invert ? ? = 1,
> +};
> +
> +static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
> + ? ? ? .max_width ? ? ? ? ? ? ?= 4,
> + ? ? ? .cd_type ? ? ? ? ? ? ? ?= S3C_SDHCI_CD_GPIO,
> + ? ? ? .ext_cd_gpio ? ? ? ? ? ?= S5PV310_GPK2(2),
> + ? ? ? .ext_cd_gpio_invert ? ? = 1,
> +};
> +
> +static void smdkv310_setup_sdhci(void)
> +{
> + ? ? ? s3c_sdhci0_set_platdata(&smdkv310_hsmmc0_pdata);
> + ? ? ? s3c_sdhci1_set_platdata(&smdkv310_hsmmc1_pdata);
> + ? ? ? s3c_sdhci2_set_platdata(&smdkv310_hsmmc2_pdata);
> + ? ? ? s3c_sdhci3_set_platdata(&smdkv310_hsmmc3_pdata);
> +}
> +
> +static struct platform_device *smdkv310_devices[] __initdata = {
> + ? ? ? &s3c_device_hsmmc0,
> + ? ? ? &s3c_device_hsmmc1,
> + ? ? ? &s3c_device_hsmmc2,
> + ? ? ? &s3c_device_hsmmc3,
> +};
> +
> ?static void __init smdkv310_map_io(void)
> ?{
> ? ? ? ?s5p_init_io(NULL, 0, S5P_VA_CHIPID);
> @@ -77,6 +123,10 @@ static void __init smdkv310_machine_init(void)
> ?#ifdef CONFIG_CACHE_L2X0
> ? ? ? ?l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
> ?#endif
> +
> + ? ? ? smdkv310_setup_sdhci();
> +
> + ? ? ? platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
> ?}
>
> ?MACHINE_START(SMDKV310, "SMDKV310")
> diff --git a/arch/arm/mach-s5pv310/setup-sdhci-gpio.c b/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> new file mode 100644
> index 0000000..96332d9
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> @@ -0,0 +1,141 @@
> +/* linux/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
> + *
> + * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
> + * ? ? ? ? ? ? http://www.samsung.com
> + *
> + * S5PV310 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
> +
> +#include <mach/map.h>
> +
> +#include <plat/gpio-cfg.h>
> +#include <plat/regs-sdhci.h>
> +#include <plat/sdhci.h>
> +
> +#define S5PV310_GPK0DRV ? ? ? ? ? ? ? ?(S5P_VA_GPIO2 + 0x4C)
> +#define S5PV310_GPK1DRV ? ? ? ? ? ? ? ?(S5P_VA_GPIO2 + 0x6C)
> +#define S5PV310_GPK2DRV ? ? ? ? ? ? ? ?(S5P_VA_GPIO2 + 0x8C)
> +#define S5PV310_GPK3DRV ? ? ? ? ? ? ? ?(S5P_VA_GPIO2 + 0xAC)

As I know there are the driver strength function. please use it.
Related with VA_GPIOx I will comment it at different patch.
> +
> +void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
> +{
> + ? ? ? unsigned int gpio;
> +
> + ? ? ? /* Set all the necessary GPK0[0:1] pins to special-function 2 */
> + ? ? ? for (gpio = S5PV310_GPK0(0); gpio < S5PV310_GPK0(2); gpio++) {
> + ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> + ? ? ? }
> +
> + ? ? ? switch (width) {
> + ? ? ? case 8:
> + ? ? ? ? ? ? ? /* GPK1[3:6] special-funtion 3 */
> + ? ? ? ? ? ? ? for (gpio = S5PV310_GPK1(3); gpio <= S5PV310_GPK1(6); gpio++) {
> + ? ? ? ? ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
> + ? ? ? ? ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> + ? ? ? ? ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? __raw_writel(0x3FC0, S5PV310_GPK1DRV);

Related with HSMMC, Anndrew and Ben want to know which functionality
support exactly at s5p series.
E.g., Why SDCLK is required. you can find these at mmc mailing list. I
also want to know why these driver strength is required.

> + ? ? ? case 4:
> + ? ? ? ? ? ? ? /* GPK0[3:6] special-funtion 2 */
> + ? ? ? ? ? ? ? for (gpio = S5PV310_GPK0(3); gpio <= S5PV310_GPK0(6); gpio++) {
> + ? ? ? ? ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + ? ? ? ? ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? __raw_writel(0x3FFF, S5PV310_GPK0DRV);
> + ? ? ? default:
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> +

Only set the CDn when internal only used
> + ? ? ? s3c_gpio_setpull(S5PV310_GPK0(2), S3C_GPIO_PULL_UP);
> + ? ? ? s3c_gpio_cfgpin(S5PV310_GPK0(2), S3C_GPIO_SFN(2));
> +}
> +
> +void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
> +{
> + ? ? ? unsigned int gpio;
> +
> + ? ? ? /* Set all the necessary GPK1[0:1] pins to special-function 2 */
> + ? ? ? for (gpio = S5PV310_GPK1(0); gpio < S5PV310_GPK1(2); gpio++) {
> + ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> + ? ? ? }
> +
> + ? ? ? /* Data pin GPK1[3:6] to special-function 2 */
> + ? ? ? for (gpio = S5PV310_GPK1(3); gpio <= S5PV310_GPK1(6); gpio++) {
> + ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> + ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> + ? ? ? }
> + ? ? ? __raw_writel(0x3FFF, S5PV310_GPK1DRV);
> +
> + ? ? ? s3c_gpio_setpull(S5PV310_GPK1(2), S3C_GPIO_PULL_UP);
> + ? ? ? s3c_gpio_cfgpin(S5PV310_GPK1(2), S3C_GPIO_SFN(2));
ditto
> +}
> +
> +void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
> +{
> + ? ? ? unsigned int gpio;
> +
> + ? ? ? /* Set all the necessary GPK2[0:1] pins to special-function 2 */
> + ? ? ? for (gpio = S5PV310_GPK2(0); gpio < S5PV310_GPK2(2); gpio++) {
> + ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> + ? ? ? }
> +
> + ? ? ? switch (width) {
> + ? ? ? case 8:
> + ? ? ? ? ? ? ? /* Data pin GPK3[3:6] to special-function 3 */
> + ? ? ? ? ? ? ? for (gpio = S5PV310_GPK3(3); gpio <= S5PV310_GPK3(6); gpio++) {
> + ? ? ? ? ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
> + ? ? ? ? ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? __raw_writel(0x3FC0, S5PV310_GPK3DRV);
> + ? ? ? case 4:
> + ? ? ? ? ? ? ? /* Data pin GPK2[3:6] to special-function 2 */
> + ? ? ? ? ? ? ? for (gpio = S5PV310_GPK2(3); gpio <= S5PV310_GPK2(6); gpio++) {
> + ? ? ? ? ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + ? ? ? ? ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? __raw_writel(0x3FFF, S5PV310_GPK2DRV);
> + ? ? ? default:
> + ? ? ? ? ? ? ? break;
> + ? ? ? }
> +
> + ? ? ? s3c_gpio_setpull(S5PV310_GPK2(2), S3C_GPIO_PULL_UP);
> + ? ? ? s3c_gpio_cfgpin(S5PV310_GPK2(2), S3C_GPIO_SFN(2));
ditto
> +}
> +
> +void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
> +{
> + ? ? ? unsigned int gpio;
> +
> + ? ? ? /* Set all the necessary GPK3[0:1] pins to special-function 2 */
> + ? ? ? for (gpio = S5PV310_GPK3(0); gpio < S5PV310_GPK3(2); gpio++) {
> + ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> + ? ? ? }
> +
> + ? ? ? /* Data pin GPK3[3:6] to special-function 2 */
> + ? ? ? for (gpio = S5PV310_GPK3(3); gpio <= S5PV310_GPK3(6); gpio++) {
> + ? ? ? ? ? ? ? s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> + ? ? ? ? ? ? ? s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
> + ? ? ? }
> + ? ? ? __raw_writel(0x3FFF, S5PV310_GPK3DRV);
> +
> + ? ? ? s3c_gpio_setpull(S5PV310_GPK3(2), S3C_GPIO_PULL_UP);
> + ? ? ? s3c_gpio_cfgpin(S5PV310_GPK3(2), S3C_GPIO_SFN(2));
ditto
> +}
> diff --git a/arch/arm/mach-s5pv310/setup-sdhci.c b/arch/arm/mach-s5pv310/setup-sdhci.c
> new file mode 100644
> index 0000000..f7750ca
> --- /dev/null
> +++ b/arch/arm/mach-s5pv310/setup-sdhci.c
> @@ -0,0 +1,56 @@
> +/* linux/arch/arm/mach-s5pv310/setup-sdhci.c
> + *
> + * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
> + * ? ? ? ? ? ? http://www.samsung.com
> + *
> + * S5PV310 - Helper functions for settign up SDHCI device(s) (HSMMC)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +
> +#include <plat/regs-sdhci.h>
> +#include <plat/sdhci.h>
> +
> +/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
> +
> +char *s5pv310_hsmmc_clksrcs[4] = {
> + ? ? ? [2] = "sclk_mmc", ? ? ? /* mmc_bus */
> +};
> +
> +void s5pv310_setup_sdhci_cfg_card(struct platform_device *dev, void __iomem *r,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct mmc_ios *ios, struct mmc_card *card)
> +{
> + ? ? ? u32 ctrl2, ctrl3;
> +
> + ? ? ? /* don't need to alter anything acording to card-type */
> +
> + ? ? ? ctrl2 = __raw_readl(r + S3C_SDHCI_CONTROL2);
> + ? ? ? ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> + ? ? ? ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> + ? ? ? ? ? ? ? ? S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> + ? ? ? ? ? ? ? ? S3C_SDHCI_CTRL2_ENFBCLKRX |
> + ? ? ? ? ? ? ? ? S3C_SDHCI_CTRL2_DFCNT_NONE |
> + ? ? ? ? ? ? ? ? S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> +
> + ? ? ? if (ios->clock < 25 * 1000000)
> + ? ? ? ? ? ? ? ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
> + ? ? ? ? ? ? ? ? ? ? ? ?S3C_SDHCI_CTRL3_FCSEL2 |
> + ? ? ? ? ? ? ? ? ? ? ? ?S3C_SDHCI_CTRL3_FCSEL1 |
> + ? ? ? ? ? ? ? ? ? ? ? ?S3C_SDHCI_CTRL3_FCSEL0);
> + ? ? ? else
> + ? ? ? ? ? ? ? ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
It's from s3c64xx code. Can you explain why these set is needed?
> +
> + ? ? ? __raw_writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> + ? ? ? __raw_writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> +}
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
> index 30844c2..a804733 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -110,6 +110,10 @@ extern void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
> ?extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
> ?extern void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
> ?extern void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
> +extern void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
> +extern void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
> +extern void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
> +extern void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
>
> ?/* S3C64XX SDHCI setup */
>
> @@ -288,4 +292,58 @@ static inline void s5pv210_default_sdhci3(void) { }
>
> ?#endif /* CONFIG_S5PV210_SETUP_SDHCI */
>
> +/* S5PV310 SDHCI setup */
> +
> +#ifdef CONFIG_S5PV310_SETUP_SDHCI
> +extern char *s5pv310_hsmmc_clksrcs[4];
> +
> +extern void s5pv310_setup_sdhci_cfg_card(struct platform_device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?void __iomem *r,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct mmc_ios *ios,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct mmc_card *card);
> +
> +static inline void s5pv310_default_sdhci0(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC
> + ? ? ? s3c_hsmmc0_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
> + ? ? ? s3c_hsmmc0_def_platdata.cfg_gpio = s5pv310_setup_sdhci0_cfg_gpio;
> + ? ? ? s3c_hsmmc0_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
> +#endif
> +}
> +
> +static inline void s5pv310_default_sdhci1(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC1
> + ? ? ? s3c_hsmmc1_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
> + ? ? ? s3c_hsmmc1_def_platdata.cfg_gpio = s5pv310_setup_sdhci1_cfg_gpio;
> + ? ? ? s3c_hsmmc1_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
> +#endif
> +}
> +
> +static inline void s5pv310_default_sdhci2(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC2
> + ? ? ? s3c_hsmmc2_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
> + ? ? ? s3c_hsmmc2_def_platdata.cfg_gpio = s5pv310_setup_sdhci2_cfg_gpio;
> + ? ? ? s3c_hsmmc2_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
> +#endif
> +}
> +
> +static inline void s5pv310_default_sdhci3(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC3
> + ? ? ? s3c_hsmmc3_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
> + ? ? ? s3c_hsmmc3_def_platdata.cfg_gpio = s5pv310_setup_sdhci3_cfg_gpio;
> + ? ? ? s3c_hsmmc3_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
> +#endif
> +}
> +
> +#else
> +static inline void s5pv310_default_sdhci0(void) { }
> +static inline void s5pv310_default_sdhci1(void) { }
> +static inline void s5pv310_default_sdhci2(void) { }
> +static inline void s5pv310_default_sdhci3(void) { }
> +
> +#endif /* CONFIG_S5PV310_SETUP_SDHCI */
> +
> ?#endif /* __PLAT_S3C_SDHCI_H */
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
