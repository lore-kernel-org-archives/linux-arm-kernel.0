From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 12 Apr 2018 16:58:06 +0200
Subject: [PATCH 5/5] arm64: allwinner: a64: add SRAM controller device
 tree node
In-Reply-To: <20180411141641.14675-6-icenowy@aosc.io>
References: <20180411141641.14675-1-icenowy@aosc.io>
 <20180411141641.14675-6-icenowy@aosc.io>
Message-ID: <20180412145806.hsvxomh6vousrhq5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 11, 2018 at 10:16:41PM +0800, Icenowy Zheng wrote:
> Allwinner A64 has a SRAM controller, and in the device tree currently
> we have a syscon node to enable EMAC driver to access the EMAC clock
> register. As SRAM controller driver can now export regmap for this
> register, replace the syscon node to the SRAM controller device node,
> and let EMAC driver to acquire its EMAC clock regmap.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 1b2ef28c42bd..1c37659d9d41 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -168,10 +168,25 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> -		syscon: syscon at 1c00000 {
> -			compatible = "allwinner,sun50i-a64-system-controller",
> -				"syscon";
> +		sram_controller: sram-controller at 1c00000 {
> +			compatible = "allwinner,sun50i-a64-sram-controller";
>  			reg = <0x01c00000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			sram_c: sram at 18000 {
> +				compatible = "mmio-sram";
> +				reg = <0x00018000 0x28000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x00018000 0x28000>;
> +
> +				de2_sram: sram-section at 0 {
> +					compatible = "allwinner,sun50i-a64-sram-c";
> +					reg = <0x0000 0x28000>;
> +				};
> +			};

That doesn't look related at all to what's being discussed here, so
you'd rather add it as part of your DE2-enablement serie (or amend
your commit log to say why this is important to do it in this patch).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/23c2a08d/attachment-0001.sig>
