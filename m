From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 13:54:39 +0000
Subject: [PATCH 5/7] mfd: menelaus: delete platform data support
In-Reply-To: <1419702779-16001-6-git-send-email-aaro.koskinen@iki.fi>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
 <1419702779-16001-6-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20150120135439.GN13701@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 27 Dec 2014, Aaro Koskinen wrote:

> Delete platform data support.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/mach-omap2/common-board-devices.h |  2 --
>  drivers/mfd/menelaus.c                     | 10 +---------
>  include/linux/mfd/menelaus.h               |  6 ------
>  3 files changed, 1 insertion(+), 17 deletions(-)

Applied, thanks.

> diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
> index 07c88ae..7a30228 100644
> --- a/arch/arm/mach-omap2/common-board-devices.h
> +++ b/arch/arm/mach-omap2/common-board-devices.h
> @@ -2,7 +2,6 @@
>  #define __OMAP_COMMON_BOARD_DEVICES__
>  
>  #include <sound/tlv320aic3x.h>
> -#include <linux/mfd/menelaus.h>
>  #include "twl-common.h"
>  
>  #define NAND_BLOCK_SIZE	SZ_128K
> @@ -14,7 +13,6 @@ void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
>  		       struct ads7846_platform_data *board_pdata);
>  void *n8x0_legacy_init(void);
>  
> -extern struct menelaus_platform_data n8x0_menelaus_platform_data;
>  extern struct aic3x_pdata n810_aic33_data;
>  
>  #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index 3e04c64..4a900cc 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -1181,8 +1181,6 @@ static int menelaus_probe(struct i2c_client *client,
>  	int			rev = 0;
>  	int			err = 0;
>  	struct device_node	*np = client->dev.of_node;
> -	struct menelaus_platform_data *menelaus_pdata =
> -					dev_get_platdata(&client->dev);
>  
>  	if (the_menelaus) {
>  		dev_dbg(&client->dev, "only one %s for now\n",
> @@ -1240,13 +1238,7 @@ static int menelaus_probe(struct i2c_client *client,
>  	else
>  		menelaus->vcore_hw_mode = 0;
>  
> -	if (menelaus_pdata != NULL) {
> -		if (menelaus_pdata->late_init != NULL) {
> -			err = menelaus_pdata->late_init(&client->dev);
> -			if (err < 0)
> -				goto fail;
> -		}
> -	} else if (np) {
> +	if (np) {
>  		u32 vcore_min;
>  		u32 vcore_max;
>  
> diff --git a/include/linux/mfd/menelaus.h b/include/linux/mfd/menelaus.h
> index 9e85ac0..21eeff5 100644
> --- a/include/linux/mfd/menelaus.h
> +++ b/include/linux/mfd/menelaus.h
> @@ -5,12 +5,6 @@
>  #ifndef __ASM_ARCH_MENELAUS_H
>  #define __ASM_ARCH_MENELAUS_H
>  
> -struct device;
> -
> -struct menelaus_platform_data {
> -	int (* late_init)(struct device *dev);
> -};
> -
>  extern int menelaus_register_mmc_callback(void (*callback)(void *data, u8 card_mask),
>  					  void *data);
>  extern void menelaus_unregister_mmc_callback(void);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
