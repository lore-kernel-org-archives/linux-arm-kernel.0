From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Oct 2015 10:17:52 +0800
Subject: [linux-sunxi] [PATCH] ARM: dts: sun7i: Correct USB regulators on
 pcDuino v3 Nano
In-Reply-To: <1444441679-4802-1-git-send-email-ats@offog.org>
References: <1444441679-4802-1-git-send-email-ats@offog.org>
Message-ID: <CAGb2v67_dSCL2JP1D5SDaqSF3B4KDMKZUJcZ8QLHgFtcO8Bzug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 10, 2015 at 9:47 AM, Adam Sampson <ats@offog.org> wrote:
> The LinkSprite pcDuino v3 Nano's two USB host ports are powered by a
> single RT9701GB regulator, which has its enable input tied to the A20's
> PD2 pin, pulled up to 3v3 via a 10k resistor.
>
> However, the script.bin that shipped with the device listed PH11 and PH3
> as Vbus control pins for the two USB ports. Neither of these are
> actually connected to anything.
>
> Siarhei Siamashka spotted this problem while reviewing the other
> LinkSprite boards. This patch fixes it by only defining a single
> regulator, controlled by PD2. Testing shows that the USB ports are now
> (correctly) only powered up once the USB PHY driver is loaded.
>
> Signed-off-by: Adam Sampson <ats@offog.org>

Since Siarhei spotted the issue, maybe add a Reported-by tag where credit
is due?

> ---
>  arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> index 5361fce..f75e3bd 100644
> --- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> @@ -158,7 +158,7 @@
>         };
>
>         usb1_vbus_pin_pcduino3_nano: usb1_vbus_pin at 0 {
> -               allwinner,pins = "PH11";
> +               allwinner,pins = "PD2";
>                 allwinner,function = "gpio_out";
>                 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> @@ -166,18 +166,17 @@
>  };
>
>  &reg_ahci_5v {
> +       pinctrl-names = "default";

This is already in sunxi-common-regulators.dtsi.
No need to add it again.

>         pinctrl-0 = <&ahci_pwr_pin_pcduino3_nano>;
>         gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
>         status = "okay";
>  };
>
> +/* A single regulator (U24) powers both USB host ports. */
>  &reg_usb1_vbus {
> +       pinctrl-names = "default";

And this.

The rest looks good.

Thanks!
ChenYu

>         pinctrl-0 = <&usb1_vbus_pin_pcduino3_nano>;
> -       gpio = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
> -       status = "okay";
> -};
> -
> -&reg_usb2_vbus {
> +       gpio = <&pio 3 2 GPIO_ACTIVE_HIGH>; /* PD2 */
>         status = "okay";
>  };
>
> @@ -189,6 +188,6 @@
>
>  &usbphy {
>         usb1_vbus-supply = <&reg_usb1_vbus>;
> -       usb2_vbus-supply = <&reg_usb2_vbus>;
> +       usb2_vbus-supply = <&reg_usb1_vbus>;
>         status = "okay";
>  };
> --
> 2.1.4
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
