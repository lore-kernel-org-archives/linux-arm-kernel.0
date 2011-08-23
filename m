From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 18:05:33 +0530
Subject: [PATCH v5 01/22] gpio/omap: remove dependency on gpio_bank_count
In-Reply-To: <1312455893-14922-2-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-2-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E539E95.2080807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> The gpio_bank_count is the count of number of GPIO devices in a SoC. Remove this
> dependency from the driver by using list. Also remove the dependency on array of
> pointers to gpio_bank struct of all GPIO devices.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
>   arch/arm/mach-omap1/gpio15xx.c         |    1 -
>   arch/arm/mach-omap1/gpio16xx.c         |    2 -
>   arch/arm/mach-omap1/gpio7xx.c          |    2 -
>   arch/arm/mach-omap2/gpio.c             |    1 -
>   arch/arm/plat-omap/include/plat/gpio.h |    3 -
>   drivers/gpio/gpio-omap.c               |  163 ++++++++++++++++----------------
>   6 files changed, 80 insertions(+), 92 deletions(-)
>

[...]

> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 34a7110..13d5ca4 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -28,7 +28,10 @@
>   #include<mach/gpio.h>
>   #include<asm/mach/irq.h>
>

[....]

> @@ -1334,17 +1325,17 @@ static int workaround_enabled;
>
>   void omap2_gpio_prepare_for_idle(int off_mode)
>   {
> -	int i, c = 0;
> -	int min = 0;
> -
> -	if (cpu_is_omap34xx())
> -		min = 1;
> +	int c = 0;
> +	struct gpio_bank *bank;
>
> -	for (i = min; i<  gpio_bank_count; i++) {
> -		struct gpio_bank *bank =&gpio_bank[i];
> +	list_for_each_entry(bank,&omap_gpio_list, node) {
>   		u32 l1 = 0, l2 = 0;
>   		int j;
>
> +		/* TODO: Do not use cpu_is_omap34xx */

Is this addressed in subsequent patches ?

> +		if ((cpu_is_omap34xx())&&  (bank->id == 0))
> +			continue;
> +

Rest of the changes looks good to me.
After you answer above, you can add my,
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
