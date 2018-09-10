From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 10 Sep 2018 20:30:20 +0200
Subject: [PATCH v2] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for
 Bluetooth
In-Reply-To: <1536322536-53109-1-git-send-email-christianshewitt@gmail.com>
References: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
 <1536322536-53109-1-git-send-email-christianshewitt@gmail.com>
Message-ID: <CAFBinCA=sDT4mVD=ZA90SF+d84bg5HCWuv6O5uz4+dKVSxNgiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Sep 7, 2018 at 2:16 PM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> This change adds the uart_A used by the brmcfmac sdio module in the
> WeTek Hub and WeTek Play 2 devices. meson_uart_probe seems to mandate
> an alias (without it, BT is not working) so this is also included.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> index 70325b2..e75ace7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> @@ -10,6 +10,7 @@
>  / {
>         aliases {
>                 serial0 = &uart_AO;
> +               serial1 = &uart_A;
>                 ethernet0 = &ethmac;
>         };
>
> @@ -239,6 +240,18 @@
>         vqmmc-supply = <&vddio_boot>;
>  };
>
> +/* This is connected to the Bluetooth module: */
> +&uart_A {
> +       status = "okay";
> +       pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +       pinctrl-names = "default";
> +
> +       bluetooth {
> +               compatible = "brcm,bcm43438-bt";
I have a question regarding the Broadcom Bluetooth compatible strings:
Christian mentioned earlier that the Bluetooth controller identifies
itself as BCM4335C0 (BCM4335 rev. C0)

do we need to add a new compatible string (to
Documentation/devicetree/bindings/net/broadcom-bluetooth.txt)?
if yes: should we also add a new of_device_id to hci_bcm.c or should
board.dts simply use compatible = "brcm,bcm4335c0-bt",
"brcm,bcm43438-bt"?


Regards
Martin
