From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 30 Oct 2013 16:45:39 -0500
Subject: [PATCH v2 4/6] edac: Document Krait L1/L2 EDAC driver binding
In-Reply-To: <1383164736-1849-5-git-send-email-sboyd@codeaurora.org>
References: <1383164736-1849-1-git-send-email-sboyd@codeaurora.org>
 <1383164736-1849-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <872F86E8-85CE-472B-9546-CDCC96F6F08B@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 30, 2013, at 3:25 PM, Stephen Boyd wrote:

> The Krait L1/L2 error reporting device is made up of two
> interrupts, one per-CPU interrupt for the L1 caches and one
> interrupt for the L2 cache.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> Documentation/devicetree/bindings/arm/cpus.txt | 49 ++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index f32494d..0f7b27f 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -44,6 +44,8 @@ For the ARM architecture every CPU node must contain the following properties:
> 		"marvell,mohawk"
> 		"marvell,xsc3"
> 		"marvell,xscale"
> +		"qcom,scorpion"
> +		"qcom,krait"
> 
> Example:
> 
> @@ -75,3 +77,50 @@ Example:
> 			reg = <0x101>;
> 		};
> 	};
> +
> +If the compatible string contains "qcom,krait" there shall be an interrupts
> +property containing the L1/CPU error interrupt number. There shall also be an

'also be a'

> +l2-cache node containing the following properties:

Is the L1 interrupt not per core L1 cache (even if they are OR together at PIC)?

> +
> + - compatible: Shall contain at least "cache"
> + - cache-level: Must be 2
> + - interrupts: Shall contain the L2 error interrupt
> +
> +Example:
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts = <1 9 0xf04>;
> +		compatible = "qcom,krait";
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		cpu at 1 {
> +			device_type = "cpu";
> +			reg = <1>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		cpu at 2 {
> +			device_type = "cpu";
> +			reg = <2>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		cpu at 3 {
> +			device_type = "cpu";
> +			reg = <3>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		L2: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			interrupts = <0 2 0x4>;
> +		};
> +	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
