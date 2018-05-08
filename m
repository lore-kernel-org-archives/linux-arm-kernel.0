From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 8 May 2018 22:50:00 +0200
Subject: [PATCH] arm: dts: atmel: graph_child_address warning fixes
In-Reply-To: <20180508221819.6b70d5c7@bbrezillon>
References: <20180508135930.5768-1-robh@kernel.org>
 <20180508221819.6b70d5c7@bbrezillon>
Message-ID: <20180508225000.15c04b69@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 May 2018 22:18:19 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Tue,  8 May 2018 08:59:25 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > Addresses for graph ports and endpoints are not necessary when
> > there's only a single child. Fix the following warnings removing
> > unnecessary addresses on OF graph nodes:
> > 
> > Warning (graph_child_address): /ahb/apb/hlcdc at f0030000/hlcdc-display-controller: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
> > Warning (graph_child_address): /ahb/apb/hlcdc at f0030000/hlcdc-display-controller/port at 0: graph node has single child node 'endpoint', #address-cells/#size-cells are not necessary
> > Warning (graph_child_address): /ahb/apb/isi at f0034000/port: graph node has single child node 'endpoint', #address-cells/#size-cells are not necessary
> > Warning (graph_child_address): /panel/port at 0: graph node has single child node 'endpoint at 0', #address-cells/#size-cells are not necessary  
> 
> Unfortunately that's not going to work, because the driver calls
> drm_of_find_panel_or_bridge() with a positive port and endpoint,
> not -1. While we could switch port arg from 0 to -1, that's not that
> simple for the endpoint arg, because we don't know in advance how many
> devices will be connected to the RGB/DPI port.
> 
> [1]https://elixir.bootlin.com/linux/v4.17-rc3/source/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c#L41
> 

I can prepare patches containing the following changes, but I need to
test them first.

To be honest, I still don't see the problem with the "single child having
a reg" case. Sure, it's not required, but it's also not an invalid
representation. Also note that, depending on the board, we'll have to
define addresses in endpoints if there's more than one endpoint, which
IMO makes things even harder to follow, because in some cases endpoints
will be numbered and in the others they won't.

--->8---
diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
index 82f2acb3d374..bc01c431d624 100644
--- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
+++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
@@ -7,13 +7,12 @@ Required properties:
  - compatible: value should be "atmel,hlcdc-display-controller"
  - pinctrl-names: the pin control state names. Should contain "default".
  - pinctrl-0: should contain the default pinctrl states.
- - #address-cells: should be set to 1.
- - #size-cells: should be set to 0.
 
 Required children nodes:
- Children nodes are encoding available output ports and their connections
- to external devices using the OF graph reprensentation (see ../graph.txt).
- At least one port node is required.
+ The port node represent the RGB/DPI output and can contain 0 to N endpoints
+ which encode connections to devices present on the RGB/DPI bus.
+ These connections are represented using the OF graph representation (see
+ ../graph.txt).
 
 Example:
 
@@ -28,16 +27,9 @@ Example:
                        compatible = "atmel,hlcdc-display-controller";
                        pinctrl-names = "default";
                        pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
-                       #address-cells = <1>;
-                       #size-cells = <0>;
 
-                       port at 0 {
-                               #address-cells = <1>;
-                               #size-cells = <0>;
-                               reg = <0>;
-
-                               hlcdc_panel_output: endpoint at 0 {
-                                       reg = <0>;
+                       port {
+                               hlcdc_panel_output: endpoint {
                                        remote-endpoint = <&panel_input>;
                                };
                        };
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 8db51fb131db..0dc8f124a95e 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -38,7 +38,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
        struct drm_bridge *bridge;
        int ret;
 
-       ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
+       ret = drm_of_find_panel_or_bridge(dev->dev->of_node, -1, endpoint,
                                          &panel, &bridge);
        if (ret)
                return ret;
@@ -86,5 +86,10 @@ int atmel_hlcdc_create_outputs(struct drm_device *dev)
        if (ret == -ENODEV && endpoint)
                return 0;
 
-       return ret;
+       /*
+        * If there's only one endpoint, the reg field will not be specified
+        * and no specific ID will be attached to this endpoint. Try with
+        * endpoint = -1 to handle this case.
+        */
+       return atmel_hlcdc_attach_endpoint(dev, -1);
 }
