From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jul 2011 14:15:41 -0700
Subject: [PATCH v3] davinci: Add wl1271/wlan support for AM18x
In-Reply-To: <1311886373-3060-1-git-send-email-ido@wizery.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CEC2@dbde02.ent.ti.com>
	<1311886373-3060-1-git-send-email-ido@wizery.com>
Message-ID: <4E31D17D.6050000@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/28/2011 1:52 PM, Ido Yariv wrote:
> The wl1271 daughter card for AM18x EVMs is a combo wireless connectivity
> add-on card, based on the LS Research TiWi module with Texas
> Instruments' wl1271 solution.
> It is a 4-wire, 1.8V, embedded SDIO WLAN device with an external IRQ
> line and is power-controlled by a GPIO-based fixed regulator.
> 
> Add support for the WLAN capabilities of this expansion board.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>
> ---
>  arch/arm/mach-davinci/Kconfig           |   10 +++
>  arch/arm/mach-davinci/board-da850-evm.c |  114 +++++++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> index c0deaca..32d837d 100644
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -192,6 +192,16 @@ config DA850_UI_RMII
>  
>  endchoice
>  
> +config DA850_WL12XX
> +	bool "AM18x wl1271 daughter board"
> +	depends on MACH_DAVINCI_DA850_EVM
> +	help
> +	  The wl1271 daughter card for AM18x EVMs is a combo wireless
> +	  connectivity add-on card, based on the LS Research TiWi module with
> +	  Texas Instruments' wl1271 solution.
> +	  Say Y if you want to use a wl1271 expansion card connected to the
> +	  AM18x EVM.
> +
>  config GPIO_PCA953X
>  	default MACH_DAVINCI_DA850_EVM
>  
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index bd53945..d817626 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -31,6 +31,8 @@
>  #include <linux/input/tps6507x-ts.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/flash.h>
> +#include <linux/delay.h>
> +#include <linux/wl12xx.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -49,6 +51,9 @@
>  #define DA850_MMCSD_CD_PIN		GPIO_TO_PIN(4, 0)
>  #define DA850_MMCSD_WP_PIN		GPIO_TO_PIN(4, 1)
>  
> +#define DA850_WLAN_EN			GPIO_TO_PIN(6, 9)
> +#define DA850_WLAN_IRQ			GPIO_TO_PIN(6, 10)
> +
>  #define DA850_MII_MDIO_CLKEN_PIN	GPIO_TO_PIN(2, 6)
>  
>  static struct mtd_partition da850evm_spiflash_part[] = {
> @@ -1117,6 +1122,110 @@ static __init int da850_evm_init_cpufreq(void)
>  static __init int da850_evm_init_cpufreq(void) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_DA850_WL12XX
> +
> +static void wl12xx_set_power(int index, bool power_on)
> +{
> +	static bool power_state;
> +
> +	pr_debug("Powering %s wl12xx", power_on ? "on" : "off");
> +
> +	if (power_on == power_state)
> +		return;
> +	power_state = power_on;
> +
> +	if (power_on) {
> +		/* Power up sequence required for wl127x devices */
> +		gpio_set_value(DA850_WLAN_EN, 1);
> +		usleep_range(15000, 15000);
> +		gpio_set_value(DA850_WLAN_EN, 0);
> +		usleep_range(1000, 1000);
> +		gpio_set_value(DA850_WLAN_EN, 1);
> +		msleep(70);


Why turn on, then off, and then back on?
Isn't off, then back on sufficient?

Also, why not use regulator API like panda board does?
