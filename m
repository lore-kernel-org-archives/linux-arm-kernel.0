From: robh@kernel.org (Rob Herring)
Date: Tue, 13 Feb 2018 17:20:07 -0600
Subject: [PATCH v4 2/5] dt-bindings: gpio: add raspberry pi GPIO expander
 binding
In-Reply-To: <214ff3856c430b8045b63b25d83733b77054dfab.1517923836.git.baruch@tkos.co.il>
References: <cover.1517923836.git.baruch@tkos.co.il>
 <214ff3856c430b8045b63b25d83733b77054dfab.1517923836.git.baruch@tkos.co.il>
Message-ID: <20180213232007.ieme6rjxgc7vidbw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 08:35:23PM +0200, Baruch Siach wrote:
> The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware over
> I2C. The firmware mailbox interface allows the ARM core to control the
> GPIO lines.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v4:
>   * Move the example gpio node under the firmware node
>   * Rename gpio node name to plain 'gpio'
> 
> v3:
>   * Rename node name.
> 
> v2:
>   * Rename compatible string to raspberrypi,firmware-gpio
> ---
>  .../bindings/gpio/raspberrypi,firmware-gpio.txt    | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt b/Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt
> new file mode 100644
> index 000000000000..30326528faa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt
> @@ -0,0 +1,29 @@
> +Raspberry Pi GPIO expander
> +
> +The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware. The
> +firmware exposes a mailbox interface that allows the ARM core to control the
> +GPIO lines on the expander.
> +
> +Required properties:
> +
> +- compatible : Should be "raspberrypi,firmware-gpio"
> +- gpio-controller : Marks the device node as a gpio controller
> +- #gpio-cells : Should be two.  The first cell is the pin number, and
> +  the second cell is used to specify the gpio polarity:
> +  0 = active high
> +  1 = active low
> +- firmware : Reference to the RPi firmware device node

This is the parent node. You don't need it.

> +
> +Example:
> +
> +firmware: firmware {
> +	compatible = "raspberrypi,bcm2835-firmware";
> +	mboxes = <&mailbox>;

No, sorry. /firmware is the container of firmware nodes. So 
something like this:

firmware {
	rpi-firmware {
		compatible = "raspberrypi,bcm2835-firmware";
		mboxes = <&mailbox>;
		gpio {
		 compatible = "raspberrypi,firmware-gpio";

		};
	};
};

> +
> +	expgpio: gpio {
> +		 compatible = "raspberrypi,firmware-gpio";
> +		 gpio-controller;
> +		 #gpio-cells = <2>;
> +		 firmware = <&firmware>;
> +	 };
> +};
> -- 
> 2.15.1
> 
