From: david@lechnology.com (David Lechner)
Date: Thu, 26 Apr 2018 20:40:48 -0500
Subject: [PATCH 2/4] ARM: davinci: board-da850-evm: fix GPIO lookup for
 MMC/SD
In-Reply-To: <20180424143506.25793-3-nsekhar@ti.com>
References: <20180424143506.25793-1-nsekhar@ti.com>
 <20180424143506.25793-3-nsekhar@ti.com>
Message-ID: <fa8feb04-2231-88b8-4d2b-10264187ba7e@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2018 09:35 AM, Sekhar Nori wrote:
> The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
> mmc can correctly lookup the wp and cp gpios. Also fix the GPIO numbers
> as they are not offsets within a bank.
> 
> Note that it is the gpio-davinci driver that sets the gpiochip label to
> davinci_gpio.0.
> 
> Fixes: bdf0e8364fd3 ("ARM: davinci: da850-evm: use gpio descriptor for mmc pins")
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>   arch/arm/mach-davinci/board-da850-evm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 3063478bcc36..158ed9a1483f 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -763,12 +763,17 @@ static const short da850_evm_mcasp_pins[] __initconst = {
>   	-1
>   };
>   
> +#define DA850_MMCSD_CD_PIN		GPIO_TO_PIN(4, 0)
> +#define DA850_MMCSD_WP_PIN		GPIO_TO_PIN(4, 1)
> +
>   static struct gpiod_lookup_table mmc_gpios_table = {
>   	.dev_id = "da830-mmc.0",
>   	.table = {
>   		/* gpio chip 2 contains gpio range 64-95 */
> -		GPIO_LOOKUP("davinci_gpio.2", 0, "cd", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("davinci_gpio.2", 1, "wp", GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_CD_PIN, "cd",
> +			    GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_WP_PIN, "wp",
> +			    GPIO_ACTIVE_LOW),
>   	},
>   };
>   
> 

Reviewed-by: David Lechner <david@lechnology.com>
