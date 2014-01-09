From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 09 Jan 2014 23:14:30 +0300
Subject: [PATCH v3 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <1389290226-6971-2-git-send-email-hdegoede@redhat.com>
References: <1389290226-6971-1-git-send-email-hdegoede@redhat.com>
 <1389290226-6971-2-git-send-email-hdegoede@redhat.com>
Message-ID: <52CF0326.1090407@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/09/2014 08:57 PM, Hans de Goede wrote:

> Add support for ohci-platform instantiation from devicetree, including
> optionally getting clks and a phy from devicetree, and enabling / disabling
> those on power_on / off.

> This should allow using ohci-platform from devicetree in various cases.
> Specifically after this commit it can be used for the ohci controller found
> on Allwinner sunxi SoCs.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   .../devicetree/bindings/usb/mmio-ohci.txt          |  22 +++
>   drivers/usb/host/ohci-platform.c                   | 150 ++++++++++++++++++---
>   2 files changed, 152 insertions(+), 20 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/usb/mmio-ohci.txt

> diff --git a/Documentation/devicetree/bindings/usb/mmio-ohci.txt b/Documentation/devicetree/bindings/usb/mmio-ohci.txt
> new file mode 100644
> index 0000000..9c776ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mmio-ohci.txt
> @@ -0,0 +1,22 @@
> +Generic MMIO OHCI controller

    OHCI controller always uses MMIO, and likewise EHCI. You don't need to 
specifically mention it.

> +
> +Required properties:
> +- compatible : "mmio-ohci"

    Likewise, it's not a good name. Why not call it "platform-ohci"?

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
> +		compatible = "mmio-ohci";
> +		reg = <0x01c14400 0x100>;
> +		interrupts = <64>;
> +		clocks = <&usb_clk 6>, <&ahb_gates 2>;
> +		phys = <&usbphy 1>;
> +		phy-names = "usb";
> +	};

WBR, Sergei
