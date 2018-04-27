From: david@lechnology.com (David Lechner)
Date: Thu, 26 Apr 2018 20:39:49 -0500
Subject: [PATCH 1/4] ARM: davinci: board-da830-evm: fix GPIO lookup for
 MMC/SD
In-Reply-To: <20180424143506.25793-2-nsekhar@ti.com>
References: <20180424143506.25793-1-nsekhar@ti.com>
 <20180424143506.25793-2-nsekhar@ti.com>
Message-ID: <fdc2aa31-de60-d44b-2ae6-ba5b52ef0360@lechnology.com>
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
> Fixes: b5e1438cf98a ("ARM: davinci: da830-evm: use gpio descriptor for mmc pins")
> Reported-by: David Lechner <david@lechnology.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>   arch/arm/mach-davinci/board-da830-evm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index 004f9c8de032..d1e8ce7b4bd2 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -205,12 +205,17 @@ static const short da830_evm_mmc_sd_pins[] = {
>   	-1
>   };
>   
> +#define DA830_MMCSD_WP_PIN		GPIO_TO_PIN(2, 1)
> +#define DA830_MMCSD_CD_PIN		GPIO_TO_PIN(2, 2)
> +
>   static struct gpiod_lookup_table mmc_gpios_table = {
>   	.dev_id = "da830-mmc.0",
>   	.table = {
>   		/* gpio chip 1 contains gpio range 32-63 */
> -		GPIO_LOOKUP("davinci_gpio.1", 2, "cd", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("davinci_gpio.1", 1, "wp", GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("davinci_gpio.0", DA830_MMCSD_CD_PIN, "cd",
> +			    GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("davinci_gpio.0", DA830_MMCSD_WP_PIN, "wp",
> +			    GPIO_ACTIVE_LOW),
>   	},
>   };
>   
> 

Reviewed-by: David Lechner <david@lechnology.com>
