From: dhdang@apm.com (Duc Dang)
Date: Tue, 05 Jul 2016 04:37:18 -0000
Subject: [PATCH v3 2/2] arm64: dts: Fix broken architected timer interrupt
 trigger
In-Reply-To: <1465235791-7064-3-git-send-email-marc.zyngier@arm.com>
References: <1465235791-7064-1-git-send-email-marc.zyngier@arm.com>
 <1465235791-7064-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <CADaLNDn_k2eDoBhmDu9Ub5D0XF7PTN-sW9kNDTuFSUybgT59jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 6, 2016 at 10:56 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> The ARM architected timer specification mandates that the interrupt
> associated with each timer is level triggered (which corresponds to
> the "counter >= comparator" condition).
>
> A number of DTs are being remarkably creative, declaring the interrupt
> to be edge triggered. A quick look at the TRM for the corresponding ARM
> CPUs clearly shows that this is wrong, and I've corrected those.
> For non-ARM designs (and in the absence of a publicly available TRM),
> I've made them active low as well, which can't be completely wrong
> as the GIC cannot disinguish between level low and level high.
>
> The respective maintainers are of course welcome to prove me wrong.
>
> While I was at it, I took the liberty to fix a couple of related issue,
> such as some spurious affinity bits on ThunderX, and their complete
> absence on ls1043a (both of which seem to be related to copy-pasting
> from other DTs).
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    | 8 ++++----
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          | 8 ++++----
>  arch/arm64/boot/dts/apm/apm-storm.dtsi               | 8 ++++----
>  arch/arm64/boot/dts/broadcom/ns2.dtsi                | 8 ++++----
>  arch/arm64/boot/dts/cavium/thunder-88xx.dtsi         | 8 ++++----
>  arch/arm64/boot/dts/exynos/exynos7.dtsi              | 8 ++++----
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 8 ++++----
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 8 ++++----
>  arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 8 ++++----
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi               | 8 ++++----
>  10 files changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index 445aa67..c2b9bcb 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -255,10 +255,10 @@
>                 /* Local timer */
>                 timer {
>                         compatible = "arm,armv8-timer";
> -                       interrupts = <1 13 0xf01>,
> -                                    <1 14 0xf01>,
> -                                    <1 11 0xf01>,
> -                                    <1 10 0xf01>;
> +                       interrupts = <1 13 0xf08>,
> +                                    <1 14 0xf08>,
> +                                    <1 11 0xf08>,
> +                                    <1 10 0xf08>;
>                 };
>
>                 timer0: timer0 at ffc03000 {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 832815d..4d9d144 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -100,13 +100,13 @@
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts = <GIC_PPI 13
> -                       (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
> +                       (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>                              <GIC_PPI 14
> -                       (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
> +                       (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>                              <GIC_PPI 11
> -                       (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
> +                       (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
>                              <GIC_PPI 10
> -                       (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>;
> +                       (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
>         };
>
>         xtal: xtal-clk {
> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> index 5147d76..1c4193f 100644
> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> @@ -110,10 +110,10 @@
>
>         timer {
>                 compatible = "arm,armv8-timer";
> -               interrupts = <1 0 0xff01>,      /* Secure Phys IRQ */
> -                            <1 13 0xff01>,     /* Non-secure Phys IRQ */
> -                            <1 14 0xff01>,     /* Virt IRQ */
> -                            <1 15 0xff01>;     /* Hyp IRQ */
> +               interrupts = <1 0 0xff08>,      /* Secure Phys IRQ */
> +                            <1 13 0xff08>,     /* Non-secure Phys IRQ */
> +                            <1 14 0xff08>,     /* Virt IRQ */
> +                            <1 15 0xff08>;     /* Hyp IRQ */
>                 clock-frequency = <50000000>;
>         };

For above changes on apm-storm.dtsi for APM X-Gene 1:

Acked-by: Duc Dang <dhdang@apm.com>

Thanks,
Duc Dang.

>
> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> index ec68ec1..9c2d8a7 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> @@ -88,13 +88,13 @@
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(0xff) |
> -                             IRQ_TYPE_EDGE_RISING)>,
> +                             IRQ_TYPE_LEVEL_LOW)>,
>                              <GIC_PPI 14 (GIC_CPU_MASK_RAW(0xff) |
> -                             IRQ_TYPE_EDGE_RISING)>,
> +                             IRQ_TYPE_LEVEL_LOW)>,
>                              <GIC_PPI 11 (GIC_CPU_MASK_RAW(0xff) |
> -                             IRQ_TYPE_EDGE_RISING)>,
> +                             IRQ_TYPE_LEVEL_LOW)>,
>                              <GIC_PPI 10 (GIC_CPU_MASK_RAW(0xff) |
> -                             IRQ_TYPE_EDGE_RISING)>;
> +                             IRQ_TYPE_LEVEL_LOW)>;
>         };
>
>         pmu {
> diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> index 2eb9b22..382d86f 100644
> --- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> +++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> @@ -354,10 +354,10 @@
>
>         timer {
>                 compatible = "arm,armv8-timer";
> -               interrupts = <1 13 0xff01>,
> -                            <1 14 0xff01>,
> -                            <1 11 0xff01>,
> -                            <1 10 0xff01>;
> +               interrupts = <1 13 8>,
> +                            <1 14 8>,
> +                            <1 11 8>,
> +                            <1 10 8>;
>         };
>
>         pmu {
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index ca663df..1628315 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -473,10 +473,10 @@
>
>                 timer {
>                         compatible = "arm,armv8-timer";
> -                       interrupts = <1 13 0xff01>,
> -                                    <1 14 0xff01>,
> -                                    <1 11 0xff01>,
> -                                    <1 10 0xff01>;
> +                       interrupts = <1 13 0xff08>,
> +                                    <1 14 0xff08>,
> +                                    <1 11 0xff08>,
> +                                    <1 10 0xff08>;
>                 };
>
>                 pmu_system_controller: system-controller at 105c0000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index c277ba6..b92543d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -111,10 +111,10 @@
>
>         timer {
>                 compatible = "arm,armv8-timer";
> -               interrupts = <1 13 0x1>, /* Physical Secure PPI */
> -                            <1 14 0x1>, /* Physical Non-Secure PPI */
> -                            <1 11 0x1>, /* Virtual PPI */
> -                            <1 10 0x1>; /* Hypervisor PPI */
> +               interrupts = <1 13 0xf08>, /* Physical Secure PPI */
> +                            <1 14 0xf08>, /* Physical Non-Secure PPI */
> +                            <1 11 0xf08>, /* Virtual PPI */
> +                            <1 10 0xf08>; /* Hypervisor PPI */
>                 fsl,erratum-a008585;
>         };
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 20d256b..b1d6bb8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -122,10 +122,10 @@
>
>                         timer {
>                                 compatible = "arm,armv8-timer";
> -                               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>,
> -                                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>,
> -                                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>,
> -                                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> +                               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>                         };
>
>                         odmi: odmi at 300000 {
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
> index 9532880..5a8e0f4 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
> @@ -127,10 +127,10 @@
>
>         timer {
>                 compatible = "arm,armv8-timer";
> -               interrupts = <1 13 0xf01>,
> -                            <1 14 0xf01>,
> -                            <1 11 0xf01>,
> -                            <1 10 0xf01>;
> +               interrupts = <1 13 0xf08>,
> +                            <1 14 0xf08>,
> +                            <1 11 0xf08>,
> +                            <1 10 0xf08>;
>         };
>
>         soc {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index e595f22..3e2e51f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -65,10 +65,10 @@
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupt-parent = <&gic>;
> -               interrupts = <1 13 0xf01>,
> -                            <1 14 0xf01>,
> -                            <1 11 0xf01>,
> -                            <1 10 0xf01>;
> +               interrupts = <1 13 0xf08>,
> +                            <1 14 0xf08>,
> +                            <1 11 0xf08>,
> +                            <1 10 0xf08>;
>         };
>
>         amba_apu {
> --
> 2.1.4
>
