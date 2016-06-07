From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 07 Jun 2016 09:08:14 +0200
Subject: [PATCH v3 2/2] arm64: dts: Fix broken architected timer interrupt
 trigger
In-Reply-To: <1465235791-7064-3-git-send-email-marc.zyngier@arm.com>
References: <1465235791-7064-1-git-send-email-marc.zyngier@arm.com>
 <1465235791-7064-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <575672DE.4060504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 07:56 PM, Marc Zyngier wrote:
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

(...)

> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index ca663df..1628315 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -473,10 +473,10 @@
>  
>  		timer {
>  			compatible = "arm,armv8-timer";
> -			interrupts = <1 13 0xff01>,
> -				     <1 14 0xff01>,
> -				     <1 11 0xff01>,
> -				     <1 10 0xff01>;
> +			interrupts = <1 13 0xff08>,
> +				     <1 14 0xff08>,
> +				     <1 11 0xff08>,
> +				     <1 10 0xff08>;
>  		};
>  
>  		pmu_system_controller: system-controller at 105c0000 {

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I got a conflicting patch in my tree so it would be nice if your fix
went to current release cycle:
https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/commit/?h=next/dt64&id=8b77005c40376816885b100bcd358887d29e323f

Best regards,
Krzysztof
