From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 15 Jan 2014 10:27:01 +0000
Subject: [PATCH v5 2/4] devicetree: bindings: Document Krait CPU/L1 EDAC
In-Reply-To: <1389735034-21430-3-git-send-email-sboyd@codeaurora.org>
References: <1389735034-21430-1-git-send-email-sboyd@codeaurora.org>
 <1389735034-21430-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140115102701.GA27314@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 09:30:32PM +0000, Stephen Boyd wrote:
> The Krait CPU/L1 error reporting device is made up a per-CPU
> interrupt. While we're here, document the next-level-cache
> property that's used by the Krait EDAC driver.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 52 ++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 91304353eea4..c332b5168456 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -191,6 +191,16 @@ nodes to be present and contain the properties described below.
>  			  property identifying a 64-bit zero-initialised
>  			  memory location.
>  
> +	- interrupts
> +		Usage: required for cpus with compatible string "qcom,krait".
> +		Value type: <prop-encoded-array>
> +		Definition: L1/CPU error interrupt

I reckon you want this property to belong in the cpus node (example below),
not in cpu nodes, right ?

Are you relying on a platform device to be created for /cpus node in
order for this series to work ? I guess that's why you want the
interrupts property to be defined in /cpus so that it becomes a platform
device resource (and you also add a compatible property in /cpus that is
missing in these bindings).

> +
> +	- next-level-cache
> +		Usage: optional
> +		Value type: <phandle>
> +		Definition: phandle pointing to the next level cache
> +
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
>  
>  	cpus {
> @@ -382,3 +392,45 @@ cpus {
>  		cpu-release-addr = <0 0x20000000>;
>  	};
>  };
> +
> +
> +Example 5 (Krait 32-bit system):
> +
> +cpus {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	interrupts = <1 9 0xf04>;

In patch 4 you also add a compatible property here, and that's not documented,
and honestly I do not think that's acceptable either. I guess you want a
compatible property here to match the platform driver, right ?

Thank you,
Lorenzo

> +
> +	cpu at 0 {
> +		device_type = "cpu";
> +		compatible = "qcom,krait";
> +		reg = <0>;
> +		next-level-cache = <&L2>;
> +	};
> +
> +	cpu at 1 {
> +		device_type = "cpu";
> +		compatible = "qcom,krait";
> +		reg = <1>;
> +		next-level-cache = <&L2>;
> +	};
> +
> +	cpu at 2 {
> +		device_type = "cpu";
> +		compatible = "qcom,krait";
> +		reg = <2>;
> +		next-level-cache = <&L2>;
> +	};
> +
> +	cpu at 3 {
> +		device_type = "cpu";
> +		compatible = "qcom,krait";
> +		reg = <3>;
> +		next-level-cache = <&L2>;
> +	};
> +
> +	L2: l2-cache {
> +		compatible = "cache";
> +		interrupts = <0 2 0x4>;
> +	};
> +};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
> 
