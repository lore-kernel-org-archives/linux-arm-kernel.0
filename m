From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 10 Jun 2016 11:56:25 +0200
Subject: [linux-sunxi] PATH[1/3] ARM: axp20x_usb_power.c add device tree
 configuration options for REG 30H: VBUS-IPSOUT
In-Reply-To: <0f58d2b3-f3d3-45a3-a307-e54df26c1ab1@googlegroups.com>
References: <0f58d2b3-f3d3-45a3-a307-e54df26c1ab1@googlegroups.com>
Message-ID: <d7cc3227-e75f-6be1-61b0-cd3f8eefff10@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17-05-16 19:41, Ene Alexandru wrote:
> The AXP20X chips have a configuration register "REG 30H: VBUS-IPSOUT Power Path Management" that provide USB power supply protection.
> The current axp20x_usb_power.c provides support only for reading those values.
>
> From the datasheet:
> In order not to affect the USB communication, VBUS is always working under Voltage-Limit mode by default. In this mode, AXP209 ensures that VBUS voltage remains above a configurable reference voltage VHOLD which can meet the USB specification. The default VHOLD is 4.4V, adjustable in Reg30H [5:3] register. If the system has limit on current obtained from USB VBUS, a current-limit mode is provided (See REG30H[1] register), with 900mA/500mA/100mA (Reg30H [0]) selectable.
>
> The following entries are added in the axp209.dtsi file: vhold-enable, vhold-set and ibus-limit
> The chosen default values are the AXP20X reset values, as described in the data sheet.
>
> Signed-off-by: Ene Alexandru <ene.alexandru@gmail.com>
>
>
> ---
> diff -uprN -X linux-sunxi-original/Documentation/dontdiff linux-sunxi-original/arch/arm/boot/dts/axp209.dtsi linux-sunxi/arch/arm/boot/dts/axp209.dtsi
> --- linux-sunxi-original/arch/arm/boot/dts/axp209.dtsi         2016-05-11 09:21:47.470923679 +0200
> +++ linux-sunxi/arch/arm/boot/dts/axp209.dtsi     2016-05-10 18:45:32.795158651 +0200
> @@ -98,5 +98,8 @@
>            usb_power_supply: usb_power_supply {
>                        compatible = "x-powers,axp202-usb-power-supply";
>                        status = "disabled";
> +                      vhold-enable = <0x01>;
> +                      vhold-set = <0x04>;
> +                      ibus-limit = <0x01>;
>            };
> };

Please do not use raw register values like this, instead make the device-tree property take
microvolts / microamps like e.g. the regulator bindings do, and translate these in the
driver.

Regards,

Hans
