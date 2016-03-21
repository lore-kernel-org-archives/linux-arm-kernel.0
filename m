From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Mar 2016 07:57:45 -0500
Subject: [PATCH 4/5] drm/vc4: Add DPI driver
In-Reply-To: <1458355366-7073-5-git-send-email-eric@anholt.net>
References: <1458355366-7073-1-git-send-email-eric@anholt.net>
 <1458355366-7073-5-git-send-email-eric@anholt.net>
Message-ID: <20160321125745.GA16407@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 07:42:45PM -0700, Eric Anholt wrote:
> The DPI interface involves taking a ton of our GPIOs to be used as
> outputs, and routing display signals over them in parallel.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../devicetree/bindings/display/brcm,bcm-vc4.txt   |  67 +++
>  drivers/gpu/drm/vc4/Kconfig                        |   1 +
>  drivers/gpu/drm/vc4/Makefile                       |   1 +
>  drivers/gpu/drm/vc4/vc4_debugfs.c                  |   1 +
>  drivers/gpu/drm/vc4/vc4_dpi.c                      | 518 +++++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_drv.c                      |   1 +
>  drivers/gpu/drm/vc4/vc4_drv.h                      |   5 +
>  7 files changed, 594 insertions(+)
>  create mode 100644 drivers/gpu/drm/vc4/vc4_dpi.c
> 
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
> index 56a961a..1782c3f 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
> @@ -35,6 +35,44 @@ Optional properties for HDMI:
>  		  as an interrupt/status bit in the HDMI controller
>  		  itself).  See bindings/pinctrl/brcm,bcm2835-gpio.txt
>  
> +Required properties for DPI:
> +- compatible:		Should be "brcm,bcm2835-dpi"
> +- reg:			Physical base address and length of the registers
> +- clocks:		a) core: The core clock the unit runs on
> +			b) pixel: The pixel clock that feeds the pixelvalve
> +- port:			Port node with a single endpoint connecting to the
> +			  panel device, as defined in [1]
> +- brcm,output-format:	Output data format, must be one of:
> +			0) disabled
> +			1) 00000000rrrrrggggggbbbbb
> +			2) 000rrrrr00gggggg000bbbbb
> +			3) 00rrrrr000gggggg00bbbbb0
> +			4) 000000rrrrrrggggggbbbbbb
> +			5) 00rrrrrr00gggggg00bbbbbb
> +			6) rrrrrrrrggggggggbbbbbbbb
> +
> +Optional properties for DPI:
> +- brcm,rgb-order:		RGB reordering, must be one of:
> +				0) RGB
> +				1) BGR
> +				2) GRB
> +				3) BRG

> +- brcm,hsync-disable:		Disables the hsync signal
> +- brcm,vsync-disable:		Disables the vsync signal
> +- brcm,output-enable-disable:	Disables the output enable signal
> +- brcm,hsync-falling:		Outputs the hsync signal on the falling clk edge
> +- brcm,vsync-falling:		Outputs the vsync signal on the falling clk edge
> +- brcm,output-enable-falling:	Outputs the output enable signal on the
> +				  falling clk edge
> +- brcm,output-enable-invert:	Inverts the polarity of the output enable
> +				  signal
> +- brcm,pixel-clk-invert:	Inverts the polarity of the pixel clk signal
> +- brcm,output-enable-mode:	Sets output enable when (vsync | hsync)
> +				  instead of (hactive & vactive)

These are all really properties of what the panel requires and we 
already have video timings binding that would cover some of these.

Also, do you have actual users? Some of these seem like they would be 
rare or never. I've not seen panels caring about which clock edge the 
sync signals are on.

Rob
