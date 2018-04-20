From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 20 Apr 2018 09:39:08 +0200
Subject: [PATCH v2 09/10] ARM: dts: sun7i-a20: Add Video Engine and
 reserved memory nodes
In-Reply-To: <20180419154536.17846-5-paul.kocialkowski@bootlin.com>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154536.17846-5-paul.kocialkowski@bootlin.com>
Message-ID: <20180420073908.nkcbsdxibnzkqski@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 05:45:35PM +0200, Paul Kocialkowski wrote:
> This adds nodes for the Video Engine and the associated reserved memory
> for the Allwinner A20. Up to 96 MiB of memory are dedicated to the VPU.
> 
> The VPU can only map the first 256 MiB of DRAM, so the reserved memory
> pool has to be located in that area. Following Allwinner's decision in
> downstream software, the last 96 MiB of the first 256 MiB of RAM are
> reserved for this purpose.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index bd0cd3204273..cb6d82065dcf 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -163,6 +163,20 @@
>  		reg = <0x40000000 0x80000000>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		/* Address must be kept in the lower 256 MiBs of DRAM for VE. */
> +		ve_memory: cma at 4a000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x4a000000 0x6000000>;
> +			no-map;

I'm not sure why no-map is needed.

And I guess we could use alloc-ranges to make sure the region is in
the proper memory range, instead of hardcoding it.

> +			linux,cma-default;
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv7-timer";
>  		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> @@ -451,6 +465,23 @@
>  			};
>  		};
>  
> +		ve: video-engine at 1c0e000 {
> +			compatible = "allwinner,sun4i-a10-video-engine";

We should have an A20-specific compatible here, at least, so that we
can deal with any quirk we might find down the road.

> +			reg = <0x01c0e000 0x1000>;
> +			memory-region = <&ve_memory>;

Since you made the CMA region the default one, you don't need to tie
it to that device in particular (and you can drop it being mandatory
from your binding as well).

> +
> +			clocks = <&ccu CLK_AHB_VE>, <&ccu CLK_VE>,
> +				 <&ccu CLK_DRAM_VE>;
> +			clock-names = "ahb", "mod", "ram";
> +
> +			assigned-clocks = <&ccu CLK_VE>;
> +			assigned-clock-rates = <320000000>;

This should be set from within the driver. If it's something that you
absolutely needed for the device to operate, you have no guarantee
that the clock rate won't change at any point in time after the device
probe, so that's not a proper solution.

And if it's not needed and can be adjusted depending on the
framerate/codec/resolution, then it shouldn't be in the DT either.

Don't you also need to map the SRAM on the A20?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/709dd34d/attachment-0001.sig>
