From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 19 Oct 2009 20:15:39 -0400
Subject: [PATCH 16/46] davinci: Add MMC/SD support for DA830/OMAP-L137 EVM
In-Reply-To: <87my3nq6vl.fsf@deeprootsystems.com>
References: <1255720190-7452-9-git-send-email-khilman@deeprootsystems.com><1255720190-7452-10-git-send-email-khilman@deeprootsystems.com><1255720190-7452-11-git-send-email-khilman@deeprootsystems.com><1255720190-7452-12-git-send-email-khilman@deeprootsystems.com><1255720190-7452-13-git-send-email-khilman@deeprootsystems.com><1255720190-7452-14-git-send-email-khilman@deeprootsystems.com><1255720190-7452-15-git-send-email-khilman@deeprootsystems.com><1255720190-7452-16-git-send-email-khilman@deeprootsystems.com><1255720190-7452-17-git-send-email-khilman@deeprootsystems.com><1255720190-7452-18-git-send-email-khilman@deeprootsystems.com><20091019140752.GC13614@n2100.arm.linux.org.uk>
	<87my3nq6vl.fsf@deeprootsystems.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901E24748@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 19, 2009 4:52 PM, Kevin Hilman wrote:
> From 05e5376685ce71812ae8eb48115ce0d7fd8e0776 Mon Sep 17 00:00:00 2001
> From: David A. Griego <dgriego@mvista.com>
> Date: Tue, 15 Sep 2009 18:10:20 -0700
> Subject: [PATCH 16/46] davinci: Add MMC/SD support for DA830/OMAP-L137 EVM
> 
> Add pinmux settings, etc. to enable the MMC/SC hardware.
> 
> Signed-off-by: David A. Griego <dgriego@mvista.com>
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-davinci/board-da830-evm.c |   41 +++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index 39711c1..444029e 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -23,6 +23,7 @@
>  #include <mach/irqs.h>
>  #include <mach/cp_intc.h>
>  #include <mach/mux.h>
> +#include <mach/gpio.h>
>  #include <mach/da8xx.h>
>  #include <mach/asp.h>
>  
> @@ -83,6 +84,30 @@ static struct snd_platform_data da830_evm_snd_data = {
>  	.rxnumevt	= 1,
>  };
>  
> +/*
> + * GPIO2[1] is used as MMC_SD_WP and GPIO2[2] as MMC_SD_INS.
> + */
> +static const short da830_evm_mmc_sd_pins[] = {
> +	DA830_MMCSD_DAT_0, DA830_MMCSD_DAT_1, DA830_MMCSD_DAT_2,
> +	DA830_MMCSD_DAT_3, DA830_MMCSD_DAT_4, DA830_MMCSD_DAT_5,
> +	DA830_MMCSD_DAT_6, DA830_MMCSD_DAT_7, DA830_MMCSD_CLK,
> +	DA830_MMCSD_CMD,   DA830_GPIO2_1,     DA830_GPIO2_2,
> +	-1
> +};
> +
> +#define DA830_MMCSD_WP_PIN		GPIO_TO_PIN(2, 1)
> +
> +static int da830_evm_mmc_get_ro(int index)
> +{
> +	return gpio_get_value(DA830_MMCSD_WP_PIN);
> +}
> +
> +static struct davinci_mmc_config da830_evm_mmc_config = {
> +	.get_ro			= da830_evm_mmc_get_ro,
> +	.wires			= 4,
> +	.version		= MMC_CTLR_VERSION_2,
> +};
> +
>  static __init void da830_evm_init(void)
>  {
>  	struct davinci_soc_info *soc_info = &davinci_soc_info;
> @@ -132,6 +157,22 @@ static __init void da830_evm_init(void)
>  				ret);
>  
>  	da8xx_register_mcasp(1, &da830_evm_snd_data);
> +
> +	ret = da8xx_pinmux_setup(da830_evm_mmc_sd_pins);
> +	if (ret)
> +		pr_warning("da830_evm_init: mmc/sd mux setup failed: %d\n",
> +				ret);
> +
> +	ret = gpio_request(DA830_MMCSD_WP_PIN, "MMC WP");
> +	if (ret)
> +		pr_warning("da830_evm_init: can not open GPIO %d\n",
> +			   DA830_MMCSD_WP_PIN);
> +	gpio_direction_input(DA830_MMCSD_WP_PIN);
> +
> +	ret = da8xx_register_mmcsd0(&da830_evm_mmc_config);
> +	if (ret)
> +		pr_warning("da830_evm_init: mmc/sd registration failed: %d\n",
> +				ret);

If the da8xx_pinmux_setup or gpio_request fail is it still safe to do
the da8xx_register_mmcsd0?

Regards,
Hartley
