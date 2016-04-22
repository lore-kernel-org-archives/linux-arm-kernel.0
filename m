From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 22 Apr 2016 16:11:11 -0700
Subject: [PATCH 2/8] firmware: qcom: scm: Convert SCM to platform driver
In-Reply-To: <1461363432-5730-3-git-send-email-andy.gross@linaro.org>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
 <1461363432-5730-3-git-send-email-andy.gross@linaro.org>
Message-ID: <20160422231111.GD3202@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 22 Apr 15:17 PDT 2016, Andy Gross wrote:

[..]
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
[..]
> +static struct qcom_scm *__scm;
> +
> +static int qcom_scm_clk_enable(void)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(__scm->core_clk);
> +	if (ret)
> +		goto bail;
> +
> +	if (__scm->iface_clk) {

No need for this check, the clk api accepts NULL.

> +		ret = clk_prepare_enable(__scm->iface_clk);
> +		if (ret)
> +			goto disable_core;
> +	}
> +
> +	if (__scm->bus_clk) {

dito

> +		ret = clk_prepare_enable(__scm->bus_clk);
> +		if (ret)
> +			goto disable_iface;
> +	}
> +
> +	return 0;
> +
> +disable_iface:
> +	if (__scm->iface_clk)

dito

> +		clk_disable_unprepare(__scm->iface_clk);
> +disable_core:
> +	if (__scm->bus_clk)

and here

> +		clk_disable_unprepare(__scm->core_clk);
> +bail:
> +	return ret;
> +}
> +
> +static void qcom_scm_clk_disable(void)
> +{
> +	clk_disable_unprepare(__scm->core_clk);
> +	if (__scm->iface_clk)

and here

> +		clk_disable_unprepare(__scm->iface_clk);
> +	if (__scm->bus_clk)

and here

> +		clk_disable_unprepare(__scm->bus_clk);
> +}
> +
>  /**
>   * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
>   * @entry: Entry point function for the cpus
> @@ -72,11 +121,17 @@ EXPORT_SYMBOL(qcom_scm_cpu_power_down);
>   */
>  bool qcom_scm_hdcp_available(void)
>  {
> -	int ret;
> +	int ret = qcom_scm_clk_enable();
> +
> +	if (ret)
> +		goto clk_err;

Just return here.

>  
>  	ret = __qcom_scm_is_call_available(QCOM_SCM_SVC_HDCP,
> -		QCOM_SCM_CMD_HDCP);
> +						QCOM_SCM_CMD_HDCP);
> +
> +	qcom_scm_clk_disable();
>  
> +clk_err:
>  	return (ret > 0) ? true : false;

Unnecessary parenthesis.

>  }
>  EXPORT_SYMBOL(qcom_scm_hdcp_available);
> @@ -91,6 +146,89 @@ EXPORT_SYMBOL(qcom_scm_hdcp_available);
>   */
>  int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
>  {
> -	return __qcom_scm_hdcp_req(req, req_cnt, resp);
> +	int ret = qcom_scm_clk_enable();
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = __qcom_scm_hdcp_req(req, req_cnt, resp);
> +	qcom_scm_clk_disable();
> +	return ret;
>  }
>  EXPORT_SYMBOL(qcom_scm_hdcp_req);
> +
> +/**
> + * qcom_scm_is_available() - Checks if SCM is available
> + */
> +bool qcom_scm_is_available(void)
> +{
> +	return !!__scm;
> +}
> +EXPORT_SYMBOL(qcom_scm_is_available);
> +
> +static int qcom_scm_probe(struct platform_device *pdev)
> +{
> +	struct qcom_scm *scm;
> +	long rate;
> +	int ret;
> +
> +	scm = devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
> +	if (!scm)
> +		return -ENOMEM;
> +
> +	scm->core_clk = devm_clk_get(&pdev->dev, "core");
> +	if (IS_ERR(scm->core_clk)) {
> +		if (PTR_ERR(scm->core_clk) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to acquire core clk\n");
> +		return PTR_ERR(scm->core_clk);
> +	}
> +
> +	if (of_device_is_compatible(pdev->dev.of_node, "qcom,scm-apq8064")) {

Shouldn't this be reversed?

> +		scm->iface_clk = devm_clk_get(&pdev->dev, "iface");
> +		if (IS_ERR(scm->iface_clk)) {
> +			if (PTR_ERR(scm->iface_clk) != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "failed to acquire iface clk\n");
> +			return PTR_ERR(scm->iface_clk);
> +		}
> +
> +		scm->bus_clk = devm_clk_get(&pdev->dev, "bus");
> +		if (IS_ERR(scm->bus_clk)) {
> +			if (PTR_ERR(scm->bus_clk) != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "failed to acquire bus clk\n");
> +			return PTR_ERR(scm->bus_clk);
> +		}
> +	}
> +
> +	/* vote for max clk rate for highest performance */
> +	rate = clk_round_rate(scm->core_clk, INT_MAX);
> +	ret = clk_set_rate(scm->core_clk, rate);
> +	if (ret)
> +		return ret;
> +
> +	__scm = scm;
> +	__scm->dev = &pdev->dev;
> +
> +	return 0;
> +}
> +

Regards,
Bjorn
