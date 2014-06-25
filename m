From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Jun 2014 15:46:18 -0600
Subject: [PATCH v1 3/9] of: Update Tegra XUSB pad controller binding for
 USB
In-Reply-To: <1403072180-4944-4-git-send-email-abrestic@chromium.org>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
 <1403072180-4944-4-git-send-email-abrestic@chromium.org>
Message-ID: <53AB432A.7010400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2014 12:16 AM, Andrew Bresticker wrote:
> Add new bindings used for USB support by the Tegra XUSB pad controller.
> This includes additional PHY types, USB-specific pinconfig properties, etc.

> diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt

> @@ -21,6 +21,12 @@ Required properties:
>    - padctl
>  - #phy-cells: Should be 1. The specifier is the index of the PHY to reference.
>    See <dt-bindings/pinctrl/pinctrl-tegra-xusb.h> for the list of valid values.
> +- nvidia,xusb-mbox: Handle to the Tegra XUSB mailbox node.

Why does the padctrl code need access to the XUSB mailbox? Isn't the
padctrl HW module something that provides services to the XUSB code. I
would have expected the XUSB node to reference the padctrl node. If
notifications need to be sent back from XUSB padctrl to XUSB, then that
seems like an internal SW detail that doesn't need to be represented in DT.

> +Optional properties:
> +-------------------
> +- vbus-otg-{0,1,2}-supply: VBUS regulator for the corresponding UTMI pad.

Isn't VBUS something that's controlled by the USB PHY? I think the PHYs
are part of the XUSB controller, whereas the XUSB pad control is just
the low level IO pad HW.

> +- nvidia,usb3-port-num: USB3 port (0 or 1) to which the lane is mapped.
> +- nvidia,usb2-port-num: USB2 port (0, 1, or 2) to which the lane is mapped.
> +- nvidia,hsic-strobe-trim: HSIC strobe trimmer value.
> +- nvidia,hsic-rx-strobe-trim: HSIC RX strobe trimmer value.
> +- nvidia,hsic-rx-data-trim: HSIC RX data trimmer value.
> +- nvidia,hsic-tx-rtune-n: HSIC TX RTUNEN value.
> +- nvidia,hsic-tx-rtune-p: HSIC TX RTUNEP value.
> +- nvidia,hsic-tx-slew-n: HSIC TX SLEWN value.
> +- nvidia,hsic-tx-slew-p: HSIC TX SLEWP value.
> +- nvidia,hsic-auto-term: Enables HSIC AUTO_TERM. (0: no, 1: yes)

I wonder if some of that isn't part of the PHY not the pads?

>      Valid functions for this group are: "snps", "xusb", "uart", "rsvd".
>  
> -    The nvidia,iddq property does not apply to this group.
> +    The nvidia,iddq, nvidia,usb3-port-num, nvidia,usb2-port-num, and
> +    nvidia,hsic-* properties do not apply to this group.

Given the increased number of properties we now have, it seems better to
list the properties that *do* apply to each group, rather than those
that don't.
