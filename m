From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Tue, 16 Jul 2013 11:37:30 +0200
Subject: [PATCH] ARM: Kirkwood: Fix the internal register ranges
 translation
In-Reply-To: <1371569479-31498-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371569479-31498-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <51E5145A.90404@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

apologies in advance for commenting on an already-merged patch.

On 06/18/2013 05:31 PM, Ezequiel Garcia wrote:
> Although the internal register window size is 1 MiB, the previous
> ranges translation for the internal register space had a size of
> 0x4000000. This was done to allow the crypto and nand node to access
> the corresponding 'sram' and 'nand' decoding windows.
>
> In order to describe the hardware more accurately, we declare the
> real 1 MiB internal register space in the ranges, and add a translation
> entry for the nand node to access the 'nand' window.
>
> This commit will make future improvements on the MBus DT binding easier.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
> Tested on Plathome Openblocks A6 board.
>
>   arch/arm/boot/dts/kirkwood.dtsi | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 8a1e3bb..910fabc 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -38,7 +38,8 @@
>
>   	ocp at f1000000 {
>   		compatible = "simple-bus";
> -		ranges = <0x00000000 0xf1000000 0x4000000
> +		ranges = <0x00000000 0xf1000000 0x0100000
> +		          0xf4000000 0xf4000000 0x0000400
>   		          0xf5000000 0xf5000000 0x0000400>;

Apart from "consistency" with the following range (0xf5000000) used by 
the crypto node, is there any reason why you did not do something like 
this instead (which Valentin suggested, but I will take the blame for):

-		ranges = <0x00000000 0xf1000000 0x4000000
+		ranges = <0x00000000 0xf1000000 0x0100000
+		          0x03000000 0xf4000000 0x0000400
   		          0xf5000000 0xf5000000 0x0000400>;

This would keep a consistent addressing within the child device bus, and 
avoid a later incosistency between the "unit-address" and the first 
"reg" address:

>   		#address-cells = <1>;
>   		#size-cells = <1>;
> @@ -171,7 +172,7 @@
 >   		nand at 3000000 {
		     ^^^^^^^
 >   			#address-cells = <1>;
 >   			#size-cells = <1>;
 >   			cle = <0>;
>   			ale = <1>;
>   			bank-width = <1>;
>   			compatible = "marvell,orion-nand";
> -			reg = <0x3000000 0x400>;
> +			reg = <0xf4000000 0x400>;
				^^^^^^^^^
>   			chip-delay = <25>;
>   			/* set partition map and/or chip-delay in board dts */
>   			clocks = <&gate_clk 7>;
>

I guess the same could be done for the third range and for the crypto 
node as well:

-		ranges = <0x00000000 0xf1000000 0x4000000
-  		          0xf5000000 0xf5000000 0x0000400>;
+		ranges = <0x00000000 0xf1000000 0x0100000
+		          0x03000000 0xf4000000 0x0000400
+		          0x04000000 0xf5000000 0x0000400>;

		crypto at 30000 {
			compatible = "marvell,orion-crypto";
			reg = <0x30000 0x10000>,
-			      <0xf5000000 0x800>;
+			      <0x04000000 0x800>;
			reg-names = "regs", "sram";
			interrupts = <22>;
			clocks = <&gate_clk 17>;
			status = "okay";
		};

Does the above make sense?
Or would that clash with your latest mvebu-mbus device tree binding?
(Which, BTW, I have not quite understood yet).

Thank you,
Gerlando
