From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 9 Jun 2016 12:53:52 +0200
Subject: [PATCH 1/2] ARM: dts: sun6i: Add pmic / regulator nodes to Mele
 A1000G quad dts
In-Reply-To: <20160607212545.GF14179@lukather>
References: <1465133880-22921-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v67Jo6MO7bp4JdV4hXrB4T60z4=ROkvAvE1i7dhAXk_UtQ@mail.gmail.com>
 <0a42bc82-83f2-80ce-93d4-a85c5ce69e24@redhat.com>
 <20160607212545.GF14179@lukather>
Message-ID: <355dac66-46cc-c6cf-7831-e14ea394ae55@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On 07-06-16 23:25, Maxime Ripard wrote:
> On Mon, Jun 06, 2016 at 09:23:36AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 06-06-16 09:12, Chen-Yu Tsai wrote:
>>> On Sun, Jun 5, 2016 at 9:37 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Add pmic / regulator nodes to Mele A1000G quad dts.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts | 88 +++++++++++++++++++++++-
>>>> 1 file changed, 87 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
>>>> index e063dab..9782113 100644
>>>> --- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
>>>> +++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
>>>> @@ -72,6 +72,10 @@
>>>>        };
>>>> };
>>>>
>>>> +&cpu0 {
>>>> +       cpu-supply = <&reg_dcdc3>;
>>>> +};
>>>> +
>>>> &ehci0 {
>>>>        status = "okay";
>>>> };
>>>> @@ -85,6 +89,7 @@
>>>>        pinctrl-0 = <&gmac_pins_mii_a>;
>>>>        phy = <&phy1>;
>>>>        phy-mode = "mii";
>>>> +       phy-supply = <&reg_dldo1>;
>>>>        status = "okay";
>>>>
>>>>        phy1: ethernet-phy at 1 {
>>>> @@ -101,13 +106,26 @@
>>>> &mmc0 {
>>>>        pinctrl-names = "default";
>>>>        pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
>>>> -       vmmc-supply = <&reg_vcc3v3>;
>>>> +       vmmc-supply = <&reg_dcdc1>;
>>>>        bus-width = <4>;
>>>>        cd-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
>>>>        cd-inverted;
>>>>        status = "okay";
>>>> };
>>>>
>>>> +&p2wi {
>>>> +       status = "okay";
>>>> +
>>>> +       axp22x: pmic at 68 {
>>>> +               compatible = "x-powers,axp221";
>>>> +               reg = <0x68>;
>>>> +               interrupt-parent = <&nmi_intc>;
>>>> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>>> +       };
>>>> +};
>>>> +
>>>> +#include "axp22x.dtsi"
>>>> +
>>>> &pio {
>>>>        led_pins_m9: led_pins at 0 {
>>>>                allwinner,pins = "PH13";
>>>> @@ -131,6 +149,73 @@
>>>>        };
>>>> };
>>>>
>>>> +&reg_aldo1 {
>>>> +       regulator-min-microvolt = <3300000>;
>>>> +       regulator-max-microvolt = <3300000>;
>>>> +       regulator-name = "vcc-wifi";
>>>> +};
>>>> +
>>>> +&reg_aldo3 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <2700000>;
>>>> +       regulator-max-microvolt = <3300000>;
>>>> +       regulator-name = "avcc";
>>>> +};
>>>> +
>>>> +&reg_dc5ldo {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <700000>;
>>>> +       regulator-max-microvolt = <1320000>;
>>>> +       regulator-name = "vdd-cpus"; /* This is an educated guess */
>>>> +};
>>>> +
>>>> +&reg_dcdc1 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <3300000>;
>>>> +       regulator-max-microvolt = <3300000>;
>>>> +       regulator-name = "vcc-3v3";
>>>> +};
>>>> +
>>>> +&reg_dcdc2 {
>>>> +       regulator-min-microvolt = <700000>;
>>>> +       regulator-max-microvolt = <1320000>;
>>>> +       regulator-name = "vdd-gpu";
>>>> +};
>>>> +
>>>> +&reg_dcdc3 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <700000>;
>>>> +       regulator-max-microvolt = <1320000>;
>>>> +       regulator-name = "vdd-cpu";
>>>> +};
>>>> +
>>>> +&reg_dcdc4 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <700000>;
>>>> +       regulator-max-microvolt = <1320000>;
>>>> +       regulator-name = "vdd-sys-dll";
>>>> +};
>>>> +
>>>> +&reg_dcdc5 {
>>>> +       regulator-always-on;
>>>> +       regulator-min-microvolt = <1500000>;
>>>> +       regulator-max-microvolt = <1500000>;
>>>> +       regulator-name = "vcc-dram";
>>>> +};
>>>> +
>>>> +&reg_dldo1 {
>>>> +       regulator-min-microvolt = <3300000>;
>>>> +       regulator-max-microvolt = <3300000>;
>>>> +       regulator-name = "vcc-ethernet-phy";
>>>> +};
>>>> +
>>>> +&reg_dldo4 {
>>>> +       regulator-always-on;
>>>
>>> Why not tie this to the usbphy? Same for the other patch.
>>
>> Because both reg_usb1_vbus and reg_dldo4 need to be on
>> for the hub attached to usb1 to work, and I can list
>> only one usb1_vbus-supply.
>
> Adding a comment stating that would be great :)

Ok I'll send a v2 of both patch with an amended commit msg.

Regards,

Hans
