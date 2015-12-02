From: robh@kernel.org (Rob Herring)
Date: Wed, 2 Dec 2015 09:26:04 -0600
Subject: [PATCH v4 1/5] dt-bindings: add SMP enable-method for Broadcom NSP
In-Reply-To: <1448987049-17041-2-git-send-email-kapilh@broadcom.com>
References: <1448987049-17041-1-git-send-email-kapilh@broadcom.com>
 <1448987049-17041-2-git-send-email-kapilh@broadcom.com>
Message-ID: <20151202152604.GA20467@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 11:24:05AM -0500, Kapil Hali wrote:
> Add a compatible string "brcm,bcm-nsp-smp" for Broadcom's
> Northstar Plus CPU to the 32-bit ARM CPU device tree binding
> documentation file and create a new binding documentation for
> Northstar Plus CPU.
> 
> Signed-off-by: Kapil Hali <kapilh@broadcom.com>
> ---
>  .../bindings/arm/bcm/brcm,nsp-cpu-method.txt       | 39 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
> new file mode 100644
> index 0000000..bf08872
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
> @@ -0,0 +1,39 @@
> +Broadcom Northstar Plus SoC CPU Enable Method
> +---------------------------------------------
> +This binding defines the enable method used for starting secondary
> +CPUs in the following Broadcom SoCs:
> +  BCM58522, BCM58525, BCM58535, BCM58622, BCM58623, BCM58625, BCM88312
> +
> +The enable method is specified by defining the following required
> +properties in the "cpus" device tree node:
> +  - enable-method = "brcm,bcm-nsp-smp";
> +  - secondary-boot-reg = <...>;

Both of these are supposed to be per cpu core.

Rob

> +
> +The secondary-boot-reg property is a u32 value that specifies the
> +physical address of the register which should hold the common
> +entry point for a secondary CPU. This entry is cpu node specific
> +and should be added per cpu. E.g., in case of NSP (BCM58625) which
> +is a dual core CPU SoC, this entry should be added to cpu1 node.
> +
> +
> +Example:
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		enable-method = "brcm,bcm-nsp-smp";
> +
> +		cpu0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			next-level-cache = <&L2>;
> +			reg = <0>;
> +		};
> +
> +		cpu1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			next-level-cache = <&L2>;
> +			reg = <1>;
> +			secondary-boot-reg = <0xffff042c>;
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 3a07a87..d191554 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -190,6 +190,7 @@ nodes to be present and contain the properties described below.
>  			    "allwinner,sun6i-a31"
>  			    "allwinner,sun8i-a23"
>  			    "arm,psci"
> +			    "brcm,bcm-nsp-smp"
>  			    "brcm,brahma-b15"
>  			    "marvell,armada-375-smp"
>  			    "marvell,armada-380-smp"
> -- 
> 2.1.0
> 
