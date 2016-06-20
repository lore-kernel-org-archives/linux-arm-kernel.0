From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Jun 2016 13:39:06 +0100
Subject: [PATCH 2/2] arm64: dts: Add device-tree for ARM's AEMv8A-AEMv8A
 FVP Base model
In-Reply-To: <1466424796-13769-2-git-send-email-tixy@linaro.org>
References: <1466424796-13769-1-git-send-email-tixy@linaro.org>
 <1466424796-13769-2-git-send-email-tixy@linaro.org>
Message-ID: <20160620123906.GC26152@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 20, 2016 at 01:13:16PM +0100, Jon Medhurst wrote:
> Fixed Virtual Platform (FVP) Base models are simulations of systems
> that resemble Versatile Express or Juno hardware.
> 
> This adds a device-tree for the model variant that has two clusters of
> Architecture Envelope Model (AEM) v8-A CPUs. The peripheral devices that
> are common to all variants of Base models have been placed in a separate
> file (fvp-base.dtsi) to facilitate creating device-trees for other
> models.
> 
> It is desirable to use simulations for code testing purposes and so it
> is beneficial to include nodes for things that are timing and power
> consumption related, even when these don't otherwise have relevance or
> accuracy. Where these have been included here (e.g. idle-states) entries
> have been copied from real hardware platforms such as Juno.

Which firmware are you using, and what precisely does it do w.r.t.
those idle states? Judging by the FVP ATF pm code [1], those state IDs
aren't valid (though perhaps the comment is wrong, or I've misunderstood
something).

People use the FVPs with a variety of FW and bootloaders, so I'm not
keen on putting anything FW or bootloader specific into the canonical
FVP DT files.

> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
>  arch/arm64/boot/dts/arm/Makefile                   |   1 +
>  arch/arm64/boot/dts/arm/fvp-base-aemv8a-aemv8a.dts | 221 +++++++++++++++++
>  arch/arm64/boot/dts/arm/fvp-base.dtsi              | 267 +++++++++++++++++++++
>  3 files changed, 489 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
> index 75cc2aa..7531001 100644
> --- a/arch/arm64/boot/dts/arm/Makefile
> +++ b/arch/arm64/boot/dts/arm/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb foundation-v8-gicv3.dtb
> +dtb-$(CONFIG_ARCH_VEXPRESS) += fvp-base-aemv8a-aemv8a.dtb
>  dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb juno-r2.dtb
>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
>  dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
> diff --git a/arch/arm64/boot/dts/arm/fvp-base-aemv8a-aemv8a.dts b/arch/arm64/boot/dts/arm/fvp-base-aemv8a-aemv8a.dts
> new file mode 100644
> index 0000000..2acfd26
> --- /dev/null
> +++ b/arch/arm64/boot/dts/arm/fvp-base-aemv8a-aemv8a.dts
> @@ -0,0 +1,221 @@
> +/*
> + * ARM Ltd. Fixed Virtual Platform (FVP) Base model with dual cluster
> + * Architecture Envelope Model (AEM) v8-A CPUs
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "arm,fvp-base,aemv8a-aemv8a", "arm,fvp-base", "arm,vexpress";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };

Please add stdout-path, e.g.

	stdout-path = "serial0:115200";

> +
> +	aliases {
> +		serial0 = &bp_serial0;
> +		serial1 = &bp_serial1;
> +		serial2 = &bp_serial2;
> +		serial3 = &bp_serial3;
> +	};

[...]

> +		idle-states {
> +			entry-method = "arm,psci";
> +
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010000>;
> +				local-timer-stop;
> +				entry-latency-us = <300>;
> +				exit-latency-us = <1200>;
> +				min-residency-us = <2000>;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x1010000>;
> +				local-timer-stop;
> +				entry-latency-us = <300>;
> +				exit-latency-us = <1200>;
> +				min-residency-us = <2500>;
> +			};
> +		};

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;

The cpumask shouldn't be there (it's not valid for GICv3).

> +		clock-frequency = <100000000>;

FW should program CNTFRQ correctly, so we should drop the
clock-frequency property. We should never have had it in the first place
for the original RTSM DT.

Thanks,
Mark.

[1] https://github.com/ARM-software/arm-trusted-firmware/commit/6355f2347aec8bf6ad74867c2b0c996e10546ad4#L53
