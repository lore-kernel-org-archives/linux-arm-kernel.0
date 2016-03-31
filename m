From: robh@kernel.org (Rob Herring)
Date: Thu, 31 Mar 2016 09:35:16 -0500
Subject: [PATCH v2 6/8] drm/fsl-dcu: add TCON driver
In-Reply-To: <1459216802-32094-7-git-send-email-stefan@agner.ch>
References: <1459216802-32094-1-git-send-email-stefan@agner.ch>
 <1459216802-32094-7-git-send-email-stefan@agner.ch>
Message-ID: <20160331143515.GA26784@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 07:00:00PM -0700, Stefan Agner wrote:
> Add driver for the TCON (timing controller) module. The TCON module
> is a separate module attached after the DCU (display controller
> unit). Each DCU instance has its own, directly connected TCON
> instance. The DCU's RGB and timing signals are passing through
> the TCON module. TCON can provide timing signals for raw TFT panels
> or operate in a bypass mode which leaves all signals unaltered.
> 
> The driver currently only supports the bypass mode.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../devicetree/bindings/display/fsl,dcu.txt        |   2 +
>  .../devicetree/bindings/display/fsl,tcon.txt       |  18 ++++
>  drivers/gpu/drm/fsl-dcu/Makefile                   |   3 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |   3 +
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h          |   1 +
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |  11 +++
>  drivers/gpu/drm/fsl-dcu/fsl_tcon.c                 | 108 +++++++++++++++++++++
>  drivers/gpu/drm/fsl-dcu/fsl_tcon.h                 |  33 +++++++
>  8 files changed, 178 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/display/fsl,tcon.txt
>  create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_tcon.c
>  create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_tcon.h
> 
> diff --git a/Documentation/devicetree/bindings/display/fsl,dcu.txt b/Documentation/devicetree/bindings/display/fsl,dcu.txt
> index f299e1e..b19bf12 100644
> --- a/Documentation/devicetree/bindings/display/fsl,dcu.txt
> +++ b/Documentation/devicetree/bindings/display/fsl,dcu.txt
> @@ -14,6 +14,7 @@ Required properties:
>  Optional properties:
>  - clocks:		Second handle for pixel clock.
>  - clock-names:		Second name "pix" for pixel clock.
> +- fsl,tcon:		The phandle to the timing controller node.
>  
>  Examples:
>  dcu: dcu at 2ce0000 {
> @@ -23,4 +24,5 @@ dcu: dcu at 2ce0000 {
>  	clock-names = "dcu";
>  	big-endian;
>  	fsl,panel = <&panel>;
> +	fsl,tcon = <&tcon>;
>  };
> diff --git a/Documentation/devicetree/bindings/display/fsl,tcon.txt b/Documentation/devicetree/bindings/display/fsl,tcon.txt
> new file mode 100644
> index 0000000..2e1015e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/fsl,tcon.txt
> @@ -0,0 +1,18 @@
> +Device Tree bindings for Freescale TCON Driver
> +
> +Required properties:
> +- compatible:		Should be one of
> +	* "fsl,vf610-tcon".
> +
> +- reg:			Address and length of the register set for dcu.

s/dcu/tcon/

With that,

Acked-by: Rob Herring <robh@kernel.org>


> +- clocks:		From common clock binding: handle to tcon ipg clock.
> +- clock-names:		From common clock binding: Shall be "ipg".
> +
> +Examples:
> +timing-controller at 4003d000 {
> +	compatible = "fsl,vf610-tcon";
> +	reg = <0x4003d000 0x1000>;
> +	clocks = <&clks VF610_CLK_TCON0>;
> +	clock-names = "ipg";
> +	status = "okay";
> +};
