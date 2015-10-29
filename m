From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 29 Oct 2015 11:27:05 +0900
Subject: [PATCH v3 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <046d990092dc85cf50db9082fc894d93a3ece7c0.1446018918.git.p.fedin@samsung.com>
References: <cover.1446018918.git.p.fedin@samsung.com>
 <046d990092dc85cf50db9082fc894d93a3ece7c0.1446018918.git.p.fedin@samsung.com>
Message-ID: <563183F9.6020806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.10.2015 16:57, Pavel Fedin wrote:
> Add documentation for new properties, allowing bank configuration.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  .../bindings/arm/samsung/exynos-srom.txt           | 24 +++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

You missed here a lot of potential Cc. Please use get_maintainer.pl
script. It *must* be sent to devicetree list.

Please send it also to DeviceTree maintainers because you are adding
quite generic names for bindings so they may have interesting thoughts
on this.

LKML list is also missing.

> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
> index 33886d5..9e4a40b 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
> @@ -5,8 +5,30 @@ Required properties:
>  
>  - reg: offset and length of the register set
>  
> -Example:
> +Bank configurations can be defined in optional subnodes. Each subnode
> +describes one bank and contains the following:
> +
> +Required properties:
> +- bank : bank number (0 - 3)

I wonder whether this should be maybe "reg"?

> +
> +- srom-timing : array of 7 integers: Tacp, Tcah, Tcoh, Tacc, Tcos, Tacs

Missing "pmc"? Where is the seventh?

This looks vendor specific, so prefix with "samsung,exynos-".

> +
> +Optional properties:
> +- width : data width in bytes (1 or 2). If omitted, default of 1 is used.

This is not bank-width? So data-width? Any vendor prefix here? How
generic is this?

These are first things which came to my mind. Maybe DT maintainers will
come with something more...

Best regards,
Krzysztof

> +
> +Example: basic definition, no banks are configured
> +	sromc at 12570000 {
> +		compatible = "samsung,exynos-srom";
> +		reg = <0x12570000 0x10>;
> +	};
> +
> +Example: SROMc with bank3 configuration
>  	sromc at 12570000 {
>  		compatible = "samsung,exynos-srom";
>  		reg = <0x12570000 0x10>;
> +		bank at 3 {
> +			bank = <3>;
> +			width = <2>;
> +			srom-timing = <1 9 12 1 9 1 1>;
> +		};
>  	};
> 
