From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 1 Mar 2016 14:43:19 +0000
Subject: [PATCH 3/8] ARM64: dts: Prepare configs for Amlogic Meson GXBaby
In-Reply-To: <1456789465-2962-4-git-send-email-afaerber@suse.de>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
 <1456789465-2962-4-git-send-email-afaerber@suse.de>
Message-ID: <56D5AA87.7020401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/02/16 23:44, Andreas F?rber wrote:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>   arch/arm64/boot/dts/Makefile                |   1 +
>   arch/arm64/boot/dts/amlogic/Makefile        |   3 +
>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 128 ++++++++++++++++++++++++++++
>   3 files changed, 132 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amlogic/Makefile
>   create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index fd80617a9c6f..330fae966cf3 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,6 +1,7 @@
>   dts-dirs += al
>   dts-dirs += altera
>   dts-dirs += amd
> +dts-dirs += amlogic
>   dts-dirs += apm
>   dts-dirs += arm
>   dts-dirs += broadcom
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> new file mode 100644
> index 000000000000..1b06c28c67eb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -0,0 +1,3 @@
> +always		:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)
> +clean-files	:= *.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> new file mode 100644
> index 000000000000..0ae089bd1806
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -0,0 +1,128 @@

[...]

> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "amlogic,meson-gxbb";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <0x2>;
> +		#size-cells = <0x0>;
> +

[...]

> +	};
> +
> +	arm-pmu {
> +		compatible = "arm,armv8-pmuv3";

Please use "arm,cortex-a53-pmu" instead

> +		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci";

Any particular reason why PSCI v0.2 or above is not supported on this
platform. PSCI v0.1 is very old now and I assume this platform is
relatively new.

> +		method = "smc";
> +		cpu_suspend = <0xc4000001>;
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0xc4000003>;
> +		migrate = <0xc4000005>;

Atleast the functions ids look like v0.2 or above. So check if it's 
actually v0.2 or above in which case you can drop all the function ids above

[...]

> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller at c4301000 {
> +			compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";

Preferably "arm,gic-400" ?

-- 
Regards,
Sudeep
