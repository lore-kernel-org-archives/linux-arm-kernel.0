From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Mar 2014 08:58:24 -0300
Subject: [PATCH v2][ 4/8] ARM: dts: imx25.dtsi: Fix USB support.
In-Reply-To: <1394535304-10240-4-git-send-email-denis@eukrea.com>
References: <1394535304-10240-1-git-send-email-denis@eukrea.com>
 <1394535304-10240-4-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5CX9GhKpKLf5JVth8zqt5sEaML8q9pbBgBPXSDKCAueBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Tue, Mar 11, 2014 at 7:55 AM, Denis Carikli <denis@eukrea.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> This patch was adapted from the thread named
> "USB Host support for mx25" on linux-usb at vger.kernel.org
>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> Changelog v1->v2:
> - The usbphy nodes were made to look like the ones in imx53.dtsi
> - The patch was rebased on top of the clock fixes commits.
> ---
>  arch/arm/boot/dts/imx25.dtsi |   27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index 829791e..16bc571 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -482,22 +482,13 @@
>                                 clocks = <&clks 99>;
>                         };
>
> -                       usbphy1: usbphy at 1 {
> -                               compatible = "nop-usbphy";
> -                               status = "disabled";
> -                       };
> -
> -                       usbphy2: usbphy at 2 {
> -                               compatible = "nop-usbphy";
> -                               status = "disabled";
> -                       };
> -
>                         usbotg: usb at 53ff4000 {
>                                 compatible = "fsl,imx25-usb", "fsl,imx27-usb";
>                                 reg = <0x53ff4000 0x0200>;
>                                 interrupts = <37>;
>                                 clocks = <&clks 70>;
>                                 fsl,usbmisc = <&usbmisc 0>;
> +                               fsl,usbphy = <&usbphy1>;
>                                 status = "disabled";
>                         };
>
> @@ -507,6 +498,7 @@
>                                 interrupts = <35>;
>                                 clocks = <&clks 70>;
>                                 fsl,usbmisc = <&usbmisc 1>;
> +                               fsl,usbphy = <&usbphy2>;
>                                 status = "disabled";
>                         };
>
> @@ -516,7 +508,6 @@
>                                 clocks = <&clks 9>, <&clks 70>, <&clks 8>;
>                                 clock-names = "ipg", "ahb", "per";
>                                 reg = <0x53ff4600 0x00f>;
> -                               status = "disabled";
>                         };
>
>                         dryice at 53ffc000 {
> @@ -548,4 +539,18 @@
>                         };
>                 };
>         };
> +
> +       usbphy {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "simple-bus";
> +
> +               usbphy1: usbphy at 1 {
> +                       compatible = "usb-nop-xceiv";
> +               };
> +
> +               usbphy2: usbphy at 2 {
> +                       compatible = "usb-nop-xceiv";
> +               };
> +       };

Do we really need to put usbphy1 and usbphy2 under 'simple-bus'? This
is not documented at
Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt.

I know that other imx SoCs do like this as you marked below the --- line.

In the version I sent yesterday I kept usbphy1/2 in their original
locations, and have not placed them under 'simple-bus'.

Adding Mark on Cc in case he can confirm it.

Thanks,

Fabio Estevam
