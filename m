From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Nov 2018 00:39:59 +0800
Subject: [PATCH 10/15] arm64: dts: allwinner: a64: Add support for the
 SRAM C1 section
In-Reply-To: <20181115145013.3378-11-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-11-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v66twfxzMzO-E1WH78N6O9N1J_AcPQcKp3FApE1gTKmn3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Add the description for the SRAM C1 section to the A64 device-tree.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index f3a66f888205..88b3e9110833 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -277,6 +277,20 @@
>                                         reg = <0x0000 0x28000>;
>                                 };
>                         };
> +
> +                       sram_c1: sram at 1d00000 {
> +                               compatible = "mmio-sram";
> +                               reg = <0x01d00000 0x80000>;

I can confirm that this SRAM region is indeed at this address. However the
size is only 0x40000, not 0x80000. The address ranges should be fixed.

One hiccup is that the VE reset has to be de-asserted and the VE bus clock
has to be ungated for the CPU to access this region when it's mapped to the
CPU.

One other thing I find interesting is that in the previous SoCs, the bits
that control this mapping says 50K, but in reality it is 512K for the older
SoCs, and 256K for this one.

ChenYu

> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               ranges = <0 0x01d00000 0x80000>;
> +
> +                               ve_sram: sram-section at 0 {
> +                                       compatible = "allwinner,sun50i-a64-sram-c1",
> +                                                    "allwinner,sun4i-a10-sram-c1";
> +                                       reg = <0x000000 0x80000>;
> +                               };
> +                       };
>                 };
>
>                 dma: dma-controller at 1c02000 {
> --
> 2.19.1
>
