From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 13:53:15 -0600
Subject: [PATCH v6 01/41] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <1516468460-4908-2-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-2-git-send-email-david@lechnology.com>
Message-ID: <20180129195315.bjanym7pmeh7bhaa@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 20, 2018 at 11:13:40AM -0600, David Lechner wrote:
> This adds a new binding for the PLL IP blocks in the mach-davinci
> family of processors. Currently, only da850 has device tree support
> but these bindings can also work for other SoCs in this family just
> by adding new compatible strings.
> 
> Note: Although these PLL controllers are very similar to the TI Keystone
> SoCs, we are not re-using those bindings. The Keystone bindings use a
> legacy one-node-per-clock binding. Furthermore, the mach-davinici SoCs
> have a slightly different PLL register layout and a number of quirks
> that can't be handled by the existing bindings, so the keystone bindings
> could not be used as-is anyway.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v6 changes:
> - Added clock-names property
> - Added ti,clkmode-square-wave property
> - Added pllout child node
> - Added obsclk child node
> - Expanded examples
> 
>  .../devicetree/bindings/clock/ti/davinci/pll.txt   | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
> new file mode 100644
> index 0000000..36998e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
> @@ -0,0 +1,96 @@
> +Binding for TI DaVinci PLL Controllers
> +
> +The PLL provides clocks to most of the components on the SoC. In addition
> +to the PLL itself, this controller also contains bypasses, gates, dividers,
> +an multiplexers for various clock signals.
> +
> +Required properties:
> +- compatible: shall be one of:
> +	- "ti,da850-pll0" for PLL0 on DA850/OMAP-L138/AM18XX
> +	- "ti,da850-pll1" for PLL1 on DA850/OMAP-L138/AM18XX
> +- reg: physical base address and size of the controller's register area.
> +- clocks: phandles corresponding to the clock names
> +- clock-names: names of the clock sources - depends on compatible string
> +	- for "ti,da850-pll0", shall be "clksrc", "extclksrc"
> +	- for "ti,da850-pll1", shall be "clksrc"
> +
> +Optional properties:
> +- ti,clkmode-square-wave: Indicates that the the board is supplying a square
> +	wave input on the OSCIN pin instead of using a crystal oscillator.
> +	This property is only valid when compatible = "ti,da850-pll0".
> +
> +
> +Optional child nodes:
> +
> +pllout
> +	Describes the main PLL clock output (before POSTDIV). The node name must
> +	be "pllout".
> +
> +	Required properties:
> +	- #clock-cells: shall be 0
> +
> +sysclk
> +	Describes the PLLDIVn divider clocks that provide the SYSCLKn clock
> +	domains. The node name must be "sysclk". Consumers of this node should
> +	use "n" in "SYSCLKn" as the index parameter for the clock cell.
> +
> +	Required properties:
> +	- #clock-cells: shall be 1
> +
> +auxclk
> +	Describes the AUXCLK output of the PLL. The node name must be "auxclk".
> +	This child node is only valid when compatible = "ti,da850-pll0".
> +
> +	Required properties:
> +	- #clock-cells: shall be 0
> +
> +obsclk
> +	Describes the OBSCLK output of the PLL. The node name must be "obsclk".
> +
> +	Required properties:
> +	- #clock-cells: shall be 0

So why have all these child nodes vs. just defining a single number 
space of clock ids?

Rob
