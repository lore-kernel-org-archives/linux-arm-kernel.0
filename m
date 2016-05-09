From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 15:30:03 -0500
Subject: [PATCH 1/4] doc/devicetree: Add Aspeed clock bindings
In-Reply-To: <1462797111-14271-2-git-send-email-joel@jms.id.au>
References: <1462797111-14271-1-git-send-email-joel@jms.id.au>
 <1462797111-14271-2-git-send-email-joel@jms.id.au>
Message-ID: <20160509203003.GA24945@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 10:01:48PM +0930, Joel Stanley wrote:
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/clock/aspeed-clock.txt     | 156 +++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/aspeed-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/aspeed-clock.txt b/Documentation/devicetree/bindings/clock/aspeed-clock.txt
> new file mode 100644
> index 000000000000..968329406435
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/aspeed-clock.txt
> @@ -0,0 +1,156 @@
> +Device Tree Clock bindings for the Aspeed SoCs
> +
> +Aspeed SoCs have a fixed frequency input osciallator is used to create the PLL
> +and APB clocks. We can determine these frequencies by reading registers that
> +are set according to strapping bits.
> +
> +Forth generation boards
> +-----------------------
> +
> +eg, ast2400.
> +
> +CLKIN:
> + - compatible : Must be "fixed-clock"
> + - #clock-cells : Should be 0
> + - clock-frequency: 48e6, 25e6 or 24e6 depending on the input clock
> +
> +PLL:
> +
> +Required properties:
> + - compatible : Must be "aspeed,g4-hpll-clock"
> + - #clock-cells : Should be 0
> + - reg : Should contain registers location and length
> + - clocks : Should contain phandle + clock-specifier for the input clock (clkin)
> +
> +Optional properties:
> + - clock-output-names : Should contain clock name
> +
> +
> +APB:
> +
> +Required properties:
> + - compatible : Must be "aspeed,g4-apb-clock"
> + - #clock-cells : Should be 0
> + - reg : Should contain registers location and length
> + - clocks : Should contain phandle + clock-specifier for the h-pll
> +
> +Optional properties:
> + - clock-output-names : Should contain clock name
> +
> +
> +For example:
> +
> +	clk_clkin: clk_clkin {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <48000000>;
> +	};
> +
> +	clk_hpll: clk_hpll {
> +		compatible = "aspeed,g4-hpll-clock";
> +		#clock-cells = <0>;
> +		reg = <0x1e6e2008 0x4>;
> +	};
> +
> +	clk_apb: clk_apb at 1e6e2008 {
> +		#clock-cells = <0>;
> +		compatible = "aspeed,g4-apb-clock";
> +		reg = <0x1e6e2008 0x4>;

You have overlapping register regions which we try to avoid (it would 
through errors, but doesn't because of existing platforms).

Just define the h/w block controlling these clocks and support multiple 
clocks.

Is this really all the clocks the SOC has?

Rob
