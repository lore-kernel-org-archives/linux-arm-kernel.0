From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Dec 2013 11:25:32 +0800
Subject: [PATCH 3/3] Add support for the eukrea-cpuimx28.
In-Reply-To: <1386250086-4666-3-git-send-email-denis@eukrea.com>
References: <1386250086-4666-1-git-send-email-denis@eukrea.com>
 <1386250086-4666-3-git-send-email-denis@eukrea.com>
Message-ID: <20131209032530.GC825@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 02:28:06PM +0100, Denis Carikli wrote:
> From: Eric B?nard <eric@eukrea.com>

Please have a proper prefix for patch subject.

> 
> The following devices/functionalities were tested:
>  * Main UART.
>  * Ethernet0.
>  * Ethernet1.
>  * SD.
>  * USB host.
>  * USB otg.
>  * Display(and its backlight).
>  * Touchscreen.
>  * Audio.
>  * nand.
>  * i2c and the pcf8563 device.
>  * The gpio buttons.
>  * The gpio leds.
>  * Watchdog
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/boot/dts/Makefile                   |    2 +
>  arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts |   71 ++++++
>  arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts |   50 ++++
>  arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi |  326 ++++++++++++++++++++++++++
>  arch/arm/mach-mxs/mach-mxs.c                 |    8 +
>  5 files changed, 457 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
>  create mode 100644 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
>  create mode 100644 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi

<snip>

> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 02b17f7..3b5f57e 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -448,6 +448,12 @@ static int __init mxs_restart_init(void)
>  	return 0;
>  }
>  
> +static void __init eukrea_mbmx283lc_init(void)
> +{
> +	enable_clk_enet_out();

This shouldn't be needed since commit daa7d39 (net: freescale: fec: add
support for optional enet_out clk) and commit (f231a9f ARM: dts: mxs:
add enet_out clock to devicetree)

Shawn

> +	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
> +}
> +
>  static void __init mxs_machine_init(void)
>  {
>  	struct device_node *root;
> @@ -486,6 +492,8 @@ static void __init mxs_machine_init(void)
>  		apx4devkit_init();
>  	else if (of_machine_is_compatible("crystalfontz,cfa10036"))
>  		crystalfontz_init();
> +	else if (of_machine_is_compatible("eukrea,mbmx283lc"))
> +		eukrea_mbmx283lc_init();
>  	else if (of_machine_is_compatible("i2se,duckbill"))
>  		duckbill_init();
>  	else if (of_machine_is_compatible("msr,m28cu3"))
> -- 
> 1.7.9.5
> 
