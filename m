From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 4 Sep 2018 21:05:42 +0200
Subject: [PATCH] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for
 Bluetooth
In-Reply-To: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
References: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
Message-ID: <CAFBinCAQFcYKRCr72vOtuB9x=Zdt4Ox=pY0E9oxZFCO2XKF7oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

On Tue, Sep 4, 2018 at 4:47 PM chewitt <christianshewitt@gmail.com> wrote:
>
> This change adds the ttyAML1 uart used by the brmcfmac sdio module in
> the WeTek Hub and WeTek Play 2 devices.
do you know which Broadcom chip this is exactly?

I assume you want to use the "patchram" userspace program (or
something similar) to initialize the HCI controller?
it's been a while since a similar patch was rejected, but things have
gotten better since then. more details below

> Signed-off-by: chewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> index 70325b2..9476868 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> @@ -10,6 +10,7 @@
>  / {
>         aliases {
>                 serial0 = &uart_AO;
> +               serial1 = &uart_A;
this can be dropped if you read on

>                 ethernet0 = &ethmac;
>         };
>
> @@ -239,6 +240,13 @@
>         vqmmc-supply = <&vddio_boot>;
>  };
>
> +/* This is connected to the Bluetooth module: */
> +&uart_A {
> +       status = "okay";
> +       pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +       pinctrl-names = "default";
insert bluetooth child-node from [0] here (with the correct max-speed,
*-gpios and clock* properties for this board)

some background: with Rob's serdev framework some Bluetooth controller
drivers recently gained the ability to get the controller into a
working state without any userspace utility. if you add the bluetooth
child-node here the kernel will:
- not create a /dev/ttyAMLn
- load the matching Bluetooth controller driver (the Broadcom one in your case)
- do the "initialize this Bluetooth controller with all the vendor
specific magic" dance (toggling GPIOs, loading firmware from userspace
via standard request_firmware, etc.)
- provide you with a ready-to-use hci0 interface


Regards
Martin


[0] https://elixir.bootlin.com/linux/v4.18/source/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
