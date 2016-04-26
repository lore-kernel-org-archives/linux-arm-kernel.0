From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Apr 2016 18:49:06 -0700
Subject: [Patch v2 1/8] dt/bindings: firmware: Add Qualcomm SCM binding
In-Reply-To: <1461625725-32425-2-git-send-email-andy.gross@linaro.org>
References: <1461625725-32425-1-git-send-email-andy.gross@linaro.org>
 <1461625725-32425-2-git-send-email-andy.gross@linaro.org>
Message-ID: <20160426014906.GH29990@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25, Andy Gross wrote:
> This patch adds the device tree support for the Qualcomm SCM firmware.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  .../devicetree/bindings/firmware/qcom,scm.txt      | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> new file mode 100644
> index 0000000..a679a87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> @@ -0,0 +1,28 @@
> +QCOM Secure Channel Manager (SCM)
> +
> +Qualcomm processors include an interface to communicate to the secure firmware.
> +This interface allows for clients to request different types of actions.  These
> +can include CPU power up/down, HDCP requests, loading of firmware, and other
> +assorted actions.
> +
> +Required properties:
> +- compatible: must contain one of the following:
> + * "qcom,scm-apq8064" for APQ8064
> + * "qcom,scm-apq8084" for APQ8084
> + * "qcom,scm-msm8916" for MSM8916
> + * "qcom,scm-msm8974" for MSM8974

Do we need to keep adding these into the driver for every SoC
that we support? My understanding is apq8064 can be the one that
requires one clk, and msm8974 can be the one that requires three.
The driver can just have those two compatibles for now, and we
can keep adding compatibles here for the different SoCs, but
really we don't care, that's just to save ourselves if something
pops up and needs a workaround.

It will certainly look weird if it's firmware that's compatible
with qcom,scm-msm8974 but on an apq8084, so perhaps something
more generic like, qcom-scm-v1 and qcom,scm-v2 can be used as the
generic compatible in the driver:

	compatible = "qcom,scm-apq8064", "qcom,scm-v1";

	vs.

	compatible = "qcom,scm-apq8084", "qcom,scm-v2";

?

I just want to avoid the constant SoC churn update here if we can.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
