From: robh@kernel.org (Rob Herring)
Date: Wed, 3 Jan 2018 14:21:54 -0600
Subject: [PATCH 06/11] dt-bindings: display: sun4i-drm: Add A83T HDMI
 pipeline
In-Reply-To: <20171230210203.24115-7-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
 <20171230210203.24115-7-jernej.skrabec@siol.net>
Message-ID: <20180103202154.eeajt3234w3adqjq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 30, 2017 at 10:01:58PM +0100, Jernej Skrabec wrote:
> This commit adds all necessary compatibles and descriptions needed to
> implement A83T HDMI pipeline.
> 
> Mixer is already properly described, so only compatible is added.
> 
> However, A83T TCON1, which is connected to HDMI, doesn't have channel 0,
> contrary to all TCONs currently described. Because of that, TCON
> documentation is extended.
> 
> A83T features Synopsys DW HDMI controller with a custom PHY which looks
> like Synopsys Gen2 PHY with few additions. Since there is no
> documentation, needed properties were found out through experimentation
> and reading BSP code.
> 
> At the end, example is added for newer SoCs, which features DE2 and DW
> HDMI.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           | 188 ++++++++++++++++++++-
>  1 file changed, 181 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 9f073af4c711..3eca258096a5 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -64,6 +64,40 @@ Required properties:
>      first port should be the input endpoint. The second should be the
>      output, usually to an HDMI connector.
>  
> +DWC HDMI TX Encoder
> +-----------------------------
> +
> +The HDMI transmitter is a Synopsys DesignWare HDMI 1.4 TX controller IP
> +with Allwinner's own PHY IP. It supports audio and video outputs and CEC.
> +
> +These DT bindings follow the Synopsys DWC HDMI TX bindings defined in
> +Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt with the
> +following device-specific properties.
> +
> +Required properties:
> +
> +  - compatible: value must be one of:
> +    * "allwinner,sun8i-a83t-dw-hdmi"
> +  - reg: two pairs of base address and size of memory-mapped region, first
> +    for controller and second for PHY
> +    registers.

Seems like the phy should be a separate node and use the phy binding. 
You can use the phy binding even if you don't use the kernel phy 
framework...

> +  - reg-io-width: See dw_hdmi.txt. Shall be 1.
> +  - interrupts: HDMI interrupt number
> +  - clocks: phandles to the clocks feeding the HDMI encoder
> +    * iahb: the HDMI bus clock
> +    * isfr: the HDMI register clock
> +    * tmds: the HDMI tmds clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandles to the reset controllers driving the encoder
> +    * ctrl: the reset line for the controller
> +    * phy: the reset line for the PHY
> +  - reset-names: the reset names mentioned above
> +
> +  - ports: A ports node with endpoint definitions as defined in
> +    Documentation/devicetree/bindings/media/video-interfaces.txt. The
> +    first port should be the input endpoint. The second should be the
> +    output, usually to an HDMI connector.
> +
>  TV Encoder
>  ----------
>  
> @@ -94,18 +128,17 @@ Required properties:
>     * allwinner,sun7i-a20-tcon
>     * allwinner,sun8i-a33-tcon
>     * allwinner,sun8i-a83t-tcon-lcd
> +   * allwinner,sun8i-a83t-tcon-tv
>     * allwinner,sun8i-v3s-tcon
>   - reg: base address and size of memory-mapped region
>   - interrupts: interrupt associated to this IP
> - - clocks: phandles to the clocks feeding the TCON. Three are needed:
> + - clocks: phandles to the clocks feeding the TCON. One is needed:
>     - 'ahb': the interface clocks
> -   - 'tcon-ch0': The clock driving the TCON channel 0
>   - resets: phandles to the reset controllers driving the encoder
>     - "lcd": the reset line for the TCON channel 0
>  
>   - clock-names: the clock names mentioned above
>   - reset-names: the reset names mentioned above
> - - clock-output-names: Name of the pixel clock created
>  
>  - ports: A ports node with endpoint definitions as defined in
>    Documentation/devicetree/bindings/media/video-interfaces.txt. The
> @@ -119,11 +152,31 @@ Required properties:
>    channel the endpoint is associated to. If that property is not
>    present, the endpoint number will be used as the channel number.
>  
> -On SoCs other than the A33 and V3s, there is one more clock required:
> +Following compatibles:
> + * allwinner,sun4i-a10-tcon
> + * allwinner,sun5i-a13-tcon
> + * allwinner,sun6i-a31-tcon
> + * allwinner,sun6i-a31s-tcon
> + * allwinner,sun7i-a20-tcon
> + * allwinner,sun8i-a33-tcon
> + * allwinner,sun8i-a83t-tcon-lcd
> + * allwinner,sun8i-v3s-tcon
> +have additional required properties:
> + - 'tcon-ch0': The clock driving the TCON channel 0

tcon-ch0 is a clock name, not a property.

> + - clock-output-names: Name of the pixel clock created
> +
> +For following compatibles:
> + * allwinner,sun4i-a10-tcon
> + * allwinner,sun5i-a13-tcon
> + * allwinner,sun6i-a31-tcon
> + * allwinner,sun6i-a31s-tcon
> + * allwinner,sun7i-a20-tcon
> + * allwinner,sun8i-a83t-tcon-tv
> +there is one more clock required:
>     - 'tcon-ch1': The clock driving the TCON channel 1
