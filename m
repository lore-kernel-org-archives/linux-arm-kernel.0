From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Oct 2014 15:04:22 +0100
Subject: [PATCH 5/7] ARM: mvebu: Enable Performance Monitor Unit on
 Armada 375 SoC
In-Reply-To: <1413985427-20918-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141022140421.GL22642@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 02:43:45PM +0100, Ezequiel Garcia wrote:
> The Armada 375 SoC has a Cortex-A9 CPU, and so the PMU is available
> to be used. This commit enables it in the devicetree.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-375.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index de65714..f131cd2 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -55,6 +55,11 @@
>  		};
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupts-extended = <&mpic 3>;
> +	};

Just to check - the interrupts from both CPUs are muxed into a single
line into the interrupt controller?

This isn't gonig to work at the moment -- the perf code will associate
this interrupt with CPU0 and you'll lose events on CPU1.

Hopefully there's a separate interrupt for CPU1?

Mark.

> +
>  	soc {
>  		compatible = "marvell,armada375-mbus", "marvell,armada370-mbus", "simple-bus";
>  		#address-cells = <2>;
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
