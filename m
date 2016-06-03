From: robh@kernel.org (Rob Herring)
Date: Thu, 2 Jun 2016 21:02:18 -0500
Subject: [PATCH v3 06/12] power: pwrseq: simple: Add support for
 regulator and generic property
In-Reply-To: <1464768141-25420-7-git-send-email-k.kozlowski@samsung.com>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-7-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160603020218.GA19436@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 10:02:15AM +0200, Krzysztof Kozlowski wrote:
> Some devices need real hard-reset by cutting the power.  During power
> sequence turn off and on the regulator, if it is provided.
> 
> Additionally add support for instantiating the pwrseq-simple device on a
> generic property 'power-sequence'.  The device will attach itself to the
> node containing the property and parse the node's properties like
> reset-gpios, ext-supply etc.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  .../bindings/power/pwrseq/pwrseq-simple.txt        | 29 +++++++-
>  drivers/power/pwrseq/pwrseq_simple.c               | 85 +++++++++++++++++++++-
>  2 files changed, 107 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt
> index ce0e76749671..a8c3f13ee83f 100644
> --- a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt
> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt
> @@ -1,11 +1,17 @@
> -* The simple MMC power sequence provider
> +* The simple power sequence provider
>  
> -The purpose of the simple MMC power sequence provider is to supports a set of
> +The purpose of the simple power sequence provider is to supports a set of
>  common properties between various SOC designs. It thus enables us to use the
>  same provider for several SOC designs.
>  
> -Required properties:
> -- compatible : contains "mmc-pwrseq-simple".
> +The driver supports two types of bindings:
> +1. Separate node
> +   Required properties:
> +   - compatible : contains "mmc-pwrseq-simple".

Please note that this is not recommended for new users.

> +
> +2. Property for any node
> +   Required properties:
> +   - power-sequence
>  
>  Optional properties:
>  - reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
> @@ -16,6 +22,7 @@ Optional properties:
>    See ../clocks/clock-bindings.txt for details.
>  - clock-names : Must include the following entry:
>    "ext_clock" (External clock provided to the card).
> +- ext-supply : External regulator supply

What happens when there are 2 supplies?

I'd prefer the name not be genericish and use the real supply names. 
Then the power seq code should just turn on all supplies it finds. If 
the order or timing to turn on matters, then sorry, no generic sequence.

>  
>  Example:
>  
> @@ -24,4 +31,18 @@ Example:
>  		reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
>  		clocks = <&clk_32768_ck>;
>  		clock-names = "ext_clock";
> +		ext-supply = <&buck8>;
>  	}
> +
> +	usb3503 at 08 {
> +		compatible = "smsc,usb3503";
> +		reg = <0x08>;
> +
> +		intn-gpios = <&gpx3 0 GPIO_ACTIVE_HIGH>;
> +		connect-gpios = <&gpx3 4 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpx3 5 GPIO_ACTIVE_HIGH>;
> +		initial-mode = <1>;
> +
> +		power-sequence;
> +		ext-supply = <&buck8_reg>;
> +	};
