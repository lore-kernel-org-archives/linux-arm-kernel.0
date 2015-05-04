From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 4 May 2015 09:08:24 +0200
Subject: [PATCH 6/7] ARM: dts: mt8135: enable basic SMP bringup for mt8135
In-Reply-To: <1430466210-22963-7-git-send-email-yingjoe.chen@mediatek.com>
References: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
 <1430466210-22963-7-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CABuKBeLXjKYXyPTtR=C887PKfiF-a5dB306zoZsya4s0ir_DVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-01 9:43 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> Add arch timer node to enable arch-timer support. MT8135 firmware
> doesn't correctly setup arch-timer frequency and CNTVOFF, add
> properties to workaround this.
>
> This also set cpu enable-method to enable SMP.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  arch/arm/boot/dts/mt8135.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> index 612bd22..eb5e06f 100644
> --- a/arch/arm/boot/dts/mt8135.dtsi
> +++ b/arch/arm/boot/dts/mt8135.dtsi
> @@ -46,6 +46,7 @@
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> +               enable-method = "mediatek,mt81xx-tz-smp";
>
>                 cpu0: cpu at 0 {
>                         device_type = "cpu";
> @@ -103,6 +104,21 @@
>                 };
>         };
>
> +       timer {
> +               compatible = "arm,armv7-timer";
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> +                                         IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> +                                         IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> +                                         IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> +                                         IRQ_TYPE_LEVEL_LOW)>;
> +               clock-frequency = <13000000>;
> +               arm,cpu-registers-not-fw-configured;
> +       };
> +

This does not apply cleanly on v4.1-rc1, please rebase.

Thanks,
Matthias
