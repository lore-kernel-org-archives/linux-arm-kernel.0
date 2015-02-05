From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Feb 2015 11:46:42 +0000
Subject: [PATCH 1/4] arm64: dts: fix PMU IRQ ordering for Juno
In-Reply-To: <1422294858-28100-1-git-send-email-will.deacon@arm.com>
References: <1422294858-28100-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150205114642.GG11344@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Mon, Jan 26, 2015 at 05:54:15PM +0000, Will Deacon wrote:
> For better or worse, perf expects the per-cpu SPI PMU interrupts to be
> listed in order of logical CPU. This patch fixes the Juno .dts to
> satisfy that requirement.
> 
> Without this patch, I see unhandled IRQs in mainline:
> 
>   irq 9: nobody cared (try booting with the "irqpoll" option)
>   CPU: 3 PID: 2830 Comm: cc1 Not tainted 3.19.0-rc6+ #1
>   Hardware name: ARM Juno development board (r0) (DT)
> 
>   [...]
> 
>   handlers:
>   [<ffffffc00009447c>] armv8pmu_handle_irq
>   Disabling IRQ #9
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> This is an immediate fix for mainline, with the remaining patches in the
> series solving this by extending the binding.
> 
>  arch/arm64/boot/dts/arm/juno.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index cb3073e4e7a8..4ed9287aaef1 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -107,11 +107,11 @@
>  	pmu {
>  		compatible = "arm,armv8-pmuv3";
>  		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
> +			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>  	};

I am very much not keen on this. While this may get things working
today, it completely relies on Linux-internal details (the order of CPU
bringup, which in this case is different from the order of entries in
/cpus).

In all other dts that I am aware of, the order of entries in /cpus
aligns with the order of interrupts in the PMU node, and the first entry
is the boot CPU.

I think that we should ensure that the ordering of CPU nodes matches the
order of interrupts here. That way we can fall back to that ordering (if
not explicitly overridden), and even after an arbitrary logical
renumbering (e.g. after a kexec) the relationship should stay intact.

This DT has clearly never worked (nor been tested), and I think having
this as an intermediary step only adds to the long term support burden
by having the juno dts arbitrarily different to all other dts files (by
relying on a logical order that's different to the /cpus order).

Longer term we must ensure we have a more explicit ordering, as with
your later patches.

Thanks,
Mark.
