From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 05 Feb 2015 11:10:04 +0100
Subject: [PATCH RFC v8 11/21] Documentation: dt-bindings: Add bindings
 for Synopsys DW MIPI DSI DRM bridge driver
In-Reply-To: <1420014219-915-12-git-send-email-Ying.Liu@freescale.com>
References: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
 <1420014219-915-12-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1423131004.3207.27.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 31.12.2014, 16:23 +0800 schrieb Liu Ying:
> This patch adds device tree bindings for Synopsys DesignWare MIPI DSI
> host controller DRM bridge driver.
> 
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
> v7->v8:
>  * None.
> 
> v6->v7:
>  * None.
> 
> v5->v6:
>  * Add the #address-cells and #size-cells properties in the example 'ports'
>    node.
>  * Remove the useless input-port properties from the example port at 0 and port at 1
>    nodes.
> 
> v4->v5:
>  * None.
> 
> v3->v4:
>  * Newly introduced in v4.  This is separated from the relevant driver patch
>    in v3 to address Stefan Wahren's comment.
> 
>  .../devicetree/bindings/drm/bridge/dw_mipi_dsi.txt | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt
> 
> diff --git a/Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt b/Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt
> new file mode 100644
> index 0000000..f88a8d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt
> @@ -0,0 +1,73 @@
> +Device-Tree bindings for Synopsys DesignWare MIPI DSI host controller
> +
> +The controller is a digital core that implements all protocol functions
> +defined in the MIPI DSI specification, providing an interface between
> +the system and the MIPI DPHY, and allowing communication with a MIPI DSI
> +compliant display.
> +
> +Required properties:
> + - #address-cells: Should be <1>.
> + - #size-cells: Should be <0>.
> + - compatible: The compatible string should be "fsl,imx6q-mipi-dsi" for
> +   i.MX6q/sdl SoCs.  For other SoCs, please refer to their specific
> +   device tree binding documentations.

I think the compatible property should additionally contain
"snps,dw-mipi-dsi". Also I think other SoCs using the same IP core
should eventually list their compatibles here, but that's for later.

How about:
+ - compatible: The compatible string contain "fsl,imx6q-mipi-dsi" for
+   i.MX6q/sdl SoCs.  For other SoCs, please refer to their specific
+   device tree binding documentations. A common compatible string
+   "snps,dw-mipi-dsi" should be appended for all SoCs.

> + - reg: Represent the physical address range of the controller.
> + - interrupts: Represent the controller's interrupt to the CPU(s).
> + - clocks, clock-names: Phandles to the controller pll reference and
> +   core configuration clocks, as described in [1].

>From the MIPI CSI-2 datasheets it looks like the D-PHY has a refclk and
a cfg_clk input. So I suspect from the name of the "core_cfg" clock,
that it actually represents two clock inputs, the "cfg_clk" wired to the
D-PHY and a core clock wired to the MIPI DSI host controller. I am not
sure if there are designs that control those clocks separately, but I
think it'd be safer to split this into two clocks in the device tree.

Also I am not sure which input to the MIPI DSI host controller the core
clock represents. The i.MX6DQ Reference Manual v2 calls the remaining
clock inputs gated by mipi_core_cfg_clk_enable "ac_clk_125m" and
"ips_clk" (I think the latter is the ABP clock driving the register
bank, just called "pclk" in the MIPI CSI-2 documentation).

regards
Philipp
