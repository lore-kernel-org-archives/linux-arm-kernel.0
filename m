From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 Jul 2013 10:14:05 +0200
Subject: [PATCH 3/3] Added support for On Chip OTP in i.MX23/28
In-Reply-To: <1372855154-8422-4-git-send-email-cb@sgoc.de>
References: <1372855154-8422-1-git-send-email-cb@sgoc.de>
 <1372855154-8422-4-git-send-email-cb@sgoc.de>
Message-ID: <20130705081405.GH2959@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Wed, Jul 03, 2013 at 02:39:14PM +0200, Christoph G. Baumann wrote:
> From: "Christoph G. Baumann" <cb@sgoc.de>
> 
> Signed-off-by: Christoph G. Baumann <cb@sgoc.de>
> ---
>  arch/arm/boot/dts/imx28.dtsi |    1 -
>  drivers/clk/mxs/clk-imx23.c  |    2 ++
>  drivers/clk/mxs/clk-imx28.c  |    1 +
>  drivers/misc/Kconfig         |   14 ++++++++++++++
>  drivers/misc/Makefile        |    1 +
>  5 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 600f7cb..e9de86b 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -711,7 +711,6 @@
>  			ocotp at 8002c000 {
>  				compatible = "fsl,ocotp";
>  				reg = <0x8002c000 0x2000>;
> -				status = "disabled";
>  			};

Why do you enable it only for imx28?

>  			axi-ahb at 8002e000 {
> diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
> index f6a7487..ec76d00 100644
> --- a/drivers/clk/mxs/clk-imx23.c
> +++ b/drivers/clk/mxs/clk-imx23.c
> @@ -168,6 +168,8 @@ int __init mx23_clocks_init(void)
>  	clk_data.clk_num = ARRAY_SIZE(clks);
>  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>  
> +	clk_register_clkdev(clks[hbus], NULL, "hbus");
> +
>  	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
>  		clk_prepare_enable(clks[clks_init_on[i]]);
>  
> diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> index 4faf0af..792fcaf 100644
> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -247,6 +247,7 @@ int __init mx28_clocks_init(void)
>  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>  
>  	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
> +	clk_register_clkdev(clks[hbus], NULL, "hbus");
>  
>  	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
>  		clk_prepare_enable(clks[clks_init_on[i]]);

These two should go in a separate patch (with details on why it's
needed).

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index c002d86..b44ef48 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -527,6 +527,20 @@ config SRAM
>  	  the genalloc API. It is supposed to be used for small on-chip SRAM
>  	  areas found on many SoCs.
>  
> +config FSL_OTP
> +	tristate "Freescale On-Chip OTP Memory Support"
> +	depends on SOC_IMX23 || SOC_IMX28
> +	default n
> +	help
> +		If you say Y here, you will get support for a SysFS interface for
> +		the One Time Programmable memory pages that are stored on the
> +		iMX23/28 processor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called fsl_otp.
> +
> +	  If unsure, it is safe to say N.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index c235d5b..e622e01 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -53,3 +53,4 @@ obj-$(CONFIG_INTEL_MEI)		+= mei/
>  obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
>  obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
>  obj-$(CONFIG_SRAM)		+= sram.o
> +obj-$(CONFIG_FSL_OTP)           += fsl_otp.o

And this should be merged with the first patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130705/b1828b3d/attachment.sig>
