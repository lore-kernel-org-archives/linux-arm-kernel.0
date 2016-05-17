From: julian.calaby@gmail.com (Julian Calaby)
Date: Wed, 18 May 2016 09:21:03 +1000
Subject: [linux-sunxi] Re: PATH[1/3] ARM: axp20x_usb_power.c add device
 tree configuration options for REG 30H: VBUS-IPSOUT
In-Reply-To: <35a39bdc-1304-403d-b56a-a45bb8debf5e@googlegroups.com>
References: <0f58d2b3-f3d3-45a3-a307-e54df26c1ab1@googlegroups.com>
 <671c7471-b63a-40cc-989f-6b20f00571ee@googlegroups.com>
 <35a39bdc-1304-403d-b56a-a45bb8debf5e@googlegroups.com>
Message-ID: <CAGRGNgX7A3bx9Dam2j1ovdf4s8L9GTi3DM4zMeyu0x3b0wwCgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ene,

On Wed, May 18, 2016 at 3:50 AM, Ene Alexandru <ene.alexandru@gmail.com> wrote:
> the documentation is updated to describe how to convert actual values to the
> provided parameters
>
> ---
> diff -uprN -X linux-sunxi-original/Documentation/dontdiff
> linux-sunxi-original/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
> linux-sunxi/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
> ---
> linux-sunxi-original/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
> 2016-05-09 16:48:46.000000000 +0200
> +++
> linux-sunxi/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
> 2016-05-11 13:05:58.995873267 +0200
> @@ -5,6 +5,26 @@ Required Properties:
>  This node is a subnode of the axp20x PMIC.
> +The following 3 parameters are configurable from the device-tree:
> +          - vhold-enable
> +                      - bit 6 of register REG 30H: VBUS-IPSOUT Power Path
> Management

I don't think it's necessary to go into this much detail here.

> +                      - available values are:
> +                                  - 0x00 : VBUS VHOLD voltage limiting
> control disabled
> +                                  - 0x01 : VBUS VHOLD voltage limiting
> control enabled

If these are the only options available, why not make this property a boolean?

> +          - vhold-set
> +                      - bits <5-3> of register REG 30H: VBUS-IPSOUT Power
> Path Management
> +                      - available values are from 0x00 to 0x07
> +                      - VHOLD = [4000000 + ( vhold-set & 0x07 ) * 100000]
> in uV

What does this actually do? Is this the lower limit on the voltage? Is
this the voltage it'll try to maintain?

> +          - ibus-limit
> +                      - bits <1-0> of register REG 30H: VBUS-IPSOUT Power
> Path Management
> +                      - available values are :
> +                                  - 0x00 : 900000uA
> +                                  - 0x01 : 500000uA
> +                                  - 0x02 : 100000uA
> +                                  - 0x03 : unlimited

Again, what does this actually do? It looks like the current limit?

> +
> +

Extra blank line.

> Example:
>  axp209: pmic at 34 {
> @@ -30,5 +50,8 @@ axp209: pmic at 34 {
>             usb-power-supply: usb-power-supply {
>                        compatible = "x-powers,axp202-usb-power-supply";
> +                      vhold-enable = <0x01>;
> +                      vhold-set = <0x04>;
> +                      ibus-limit = <0x01>;
>            };
> };

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
