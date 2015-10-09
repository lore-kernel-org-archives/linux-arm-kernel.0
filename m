From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Oct 2015 18:04:48 +0100
Subject: [PATCH v2 4/5] arm64: Juno: Add support for the PCIe host bridge
 on Juno R1
In-Reply-To: <1444409849-5685-5-git-send-email-Liviu.Dudau@arm.com>
References: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
 <1444409849-5685-5-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20151009170448.GG21629@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 05:57:28PM +0100, Liviu Dudau wrote:
> Juno R1 board sports a functional PCIe host bridge that is
> compliant with the SBSA standard found [1] here. With the right
> firmware that initialises the XpressRICH3 controller one can
> use the generic Host Bridge driver to use the PCIe hardware.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> [1] http://infocenter.arm.com/help/topic/com.arm.doc.den0029a/
> ---
>  arch/arm64/boot/dts/arm/juno-r1.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> index c627511..a702a6b 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -109,7 +109,26 @@
>  
>  	#include "juno-base.dtsi"
>  
> +	pcie-controller at 40000000 {
> +		compatible = "arm,juno-r1-pcie", "plda,xpressrich3", "pci-host-ecam-generic";

Judging by a PLDA press release [1], it looks like Juno uses
"XpressRICH3-AXI" [2] rather than "XpressRICH3 for ASIC" [3].

So sorry to bikeshed the name I suggested, but it's probably best to
s/plda,xpressrich3/plda,xpressrich3-axi/

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I assume that can be fixed up when picking (or prior to a pull) without
the need to repost.

> +		device_type = "pci";
> +		reg = <0 0x40000000 0 0x10000000>;	/* ECAM config space */
> +		bus-range = <0 255>;
> +		linux,pci-domain = <0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		dma-coherent;
> +		ranges = <0x01000000 0x00 0x5f800000 0x00 0x5f800000 0x0 0x00800000
> +			  0x02000000 0x00 0x50000000 0x00 0x50000000 0x0 0x08000000
> +		          0x42000000 0x40 0x00000000 0x40 0x00000000 0x1 0x00000000>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &gic 0 0 0 136 4
> +			         0 0 0 2 &gic 0 0 0 137 4
> +				 0 0 0 3 &gic 0 0 0 138 4
> +				 0 0 0 4 &gic 0 0 0 139 4>;
> +		msi-parent = <&v2m_0>;

Minor nit for ranges and interrupt-map, but it'd be good to bracket
entries individually, for consistency with what we do elsewhere.

Thanks,
Mark.

[1] https://www.plda.com/arm-0
[2] https://www.plda.com/products/asicfpgasoc-ip/pcie-soft-ip/pcie-30-soft-ip-arm-soc/xpressrich3-axi
[3] https://www.plda.com/products/asicfpgasoc-ip/pcie-soft-ip/pcie-30-soft-ip/xpressrich3-pcie-30
