From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 09 Oct 2012 17:27:49 +0900
Subject: [PATCH 1/2] ARM: Exynos5250: Enabling ehci-s5p driver
In-Reply-To: <1349431818-15639-2-git-send-email-gautam.vivek@samsung.com>
References: <1349431818-15639-1-git-send-email-gautam.vivek@samsung.com>
 <1349431818-15639-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <003801cda5f7$f7fd9a30$e7f8ce90$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 05, 2012 7:10 PM Vivek Gautam wrote
> 
> Adding EHCI device tree node for Exynos5250 along with
> the device base adress and gpio line for vbus.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>

It looks good. Also I have tested this patch with Exynos5250.

Acked-by: Jingoo Han <jg1.han@samsung.com>

> ---
>  .../devicetree/bindings/usb/exynos-usb.txt         |   25 ++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |    4 +++
>  arch/arm/boot/dts/exynos5250.dtsi                  |    6 ++++
>  arch/arm/mach-exynos/include/mach/map.h            |    1 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +
>  5 files changed, 38 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt
> b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> new file mode 100644
> index 0000000..56e35c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> @@ -0,0 +1,25 @@
> +Samsung Exynos SoC USB controller
> +
> +The USB devices interface with USB controllers on Exynos SOCs.
> +The device node has following properties.
> +
> +EHCI
> +Required properties:
> + - compatible: should be "samsung,exynos-ehci" for USB 2.0
> +   EHCI controller in host mode.
> + - reg: physical base address of the controller and length of memory mapped
> +   region.
> + - interrupts: interrupt number to the cpu.
> +
> +Optional properties:
> + - samsung,vbus-gpio:  if present, specifies the GPIO that
> +   needs to be pulled up for the bus to be powered.
> +
> +Example:
> +
> +	ehci {
> +		compatible = "samsung,exynos-ehci";
> +		reg = <0x12110000 0x100>;
> +		interrupts = <0 71 0>;
> +		samsung,vbus-gpio = <&gpx2 6 1 3 3>;
> +	};
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index a352df4..089576b 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -166,4 +166,8 @@
>  	spi_2: spi at 12d40000 {
>  		status = "disabled";
>  	};
> +
> +	ehci {
> +		samsung,vbus-gpio = <&gpx2 6 1 3 3>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index dddfd6e..73ea844 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -218,6 +218,12 @@
>  		#size-cells = <0>;
>  	};
> 
> +	ehci {
> +		compatible = "samsung,exynos-ehci";
> +		reg = <0x12110000 0x100>;
> +		interrupts = <0 71 0>;
> +	};
> +
>  	amba {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 8480849..825fe40 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -195,6 +195,7 @@
>  #define EXYNOS4_PA_EHCI			0x12580000
>  #define EXYNOS4_PA_OHCI			0x12590000
>  #define EXYNOS4_PA_HSPHY		0x125B0000
> +#define EXYNOS5_PA_EHCI			0x12110000
>  #define EXYNOS4_PA_MFC			0x13400000
> 
>  #define EXYNOS4_PA_UART			0x13800000
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
> index fee9dcd..6d950d7b 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -72,6 +72,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
>  				"exynos-gsc.2", NULL),
>  	OF_DEV_AUXDATA("samsung,exynos5-gsc", EXYNOS5_PA_GSC3,
>  				"exynos-gsc.3", NULL),
> +	OF_DEV_AUXDATA("samsung,exynos-ehci", EXYNOS5_PA_EHCI,
> +					"s5p-ehci", NULL),
>  	{},
>  };
> 
> --
> 1.7.6.5
