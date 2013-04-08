From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 08 Apr 2013 18:08:53 +0900
Subject: [PATCH 6/6] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <00c501ce277c$30e49dc0$92add940$%han@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <00c501ce277c$30e49dc0$92add940$%han@samsung.com>
Message-ID: <000001ce3438$b136e1e0$13a4a5a0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 23, 2013 1:09 PM, Jingoo Han wrote:
> 
> Exynos5440 has two PCIe controllers which can be used as root complex
> for PCIe interface.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5440-ssdk5440.dts |    8 +++++++
>  arch/arm/boot/dts/exynos5440.dtsi         |   32 +++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> index a21eb4c..746f9fc 100644
> --- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> +++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> @@ -34,4 +34,12 @@
>  			clock-frequency = <50000000>;
>  		};
>  	};
> +
> +	pcie0 at 40000000 {
> +		reset-gpio = <5>;
> +	};
> +
> +	pcie1 at 60000000 {
> +		reset-gpio = <22>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> index c374a31..41b2d2c 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -178,4 +178,36 @@
>  		clocks = <&clock 21>;
>  		clock-names = "rtc";
>  	};
> +
> +	pcie0 at 40000000 {
> +		compatible = "samsung,exynos5440-pcie";
> +		reg = <0x40000000 0x4000
> +			0x290000 0x1000
> +			0x270000 0x1000
> +			0x271000 0x40>;
> +		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		bus-range = <0x0 0xf>;
> +		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00200000   /* configuration space */
> +			  0x81000000 0 0	  0x40200000 0 0x00004000   /* downstream I/O */
> +			  0x82000000 0 0	  0x40204000 0 0x10000000>; /* non-prefetchable memory */
> +	};
> +
> +	pcie1 at 60000000 {
> +		compatible = "samsung,exynos5440-pcie";
> +		reg = <0x60000000 0x4000
> +			0x2a0000 0x1000
> +			0x272000 0x1000
> +			0x271040 0x40>;
> +		interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		bus-range = <0x0 0xf>;
> +		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00200000   /* configuration space */
> +			  0x81000000 0 0	  0x60200000 0 0x00004000   /* downstream I/O */
> +			  0x82000000 0 0	  0x60204000 0 0x10000000>; /* non-prefetchable memory */
> +	};

Hi Jason,

I have a question.
Now, I am reviewing the Tegra PCIe, Marvell PCIe patchset.
However, in the case of Exynos PCIe,
'downstream I/O' and 'non-prefetchable memory' are different between PCIe0 and PCIe1.
These regions are not shared.

PCIe0:
	ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00200000   /* configuration space */
		  0x81000000 0 0	  0x40200000 0 0x00004000   /* downstream I/O */
		  0x82000000 0 0	  0x40204000 0 0x10000000>; /* non-prefetchable memory */

PCIe1:
	ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00200000   /* configuration space */
		  0x81000000 0 0	  0x40200000 0 0x00004000   /* downstream I/O */
		  0x82000000 0 0	  0x40204000 0 0x10000000>; /* non-prefetchable memory */

PCIe0 uses 0x40000000~0x5fffffff, PCI1 uses 0x60000000~0x7fffffff.

How can I handle this? :)
The following is right?

+       pcie-controller {
		.....
+               ranges = <0x82000000 0 0x40000000 0x40000000 0 0x00200000   /* port 0 registers */
+                         0x82000000 0 0x60000000 0x60000000 0 0x00200000   /* port 1 registers */
+                         0x81000000 0 0          0x40200000 0 0x00004000   /* port 0 downstream I/O */
+                         0x81000000 0 0          0x60200000 0 0x00004000   /* port 1 downstream I/O */
+                         0x82000000 0 0x40204000 0x40204000 0 0x10000000>; /* port 0 non-prefetchable memory */
+                         0x82000000 0 0x40204000 0x60204000 0 0x10000000>; /* port 1 non-prefetchable memory */
+
+               pci at 1,0 {
+                       device_type = "pci";
+                       assigned-addresses = <0x82000800 0 0x40000000 0 0x00200000
+                                                 0x81000800 0 0x40200000 0 0x00004000
+                                                 0x81000800 0 0x40204000 0 0x10000000>;
		.....
+               pci at 2,0 {
+                       device_type = "pci";
+                       assigned-addresses = <0x82000800 0 0x60000000 0 0x00200000
+                                                 0x81000800 0 0x60200000 0 0x00004000
+                                                 0x81000800 0 0x60204000 0 0x10000000>;

Best regards,
Jingoo Han


>  };
> --
> 1.7.2.5
