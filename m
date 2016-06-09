From: ddaney@caviumnetworks.com (David Daney)
Date: Thu, 9 Jun 2016 11:11:15 -0700
Subject: [PATCH v3 2/2] arm64: dts: Fix broken architected timer interrupt
 trigger
In-Reply-To: <1465235791-7064-3-git-send-email-marc.zyngier@arm.com>
References: <1465235791-7064-1-git-send-email-marc.zyngier@arm.com>
 <1465235791-7064-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <5759B143.9070503@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 10:56 AM, Marc Zyngier wrote:
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
>   arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    | 8 ++++----
>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          | 8 ++++----
>   arch/arm64/boot/dts/apm/apm-storm.dtsi               | 8 ++++----
>   arch/arm64/boot/dts/broadcom/ns2.dtsi                | 8 ++++----
>   arch/arm64/boot/dts/cavium/thunder-88xx.dtsi         | 8 ++++----
>   arch/arm64/boot/dts/exynos/exynos7.dtsi              | 8 ++++----
>   arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 8 ++++----
>   arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 8 ++++----
>   arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 8 ++++----
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi               | 8 ++++----
>   10 files changed, 40 insertions(+), 40 deletions(-)
>
[...]
> diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> index 2eb9b22..382d86f 100644
> --- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> +++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> @@ -354,10 +354,10 @@
>
>   	timer {
>   		compatible = "arm,armv8-timer";
> -		interrupts = <1 13 0xff01>,
> -		             <1 14 0xff01>,
> -		             <1 11 0xff01>,
> -		             <1 10 0xff01>;
> +		interrupts = <1 13 8>,
> +		             <1 14 8>,
> +		             <1 11 8>,
> +		             <1 10 8>;
>   	};
>
>   	pmu {

Acked-by: David Daney <david.daney@cavium.com>
