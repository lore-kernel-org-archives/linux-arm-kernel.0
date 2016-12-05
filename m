From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Dec 2016 11:16:41 +0800
Subject: [PATCH] arm64: dts: zx: add pcu_domain node for zx296718
In-Reply-To: <1480766354-25168-1-git-send-email-baoyou.xie@linaro.org>
References: <1480766354-25168-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20161205031639.GB2667@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 03, 2016 at 07:59:14PM +0800, Baoyou Xie wrote:
> This patch adds the pcu_domain node, so it can be used
> by zte-soc's power domain driver.
> 
> Furthermore, it adds the document of the node.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/zte.txt | 11 +++++++++++

DT bindings doc should be a separate patch, and goes together with
driver changes using the bindings through subsystem maintainers, rather
than dts patches.

>  arch/arm64/boot/dts/zte/zx296718.dtsi         |  7 +++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/zte.txt b/Documentation/devicetree/bindings/arm/zte.txt
> index 83369785..19a7e1b 100644
> --- a/Documentation/devicetree/bindings/arm/zte.txt
> +++ b/Documentation/devicetree/bindings/arm/zte.txt
> @@ -27,6 +27,9 @@ System management required properties:
>        - compatible = "zte,zx296718-aon-sysctrl"
>        - compatible = "zte,zx296718-sysctrl"
>  
> +Low power management required properties:
> +      - compatible = "zte,zx296718-pcu"
> +
>  Example:
>  aon_sysctrl: aon-sysctrl at 116000 {
>  	compatible = "zte,zx296718-aon-sysctrl", "syscon";
> @@ -37,3 +40,11 @@ sysctrl: sysctrl at 1463000 {
>  	compatible = "zte,zx296718-sysctrl", "syscon";
>  	reg = <0x1463000 0x1000>;
>  };
> +
> +pcu_domain: pcu at 0x00117000 {
> +        compatible = "zte,zx296718-pcu";
> +        reg = <0x00117000 0x1000>;
> +        #power-domain-cells = <1>;
> +        status = "ok";
> +};
> +

I think we should have a separate bindings doc for PCU power domain
block in Documentation/devicetree/bindings/soc/zte.

> diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
> index b44d1d1..39e70c7 100644
> --- a/arch/arm64/boot/dts/zte/zx296718.dtsi
> +++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
> @@ -351,5 +351,12 @@
>  			reg = <0x01480000 0x1000>;
>  			#clock-cells = <1>;
>  		};
> +
> +		pcu_domain: pcu at 0x00117000 {

Please drop the 0x and leading zeros in unit-address after node name.
That said, the node name should be written like below:

	pcu at 117000 {

Also, please sort the node with unit-address in order of the address.
That means that pcu node should be put after aon-sysctrl at 116000.

> +			compatible = "zte,zx296718-pcu";
> +			reg = <0x00117000 0x1000>;
> +			#power-domain-cells = <1>;
> +			status = "ok";

The property 'status' is generally used to enable devices that have
board-level pin-out or configuration in board dts.  It's not really
necessary for pcu here.

Shawn

> +		};
>  	};
>  };
> -- 
> 2.7.4
> 
