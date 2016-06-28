From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Jun 2016 15:56:37 -0500
Subject: [PATCH] usb: misc: Add driver for usb4604
In-Reply-To: <20160626052454.7743-1-stephen.boyd@linaro.org>
References: <20160626052454.7743-1-stephen.boyd@linaro.org>
Message-ID: <20160628205637.GO3737@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2016 at 10:24:54PM -0700, Stephen Boyd wrote:
> This is a minimal driver to support bringing a usb4604 device
> from microchip out of reset and into hub mode. The usb4604 device
> is related to the usb3503 device, but it didn't seem close enough
> to warrant putting both into the same file. This patch borrows
> some of the usb3503 structure and trims it down to just handle
> the optional reset gpio and adds the i2c command to put the
> device into hub mode.
> 
> Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/00001716A.pdf
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/usb4604.txt |  19 +++
>  drivers/usb/misc/Kconfig                          |   6 +
>  drivers/usb/misc/Makefile                         |   1 +
>  drivers/usb/misc/usb4604.c                        | 175 ++++++++++++++++++++++
>  4 files changed, 201 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb4604.txt
>  create mode 100644 drivers/usb/misc/usb4604.c
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb4604.txt b/Documentation/devicetree/bindings/usb/usb4604.txt
> new file mode 100644
> index 000000000000..82506d17712c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb4604.txt
> @@ -0,0 +1,19 @@
> +SMSC USB4604 High-Speed Hub Controller
> +
> +Required properties:
> +- compatible: Should be "smsc,usb4604"
> +
> +Optional properties:
> +- reg: Specifies the i2c slave address, it is required and should be 0x2d
> +       if I2C is used.
> +- reset-gpios: Should specify GPIO for reset.
> +- initial-mode: Should specify initial mode.
> +                (1 for HUB mode, 2 for STANDBY mode)

I was going to ask what would be the purpose of standby mode, and 
say it needs a vendor prefix, but I see you are re-using this from the 
3503.

> +
> +Examples:
> +	usb-hub at 2d {

I'm not sure what we'll do when/if we need this as a USB bus child node.

Acked-by: Rob Herring <robh@kernel.org>

> +		compatible = "smsc,usb4604";
> +		reg = <0x2d>;
> +		reset-gpios = <&gpx3 5 1>;
> +		initial-mode = <1>;
> +	};
