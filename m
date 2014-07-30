From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 21:03:28 -0700
Subject: [PATCH 2/4] ARM: dts: add rk3288 dwc2 controller support
In-Reply-To: <1406684075-18271-1-git-send-email-kever.yang@rock-chips.com>
References: <1406683873-18194-1-git-send-email-kever.yang@rock-chips.com>
 <1406684075-18271-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=VrFpQ_-1Dzk1kMypDjtj7ZFihEVjbt5sNETg=-Fc5jNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Tue, Jul 29, 2014 at 6:34 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> rk3288 has two kind of usb controller, this add the dwc2 controller
> for otg and host1.
>
> Controller can works with usb PHY default setting and Vbus on.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index abc51f5..4309c4f 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi

Maybe move the dtsi patch to the 3rd or 4th patch in the series?
Things won't work super well without patch #3, right?

Also: do you want to add a 5th patch in the series that enables the
ports like <https://chromium-review.googlesource.com/#/c/210066/>


> @@ -646,5 +646,25 @@
>                         clock-names = "baudclk", "apb_pclk";
>                         status = "disabled";
>                 };
> +
> +               usb_otg: dwc2 at ff580000 {
> +                       compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
> +                                       "snps,dwc2";

You included the snps,dwc2 (at my request) here.  ...but you didn't
add it to the bindings (patch #1).  You should probably add it to the
bindings in the next version unless someone else thinks it shouldn't
be here.


> +                       reg = <0xff580000 0x40000>;
> +                       interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cru HCLK_OTG0>;
> +                       clock-names = "otg";
> +                       status = "disabled";
> +               };
> +
> +               usb_host1: dwc2 at ff540000 {

Please sort by base address.  ...and if Heiko Acks my EHCI device tree
patches maybe rebase atop my patches to avoid merge conflicts?


> +                       compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
> +                                       "snps,dwc2";
> +                       reg = <0xff540000 0x40000>;
> +                       interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cru HCLK_USBHOST1>;
> +                       clock-names = "otg";
> +                       status = "disabled";
> +               };
>         };
>  };
