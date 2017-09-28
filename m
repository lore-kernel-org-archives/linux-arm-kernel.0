From: yehuday@marvell.com (Yehuda Yitschak)
Date: Thu, 28 Sep 2017 12:52:07 +0000
Subject: [EXT] [PATCH 1/2] arm64: dts: marvell: fix interrupt-map property
 for Armada CP110 master PCIe controller
In-Reply-To: <20170928124550.11492-2-thomas.petazzoni@free-electrons.com>
References: <20170928124550.11492-1-thomas.petazzoni@free-electrons.com>
 <20170928124550.11492-2-thomas.petazzoni@free-electrons.com>
Message-ID: <2164f35d99974e1480790dac98be4a5d@IL-EXCH02.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas 

> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni at free-electrons.com]
> Sent: Thursday, September 28, 2017 15:46
> To: Jason Cooper; Andrew Lunn; Sebastian Hesselbarth; Gregory Clement
> Cc: Nadav Haklai; Hanna Hawa; Yehuda Yitschak; Antoine Tenart; Miqu?l
> Raynal; linux-arm-kernel at lists.infradead.org; Thomas Petazzoni
> Subject: [EXT] [PATCH 1/2] arm64: dts: marvell: fix interrupt-map property
> for Armada CP110 master PCIe controller
> 
> External Email
> 
> ----------------------------------------------------------------------
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
> This problem exists since the Device Tree description of the master
> CP110 was added to the kernel.

The initial version referenced the GIC interrupt controller. 
Maybe this issue was introduced during the switch to the ICU  ?
I am not sure but does the GIC has the same I think the GIC <address/size-cells> as the ICU ?

> 
> Fixes: 728dacc7f4dd5 ("arm64: dts: marvell: initial DT description of Armada
> 7K/8K CP110 master")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
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
> --
> 2.13.5
