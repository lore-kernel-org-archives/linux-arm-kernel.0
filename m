From: dianders@chromium.org (Doug Anderson)
Date: Mon, 11 Aug 2014 10:01:08 -0700
Subject: [PATCH 3/4] ARM: dts: rockchip: add rk3288 dma controllers
In-Reply-To: <1406661128-7614-4-git-send-email-heiko@sntech.de>
References: <1406661128-7614-1-git-send-email-heiko@sntech.de>
 <1406661128-7614-4-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=VWBh3STfZWLDuYerS9wiceQL=UEJyjqp0-GLh0=-hTdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Jul 29, 2014 at 12:12 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Add both the bus and peripheral pl330 dma controllers present in rk3288 socs.
> The first dma controller can change between secure and non-secure mode and is
> left by the bootloader in secure mode, which gets added here.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

This is outside of my area of expertise, but comparing this to
bindings, TRM, and other platforms it looks reasonable to me.


> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 3ef8951..3f39d26 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -62,6 +62,33 @@
>                 };
>         };
>
> +       amba {
> +               compatible = "arm,amba-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               dmac1: dma at ffb20000 {

I'm curious: why did you choose "dmac1" for the alias here?  I would
have called it "dmac_peri", "pdma", or something similar as per the
address map in the TRM.  I found a single reference in the TRM to
"dmac2" but it wasn't immediately clear to me which DMA that was
referring to.  In a commit in a temporary tree I see that someone at
Rockchip called the DMA at ff250000 "pdma1".


> +                       compatible = "arm,pl330", "arm,primecell";
> +                       reg = <0xffb20000 0x4000>;
> +                       interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +                       #dma-cells = <1>;
> +                       clocks = <&cru ACLK_DMAC1>;
> +                       clock-names = "apb_pclk";
> +               };
> +
> +               dmac2: dma at ff250000 {

nit: when we have easy addresses to compare to, we should probably
sort by address?


> +                       compatible = "arm,pl330", "arm,primecell";
> +                       reg = <0xff250000 0x4000>;
> +                       interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +                       #dma-cells = <1>;
> +                       clocks = <&cru ACLK_DMAC2>;
> +                       clock-names = "apb_pclk";
> +               };
> +       };
> +
>         xin24m: oscillator {
>                 compatible = "fixed-clock";
>                 clock-frequency = <24000000>;
> --
> 2.0.1
>
