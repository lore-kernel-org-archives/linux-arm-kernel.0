From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Mar 2015 08:20:34 -0700
Subject: [PATCH 2/5] ARM: dts: sun4i: Add A10 SRAM and SRAM controller
In-Reply-To: <1426877569-11493-3-git-send-email-hdegoede@redhat.com>
References: <1426877569-11493-1-git-send-email-hdegoede@redhat.com>
 <1426877569-11493-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150324152034.GB4951@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 07:52:46PM +0100, Hans de Goede wrote:
> The A10 has a few SRAM that can be mapped either to a device or to the CPU,
> with the mapping being controlled by a SRAM controller.
> 
> Since most of the time these SRAM won't be accessible by the CPU,
> we can't use the mmio-sram driver and compatible.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index b66ebb3..88f57b4 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -451,12 +451,46 @@
>  		};
>  	};
>  
> +	/*
> +	 * Note we use the address were mmio registers start, not where the
                                   ^ where

> +	 * SRAM blocks start, this cannot be changed because that would be
> +	 * a devicetree ABI change.
> +	 */
>  	soc at 01c00000 {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges;
>  
> +		sram at 00000000 {
> +			compatible = "allwinner,sun4i-a10-sram";
> +			reg = <0x00000000 0x4000>;
> +			allwinner,sram-name = "A1";
> +		};
> +
> +		sram at 00004000 {
> +			compatible = "allwinner,sun4i-a10-sram";
> +			reg = <0x00004000 0x4000>;
> +			allwinner,sram-name = "A2";
> +		};
> +
> +		sram at 00008000 {
> +			compatible = "allwinner,sun4i-a10-sram";
> +			reg = <0x00008000 0x4000>;
> +			allwinner,sram-name = "A3-A4";
> +		};
> +
> +		sram at 00010000 {
> +			compatible = "allwinner,sun4i-a10-sram";
> +			reg = <0x00010000 0x1000>;
> +			allwinner,sram-name = "D";
> +		};
> +
> +		sram-controller at 01c00000 {
> +			compatible = "allwinner,sun4i-a10-sram-controller";
> +			reg = <0x01c00000 0x30>;
> +		};
> +
>  		dma: dma-controller at 01c02000 {
>  			compatible = "allwinner,sun4i-a10-dma";
>  			reg = <0x01c02000 0x1000>;
> -- 
> 2.3.3
> 

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/b7687602/attachment-0001.sig>
