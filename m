From: yehuday@marvell.com (Yehuda Yitschak)
Date: Thu, 28 Sep 2017 14:28:36 +0000
Subject: [PATCH v2] arm64: dts: marvell: fix interrupt-map property for
 Armada CP110 PCIe controller
In-Reply-To: <20170928140633.13942-1-thomas.petazzoni@free-electrons.com>
References: <20170928140633.13942-1-thomas.petazzoni@free-electrons.com>
Message-ID: <62042484a9484a64b8bcbc6a2a5b9b43@IL-EXCH02.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Reviewed-by: Yehuda Yitschak <yehuday@marvell.com>

> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni at free-electrons.com]
> Sent: Thursday, September 28, 2017 17:07
> To: Jason Cooper; Andrew Lunn; Sebastian Hesselbarth; Gregory Clement
> Cc: Nadav Haklai; Hanna Hawa; Yehuda Yitschak; Antoine Tenart; Miqu?l
> Raynal; linux-arm-kernel at lists.infradead.org; Thomas Petazzoni
> Subject: [PATCH v2] arm64: dts: marvell: fix interrupt-map property for
> Armada CP110 PCIe controller
> 
> The interrupt-map property used in the description of the Marvell Armada
> 7K/8K PCIe controllers has a bogus extraneous 0 that causes the interrupt
> conversion to not be done properly. This causes the PCIe PME and AER root
> port service drivers to fail their initialization:
> 
> [    5.019900] genirq: Setting trigger mode 7 for irq 114 failed
> (irq_chip_set_type_parent+0x0/0x30)
> [    5.028821] pcie_pme: probe of 0001:00:00.0:pcie001 failed with error -22
> [    5.035687] genirq: Setting trigger mode 7 for irq 114 failed
> (irq_chip_set_type_parent+0x0/0x30)
> [    5.044614] aer: probe of 0001:00:00.0:pcie002 failed with error -22
> 
> This problem was introduced when the interrupt description was switched
> from using the GIC directly to using the ICU interrupt controller. Indeed, the
> GIC has address-cells = <1>, which requires a parent unit address, while the
> ICU has address-cells = <0>.
> 
> Fixes: 6ef84a827c37 ("arm64: dts: marvell: enable GICP and ICU on Armada
> 7K/8K")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Changes since v1:
>  - Fix the commit log with a proper explanation, as noticed by Yehuda
>  - Adjust the Fixes tag accordingly
>  - Squash both patches together since they fix the same commit
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 6 +++---
> arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 8263a8a504a8..f2aa2a81de4d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -336,7 +336,7 @@
>  				/* non-prefetchable memory */
>  				0x82000000 0 0xf6000000 0  0xf6000000 0
> 0xf00000>;
>  			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &cpm_icu 0 ICU_GRP_NSR
> 22 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map = <0 0 0 0 &cpm_icu ICU_GRP_NSR 22
> +IRQ_TYPE_LEVEL_HIGH>;
>  			interrupts = <ICU_GRP_NSR 22
> IRQ_TYPE_LEVEL_HIGH>;
>  			num-lanes = <1>;
>  			clocks = <&cpm_clk 1 13>;
> @@ -362,7 +362,7 @@
>  				/* non-prefetchable memory */
>  				0x82000000 0 0xf7000000 0  0xf7000000 0
> 0xf00000>;
>  			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &cpm_icu 0 ICU_GRP_NSR
> 24 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map = <0 0 0 0 &cpm_icu ICU_GRP_NSR 24
> +IRQ_TYPE_LEVEL_HIGH>;
>  			interrupts = <ICU_GRP_NSR 24
> IRQ_TYPE_LEVEL_HIGH>;
> 
>  			num-lanes = <1>;
> @@ -389,7 +389,7 @@
>  				/* non-prefetchable memory */
>  				0x82000000 0 0xf8000000 0  0xf8000000 0
> 0xf00000>;
>  			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &cpm_icu 0 ICU_GRP_NSR
> 23 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map = <0 0 0 0 &cpm_icu ICU_GRP_NSR 23
> +IRQ_TYPE_LEVEL_HIGH>;
>  			interrupts = <ICU_GRP_NSR 23
> IRQ_TYPE_LEVEL_HIGH>;
> 
>  			num-lanes = <1>;
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index b71ee6c83668..4fe70323abb3 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -335,7 +335,7 @@
>  				/* non-prefetchable memory */
>  				0x82000000 0 0xfa000000 0  0xfa000000 0
> 0xf00000>;
>  			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &cps_icu 0 ICU_GRP_NSR 22
> IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map = <0 0 0 0 &cps_icu ICU_GRP_NSR 22
> +IRQ_TYPE_LEVEL_HIGH>;
>  			interrupts = <ICU_GRP_NSR 22
> IRQ_TYPE_LEVEL_HIGH>;
>  			num-lanes = <1>;
>  			clocks = <&cps_clk 1 13>;
> @@ -361,7 +361,7 @@
>  				/* non-prefetchable memory */
>  				0x82000000 0 0xfb000000 0  0xfb000000 0
> 0xf00000>;
>  			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &cps_icu 0 ICU_GRP_NSR 24
> IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map = <0 0 0 0 &cps_icu ICU_GRP_NSR 24
> +IRQ_TYPE_LEVEL_HIGH>;
>  			interrupts = <ICU_GRP_NSR 24
> IRQ_TYPE_LEVEL_HIGH>;
> 
>  			num-lanes = <1>;
> @@ -388,7 +388,7 @@
>  				/* non-prefetchable memory */
>  				0x82000000 0 0xfc000000 0  0xfc000000 0
> 0xf00000>;
>  			interrupt-map-mask = <0 0 0 0>;
> -			interrupt-map = <0 0 0 0 &cps_icu 0 ICU_GRP_NSR 23
> IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map = <0 0 0 0 &cps_icu ICU_GRP_NSR 23
> +IRQ_TYPE_LEVEL_HIGH>;
>  			interrupts = <ICU_GRP_NSR 23
> IRQ_TYPE_LEVEL_HIGH>;
> 
>  			num-lanes = <1>;
> --
> 2.13.5
