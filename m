From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 05 Feb 2013 14:57:02 +0100
Subject: [PATCH 1/2] ARM: mvebu: Add support for SPI controller in Armada
 370/XP
In-Reply-To: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <51110FAE.4070700@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 02/04/2013 05:38 PM, Ezequiel Garcia wrote:
> The Armada 370 and Armada XP SoC has an SPI controller.
> This patch adds support for this controller in Armada 370
> and Armada XP SoC common device tree files.
> 
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 28276fe..22340d5 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -145,6 +145,28 @@
>  			clocks = <&gateclk 17>;
>  			status = "disabled";
>  		};
> +
> +		spi0: spi at d0010600 {
> +			compatible = "marvell,orion-spi";
> +			reg = <0xd0010600 0x50>;

Currently the driver only use the 5th first register. All of the other
mvebu platform declare the last register at offset 0x28. The Armada
370 SoC have also the last register at offset 0x28. Only for the
Armada XP SoC there are more registers and we have a the last register
at offset 0x50. Obviously the driver won't use these extra register.

So I think that the best for now is to declare:
			reg = <0xd0010600 0x28>;

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <0>;
> +			interrupts = <30>;
> +			clocks = <&coreclk 0>;
> +			status = "disabled";
> +		};
> +
> +		spi1: spi at d0010680 {
> +			compatible = "marvell,orion-spi";
> +			reg = <0xd0010680 0x50>;
and here:
			reg = <0xd0010680 0x28>;

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <1>;
> +			interrupts = <92>;
> +			clocks = <&coreclk 0>;
> +			status = "disabled";
> +		};
>  	};
>  };
>  
> 

Once it will be fixed, for this patch you can add my

Acked-by: Gregory Clement <gregory.clement@free-electrons.com>


Regards,
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
