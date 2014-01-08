From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Jan 2014 19:16:32 +0100
Subject: [PATCH v2 2/2] ehci-platform: Add support for clks and phy
 passed through devicetree
In-Reply-To: <1389198608-24339-3-git-send-email-hdegoede@redhat.com>
References: <1389198608-24339-1-git-send-email-hdegoede@redhat.com>
 <1389198608-24339-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20140108181632.GG2941@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 05:30:08PM +0100, Hans de Goede wrote:
> Currently ehci-platform is only used in combination with devicetree when used
> with some via socs. By extending it to (optionally) get clks and a phy from
> devicetree, and enabling / disabling those on power_on / off, it can be used
> more generically. Specifically after this commit it can be used for the
> ehci controller on Allwinner sunxi SoCs.
> 
> Somehow we've ended up with 2 device-bindings documents for ehci-platform.c,
> this patch renames and updates one to platform-ehci.txt to reflect that this
> is a generic platform driver, and removes the other.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/usb/platform-ehci.txt      |  25 ++++
>  .../devicetree/bindings/usb/via,vt8500-ehci.txt    |  15 ---
>  .../devicetree/bindings/usb/vt8500-ehci.txt        |  12 --
>  drivers/usb/host/ehci-platform.c                   | 126 +++++++++++++++++----
>  4 files changed, 131 insertions(+), 47 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/platform-ehci.txt
>  delete mode 100644 Documentation/devicetree/bindings/usb/via,vt8500-ehci.txt
>  delete mode 100644 Documentation/devicetree/bindings/usb/vt8500-ehci.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/platform-ehci.txt b/Documentation/devicetree/bindings/usb/platform-ehci.txt
> new file mode 100644
> index 0000000..56c478d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/platform-ehci.txt
> @@ -0,0 +1,25 @@
> +Generic Platform EHCI controller
> +
> +Required properties:
> +- compatible : "via,vt8500-ehci" or "wm,prizm-ehci"
> +- reg : ehci controller register range (address and length)
> +- interrupts : ehci controller interrupt
> +
> +Optional properties:
> +- clocks : a list of phandle + clock specifier pairs, one for each entry
> +   in clock-names.
> +- clock-names : "clk0", "clk1", ...
> +- phys : phy
> +- phy-names : "phy0"
> +
> +Example:
> +
> +	ehci at d8007900 {
> +		compatible = "via,vt8500-ehci";
> +		reg = <0xd8007900 0x200>;
> +		interrupts = <43>;
> +		clocks = <&usb_clk 6>, <&ahb_gates 2>;
> +		clock-names = "clk0", "clk1";

I'm really not convinced by this either. It prevents you from doing
anything useful out of these clocks, and the only thing you can
actually do with it is calling clk_get, and that's pretty much it.

What if you some platform needs to adjust the rate of one of the two?
Or wants to cut one but not the other for any reason? You're just
screwed, and you can do anything about it, because you have no way of
telling what "clk0" is used for.

Especially, since what you really want is to access the clocks by
index, that you can do with of_clk_get.

Calling it "bus" and "phy" or whatever it's used for both provide a
way of differentiating the two, yet being rather generic. And if we
need to add a third one, I'm pretty sure we will be able to come up
with a generic name then.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/f9c3b60a/attachment-0001.sig>
