From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 9 Feb 2016 20:54:52 +0100
Subject: [linux-sunxi][PATCH v2] ARM: dts: sun7i: Enable USB DRC on Itead
 Ibox
In-Reply-To: <CAEKpxBncN5-WYTNTw+8jfZypiMNfJt=55qEx2zTPfvZmjr9XdQ@mail.gmail.com>
References: <1455010156-27754-1-git-send-email-codekipper@gmail.com>
 <20160209183420.GW31506@lukather>
 <CAEKpxBncN5-WYTNTw+8jfZypiMNfJt=55qEx2zTPfvZmjr9XdQ@mail.gmail.com>
Message-ID: <56BA440C.5030903@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/09/2016 08:10 PM, Code Kipper wrote:
>
>
> On 9 February 2016 at 19:34, Maxime Ripard <maxime.ripard at free-electrons.com <mailto:maxime.ripard@free-electrons.com>> wrote:
>  > Hi,
>  >
>  > On Tue, Feb 09, 2016 at 10:29:16AM +0100, codekipper at gmail.com <mailto:codekipper@gmail.com> wrote:
>  >> From: Marcus Cooper <codekipper at gmail.com <mailto:codekipper@gmail.com>>
>  >>
>  >> Enable the otg/drc usb controller on the Itead Ibox device.
>  >>
>  >> Note this board has the otg-vbus connected directly to the 5v-dcc of
>  >> the board, so there is no vbus0 regulator, nor vbus0-det.
>  >>
>  >> Signed-off-by: Marcus Cooper <codekipper at gmail.com <mailto:codekipper@gmail.com>>
>  >> ---
>  >> Changes since v1:
>  >> - Added comment concerning vbus0 regulator and detection to commit message
>  >>
>  >> ---
>  >>  arch/arm/boot/dts/sun7i-a20-itead-ibox.dts     | 14 ++++++++++++++
>  >>  arch/arm/boot/dts/sunxi-itead-core-common.dtsi |  9 +++++++++
>  >>  2 files changed, 23 insertions(+)
>  >>
>  >> diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
>  >> index 661c21d..a512581 100644
>  >> --- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
>  >> +++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
>  >> @@ -118,8 +118,22 @@
>  >>               allwinner,drive = <SUN4I_PINCTRL_20_MA>;
>  >>               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  >>       };
>  >> +
>  >> +     usb0_id_detect_pin: usb0_id_detect_pin at 0 {
>  >> +             allwinner,pins = "PH4";
>  >> +             allwinner,function = "gpio_in";
>  >> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>  >> +             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  >> +     };
>  >>  };
>  >>
>  >>  &reg_ahci_5v {
>  >>       status = "okay";
>  >>  };
>  >> +
>  >> +&usbphy {
>  >> +     pinctrl-names = "default";
>  >> +     pinctrl-0 = <&usb0_id_detect_pin>;
>  >> +     usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
>  >> +     status = "okay";
>  >> +};
>  >> diff --git a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>  >> index 2565d51..d22eea3 100644
>  >> --- a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>  >> +++ b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
>  >> @@ -88,6 +88,10 @@
>  >>       status = "okay";
>  >>  };
>  >>
>  >> +&otg_sram {
>  >> +     status = "okay";
>  >> +};
>  >> +
>  >>  #include "axp209.dtsi"
>  >>
>  >>  &reg_dcdc2 {
>  >> @@ -129,6 +133,11 @@
>  >>       status = "okay";
>  >>  };
>  >>
>  >> +&usb_otg {
>  >> +     dr_mode = "otg";
>  >
>  > If VBUS is tied to 5V, without anyway to disable it, then it cannot do
>  > OTG.
>  >
>  > The mode it can do is host.
> This is the same patch as what was applied to cubieboard2 https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts?id=b8962f7ee700580a148e05eceb2302bcfc59ffbc which it looks like this hardware copies. I can power the Ibox using this USB socket and when I plug in a usb2ethernet device then it is detected.

Right, the otg port on the cubieboard can work in otg mode just fine, as long as either the
otg is the only power supply, or the 5v supplied to the power barrel comes from the same
source as the otg 5v. Note that only allowing host mode does not take away this limitation
as the 2 5v pins are hardwired together, so we might just as well offer otg support.

Regards,

Hans
