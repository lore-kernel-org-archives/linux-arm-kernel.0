From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Feb 2013 23:45:53 +0530
Subject: [PATCH V2 2/2] ARM: davinci: restart: fix wdt to machine restart
 with DT
In-Reply-To: <1360123204-9978-3-git-send-email-anilkumar.v@ti.com>
References: <1360123204-9978-1-git-send-email-anilkumar.v@ti.com>
 <1360123204-9978-3-git-send-email-anilkumar.v@ti.com>
Message-ID: <5113EF59.80508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2/6/2013 9:30 AM, Kumar, Anil wrote:
> In non DT case da8xx_register_watchdog() is called to register platform device
> "da8xx_wdt_device" by board file. But in DT case it is not called and wdt
> device get registered via wdt DT node.
> 
> Currently code is passing platform device "da8xx_wdt_device" in
> "davinci_watchdog_reset" function in both DT and non DT case and that
> leads to crash in DT boot.
> 
> Update restart function to make it generic DaVinci machine restart

s/DaVinci/da8xx. Also, subject can simply be "ARM: davinci: da850 DT:
add support for machine reboot" since reboot never worked with DT
before, "fix" isn't really appropriate.

> in case of DT and non DT boot.
> 
> Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
> ---
> :100644 100644 2d5502d... 1df68fd... M	arch/arm/mach-davinci/devices-da8xx.c
> :100644 100644 700d311... ef9f70e... M	arch/arm/mach-davinci/include/mach/da8xx.h
>  arch/arm/mach-davinci/devices-da8xx.c      |   14 ++++++++++++--
>  arch/arm/mach-davinci/include/mach/da8xx.h |    1 -
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index 2d5502d..1df68fd 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -359,7 +359,7 @@ static struct resource da8xx_watchdog_resources[] = {
>  	},
>  };
>  
> -struct platform_device da8xx_wdt_device = {
> +static struct platform_device da8xx_wdt_device = {

Making of da8xx_wdt_device static should find a mention in description.

>  	.name		= "watchdog",
>  	.id		= -1,
>  	.num_resources	= ARRAY_SIZE(da8xx_watchdog_resources),
> @@ -368,7 +368,17 @@ struct platform_device da8xx_wdt_device = {
>  
>  void da8xx_restart(char mode, const char *cmd)
>  {
> -	davinci_watchdog_reset(&da8xx_wdt_device);
> +	struct device *dev = NULL;
> +	struct platform_device *wdt_device = NULL;

No need to initialize these variables here.

> +
> +	dev = bus_find_device_by_name(&platform_bus_type, NULL, "watchdog");
> +	if (!dev) {
> +		pr_err("wdt device not found to machine reboot\n");

Rather: "%s: failed to find watchdog device", __func__

Thanks,
Sekhar
