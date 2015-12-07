From: robh@kernel.org (Rob Herring)
Date: Mon, 7 Dec 2015 08:31:02 -0600
Subject: [PATCH] clk: sunxi: Extend the simple gates and handle the
 Allwinner H3
In-Reply-To: <20151206100412.1a74b71da8e9ca28c6e61589@free.fr>
References: <20151206100412.1a74b71da8e9ca28c6e61589@free.fr>
Message-ID: <20151207143102.GA29097@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 06, 2015 at 10:04:12AM +0100, Jean-Francois Moine wrote:
> The H3 has a clock gate definition similar to the other Allwinner SoCs,
> but with a different parent clock for each single gate.
> 
> Adding the names of the parent clocks in both the source and output clocks
> permits the use of the simple-gates driver to define the bus gates
> of all known Allwinner SoCs.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> This patch replaces a part of Jens Kuske's patch
> 	[PATCH v5 1/4] clk: sunxi: Add H3 clocks support
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt | 25 +++++++++++++++++++++++
>  drivers/clk/sunxi/clk-simple-gates.c              | 14 ++++++++++++-
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 8a47b77..5736e6d 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -70,6 +70,7 @@ Required properties:
>  	"allwinner,sun8i-a23-usb-clk" - for usb gates + resets on A23
>  	"allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets on A80
>  	"allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
> +	"allwinner,sunxi-gates-clk" - simple gates
>  
>  Required properties for all clocks:
>  - reg : shall be the control register address for the clock.
> @@ -93,6 +94,12 @@ The "allwinner,sun9i-a80-mmc-config-clk" clock also requires:
>  - #reset-cells : shall be set to 1
>  - resets : shall be the reset control phandle for the mmc block.
>  
> +The "allwinner,sunxi-gates-clk" clock also requires:
> +- clock-names : corresponding names of the parent clocks
> +when the output clocks have different parents.
> +These names must be 4 characters long and must appear as a prefix in
> +the names of the output clocks. See example.
> +

I don't think you should be encoding relationships of clocks using the 
name strings. We describe relationships in DT via parent/child or 
phandles.

Rob
