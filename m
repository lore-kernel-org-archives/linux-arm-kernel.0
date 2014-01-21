From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 21 Jan 2014 20:59:24 +0300
Subject: [PATCH v7 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <1389813883-567-2-git-send-email-hdegoede@redhat.com>
References: <1389813883-567-1-git-send-email-hdegoede@redhat.com>
 <1389813883-567-2-git-send-email-hdegoede@redhat.com>
Message-ID: <52DEB57C.8080700@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/15/2014 10:24 PM, Hans de Goede wrote:

> Add support for ohci-platform instantiation from devicetree, including
> optionally getting clks and a phy from devicetree, and enabling / disabling
> those on power_on / off.

> This should allow using ohci-platform from devicetree in various cases.
> Specifically after this commit it can be used for the ohci controller found
> on Allwinner sunxi SoCs.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
[...]

   Have only found time to fully read the patches just now...

> diff --git a/Documentation/devicetree/bindings/usb/usb-ohci.txt b/Documentation/devicetree/bindings/usb/usb-ohci.txt
> new file mode 100644
> index 0000000..f9d6c73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-ohci.txt
> @@ -0,0 +1,22 @@
> +USB OHCI controllers
> +
> +Required properties:
> +- compatible : "usb-ohci"
> +- reg : ohci controller register range (address and length)
> +- interrupts : ohci controller interrupt
> +
> +Optional properties:
> +- clocks : a list of phandle + clock specifier pairs
> +- phys : phandle + phy specifier pair
> +- phy-names : "usb"
> +
> +Example:
> +
> +	ohci0: ohci at 0x01c14400 {

    Two minor nits: there should be no "0x" in the address part of the node 
name. And according to ePAPR [1], "the name of a node should be somewhat 
generic, reflecting the function of the device and not its precise programming 
model. If appropriate, the name should be one of the following choices:
[...]
- usb".

    Same comments for "usb-ehci" binding.

> +		compatible = "allwinner,sun4i-a10-ohci", "usb-ohci";
> +		reg = <0x01c14400 0x100>;
> +		interrupts = <64>;
> +		clocks = <&usb_clk 6>, <&ahb_gates 2>;
> +		phys = <&usbphy 1>;
> +		phy-names = "usb";
> +	};

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
