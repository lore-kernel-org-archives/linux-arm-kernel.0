From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 Aug 2014 14:01:26 -0300
Subject: [PATCH 1/1] undo workaround for i.mx6 silicon errata ERR006687
 which resulted in an unstable ethernet connection (lost interrupts?)
In-Reply-To: <1407515584.19455.9.camel@sharkbay.at>
References: <1407503758.19455.1.camel@sharkbay.at>
 <20140808132754.GC30282@n2100.arm.linux.org.uk>
 <1407507023.19455.3.camel@sharkbay.at>
 <20140808143008.GD30282@n2100.arm.linux.org.uk>
 <1407509932.19455.7.camel@sharkbay.at>
 <CAOMZO5C=sTL-ksaHX9uL=zyGR0d5hR8Rd5JAiQMTrr_0wiNdxQ@mail.gmail.com>
 <1407515584.19455.9.camel@sharkbay.at>
Message-ID: <CAOMZO5B-hkc1BJJBSaOuRXpkNa-kheskEWcTQv1pmhBa3n3WjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Aug 8, 2014 at 1:33 PM, Thomas Scheiblauer <tom@sharkbay.at> wrote:

> Ok, here is my attempt on the patch. I've also removed the respective lines from all the other imx6qdl-*.dtsi files.

Please create a clean patch and submit it via git send-mail instead of
sending it inside this thread.

Also, please check the style of the Subject. It should be "ARM: dts:
imx6qdl-wandboard: ....."

You need to copy the imx maintainer Shawn Guo and it would be nice to
also copy commit Sascha Silbe, who introduced this patch for
wandboard:

9fc77821b17155c6e0ab50b1e1dd80c2b0e63e98
Author: Sascha Silbe <x-linux@infra-silbe.de>
Date:   Thu Feb 6 23:24:13 2014 +0100

    ARM: dts: imx6qdl-wandboard: use GPIO_6 for FEC interrupt

, and also Troy Kisky to get their inputs.

>
> Signed-off-by: Thomas Scheiblauer <tom@sharkbay.at>
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 2 --
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi  | 2 --
>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 2 --
>  arch/arm/boot/dts/imx6qdl-wandboard.dtsi  | 2 --
>  4 files changed, 8 deletions(-)

I would suggest by starting only with
arch/arm/boot/dts/imx6qdl-wandboard.dtsi as this is the one you have
really tested.

> diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> index 6461f66..3b61c9a 100644
> --- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> @@ -257,8 +257,6 @@
>         pinctrl-0 = <&pinctrl_enet>;
>         phy-mode = "rgmii";
>         phy-reset-gpios = <&gpio3 29 0>;
> -       interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
> -                             <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;

You should also remove the MX6QDL_PAD_GPIO_6__ENET_IRQ.

Actually it would easier if you just send a patch reverting 9fc77821b17.

You need to put a detailed commit log explaining what are the tests
you are running that show an unstable ethernet connection, add the
logs, command line tests, etc.

Thanks
