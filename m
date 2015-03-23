From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 23 Mar 2015 15:06:21 -0700
Subject: [PATCH v17 01/10] ARM: qcom: Add Subsystem Power Manager (SPM)
 driver
In-Reply-To: <1426882877-33008-2-git-send-email-lina.iyer@linaro.org>
References: <1426882877-33008-1-git-send-email-lina.iyer@linaro.org>
 <1426882877-33008-2-git-send-email-lina.iyer@linaro.org>
Message-ID: <F7886F3F-50DF-4E1B-A6DF-5463362B2BC7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 20, 2015, at 1:21 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> 
> Based on work by: Mahesh Sivasubramanian <msivasub@codeaurora.org>,
> Ai Li <ali@codeaurora.org>, Praveen Chidambaram <pchidamb@codeaurora.org>
> Original tree available at -
> git://codeaurora.org/quic/la/kernel/msm-3.10.git
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
> .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  29 +-
> drivers/soc/qcom/Kconfig                           |   7 +
> drivers/soc/qcom/Makefile                          |   1 +
> drivers/soc/qcom/spm.c                             | 405 +++++++++++++++++++++
> 4 files changed, 436 insertions(+), 6 deletions(-)
> create mode 100644 drivers/soc/qcom/spm.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> index 1505fb8..664aa91 100644
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
> @@ -2,11 +2,20 @@ SPM AVS Wrapper 2 (SAW2)
> 
> The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and the
> Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
> -micro-controller that transitions a piece of hardware (like a processor or
> +power-controller that transitions a piece of hardware (like a processor or
> subsystem) into and out of low power modes via a direct connection to
> the PMIC. It can also be wired up to interact with other processors in the
> system, notifying them when a low power state is entered or exited.
> 
> +Multiple revisions of the SAW hardware are supported using these Device Nodes.
> +SAW2 revisions differ in the register offset and configuration data. Also, the
> +same revision of the SAW in different SoCs may have different configuration
> +data due the the differences in hardware capabilities. Hence the SoC name, the
> +version of the SAW hardware in that SoC and the distinction between cpu (big
> +or Little) or cache, may be needed to uniquely identify the SAW register
> +configuration and initialization data. The compatible string is used to
> +indicate this parameter.
> +
> PROPERTIES
> 
> - compatible:
> @@ -14,10 +23,11 @@ PROPERTIES
> 	Value type: <string>
> 	Definition: shall contain "qcom,saw2". A more specific value should be
> 		    one of:

Does ?qcom,saw2? have any meaning anymore?  I see we use it in some places, but not everywhere on the .dts.  We also see to have the L2 just be a ?qcom,saw2? node, do we expect that to change?

> -			 "qcom,saw2-v1"
> -			 "qcom,saw2-v1.1"
> -			 "qcom,saw2-v2"
> -			 "qcom,saw2-v2.1"
> +			"qcom,saw2-v2"
> +			"qcom,saw2-v2.1"
> +			"qcom,apq8064-saw2-v1.1-cpu"
> +			"qcom,msm8974-saw2-v2.1-cpu"
> +			"qcom,apq8084-saw2-v2.1-cpu"
> 
> - reg:
> 	Usage: required
> @@ -26,10 +36,17 @@ PROPERTIES
> 		    the register region. An optional second element specifies
> 		    the base address and size of the alias register region.
> 
> +- regulator:
> +	Usage: optional
> +	Value type: boolean
> +	Definition: Indicates that this SPM device acts as a regulator device
> +			device for the core (CPU or Cache) the SPM is attached
> +			to.
> 
> Example:
> 
> -	regulator at 2099000 {
> +	power-controller at 2099000 {
> 		compatible = "qcom,saw2";
> 		reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
> +		regulator;
> 	};

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
