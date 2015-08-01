From: dianders@chromium.org (Doug Anderson)
Date: Sat, 1 Aug 2015 14:32:32 -0700
Subject: [PATCH 1/2] ARM: dts: rockchip: reserve unusable memory region on
 rk3288
In-Reply-To: <15143985.aGzb1oeyb9@diego>
References: <15143985.aGzb1oeyb9@diego>
Message-ID: <CAD=FV=W2LSQh4e9+=ooTf34VzM_yPZn497DqSVEdb1kehZbqQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko

On Sat, Aug 1, 2015 at 5:35 AM, Heiko St?bner <heiko@sntech.de> wrote:
> The rk3288 has problems accessing the memory region 0xfe000000~0xff000000.
> So block off the affected region to prevent its use.
>
> Tested on 4GB Veyron Minnie and 2GB Veyron Jerry devices.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 2db91c9..19766af 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -169,6 +169,16 @@
>                 };
>         };
>
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               unusable at fe000000 {
> +                       reg = <0xfe000000 0x1000000>;
> +               };
> +       };
> +

I don't object to just reserving this memory, but I do object a little
to this implementation.

It's 16 MB we're talking about here, which is pretty small compared to
the 4G of memory that you must have when this is a problem.  However,
at some point we might want to try to actually use this 16 MB.

The memory is actually _not_ unusable, it's only unusable for DMA.  In
theory the kernel is supposed to have a way to mark memory as unusable
for DMA which would then allow us to use this memory for non-DMA
purposes...

Nobody ever managed to figure this out in the Chrome OS tree (it was
16 megs so we just reserved it and never got back around to it), but
when folks were looking at it they looked at things like ZONE_DMA,
dma_set_mask_and_coherent, etc.

In any case, to leave the door open for people to fix this in the
future, it seems prudent to fix this in code like
<https://chromium-review.googlesource.com/#/c/245107/> rather than to
put the limit in DTS.

-Doug
