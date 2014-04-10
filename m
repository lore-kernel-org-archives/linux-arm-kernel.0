From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 10 Apr 2014 16:07:23 +0900
Subject: [PATCH] ARM: shmobile: r8a7790: link PCI USb devices to USB PHY
In-Reply-To: <201404092318.26231.sergei.shtylyov@cogentembedded.com>
References: <201404092318.26231.sergei.shtylyov@cogentembedded.com>
Message-ID: <CANqRtoQeuT=Q9PRYNMqA079gjb1VkwgvcDmsWKxjzSVxcVfeWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thanks for this patch, good to see that the relationship between the
USB Host and the PHY is described via DT.

This patch seems to cover USB0 and USB2 that both require special
control in the PHY. How about USB1? Can you explain about the reason
why you omit that?

I somehow expected USB1 to be tied to the PHY via DT as well, this so
the PHY driver can be able to disable the hardware if no ports are
registered. In detail, I'm thinking that the register.bit
UGCTL.CONNECT wants to be set to 0 by default but be set to 1 once one
or more USB controllers are hooked up to the PHY.

Cheers,

/ magnus

On Thu, Apr 10, 2014 at 4:18 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Describe the PCI USB devices that are behind the PCI bridges, adding necessary
> links to the USB PHY device.
>
> Based on the original work by Ben Dooks <ben.dooks@codethink.co.uk>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against 'renesas-devel-v3.14-20140408' tag of Simon Horman's
> 'renesas.git' repo plus R8A7790/Lager PCI and USB PHY support patches posted
> yesterday and day before. The patch requires the internal PCI and USB PHY
> drivers (also already posted) in order to work...
>
>  arch/arm/boot/dts/r8a7790.dtsi |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7790.dtsi
> @@ -841,6 +841,20 @@
>                 bus-range = <0 0>;
>                 #address-cells = <3>;
>                 #size-cells = <2>;
> +
> +               pci at 0,1 {
> +                       reg = <0x800 0 0 0 0>;
> +                       device_type = "pci";
> +                       phys = <&usbphy 0 0>;
> +                       phy-names = "usb";
> +               };
> +
> +               pci at 0,2 {
> +                       reg = <0x1000 0 0 0 0>;
> +                       device_type = "pci";
> +                       phys = <&usbphy 0 0>;
> +                       phy-names = "usb";
> +               };
>         };
>
>         pci1: pci at ee0b0000 {
> @@ -867,5 +881,19 @@
>                 bus-range = <2 2>;
>                 #address-cells = <3>;
>                 #size-cells = <2>;
> +
> +               pci at 0,1 {
> +                       reg = <0x800 0 0 0 0>;
> +                       device_type = "pci";
> +                       phys = <&usbphy 2 0>;
> +                       phy-names = "usb";
> +               };
> +
> +               pci at 0,2 {
> +                       reg = <0x1000 0 0 0 0>;
> +                       device_type = "pci";
> +                       phys = <&usbphy 2 0>;
> +                       phy-names = "usb";
> +               };
>         };
>  };
