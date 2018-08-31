From: frowand.list@gmail.com (Frank Rowand)
Date: Fri, 31 Aug 2018 15:46:53 -0700
Subject: [PATCH 1/3] ARM: dts: qcom: Add SPMI PMIC Arbiter nodes for
 APQ8084 and MSM8974
In-Reply-To: <1422965880-11047-2-git-send-email-iivanov@mm-sol.com>
References: <1422965880-11047-1-git-send-email-iivanov@mm-sol.com>
 <1422965880-11047-2-git-send-email-iivanov@mm-sol.com>
Message-ID: <550311ad-8f93-3e80-9706-1321482b8c19@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan,


On 02/03/15 04:17, Ivan T. Ivanov wrote:
> Add SPMI PMIC Arbiter configuration nodes for APQ8084 and MSM8974.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 16 ++++++++++++++++
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
> index 1f130bc..dbedf64 100644
> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
> @@ -226,5 +226,21 @@
>  			clock-names = "core", "iface";
>  			status = "disabled";
>  		};
> +
> +		spmi_bus: spmi at fc4cf000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg-names = "core", "intr", "cnfg";
> +			reg = <0xfc4cf000 0x1000>,
> +			      <0xfc4cb000 0x1000>,
> +			      <0xfc4ca000 0x1000>;
> +			interrupt-names = "periph_irq";
> +			interrupts = <0 190 0>;> +			qcom,ee = <0>;
> +			qcom,channel = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index e265ec1..2d11641 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -247,5 +247,21 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  		};
> +
> +		spmi_bus: spmi at fc4cf000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg-names = "core", "intr", "cnfg";
> +			reg = <0xfc4cf000 0x1000>,
> +			      <0xfc4cb000 0x1000>,
> +			      <0xfc4ca000 0x1000>;
> +			interrupt-names = "periph_irq";

> +			interrupts = <0 190 0>;

The final value in this interrupts property means IRQ_TYPE_NONE.

A WARN_ON() was added early this year to complain about use of
IRQ_TYPE_NONE: 83a86fbb5b56 "irqchip/gic: Loudly complain about
the use of IRQ_TYPE_NONE", resulting in many warnings spewing
forth when I boot an APQ8074 Dragonboard.  I am trying to
determine whether the warning is overly aggressive, or whether
the IRQ TYPE is incorrectly specified for the spmi node.

The interrupt-parent for the spmi node is intc: interrupt-controller at f9000000,
which has compatible = "qcom,msm-qgic2".  I do not know the architecture
or implementation of this interrupt controller.  Is an IRQ_TYPE_NONE
valid in this case, or should a specific type be provided?

Thanks!

-Frank


> +			qcom,ee = <0>;
> +			qcom,channel = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +		};
>  	};
>  };
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
