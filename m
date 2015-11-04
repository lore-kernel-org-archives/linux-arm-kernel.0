From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 Nov 2015 17:09:36 +0900
Subject: [PATCH v5 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <9a1edb15c06e27fa1fba5773c937e3a3d363c32a.1446542020.git.p.fedin@samsung.com>
References: <cover.1446542020.git.p.fedin@samsung.com>
 <9a1edb15c06e27fa1fba5773c937e3a3d363c32a.1446542020.git.p.fedin@samsung.com>
Message-ID: <5639BD40.4020000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.11.2015 18:16, Pavel Fedin wrote:
> Add documentation for new subnode properties, allowing bank configuration.
> Based on u-boot implementation, but heavily reworked.

Please mention also fixing the size of mapped memory in <reg> in the
example.

> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  .../bindings/arm/samsung/exynos-srom.txt           | 68 +++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
> index 33886d5..ee378ca 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
> @@ -5,8 +5,72 @@ Required properties:
>  
>  - reg: offset and length of the register set
>  
> -Example:
> +- #address-cells: Must be set to 2 to allow memory address translation
> +
> +- #size-cells: Must be set to 1 to allow CS address passing
> +
> +- ranges: Must be set up to reflect the memory layout with four integer values
> +	  per bank:
> +		<bank-number> 0 <physical address of bank> <size>
> +

These are mentioned as required but actually they shouldn't be, if there
are no peripherals.

By making them required you would be breaking ABI. I see that actually
the ABI is not broken by the driver so maybe just add a separate
optional section for subdevices.
In that section you would described required attributes and subnodes.

> +Sub-nodes:
> +The SROM controller can be used to attach external peripherials. In this case

s/peripherials/peripherals/

> +device nodes should be added as subnodes to the SROMc node. These subnodes,
> +except regular device specification, should contain the following properties,
> +describing configuration of the relevant SROM bank:
> +
> +Required properties:
> +- reg: bank number, base address (relative to start of the bank) and size of
> +       the memory mapped for the device. Note that base address will be
> +       typically 0 as this is the start of the bank.
> +
> +- samsung,srom-timing : array of 6 integers, specifying bank timings in the
> +                        following order: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs.
> +                        Each value is specified in cycles (0 - 15) and has the
> +                        following meaning:
> +                        Tacp : Page mode access cycle at Page mode
> +                        Tcah : Address holding time after CSn
> +                        Tcoh : Chip selection hold on OEn
> +                        Tacc : Access cycle

This one has values 1-32 clock cycles

> +                        Tcos : Chip selection set-up before OEn
> +                        Tacs : Address set-up before CSn
> +
> +Optional properties:
> +- reg-io-width : data width in bytes (1 or 2). If omitted, default of 1 is used.
> +
> +- samsung,srom-page-mode : page mode configuration for the bank:
> +			   0 - normal (one data)
> +			   1 - four data
> +			   If omitted, default of 0 is used.
> +
> +Example: basic definition, no banks are configured
> +	sromc at 12570000 {
> +		compatible = "samsung,exynos-srom";
> +		reg = <0x12570000 0x14>;
> +	};
> +
> +Example: SROMc with smsc 911x ethernet chip on bank 3

Maybe:
s/smsc 911x ethernet/SMSC911x Ethernet/

Best regards,
Krzysztof

>  	sromc at 12570000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0x04000000 0x20000   // Bank0
> +			  1 0 0x05000000 0x20000   // Bank1
> +			  2 0 0x06000000 0x20000   // Bank2
> +			  3 0 0x07000000 0x20000>; // Bank3
> +
>  		compatible = "samsung,exynos-srom";
> -		reg = <0x12570000 0x10>;
> +		reg = <0x12570000 0x14>;
> +
> +		ethernet at 3 {
> +			compatible = "smsc,lan9115";
> +			reg = <3 0 0x10000>;	   // Bank 3, offset = 0
> +			phy-mode = "mii";
> +			interrupt-parent = <&gpx0>;
> +			interrupts = <5 8>;
> +			reg-io-width = <2>;
> +			smsc,irq-push-pull;
> +			smsc,force-internal-phy;
> +
> +			samsung,srom-config = <1 9 12 1 9 1 1>;
> +		};
>  	};
> 
