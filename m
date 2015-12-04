From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 04 Dec 2015 15:06:34 -0800
Subject: [PATCH v5 1/5] dt-bindings: add SMP enable-method for Broadcom NSP
In-Reply-To: <1449260611-24417-2-git-send-email-kapilh@broadcom.com>
References: <1449260611-24417-1-git-send-email-kapilh@broadcom.com>
 <1449260611-24417-2-git-send-email-kapilh@broadcom.com>
Message-ID: <56621C7A.5050202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/15 12:23, Kapil Hali wrote:
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

That comment is not quite correct with respect to the paragraph below then?

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

Based on the requested feedback, this property should now be placed
under the cpu1 node.

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
> 


-- 
Florian
