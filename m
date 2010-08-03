From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 3 Aug 2010 19:21:01 +0800
Subject: [PATCH 1/3] [ARM] pxa: Hookup MAX7312 thats connected to I2C.
In-Reply-To: <1280849830-5350-2-git-send-email-ssanap@marvell.com>
References: <1280849830-5350-1-git-send-email-ssanap@marvell.com>
	<1280849830-5350-2-git-send-email-ssanap@marvell.com>
Message-ID: <AANLkTi=U58n4q9sJ+t5=YyTC+sMo4QJ1XiqHEmuv8Odg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 3, 2010 at 11:37 PM, Sachin Sanap <ssanap@marvell.com> wrote:
> Signed-off-by: Sachin Sanap <ssanap@marvell.com>
> ---
> ?arch/arm/mach-mmp/aspenite.c | ? 31 +++++++++++++++++++++++++++++--
> ?1 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
> index 244655d..d19c26c 100644
> --- a/arch/arm/mach-mmp/aspenite.c
> +++ b/arch/arm/mach-mmp/aspenite.c
> @@ -23,9 +23,12 @@
> ?#include <mach/mfp-pxa168.h>
> ?#include <mach/pxa168.h>
> ?#include <mach/gpio.h>
> +#include <linux/i2c/pca953x.h>
>
> ?#include "common.h"
>
> +#define GPIO_EXT1(x) ? (128 + 16 + (x))
> +
> ?static unsigned long common_pin_config[] __initdata = {
> ? ? ? ?/* Data Flash Interface */
> ? ? ? ?GPIO0_DFI_D15,
> @@ -66,6 +69,11 @@ static unsigned long common_pin_config[] __initdata = {
> ? ? ? ?GPIO115_I2S_BCLK,
> ? ? ? ?GPIO116_I2S_RXD,
> ? ? ? ?GPIO117_I2S_TXD,
> +
> + ? ? ? /* i2c bus */
> + ? ? ? GPIO105_CI2C_SDA,
> + ? ? ? GPIO106_CI2C_SCL,
> +
> ?};
>
> ?static struct smc91x_platdata smc91x_info = {
> @@ -130,17 +138,36 @@ static struct pxa3xx_nand_platform_data aspenite_nand_info = {
> ? ? ? ?.nr_parts ? ? ? = ARRAY_SIZE(aspenite_nand_partitions),
> ?};
>
> -static struct i2c_board_info aspenite_i2c_info[] __initdata = {
> +#if defined(CONFIG_GPIO_PCA953X)
> +static struct pca953x_platform_data max7312_data[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .gpio_base ? ? ?= GPIO_EXT1(0),
> + ? ? ? },
> +};
> +#endif
> +
> +static struct i2c_board_info aspenite_pwri2c_info[] __initdata = {
> ? ? ? ?{ I2C_BOARD_INFO("wm8753", 0x1b), },
> ?};
>
> +static struct i2c_board_info aspenite_i2c_info[] __initdata = {
> +#if defined(CONFIG_GPIO_PCA953X)

correct form will be

#if defined(CONFIG_GPIO_PCA953X) || defined(CONFIG_GPIO_PCA953X_MODULE)

yet I doubt that's adding too much benefit except for saving
several bytes here. So I'd rather we don't introduce the #ifdef
here.

Otherwise looks good to me.

> + ? ? ? {
> + ? ? ? ? ? ? ? I2C_BOARD_INFO("max7312", 0x20),
> + ? ? ? ? ? ? ? .irq = IRQ_GPIO(120),
> + ? ? ? ? ? ? ? .platform_data ?= &max7312_data[0],
> + ? ? ? },
> +#endif
> +};
> +
> ?static void __init common_init(void)
> ?{
> ? ? ? ?mfp_config(ARRAY_AND_SIZE(common_pin_config));
>
> ? ? ? ?/* on-chip devices */
> ? ? ? ?pxa168_add_uart(1);
> - ? ? ? pxa168_add_twsi(1, NULL, ARRAY_AND_SIZE(aspenite_i2c_info));
> + ? ? ? pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(aspenite_i2c_info));
> + ? ? ? pxa168_add_twsi(1, NULL, ARRAY_AND_SIZE(aspenite_pwri2c_info));
> ? ? ? ?pxa168_add_ssp(1);
> ? ? ? ?pxa168_add_nand(&aspenite_nand_info);
>
> --
> 1.6.2.5
>
>
