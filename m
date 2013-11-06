From: neko@bakuhatsu.net (Matt Sealey)
Date: Wed, 6 Nov 2013 16:43:37 -0600
Subject: [PATCH v6 4/8] ARM: dts: imx27 pinctrl
In-Reply-To: <1382950843-26066-5-git-send-email-mpa@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
 <1382950843-26066-5-git-send-email-mpa@pengutronix.de>
Message-ID: <CAHCPf3sz6eOYrnNDfOTo5Z5dZP2U9+GtQMKYZEb-1WfuXepa6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 4:00 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> Pinctrl driver node and pin group definitions for other driver nodes.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 102 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index b7a1c6d..641a63d 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -10,6 +10,7 @@
>   */
>
>  #include "skeleton.dtsi"
> +#include "imx27-pinfunc.h"
>
>  / {
>         aliases {
> @@ -235,6 +236,12 @@
>                                 status = "disabled";
>                         };
>
> +                       iomuxc: iomuxc at 10015000 {
> +                               compatible = "fsl,imx27-iomuxc";
> +                               reg = <0x10015000 0x600>;
> +
> +                       };
> +
>                         gpio1: gpio at 10015000 {
>                                 compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
>                                 reg = <0x10015000 0x100>;

Linus,

Case in point, you can't have two nodes which overlap registers.

Probably the most reasonable way to effect this is to keep the GPIO
bindings, put pinctrl definitions in there (there's no reason pinctrl
and gpio drivers can't probe the same compatible property) and use
regmap internally on that single node.

On the good news side, this makes the pinctrl binding easier as every
single one would be is parented by a gpio instance (gpio1 as above,
for example), so it doesn't need to specify a port number anymore or
do any (port*32)+pin math - just a pin index within that port.

Schema guys: is the DT validator code prepped for checking for
overlapping register spaces, because this is totally undesirable
behavior in device trees..

Matt Sealey <neko@bakuhatsu.net>
