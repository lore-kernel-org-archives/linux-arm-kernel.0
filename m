From: robh@kernel.org (Rob Herring)
Date: Fri, 4 Dec 2015 08:52:09 -0600
Subject: [PATCH v2 5/7] dt-bindings: Amlogic: Add SMP related documentation
In-Reply-To: <1449076953-5058-6-git-send-email-carlo@caione.org>
References: <1449076953-5058-1-git-send-email-carlo@caione.org>
 <1449076953-5058-6-git-send-email-carlo@caione.org>
Message-ID: <20151204145209.GA18876@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 06:22:31PM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> With this patch we add documentation for:
> 
> * power-management-unit: the PMU is used to bring up the cores during
>   SMP operations
> * sram: among other things the sram is used to store the first code
>   executed by the core when it is powered up
> * cpu-enable-method: the CPU enable method used by Amlogic Meson8b SoCs
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/arm/amlogic/pmu.txt        | 16 +++++++++++
>  .../devicetree/bindings/arm/amlogic/smp-sram.txt   | 32 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
>  3 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/pmu.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic/pmu.txt b/Documentation/devicetree/bindings/arm/amlogic/pmu.txt
> new file mode 100644
> index 0000000..7b9b2da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/amlogic/pmu.txt
> @@ -0,0 +1,16 @@
> +Amlogic power-management-unit:
> +-------------------------------
> +
> +The pmu is used to turn off and on different power domains of the SoCs
> +This includes the power to the CPU cores.
> +
> +Required node properties:
> +- compatible value : = "amlogic,meson8b-pmu";
> +- reg : physical base address and the size of the registers window
> +
> +Example:
> +
> +	pmu at c81000e4 {
> +		compatible = "amlogic,meson8b-pmu", "syscon";
> +		reg = <0xc81000e0 0x18>;
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt b/Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
> new file mode 100644
> index 0000000..455ca20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
> @@ -0,0 +1,32 @@
> +Amlogic SRAM for smp bringup:
> +------------------------------
> +
> +Amlogic's smp-capable SoCs use part of the sram for the bringup of the cores.
> +Once the core gets powered up it executes the code that is residing at a
> +specific location.
> +
> +Therefore a reserved section sub-node has to be added to the mmio-sram
> +declaration.
> +
> +Required sub-node properties:
> +- compatible : should be "amlogic,meson8b-smp-sram"
> +
> +The rest of the properties should follow the generic mmio-sram discription
> +found in ../../misc/sram.txt
> +
> +Example:
> +
> +	sram: sram at d9000000 {
> +		compatible = "mmio-sram";
> +		reg = <0xd9000000 0x20000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0xd9000000 0x20000>;
> +
> +		smp-sram at 1ff80 {
> +			compatible = "amlogic,meson8b-smp-sram";
> +			reg = <0x1ff80 0x8>;
> +		};
> +	};
> +
> +
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 3a07a87..22381b4 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -189,6 +189,7 @@ nodes to be present and contain the properties described below.
>  			  can be one of:
>  			    "allwinner,sun6i-a31"
>  			    "allwinner,sun8i-a23"
> +			    "amlogic,meson8b-smp"
>  			    "arm,psci"
>  			    "brcm,brahma-b15"
>  			    "marvell,armada-375-smp"
> -- 
> 2.5.0
> 
