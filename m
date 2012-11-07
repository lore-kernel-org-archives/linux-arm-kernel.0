From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Nov 2012 16:26:15 +0100
Subject: [PATCH 2/5] ARM: AT91SAM9G45: same platform data structure for
 all crypto peripherals
In-Reply-To: <1352219544-30416-1-git-send-email-nicolas@eukrea.com>
References: <1352219544-30416-1-git-send-email-nicolas@eukrea.com>
Message-ID: <20121107152615.GD4576@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:32 Tue 06 Nov     , Nicolas Royer wrote:
> Only AES use DMA in AT91SAM9G45 (TDES and SHA use PDC).
> 
> However latest Atmel TDES and SHA IP releases use DMA instead of PDC.
>   --> Atmel TDES and SHA drivers need DMA platform data for those IP releases.
> 
> Goal of this patch is to use the same platform data structure for all Atmel
> crypto peripherals. This structure contains information about DMA interface.
> 
> Signed-off-by: Nicolas Royer <nicolas@eukrea.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Eric B?nard <eric@eukrea.com>
> Tested-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/mach-at91/at91sam9g45_devices.c   |    8 ++++----
>  include/linux/platform_data/atmel-aes.h    |   22 ----------------------
>  include/linux/platform_data/crypto-atmel.h |   22 ++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 26 deletions(-)
>  delete mode 100644 include/linux/platform_data/atmel-aes.h
>  create mode 100644 include/linux/platform_data/crypto-atmel.h
> 
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index fcd233c..a48dcb4 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -18,7 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/i2c-gpio.h>
>  #include <linux/atmel-mci.h>
> -#include <linux/platform_data/atmel-aes.h>
> +#include <linux/platform_data/crypto-atmel.h>
>  
>  #include <linux/platform_data/at91_adc.h>
>  
> @@ -1900,7 +1900,7 @@ static void __init at91_add_device_tdes(void) {}
>   * -------------------------------------------------------------------- */
>  
>  #if defined(CONFIG_CRYPTO_DEV_ATMEL_AES) || defined(CONFIG_CRYPTO_DEV_ATMEL_AES_MODULE)
> -static struct aes_platform_data aes_data;
> +static struct crypto_platform_data aes_data;
>  static u64 aes_dmamask = DMA_BIT_MASK(32);
>  
>  static struct resource aes_resources[] = {
> @@ -1931,9 +1931,9 @@ static struct platform_device at91sam9g45_aes_device = {
>  static void __init at91_add_device_aes(void)
>  {
>  	struct at_dma_slave	*atslave;
> -	struct aes_dma_data	*alt_atslave;
> +	struct crypto_dma_data	*alt_atslave;
>  
> -	alt_atslave = kzalloc(sizeof(struct aes_dma_data), GFP_KERNEL);
> +	alt_atslave = kzalloc(sizeof(struct crypto_dma_data), GFP_KERNEL);
we do not check the result of kzalloc ouch

and why we allocate it?

Best Regards,
J.
J.
