From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Nov 2018 10:41:02 +0100
Subject: [PATCH 15/15] arm64: dts: allwinner: a64: Add Video Engine and
 reserved memory node
In-Reply-To: <20181115145013.3378-16-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-16-paul.kocialkowski@bootlin.com>
Message-ID: <20181116094102.6j5xhpptvelxtr6h@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 03:50:13PM +0100, Paul Kocialkowski wrote:
> This adds nodes for the Video Engine and the associated reserved memory
> for the A64. Up to 96 MiB of memory are dedicated to the CMA pool.
> 
> The pool is located at the end of the first 256 MiB of RAM so that the
> VPU can access it. It is unclear whether this is still a hard
> requirement for this platform, but it seems safer that way.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 88b3e9110833..a35a5c9ffbbe 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -185,6 +185,20 @@
>  			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		cma_pool: cma at 4a000000 {
> +			compatible = "shared-dma-pool";
> +			size = <0x6000000>;
> +			alloc-ranges = <0x4a000000 0x6000000>;

This introduces a DTC warning, since you're using a unit-address, but
don't have a reg register.

I've fixed it in the other DT by renaming that node to
default-pool. You can also drop the label, it's not used anywhere.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/2fc31fdd/attachment.sig>
