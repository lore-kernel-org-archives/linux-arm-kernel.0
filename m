From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 14:24:23 -0600
Subject: [PATCH 3/7] pinctrl: sunxi: add support for the Allwinner H6
 main pin controller
In-Reply-To: <20180106042326.46519-3-icenowy@aosc.io>
References: <20180106042326.46519-1-icenowy@aosc.io>
 <20180106042326.46519-3-icenowy@aosc.io>
Message-ID: <20180111202423.xslkd7nbejkqvoz6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 06, 2018 at 12:23:22PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC has two pin controllers, one main controller
> (called CPUX-PORT in user manual) and one controller in CPUs power
> domain (called CPUS-PORT in user manual).
> 
> This commit introduces support for the main pin controller on H6.
> 
> The pin bank A and B are not wired out and hidden from the SoC's
> documents, however it's shown that the "ATE" (an AC200 chip
> co-packaged with the H6 die) is connected to the main SoC die via these
> pin banks. The information about these banks is just copied from the BSP
> pinctrl driver, but re-formatted to fit the mainline pinctrl driver
> format.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   4 +-
>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c          | 679 +++++++++++++++++++++
>  4 files changed, 687 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> index 09789fdfa749..4523e658b9f2 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> @@ -27,6 +27,7 @@ Required properties:
>    "allwinner,sun50i-a64-pinctrl"
>    "allwinner,sun50i-a64-r-pinctrl"
>    "allwinner,sun50i-h5-pinctrl"
> +  "allwinner,sun50i-h6-pinctrl"
>    "nextthing,gr8-pinctrl"
>  
>  - reg: Should contain the register physical address and length for the
> @@ -39,7 +40,8 @@ Required properties:
>  
>  Note: For backward compatibility reasons, the hosc and losc clocks are only
>  required if you need to use the optional input-debounce property. Any new
> -device tree should set them.
> +device tree should set them. For the pin controllers on Allwinner H6 SoC,
> +there's no APB bus gate, and the "apb" clock should be omitted.

This should be with the clocks prop definition.

Rob
