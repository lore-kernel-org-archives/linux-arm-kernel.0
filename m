From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 2 Apr 2012 16:45:11 +0200
Subject: [PATCH 1/5] ARM: mx53ard: Fix smsc911x driver probe
In-Reply-To: <1333373987-30459-1-git-send-email-fabio.estevam@freescale.com>
References: <1333373987-30459-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120402144511.GA3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Apr 02, 2012 at 10:39:43AM -0300, Fabio Estevam wrote:
> Fix smsc911x driver probe by adding a fixed dummy regulator.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

The series looks good, I applied it to my fixes branch. Unless no
objections to this one come up I'll send a pull request tomorrow. Please
check git://git.pengutronix.de/git/imx/linux-2.6.git imx-fixes and
let me know if I have missed something.

Sascha

> ---
>  arch/arm/mach-imx/mach-mx53_ard.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx53_ard.c b/arch/arm/mach-imx/mach-mx53_ard.c
> index 753f4fc..0564198 100644
> --- a/arch/arm/mach-imx/mach-mx53_ard.c
> +++ b/arch/arm/mach-imx/mach-mx53_ard.c
> @@ -23,6 +23,8 @@
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
>  #include <linux/smsc911x.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/fixed.h>
>  
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> @@ -214,6 +216,11 @@ static int weim_cs_config(void)
>  	return 0;
>  }
>  
> +static struct regulator_consumer_supply dummy_supplies[] = {
> +	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
> +	REGULATOR_SUPPLY("vddvario", "smsc911x"),
> +};
> +
>  void __init imx53_ard_common_init(void)
>  {
>  	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
> @@ -232,6 +239,7 @@ static void __init mx53_ard_board_init(void)
>  
>  	imx53_ard_common_init();
>  	mx53_ard_io_init();
> +	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  
>  	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
