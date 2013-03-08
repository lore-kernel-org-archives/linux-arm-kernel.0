From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 08 Mar 2013 11:46:12 +0100
Subject: [PATCH 01/13] usb: phy: nop: Add device tree support and binding
 information
In-Reply-To: <1359993540-20780-2-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-2-git-send-email-rogerq@ti.com>
Message-ID: <5139C174.7030401@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2013 04:58 PM, Roger Quadros wrote:
> The PHY clock, clock rate, VCC regulator and RESET regulator
> can now be provided via device tree.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 ++++++++++++++++++++
>  drivers/usb/otg/nop-usb-xceiv.c                    |   31 ++++++++++++++++++
>  2 files changed, 65 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> new file mode 100644
> index 0000000..d7e2726
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> @@ -0,0 +1,34 @@
> +USB NOP PHY
> +
> +Required properties:
> +- compatible: should be usb-nop-xceiv
> +
> +Optional properties:
> +- clocks: phandle to the PHY clock. Use as per Documentation/devicetree
> +  /bindings/clock/clock-bindings.txt
> +  This property is required if clock-frequency is specified.
> +
> +- clock-names: Should be "main_clk"
> +
> +- clock-frequency: the clock frequency (in Hz) that the PHY clock must
> +  be configured to.
> +
> +- vcc-supply: phandle to the regulator that provides RESET to the PHY.
> +
> +- reset-supply: phandle to the regulator that provides power to the PHY.
> +
> +Example:
> +
> +	hsusb1_phy {
> +		compatible = "usb-nop-xceiv";
> +		clock-frequency = <19200000>;

Why do you hardcode the clock frequency here? You should use
clk_get_rate() to get the frequency from the clock tree.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/9f142d8f/attachment.sig>
