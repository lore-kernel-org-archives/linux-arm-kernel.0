From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 27 May 2014 07:36:03 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7790: link PCI USB devices to USB PHY
In-Reply-To: <201405270217.33057.sergei.shtylyov@cogentembedded.com>
References: <201405270217.33057.sergei.shtylyov@cogentembedded.com>
Message-ID: <CANqRtoT+xKmK7wkayiD9yCmUqFNKWxpeSgkGTiCqc+THYE0sVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 7:17 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Describe the PCI USB devices that are behind the PCI bridges, adding necessary
> links to the USB PHY device.
>
> Based on the original work by Ben Dooks <ben.dooks@codethink.co.uk>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against 'renesas-devel-v3.15-rc7-20140526' tag of Simon Horman's
> 'renesas.git' repo plus R8A7790/Lager PCI and USB PHY support patches posted
> before. The patch requires the internal PCI DT support, USB PHY driver, and
> USB HCD generic PHY support (also already posted) in order to work.
>
> Changes in version 2:
> - renamed the PCI OHCI/EHCI device nodes to comply with the PCI binding;
> - changed the PHY specifier in the PCI#2 node to reflect that channel #1 support
>   was dropped;
> - resolved rejects, refreshed the patch.
>
>  arch/arm/boot/dts/r8a7790.dtsi |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7790.dtsi
> @@ -919,6 +919,20 @@
>                 interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
>                                  0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
>                                  0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
> +
> +               usb at 0,1 {
> +                       reg = <0x800 0 0 0 0>;
> +                       device_type = "pci";
> +                       phys = <&usbphy 0 0>;
> +                       phy-names = "usb";
> +               };
> +
> +               usb at 0,2 {
> +                       reg = <0x1000 0 0 0 0>;
> +                       device_type = "pci";
> +                       phys = <&usbphy 0 0>;
> +                       phy-names = "usb";
> +               };
>         };
>
>         pci1: pci at ee0b0000 {
> @@ -955,5 +969,19 @@
>                 interrupt-map = <0x0000 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
>                                  0x0800 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
>                                  0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
> +
> +               usb at 0,1 {
> +                       reg = <0x800 0 0 0 0>;
> +                       device_type = "pci";
> +                       phys = <&usbphy 1 0>;
> +                       phy-names = "usb";
> +               };
> +
> +               usb at 0,2 {
> +                       reg = <0x1000 0 0 0 0>;
> +                       device_type = "pci";
> +                       phys = <&usbphy 1 0>;
> +                       phy-names = "usb";
> +               };
>         };
>  };

Hi Sergei,

Above I see two hunks of DTS code but my r8a7790 data sheet contains
three USB PCI devices. Perhaps my understanding is wrong, or may there
is some other patch available to enable all USB PCI devices included
in the SoC?

Thanks,

/ magnus
