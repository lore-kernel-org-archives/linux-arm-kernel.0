From: john@metanate.com (John Keeping)
Date: Fri, 3 Mar 2017 11:39:45 +0000
Subject: [PATCH] dt-bindings: display: rk3288-mipi-dsi: add reset property
In-Reply-To: <20170302215643.GA49163@google.com>
References: <20170224125506.21533-1-john@metanate.com>
 <20170224125506.21533-24-john@metanate.com>
 <20170302215643.GA49163@google.com>
Message-ID: <20170303113945.3bd2cbd9.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reset is required in order to fully reset the internal state of the
MIPI controller.

Signed-off-by: John Keeping <john@metanate.com>
---
On Thu, 2 Mar 2017 13:56:46 -0800, Brian Norris wrote:
> On Fri, Feb 24, 2017 at 12:55:06PM +0000, John Keeping wrote:
> > +	/*
> > +	 * Note that the reset was not defined in the initial device tree, so
> > +	 * we have to be prepared for it not being found.
> > +	 */
> > +	apb_rst = devm_reset_control_get(dev, "apb");  
> 
> Did this reset ever get documented in the device tree bindings? I
> couldn't find it. Perhaps a follow-up patch is in order?

Here's a patch to do that.

 .../devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
index 1753f0cc6fad..28d0b437d3cd 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -13,8 +13,13 @@ Required properties:
 - ports: contain a port node with endpoint definitions as defined in [2].
   For vopb,set the reg = <0> and set the reg = <1> for vopl.
 
+Optional properties:
+- resets: list of phandle + reset specifier pairs, as described in [3].
+- reset-names: string reset name, must be "apb".
+
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 [2] Documentation/devicetree/bindings/media/video-interfaces.txt
+[3] Documentation/devicetree/bindings/reset/reset.txt
 
 Example:
 	mipi_dsi: mipi at ff960000 {
@@ -25,6 +30,8 @@ Example:
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_MIPI_24M>, <&cru PCLK_MIPI_DSI0>;
 		clock-names = "ref", "pclk";
+		resets = <&cru SRST_MIPIDSI0>;
+		reset-names = "apb";
 		rockchip,grf = <&grf>;
 		status = "okay";
 
-- 
2.12.0.rc2.230.ga28edc07cd.dirty
