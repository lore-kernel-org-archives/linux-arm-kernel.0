From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 6 Jan 2014 15:45:55 +0000
Subject: [PATCH 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <1388963080-12544-1-git-send-email-hdegoede@redhat.com>
References: <1388963080-12544-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140106154555.GC24664@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 05, 2014 at 11:04:39PM +0000, Hans de Goede wrote:
> Add support for ohci-platform instantiation from devicetree, including
> optionally getting clks and a phy from devicetree, and enabling / disabling
> those on power_on / off.
> 
> This should allow using ohci-platform from devicetree in various cases.
> Specifically after this commit it can be used for the ohci controller found
> on Allwinner sunxi SoCs.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/usb/platform-ohci.txt      |  25 ++++
>  drivers/usb/host/ohci-platform.c                   | 146 ++++++++++++++++++---
>  2 files changed, 151 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/platform-ohci.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/platform-ohci.txt b/Documentation/devicetree/bindings/usb/platform-ohci.txt
> new file mode 100644
> index 0000000..6846f1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/platform-ohci.txt
> @@ -0,0 +1,25 @@
> +Generic Platform OHCI controller
> +
> +Required properties:
> + - compatible: Should be "platform-ohci"

To me, "platform-ohci" seems rather Linux-specific. Platform devices are
a Linux abstraction that don't correspond to any particular bus type in
reality.

We have some "*-generic" bindings. A name of that form might be more
appropriate. Or we could choose an arbitrary OHCI implementation's
vendor,ochi string and everything else can declare compatibility with
that.

> + - reg: Address range of the ohci registers.
> + - interrupts: Should contain the ohci interrupt.
> +
> +Optional properties:
> + - clocks: array of clocks
> + - clock-names: clock names "ahb" and/or "ohci"

A description of what the clocks are might be helpful.

How about something like:

- clocks: a list of phandle + clock specifier pairs, one for each entry
  in clock-names.

- clock-names: Should contain:
   * "ahb" - some description here.
   * "ohci" - some description here.

Thanks,
Mark.
