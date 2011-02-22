From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 22 Feb 2011 08:59:16 +0200
Subject: [PATCH 4/6] ARM: tegra: harmony: register sdhci devices
In-Reply-To: <1298354117-19097-5-git-send-email-olof@lixom.net>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-5-git-send-email-olof@lixom.net>
Message-ID: <4D635EC4.2030102@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
Sorry for jumping late, haven't thought about the proposal below yesterday.
I'm not objecting to applying the patch as is, we can refactor the code
afterwards as well.

On 02/22/11 07:55, Olof Johansson wrote:
> Add the 3 sdhci devices that are available on Harmony as
> platform devices. Two go to slots (one 4-lane, one 8-lane),
> and one goes to onboard wifi.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/mach-tegra/board-harmony.c |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
> index f6ad58b..7010774 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -30,10 +30,13 @@
>  
>  #include <mach/iomap.h>
>  #include <mach/irqs.h>
> +#include <mach/sdhci.h>
>  
>  #include "board.h"
>  #include "board-harmony.h"
>  #include "clock.h"
> +#include "devices.h"
> +#include "gpio-names.h"
>  
>  static struct plat_serial8250_port debug_uart_platform_data[] = {
>  	{
> @@ -59,6 +62,9 @@ static struct platform_device debug_uart = {
>  
>  static struct platform_device *harmony_devices[] __initdata = {
>  	&debug_uart,
> +	&tegra_sdhci_device1,
> +	&tegra_sdhci_device2,
> +	&tegra_sdhci_device4,
>  };
>  
>  static void __init tegra_harmony_fixup(struct machine_desc *desc,
> @@ -77,6 +83,26 @@ static __initdata struct tegra_clk_init_table harmony_clk_init_table[] = {
>  	{ NULL,		NULL,		0,		0},
>  };
>  
> +
> +static struct tegra_sdhci_platform_data sdhci_pdata1 = {
> +	.cd_gpio	= -1,
> +	.wp_gpio	= -1,
> +	.power_gpio	= -1,
> +};
> +
> +static struct tegra_sdhci_platform_data sdhci_pdata2 = {
> +	.cd_gpio	= TEGRA_GPIO_PI5,
> +	.wp_gpio	= TEGRA_GPIO_PH1,
> +	.power_gpio	= TEGRA_GPIO_PT3,
> +};
> +
> +static struct tegra_sdhci_platform_data sdhci_pdata4 = {
> +	.cd_gpio	= TEGRA_GPIO_PH2,
> +	.wp_gpio	= TEGRA_GPIO_PH3,
> +	.power_gpio	= TEGRA_GPIO_PI6,
> +	.is_8bit	= 1,
> +};
> +
>  static void __init tegra_harmony_init(void)
>  {
>  	tegra_common_init();
> @@ -85,6 +111,10 @@ static void __init tegra_harmony_init(void)
>  
>  	harmony_pinmux_init();
>  
> +	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
> +	tegra_sdhci_device2.dev.platform_data = &sdhci_pdata2;
> +	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
> +

I think that instead of copying explicit initialization of the platform_data
member from board to board we can do something similar to what PXA does. The
board file would have to call something like
tegra_set_device_X_info(struct tegra_device_X_platform_data *data);
and then static registration of platform devices in the board files can be dropped.

For instance, the devices.c would have

void __init tegra_register_device(struct platform_device *dev, void *data)
{
	int ret;

	dev->dev.platform_data = data;

	ret = platform_device_register(dev);
	if (ret)
		dev_err(&dev->dev, "unable to register device: %d\n", ret);
}

void __init tegra_set_sdhci1_info(struct tegra_sdhci_platform_data *info)
{
	tegra_register_device(&tegra_sdhci_device1, info);
}

and the board files would just call tegra_set_sdhci1_info to pass the platform
data for the tegra_sdhci_device1 and register the device.

This way we could reduce amount of copy/paste between the board files. Besides,
if/when tegra will be using device trees, handling of the device registration in
common place would make the transition easier.

>  	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
>  }
>  


-- 
Sincerely yours,
Mike.
