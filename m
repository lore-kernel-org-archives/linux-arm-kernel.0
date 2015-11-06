From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 Nov 2015 09:03:16 +0900
Subject: [PATCH v6 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <26ce9f26ee8537b2f81ad0bf470d1c6b1c8a1a31.1446724046.git.p.fedin@samsung.com>
References: <cover.1446724046.git.p.fedin@samsung.com>
 <26ce9f26ee8537b2f81ad0bf470d1c6b1c8a1a31.1446724046.git.p.fedin@samsung.com>
Message-ID: <563BEE44.4040207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2015 21:03, Pavel Fedin wrote:
> Add documentation for new subnode properties, allowing bank configuration.
> Based on u-boot implementation, but heavily reworked.
> 
> Also, fix size of SROMc mapping in the example.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  .../bindings/arm/samsung/exynos-srom.txt           | 71 +++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
> index 33886d5..cce5c1f 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
> @@ -5,8 +5,75 @@ Required properties:
>  
>  - reg: offset and length of the register set
>  
> -Example:
> +Optional properties:
> +The SROM controller can be used to attach external peripherals. In this case
> +extra properties, describing the bus behind it, should be specified as below:
> +
> +- #address-cells: Must be set to 2 to allow memory address translation
> +
> +- #size-cells: Must be set to 1 to allow CS address passing
> +
> +- ranges: Must be set up to reflect the memory layout with four integer values
> +	  per bank:
> +		<bank-number> 0 <physical address of bank> <size>
> +
> +Sub-nodes:
> +The actual device nodes should be added as subnodes to the SROMc node. These
> +subnodes, except regular device specification, should contain the following
> +properties, describing configuration of the relevant SROM bank:
> +
> +Required properties:
> +- reg: bank number, base address (relative to start of the bank) and size of
> +       the memory mapped for the device. Note that base address will be
> +       typically 0 as this is the start of the bank.
> +
> +- samsung,srom-timing : array of 6 integers, specifying bank timings in the
> +                        following order: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs.
> +                        Each value is specified in cycles and has the following
> +                        meaning and valid range:
> +                        Tacp : Page mode access cycle at Page mode (0 - 15)
> +                        Tcah : Address holding time after CSn (0 - 15)
> +                        Tcoh : Chip selection hold on OEn (0 - 15)
> +                        Tacc : Access cycle (0 - 32)

All of the manuals have error here. Probably it can be either: 1-32 or
0-31. I would bet on 0-31, what do you think?

Rest looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
