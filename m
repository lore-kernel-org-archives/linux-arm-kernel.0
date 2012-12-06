From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 06 Dec 2012 10:15:34 +0000
Subject: [PATCH v2] ARM: Exynos5250: Enabling dwc3-exynos driver
In-Reply-To: <1352363533-14970-2-git-send-email-gautam.vivek@samsung.com>
References: <1352363533-14970-1-git-send-email-gautam.vivek@samsung.com>
 <1352363533-14970-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20121206101534.A10123E05A4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 08 Nov 2012 14:02:13 +0530, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> Adding DWC3 device tree node for Exynos5250 along with the
> device address and clock support needed for the controller.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  .../devicetree/bindings/usb/exynos-usb.txt         |   14 +++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                  |    6 +++++
>  arch/arm/mach-exynos/Kconfig                       |    1 +
>  arch/arm/mach-exynos/clock-exynos5.c               |   24 ++++++++++++++++++++
>  arch/arm/mach-exynos/include/mach/map.h            |    1 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +
>  6 files changed, 48 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> index 5ff3def1..a7e3eaa 100644
> --- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> @@ -38,3 +38,17 @@ Example:
>  		reg = <0x12120000 0x100>;
>  		interrupts = <0 71 0>;
>  	};
> +
> +DWC3
> +Required properties:
> + - compatible: should be "samsung,exynos-dwc3" for USB 3.0 DWC3 controller.

Nit: Please use a specific chip in compatible strings. ie.
"samsung,exynos5250-dwc3". Newer parts using the same core can claim
compatibility by including the older string in the compatible list.

> + - reg: physical base address of the controller and length of memory mapped
> +   region.
> + - interrupts: interrupt number to the cpu.
> +
> +Example:
> +	usb at 12000000 {
> +		compatible = "samsung,exynos-dwc3";
> +		reg = <0x12000000 0x10000>;
> +		interrupts = <0 72 0>;
> +	};
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index f18abe0..d349636 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -68,6 +68,12 @@
>  		interrupts = <0 96 0>;
>  	};
>  
> +	usb at 12000000 {
> +		compatible = "samsung,exynos-dwc3";
> +		reg = <0x12000000 0x10000>;
> +		interrupts = <0 72 0>;
> +	};
> +
>  	rtc {
>  		compatible = "samsung,s3c6410-rtc";
>  		reg = <0x101E0000 0x100>;
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index bb3b09a..588814a 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -422,6 +422,7 @@ config MACH_EXYNOS5_DT
>  	select ARM_AMBA
>  	select SOC_EXYNOS5250
>  	select USE_OF
> +	select USB_ARCH_HAS_XHCI
>  	help
>  	  Machine support for Samsung EXYNOS5 machine with device tree enabled.
>  	  Select this if a fdt blob is available for the EXYNOS5 SoC based board.
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
> index a88e0d9..ee094ee 100644
> --- a/arch/arm/mach-exynos/clock-exynos5.c
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -740,6 +740,11 @@ static struct clk exynos5_init_clocks_off[] = {
>  		.enable		= exynos5_clk_ip_fsys_ctrl ,
>  		.ctrlbit	= (1 << 18),
>  	}, {
> +		.name		= "usbdrd30",
> +		.parent		= &exynos5_clk_aclk_200.clk,
> +		.enable		= exynos5_clk_ip_fsys_ctrl,
> +		.ctrlbit	= (1 << 19),
> +	}, {
>  		.name		= "usbotg",
>  		.enable		= exynos5_clk_ip_fsys_ctrl,
>  		.ctrlbit	= (1 << 7),
> @@ -1004,6 +1009,16 @@ struct clksrc_sources exynos5_clkset_group = {
>  	.nr_sources	= ARRAY_SIZE(exynos5_clkset_group_list),
>  };
>  
> +struct clk *exynos5_clkset_usbdrd30_list[] = {
> +	[0] = &exynos5_clk_mout_mpll.clk,
> +	[1] = &exynos5_clk_mout_cpll.clk,
> +};
> +
> +struct clksrc_sources exynos5_clkset_usbdrd30 = {
> +	.sources        = exynos5_clkset_usbdrd30_list,
> +	.nr_sources     = ARRAY_SIZE(exynos5_clkset_usbdrd30_list),
> +};
> +
>  /* Possible clock sources for aclk_266_gscl_sub Mux */
>  static struct clk *clk_src_gscl_266_list[] = {
>  	[0] = &clk_ext_xtal_mux,
> @@ -1288,6 +1303,15 @@ static struct clksrc_clk exynos5_clksrcs[] = {
>  			.parent		= &exynos5_clk_mout_cpll.clk,
>  		},
>  		.reg_div = { .reg = EXYNOS5_CLKDIV_GEN, .shift = 4, .size = 3 },
> +	}, {
> +		.clk    = {
> +			.name           = "sclk_usbdrd30",
> +			.enable         = exynos5_clksrc_mask_fsys_ctrl,
> +			.ctrlbit        = (1 << 28),
> +		},
> +		.sources = &exynos5_clkset_usbdrd30,
> +		.reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 28, .size = 1 },
> +		.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS0, .shift = 24, .size = 4 },
>  	},
>  };
>  
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 471ffaf..064ca1c 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -197,6 +197,7 @@
>  #define EXYNOS4_PA_EHCI			0x12580000
>  #define EXYNOS4_PA_OHCI			0x12590000
>  #define EXYNOS4_PA_HSPHY		0x125B0000
> +#define EXYNOS5_PA_DRD			0x12000000
>  #define EXYNOS5_PA_EHCI			0x12110000
>  #define EXYNOS5_PA_OHCI			0x12120000
>  #define EXYNOS4_PA_MFC			0x13400000
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
> index c03f3dd..3032222 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -90,6 +90,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
>  				"s5p-ehci", NULL),
>  	OF_DEV_AUXDATA("samsung,exynos-ohci", EXYNOS5_PA_OHCI,
>  				"exynos-ohci", NULL),
> +	OF_DEV_AUXDATA("samsung,exynos-dwc3", EXYNOS5_PA_DRD,
> +				"exynos-dwc3", NULL),
>  	{},
>  };
>  
> -- 
> 1.7.6.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
