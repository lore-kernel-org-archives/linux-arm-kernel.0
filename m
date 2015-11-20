From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 13:47:37 -0600
Subject: [PATCH v2 8/8] arm: dts: lpc32xx: move USB controller subdevices
 into own device node
In-Reply-To: <1445117757-8073-9-git-send-email-vz@mleia.com>
References: <1445117757-8073-1-git-send-email-vz@mleia.com>
 <1445117757-8073-9-git-send-email-vz@mleia.com>
Message-ID: <CAL_JsqJZ+fKe32gaKAJa+8KvaDkNJS0rWD+NQH7hkWxaahC4ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2015 at 4:35 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> NXP LPC32xx SoC has one USB OTG controller, which is supposed to work
> with an external phy (default is NXP ISP1301).
>
> Practically the USB controller contains 5 subdevices:
> - host controller   0x3102 0000 -- 0x3102 00FF
> - OTG controller    0x3102 0100 -- 0x3102 01FF
> - device controller 0x3102 0200 -- 0x3102 02FF
> - I2C controller    0x3102 0300 -- 0x3102 03FF
> - clock controller  0x3102 0F00 -- 0x3102 0FFF

[...]

> -               /*
> -                * Enable either ohci or usbd (gadget)!
> -                */
> -               ohci: ohci at 31020000 {
> -                       compatible = "nxp,ohci-nxp", "usb-ohci";
> -                       reg = <0x31020000 0x300>;
> -                       interrupts = <0x3b 0>;
> -                       status = "disabled";
> -               };
> +               usb {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       compatible = "simple-bus";
> +                       ranges = <0x0 0x31020000 0x00001000>;
>
> -               usbd: usbd at 31020000 {
> -                       compatible = "nxp,lpc3220-udc";
> -                       reg = <0x31020000 0x300>;
> -                       interrupts = <0x3d 0>, <0x3e 0>, <0x3c 0>, <0x3a 0>;
> -                       status = "disabled";
> +                       /*
> +                        * Enable either ohci or usbd (gadget)!
> +                        */
> +                       ohci: ohci at 0 {
> +                               compatible = "nxp,ohci-nxp", "usb-ohci";
> +                               reg = <0x0 0x300>;
> +                               interrupts = <0x3b 0>;
> +                               status = "disabled";
> +                       };
> +
> +                       usbd: usbd at 0 {
> +                               compatible = "nxp,lpc3220-udc";
> +                               reg = <0x0 0x300>;

Not a result of this change, but you are overlapping addresses. Please
don't do that. It causes problems adding device resources into the
resource tree (i.e. request_resource).

Rob
