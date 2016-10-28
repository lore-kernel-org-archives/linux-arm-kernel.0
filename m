From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 28 Oct 2016 17:40:10 +0530
Subject: [PATCH] ARM: davinci: enable PM for DT boot
In-Reply-To: <20161025214738.27744-1-khilman@baylibre.com>
References: <20161025214738.27744-1-khilman@baylibre.com>
Message-ID: <c3a69359-bcec-40fe-e25c-048b97bab726@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wednesday 26 October 2016 03:17 AM, Kevin Hilman wrote:
> Currently system PM is only enabled for legacy (non-DT) boot.  Enable
> for DT boot also.
> 
> Tested on da850-lcdk using "rtcwake -m mem -s5 -d rtc0".
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm/mach-davinci/da8xx-dt.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index c9f7e9274aa8..a8089fa40d86 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -43,8 +43,26 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>  
>  #ifdef CONFIG_ARCH_DAVINCI_DA850
>  
> +static struct davinci_pm_config da850_pm_pdata = {
> +	.sleepcount = 128,
> +};
> +
> +static struct platform_device da850_pm_device = {
> +	.name           = "pm-davinci",
> +	.dev = {
> +		.platform_data	= &da850_pm_pdata,
> +	},
> +	.id             = -1,
> +};
> +
>  static void __init da850_init_machine(void)
>  {
> +	int ret;
> +
> +	ret = da850_register_pm(&da850_pm_device);

I am not sure if it makes sense to keep the "pm device" around anymore.
I think for both DT and non-DT boot, we can get rid of the fake PM
device and combine da850_register_pm() and davinci_pm_probe() into a
single davinci_init_suspend() function which can then be called both for
DT and non-DT boot.

This was we can also avoid replication of the platform data and platform
device structures.

Thanks,
Sekhar
