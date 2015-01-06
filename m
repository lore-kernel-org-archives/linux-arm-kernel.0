From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jan 2015 17:11:02 +0100
Subject: [PATCH 08/17] ARM: dts: sun7i: cubieboard2: add axp209 regulator
 nodes
In-Reply-To: <1420511727-8242-9-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-9-git-send-email-wens@csie.org>
Message-ID: <20150106161102.GV7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 06, 2015 at 10:35:18AM +0800, Chen-Yu Tsai wrote:
> This patch adds the regulator nodes for the axp209 by including
> the axp209 dtsi. As the inputs of these regulators are from the
> axp209's PS output, which is basically just a mux over the 2
> inputs, it is considered to be unregulated. Thus we do not provide
> input supply properties for them.
> 
> The regulator names and constraints are based on the board
> schematics and the SoC datasheet.
> 
> DCDC2 is used as the cpu power supply. This patch also references
> it from the cpu node.
> 
> Also get rid of axp209 properties already set in axp209.dtsi.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/axp209.dtsi               |  4 ++++
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 35 +++++++++++++++++++++++++----
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> index 3c38cbafe285..fec3364b2110 100644
> --- a/arch/arm/boot/dts/axp209.dtsi
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -54,6 +54,10 @@
>   */
>  
>  &axp209 {
> +	compatible = "x-powers,axp209";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +

This should be in your patch adding the AXP DTSI.

>  	regulators {
>  		/* Default work frequency for buck regulators */
>  		x-powers,dcdc-freq = <1500>;
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> index 53680983461a..61e61c0eb829 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -84,13 +84,9 @@
>  			status = "okay";
>  
>  			axp209: pmic at 34 {
> -				compatible = "x-powers,axp209";
>  				reg = <0x34>;
>  				interrupt-parent = <&nmi_intc>;
>  				interrupts = <0 8>;
> -
> -				interrupt-controller;
> -				#interrupt-cells = <1>;
>  			};
>  		};
>  
> @@ -141,3 +137,34 @@
>  		status = "okay";
>  	};
>  };
> +
> +/include/ "axp209.dtsi"

We've switched to preprocessor includes, please use them instead.

Thanks!
Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/c2eb17ee/attachment.sig>
