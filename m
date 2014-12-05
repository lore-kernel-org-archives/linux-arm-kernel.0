From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 5 Dec 2014 16:53:56 +0000
Subject: [RFC 1/3] devfreq: dt-bindings: Document Exynos3250 devfreq driver
In-Reply-To: <1417797988-29225-2-git-send-email-k.kozlowski@samsung.com>
References: <1417797988-29225-1-git-send-email-k.kozlowski@samsung.com>
 <1417797988-29225-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141205165356.GC12849@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 04:46:26PM +0000, Krzysztof Kozlowski wrote:
> Add documentation for bindings used by Exynos3250 devfreq driver.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  .../bindings/arm/samsung/exynos3250-devfreq.txt    | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt b/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
> new file mode 100644
> index 000000000000..047955e9e371
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
> @@ -0,0 +1,66 @@
> +Samsung Exynos3250 devfreq driver

The binding should describe the hardware, not a particular driver of
that hardware. Please write the binding (and its documentation) with
that in mind, and drop references to the driver and "busfreq".

With an adequate binding we can probe the device and forward the
information to relevant driver(s) as necessary.

> +=================================
> +
> +The driver support changing frequencies and voltage for:
> + - memory controller and bus,
> + - peripheral buses (left and right).


What do left and right mean in this context?

> +
> +Memory controller and bus
> +=========================
> +Required properties:
> + - compatible : should be "samsung,exynos3250-busfreq-mif"
> + - reg : two sets (offset and length of the register) for PPMU registers
> +	used by this devfreq driver
> + - clock-names : one clock of name "dmc" to manage frequency
> + - clocks : phandle and specifier for clock listed in clock-names property
> + - vdd_mif-supply : phandle to MIF voltage regulator

s/_/-/ in property names please.

> +
> +Peripheral buses
> +================
> +Required properties:
> + - compatible : should be "samsung,exynos3250-busfreq-int"

What does "int" mean here?

> + - reg : two sets (offset and length of the register) for PPMU registers
> +	used by this devfreq driver
> + - clock-names : names for PPMU clocks and bus clocks to manage frequencies;
> +	All following clock names (and corresponding phandles) must be
> +	provided:
> +	- "ppmu_left", "ppmu_right",
> +	- "aclk_400", "aclk_266", "aclk_200", "aclk_160", "aclk_gdl", "aclk_gdr", "mfc";
> + - clocks : phandles and specifiers for clocks listed in clock-names property
> + - vdd_mif-supply : phandle to INT voltage regulator

s/_/-/ here too.

Thanks,
Mark.

> +
> +Example
> +=======
> +	busfreq_mif: busfreq at 106A0000 {
> +		compatible = "samsung,exynos3250-busfreq-mif";
> +		reg = <0x106A0000 0x2000>, <0x106B0000 0x2000>;
> +		clocks = <&cmu_dmc CLK_DIV_DMC>;
> +		clock-names = "dmc";
> +		vdd_mif-supply = <&buck1_reg>;
> +		status = "okay";
> +	};
> +
> +	busfreq_int: busfreq at 116A0000 {
> +		compatible = "samsung,exynos3250-busfreq-int";
> +		reg = <0x116A0000 0x2000>, <0x112A0000 0x2000>;
> +		clocks = <&cmu CLK_PPMULEFT>,
> +			<&cmu CLK_PPMURIGHT>,
> +			<&cmu CLK_DIV_ACLK_400_MCUISP>,
> +			<&cmu CLK_DIV_ACLK_266>,
> +			<&cmu CLK_DIV_ACLK_200>,
> +			<&cmu CLK_DIV_ACLK_160>,
> +			<&cmu CLK_DIV_GDL>,
> +			<&cmu CLK_DIV_GDR>,
> +			<&cmu CLK_DIV_MFC>;
> +		clock-names = "ppmuleft",
> +			"ppmuright",
> +			"aclk_400",
> +			"aclk_266",
> +			"aclk_200",
> +			"aclk_160",
> +			"aclk_gdl",
> +			"aclk_gdr",
> +			"mfc";
> +		vdd_int-supply = <&buck3_reg>;
> +		status = "okay";
> +	};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
