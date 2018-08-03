From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 3 Aug 2018 13:32:25 +0300
Subject: [PATCH v6 2/3] dt-bindings: display: atmel: optional
 video-interface of endpoints
In-Reply-To: <20180803101124.4622-3-peda@axentia.se>
References: <20180803101124.4622-1-peda@axentia.se>
 <20180803101124.4622-3-peda@axentia.se>
Message-ID: <20180803103225.xkwqe3wiv2gwdo5g@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thanks for cc'ing me.

On Fri, Aug 03, 2018 at 12:11:23PM +0200, Peter Rosin wrote:
> With bus-type/bus-width properties in the endpoint nodes, the video-
> interface of the connection can be specified for cases where the
> heuristic fails to select the correct output mode. This can happen
> e.g. if not all RGB pins are routed on the PCB; the driver has no
> way of knowing this, and needs to be told explicitly.
> 
> This is critical for the devices that have the "conflicting output
> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> RGB bits move around depending on the selected output mode. For
> devices that do not have the "conflicting output formats" issue
> (SAMA5D2, SAMA5D4), this is completely irrelevant.
> 
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> index 82f2acb3d374..10e8707d1443 100644
> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> @@ -15,6 +15,14 @@ Required children nodes:
>   to external devices using the OF graph reprensentation (see ../graph.txt).
>   At least one port node is required.
>  
> +Optional properties in grandchild nodes:
> + Any endpoint grandchild node may specify a desired video interface
> + according to ../../media/video-interfaces.txt, specifically
> + - bus-type: must be <0>.

bus-type won't tell anything in this case, you could simply drop it. If
your hardware only supports parallel or Bt.656 bus then the code parsing
the properties can (and should) know the bus type as well.

Looking at your implementation, bus-type is not being used. This supports
the suggestion.

The V4L2 implementation is about to change as well and there's a bit of
discussion ongoing related to the bus-type property:

<URL:https://www.spinics.net/lists/linux-media/msg137980.html>
<URL:https://www.spinics.net/lists/linux-media/msg137979.html>

> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
> +   override any output mode selection heuristic, forcing "rgb444",
> +   "rgb565", "rgb666" and "rgb888" respectively.
> +
>  Example:
>  
>  	hlcdc: hlcdc at f0030000 {
> @@ -50,3 +58,25 @@ Example:
>  			#pwm-cells = <3>;
>  		};
>  	};
> +
> +Example 2: With a video interface override to force rgb565; as above
> +but with these changes/additions:
> +
> +	&hlcdc {
> +		hlcdc-display-controller {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> +
> +			port at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0>;
> +
> +				hlcdc_panel_output: endpoint at 0 {
> +					reg = <0>;
> +					bus-type = <0>;
> +					bus-width = <16>;
> +				};
> +			};
> +		};
> +	};

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi
