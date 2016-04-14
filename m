From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Apr 2016 12:22:59 -0500
Subject: [PATCH 2/5] serial: imx: Use generic uart-has-rtscts DT property
In-Reply-To: <1460636003-3011-3-git-send-email-geert+renesas@glider.be>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
 <1460636003-3011-3-git-send-email-geert+renesas@glider.be>
Message-ID: <20160414172259.GA16348@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 02:13:20PM +0200, Geert Uytterhoeven wrote:
> Convert the Freescale IMX UART driver from using the vendor-specific
> "fsl,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
> documented by the Generic Serial DT Bindings.
> 
> The old vendor-specific property is still recognized by the driver for
> backwards compatibility, but deprecated.

You should update the dts files as well.

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 4 ++--
>  drivers/tty/serial/imx.c                                  | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> index ed94c217c98d18a6..1e82802d8e322db5 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> @@ -6,7 +6,7 @@ Required properties:
>  - interrupts : Should contain uart interrupt
>  
>  Optional properties:
> -- fsl,uart-has-rtscts : Indicate the uart has rts and cts
> +- uart-has-rtscts : Indicate the uart has rts and cts
>  - fsl,irda-mode : Indicate the uart supports irda mode
>  - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
>                    in DCE mode by default.
> @@ -24,6 +24,6 @@ uart1: serial at 73fbc000 {
>  	compatible = "fsl,imx51-uart", "fsl,imx21-uart";
>  	reg = <0x73fbc000 0x4000>;
>  	interrupts = <31>;
> -	fsl,uart-has-rtscts;
> +	uart-has-rtscts;
>  	fsl,dte-mode;
>  };
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 231e7d5caf6c1845..9fc09d3de1e2428b 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1927,7 +1927,8 @@ static int serial_imx_probe_dt(struct imx_port *sport,
>  	}
>  	sport->port.line = ret;
>  
> -	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
> +	if (of_get_property(np, "uart-has-rtscts", NULL) ||
> +	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
>  		sport->have_rtscts = 1;
>  
>  	if (of_get_property(np, "fsl,dte-mode", NULL))
> -- 
> 1.9.1
> 
