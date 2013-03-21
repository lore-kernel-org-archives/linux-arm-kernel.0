From: robherring2@gmail.com (Rob Herring)
Date: Thu, 21 Mar 2013 12:59:21 -0500
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <514B4A79.1070501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 11:26 AM, Gregory CLEMENT wrote:
> In order to be able to use more than 4GB of RAM when the LPAE is
> activated, the dts must be converted in 64 bits.
> 
> Armada XP and Armada 370 share a dtsi file which have also be
> converted to 64 bits. This lead to convert all the device tree files
> to 64 bits even the one used for Armada 370 (which don't support
> LPAE)
> 
> This was heavily based on the work of Lior Amsalem.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

[snip]

> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 5b70820..562f24c 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -15,8 +15,7 @@
>   * This file contains the definitions that are common to the Armada
>   * 370 and Armada XP SoC.
>   */
> -
> -/include/ "skeleton.dtsi"
> +/include/ "skeleton64.dtsi"
>  
>  / {
>  	model = "Marvell Armada 370 and XP SoC";
> @@ -37,20 +36,20 @@
>  
>  	coherency-fabric at d0020200 {
>  		compatible = "marvell,coherency-fabric";
> -		reg = <0xd0020200 0xb0>,
> -		      <0xd0021810 0x1c>;
> +		reg = <0 0xd0020200 0 0xb0>,
> +		      <0 0xd0021810 0 0x1c>;
>  	};
>  
>  	soc {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;

If all the addresses for the soc bus are below 4GB or even within a 4GB
range if using the ranges property, then changing all this and
everything below it is kind of pointless.

Rob
