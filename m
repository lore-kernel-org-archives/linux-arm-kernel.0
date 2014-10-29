From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 29 Oct 2014 10:43:40 +0100
Subject: [PATCH RESEND V4 5/9] of: Add NVIDIA Tegra xHCI controller binding
In-Reply-To: <1414535277-15645-6-git-send-email-abrestic@chromium.org>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-6-git-send-email-abrestic@chromium.org>
Message-ID: <20141029094338.GA28356@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 03:27:50PM -0700, Andrew Bresticker wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
[...]
> +Optional properties:
> +-------------------
> +- vbus-{0,1,2}-supply: VBUS regulator for the corresponding UTMI pad.
> +- vddio-hsic-supply: VDDIO regulator for the HSIC pads.
> +- nvidia,usb3-port-{0,1}-lane: PCIe/SATA lane to which the corresponding USB3
> +  port is mapped.  See <dt-bindings/pinctrl/pinctrl-tegra-xusb.h> for the list
> +  of valid values.

I dislike how we now need to provide a list of all pins in the header
file, where previously we used strings for this. This could become very
ugly if the set of pins changes in future generations of this IP block.

Could we instead derive this from the pinmux nodes? For example you have
this in the example below:

	usb3p0 {
		nvidia,lanes = "pcie-0";
		...
	};

Perhaps what we need is to either key off the node name or add another
property, such as:

	nvidia,usb3-port = <0>;

This would match the nvidia,usb2-port property that you've added below.

>  Lane muxing:
>  ------------
> @@ -50,6 +62,17 @@ Optional properties:
>    pin or group should be assigned to. Valid values for function names are
>    listed below.
>  - nvidia,iddq: Enables IDDQ mode of the lane. (0: no, 1: yes)
> +- nvidia,usb2-port-num: USB2 port (0, 1, or 2) to which the lane is mapped.

I'd leave away the -num suffix since it is implied that it's a number.

> +- nvidia,hsic-strobe-trim: HSIC strobe trimmer value.
> +- nvidia,hsic-rx-strobe-trim: HSIC RX strobe trimmer value.
> +- nvidia,hsic-rx-data-trim: HSIC RX data trimmer value.
> +- nvidia,hsic-tx-rtune-n: HSIC TX RTUNEN value.
> +- nvidia,hsic-tx-rtune-p: HSIC TX RTUNEP value.
> +- nvidia,hsic-tx-slew-n: HSIC TX SLEWN value.
> +- nvidia,hsic-tx-slew-p: HSIC TX SLEWP value.

It would be useful for these to provide a range of valid values. I also
see that there are other registers that contain values for tuning. I
take it that the ones you've included here are the only ones that need
to be overridden on hardware you've tested this on? That should be fine,
we can always add new ones if necessary.

> +- nvidia,hsic-auto-term: Enables HSIC AUTO_TERM. (0: no, 1: yes)
> +- nvidia,otg-hs-curr-level-offset: Offset to be applied to the pad's fused
> +  HS_CURR_LEVEL value.
>  
>  Note that not all of these properties are valid for all lanes. Lanes can be
>  divided into three groups:
> @@ -58,18 +81,21 @@ divided into three groups:
>  
>      Valid functions for this group are: "snps", "xusb", "uart", "rsvd".
>  
> -    The nvidia,iddq property does not apply to this group.
> +    The nvidia,otg-hs-curr-level-offset property only applies.

The wording is confusing here in my opinion. Maybe better: "Only the ...
property applies."?

>    - ulpi-0, hsic-0, hsic-1:
>  
>      Valid functions for this group are: "snps", "xusb".
>  
> -    The nvidia,iddq property does not apply to this group.
> +    The nvidia,hsic-* properties apply only to the pins hsic-{0,1} when
> +    the function is xusb.

I assume that hsic-* properties also only apply to the hsic-* pins?
That's not clear from the above sentence.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/299b64f8/attachment.sig>
