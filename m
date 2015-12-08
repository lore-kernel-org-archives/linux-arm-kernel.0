From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 08 Dec 2015 10:50:49 +0100
Subject: [PATCH 2/3] doc: dt-binding: generic onboard USB HUB
In-Reply-To: <1449538670-7954-3-git-send-email-peter.chen@freescale.com>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
 <1449538670-7954-3-git-send-email-peter.chen@freescale.com>
Message-ID: <1449568249.3691.15.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Am Dienstag, den 08.12.2015, 09:37 +0800 schrieb Peter Chen:
> Add dt-binding documentation for generic onboard USB HUB.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  .../bindings/usb/generic-onboard-hub.txt           | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt b/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> new file mode 100644
> index 0000000..ea92205
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> @@ -0,0 +1,28 @@
> +Generic Onboard USB HUB
>+
> +Required properties:
> +- compatible: should be "generic-onboard-hub"

This something we don't have to define ad-hoc. The hub hangs off an USB
controller, right? The "Open Firmware recommended practice: USB"
document already describes how to represent USB devices in a generic
manner:
http://www.firmware.org/1275/bindings/usb/usb-1_0.ps

Is there a reason not to reuse this?

The usb hub node would be a child of the usb controller node, and it
could use
	compatible = "usb,class9"; /* bDeviceClass 9 (Hub) */


> +Optional properties:
> +- clocks: the input clock for HUB.
> +
> +- clock-names: Should be "external_clk"

Is clock-names necessary for a single clock?

> +- hub-reset-gpios: Should specify the GPIO for reset.

I'd prefer that to be just "reset-gpios", it is the only reset property
in the hub node after all. And use the GPIO_ACTIVE_HIGH/LOW flags to
indicate polarity.

> +- hub-reset-active-high: the active reset signal is high, if this property is
> +  not set, the active reset signal is low.

Then this could be dropped.

> +- hub-reset-duration-us: the duration for assert reset signal, the time unit
> +  is microsecond.

And consequently, this could just be called "reset-duration-us".
It might make sense to define the same for other reset GPIOs, too.
The Freescale FEC, for example, has "phy-reset-duration" (in ms)
already.

> +
> +Example:
> +
> +	usb_hub1 {
> +		compatible = "generic-onboard-hub";
> +		clocks = <&clks IMX6QDL_CLK_CKO>;
> +		clock-names = "external_clk";
> +		hub-reset-gpios = <&gpio7 12 0>;
> +		hub-reset-active-high;
> +		hub-reset-duration-us = <2>;
> +	};

best regards
Philipp
