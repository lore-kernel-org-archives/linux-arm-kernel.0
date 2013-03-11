From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Mar 2013 10:44:46 -0600
Subject: [PATCH 2/6] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-3-git-send-email-linux@prisktech.co.nz>
Message-ID: <513E09FE.5040104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 10:39 PM, Tony Prisk wrote:
> This patch adds support for the GPIO/pinmux controller found on the VIA
> VT8500 and Wondermedia WM8xxx-series SoCs.
> 
> Each pin within the controller is capable of operating as a GPIO or as
> an alternate function. The pins are numbered according to their control
> bank/bit so that if new pins are added, the existing numbering is maintained.
> 
> All currently supported SoCs are included: VT8500, WM8505, WM8650, WM8750 and
> WM8850.

> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt

> +Required properties:
> +- compatible: "via,vt8500-pinctrl", "wm,wm8505-pinctrl", "wm,wm8650-pinctrl",
> +	"wm8750-pinctrl" or "wm,wm8850-pinctrl"
> +- reg: Should contain the physical address of the module's registers.
> +- gpio-controller: Marks the device node as a GPIO controller.
> +- #gpio-cells : Should be two. The first cell is the pin number and the
> +  second cell is used to specify optional parameters.

Can the GPIOs generate interrupts? If the HW can support this, even if
the driver doesn't initially support it, the binding should describe the
required interrupt-controller and #interrupt-cells properties.

> +Required subnode-properties:
> +- wm,pins: An array of cells. Each cell contains the ID of a pin.

That's a little odd. Presumably this is to allow configuring "pin
configuration" data beyond the mux function and pull. Why aren't those
options exposed as explicit properties, rather than allowing manual
register tweaking?
