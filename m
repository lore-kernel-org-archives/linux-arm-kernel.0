From: mgr@pengutronix.de (Michael Grzeschik)
Date: Tue, 28 Aug 2012 16:51:51 +0200
Subject: [PATCH v6 1/3] USB: chipidea: add imx usbmisc support
In-Reply-To: <1346137109-32247-2-git-send-email-richard.zhao@freescale.com>
References: <1346137109-32247-1-git-send-email-richard.zhao@freescale.com>
 <1346137109-32247-2-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120828145151.GJ10429@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 28, 2012 at 02:58:27PM +0800, Richard Zhao wrote:
> i.MX usb controllers shares non-core registers, which may include
> SoC specific controls. We take it as a usbmisc device and usbmisc
> driver set operations needed by ci13xxx_imx driver.
> 
> For example, Sabrelite board has bad over-current design, we can
> usbmisc to disable over-current detect.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    5 +
>  .../devicetree/bindings/usb/usbmisc-imx.txt        |   14 ++
>  drivers/usb/chipidea/Makefile                      |    2 +-
>  drivers/usb/chipidea/ci13xxx_imx.c                 |   64 ++++++++
>  drivers/usb/chipidea/ci13xxx_imx.h                 |   28 ++++
>  drivers/usb/chipidea/usbmisc_imx6q.c               |  162 ++++++++++++++++++++
>  6 files changed, 274 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>  create mode 100644 drivers/usb/chipidea/ci13xxx_imx.h
>  create mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> index 2c29041..5778b9c 100644
> --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> @@ -7,7 +7,10 @@ Required properties:
>  
>  Optional properties:
>  - fsl,usbphy: phandler of usb phy that connects to the only one port
> +- fsl,usbmisc: phandler of non-core register device, with one argument
> +  that indicate usb controller index
>  - vbus-supply: regulator for vbus
> +- disable-over-current: disable over current detect
>  
>  Examples:
>  usb at 02184000 { /* USB OTG */
> @@ -15,4 +18,6 @@ usb at 02184000 { /* USB OTG */
>  	reg = <0x02184000 0x200>;
>  	interrupts = <0 43 0x04>;
>  	fsl,usbphy = <&usbphy1>;
> +	fsl,usbmisc = <&usbmisc 0>;
> +	disable-over-current;
>  };
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> new file mode 100644
> index 0000000..97ce94e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> @@ -0,0 +1,14 @@
> +* Freescale i.MX non-core registers
> +
> +Required properties:
> +- #index-cells: Cells used to descibe usb controller index. Should be <1>
> +- compatible: Should be one of below:
> +	"fsl,imx6q-usbmisc" for imx6q
> +- reg: Should contain registers location and length
> +
> +Examples:
> +usbmisc at 02184800 {
> +	#index-cells = <1>;
> +	compatible = "fsl,imx6q-usbmisc";
> +	reg = <0x02184800 0x200>;
> +};

i think we should have the devicetree-discuss Mailinglist in Cc: for
that.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
