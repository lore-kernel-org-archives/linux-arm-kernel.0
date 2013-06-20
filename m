From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 20 Jun 2013 10:04:22 +0200
Subject: [PATCH V6 3/3] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <00c201ce6d85$83b072a0$8b1157e0$@samsung.com>
References: <00c201ce6d85$83b072a0$8b1157e0$@samsung.com>
Message-ID: <3250954.dVh4O1LchK@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingoo,

On Thursday 20 of June 2013 16:12:24 Jingoo Han wrote:
> Exynos5440 has two PCIe controllers which can be used as root complex
> for PCIe interface.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5440-ssdk5440.dts |    8 ++++++
>  arch/arm/boot/dts/exynos5440.dtsi         |   40
> ++++++++++++++++++++++++++++- 2 files changed, 47 insertions(+), 1
> deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> b/arch/arm/boot/dts/exynos5440-ssdk5440.dts index f32cd77..3d93804
> 100644
> --- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> +++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> @@ -65,4 +65,12 @@
>  			clock-frequency = <50000000>;
>  		};
>  	};
> +
> +	pcie0 at 290000 {
> +		reset-gpio = <&pin_ctrl 5 0>;
> +	};
> +
> +	pcie1 at 2a0000 {
> +		reset-gpio = <&pin_ctrl 22 0>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi
> b/arch/arm/boot/dts/exynos5440.dtsi index 03d40c0..6295eda 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -126,7 +126,7 @@
>  		clock-names = "spi", "spi_busclk0";
>  	};
> 
> -	pinctrl {
> +	pin_ctrl: pinctrl {
>  		compatible = "samsung,exynos5440-pinctrl";
>  		reg = <0xE0000 0x1000>;
>  		interrupts = <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>,
> @@ -230,4 +230,42 @@
>  		clocks = <&clock 24>;
>  		clock-names = "usbhost";
>  	};

I think this patch should be split into two:
 - patch adding just generlic PCIe nodes for Exynos5440,
 - patch adding label to the pinctrl node (which is a prerequisite) and 
board-specific properties of PCIe nodes.

> +
> +	pcie0 at 290000 {

Node naming looks incorrect here. The name should be as generic as 
possible, without any hardware-specific IDs, e.g. pcie, not pcie0. The 
@290000 suffix is enough to make the node unique.

> +		compatible = "samsung,exynos5440-pcie";
> +		reg = <0x290000 0x1000
> +			0x270000 0x1000
> +			0x271000 0x40>;
> +		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> +		clocks = <&clock 28>, <&clock 27>;
> +		clock-names = "pcie", "pcie_bus";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000   
/*
> configuration space */ +			  0x81000000 0 0	  
0x40001000 0 0x00010000  
> /* downstream I/O */ +			  0x82000000 0 0x40011000 
0x40011000 0
> 0x1ffef000>; /* non-prefetchable memory */ +		#interrupt-cells = 
<1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0x0 0 &gic 53>;
> +	};
> +
> +	pcie1 at 2a0000 {

Same here.

Best regards,
Tomasz

> +		compatible = "samsung,exynos5440-pcie";
> +		reg = <0x2a0000 0x1000
> +			0x272000 0x1000
> +			0x271040 0x40>;
> +		interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
> +		clocks = <&clock 29>, <&clock 27>;
> +		clock-names = "pcie", "pcie_bus";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000   
/*
> configuration space */ +			  0x81000000 0 0	  
0x60001000 0 0x00010000  
> /* downstream I/O */ +			  0x82000000 0 0x60011000 
0x60011000 0
> 0x1ffef000>; /* non-prefetchable memory */ +		#interrupt-cells = 
<1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0x0 0 &gic 56>;
> +	};
>  };
