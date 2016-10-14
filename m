From: riku.voipio@linaro.org (Riku Voipio)
Date: Fri, 14 Oct 2016 17:11:36 +0300
Subject: [PATCH v2] arm64: dts: qcom: Fix broken interrupt trigger settings
In-Reply-To: <1470937850-10492-1-git-send-email-marc.zyngier@arm.com>
References: <1470937850-10492-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAAqcGHmgHn2sK6j6ByqhAx_xibOfz4K7O-yyb8EwODEAcVHMFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 August 2016 at 20:50, Marc Zyngier <marc.zyngier@arm.com> wrote:
> When a device uses the GIC as its interrupt controller and generates
> SPIs, only the values 1 (edge rising) and 4 (level high) are legal.
>
> Anything else is just plain wrong (can't be programmed into the HW),
> and leads to aborted driver probes (USB doesn't work with 4.8-rc1
> on a Dragonboard 410C).

Should this be sent to -stable as well? This fixes USB driver loading
for me on v4.8, but still don't seem to get the host usb ports working
on db410c.

Riku

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> * From v1:
>   - Fixed USB interrupts after review from Stephen
>
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 10 +++++-----
>  arch/arm64/boot/dts/qcom/msm8996.dtsi |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 11bdc24..b010d33 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -483,7 +483,7 @@
>                         compatible = "qcom,ci-hdrc";
>                         reg = <0x78d9000 0x400>;
>                         dr_mode = "peripheral";
> -                       interrupts = <GIC_SPI 134 IRQ_TYPE_NONE>;
> +                       interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
>                         usb-phy = <&usb_otg>;
>                         status = "disabled";
>                 };
> @@ -491,7 +491,7 @@
>                 usb_host: ehci at 78d9000 {
>                         compatible = "qcom,ehci-host";
>                         reg = <0x78d9000 0x400>;
> -                       interrupts = <GIC_SPI 134 IRQ_TYPE_NONE>;
> +                       interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
>                         usb-phy = <&usb_otg>;
>                         status = "disabled";
>                 };
> @@ -499,8 +499,8 @@
>                 usb_otg: phy at 78d9000 {
>                         compatible = "qcom,usb-otg-snps";
>                         reg = <0x78d9000 0x400>;
> -                       interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_BOTH>,
> -                                    <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>;
> +                       interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>
>                         qcom,vdd-levels = <500000 1000000 1320000>;
>                         qcom,phy-init-sequence = <0x44 0x6B 0x24 0x13>;
> @@ -594,7 +594,7 @@
>                               <0x200a000 0x002100>;
>                         reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>                         interrupt-names = "periph_irq";
> -                       interrupts = <GIC_SPI 190 IRQ_TYPE_NONE>;
> +                       interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
>                         qcom,ee = <0>;
>                         qcom,channel = <0>;
>                         #address-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 55ec3e8..69ed6e1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -339,7 +339,7 @@
>                               <0x400a000 0x002100>;
>                         reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>                         interrupt-names = "periph_irq";
> -                       interrupts = <GIC_SPI 326 IRQ_TYPE_NONE>;
> +                       interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
>                         qcom,ee = <0>;
>                         qcom,channel = <0>;
>                         #address-cells = <2>;
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
