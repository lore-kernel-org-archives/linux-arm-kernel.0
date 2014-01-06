From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 6 Jan 2014 15:52:04 +0000
Subject: [PATCH 2/2] ehci-platform: Add support for clks and phy passed
 through devicetree
In-Reply-To: <1388963080-12544-2-git-send-email-hdegoede@redhat.com>
References: <1388963080-12544-1-git-send-email-hdegoede@redhat.com>
 <1388963080-12544-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140106155204.GD24664@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 05, 2014 at 11:04:40PM +0000, Hans de Goede wrote:
> Currently ehci-platform is only used in combination with devicetree when used
> with some via socs. By extending it to (optionally) get clks and a phy from
> devicetree, and enabling / disabling those on power_on / off, it can be used
> more generically. Specifically after this commit it can be used for the
> ehci controller on Allwinner sunxi SoCs.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/usb/platform-ehci.txt      |  25 +++++
>  .../devicetree/bindings/usb/vt8500-ehci.txt        |  12 --
>  drivers/usb/host/ehci-platform.c                   | 125 +++++++++++++++++----
>  3 files changed, 131 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/platform-ehci.txt
>  delete mode 100644 Documentation/devicetree/bindings/usb/vt8500-ehci.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/platform-ehci.txt b/Documentation/devicetree/bindings/usb/platform-ehci.txt
> new file mode 100644
> index 0000000..aba6da1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/platform-ehci.txt
> @@ -0,0 +1,25 @@
> +Generic Platform EHCI controller
> +
> +Required properties:
> + - compatible: Should be "platform-ehci"
> +   (legacy: via,vt8500-ehci" or "wm,prizm-ehci")

Is there any reason for these to be considered legacy? New devices could
just declare their compatibility with one of the existing
implementations, e.g:

ehci {
	compatible  = "some-vendor,ehci", "via,vt8500-ehci";
	...
}

No new compatible string needed in the driver, and we can easily add
quirks support later.

I'm also not a fan of "platform-*" naming, it's leaking a Linux-internal
implementation detail.

> + - reg: Address range of the ehci registers.
> + - interrupts: Should contain the ehci interrupt.
> +
> +Optional properties:
> + - clocks: array of clocks
> + - clock-names: clock names "ahb" and/or "ehci"

It would be nice to define clocks in terms of clock-names, as with my
OCHI comments.

[...]

> @@ -85,7 +159,7 @@ static int ehci_platform_probe(struct platform_device *dev)
>  
>  	/*
>  	 * use reasonable defaults so platforms don't have to provide these.
> -	 * with DT probing on ARM, none of these are set.
> +	 * with DT probing on ARM.

Did you mean to also get rid of the full-stop on the line before?

Thanks,
Mark.
