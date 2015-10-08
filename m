From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 7 Oct 2015 23:05:57 -0700
Subject: [PATCH v3 4/9] clk: qcom: create virtual child device for TSENS
In-Reply-To: <1444280468-17159-5-git-send-email-rnayak@codeaurora.org>
References: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org>
 <1444280468-17159-5-git-send-email-rnayak@codeaurora.org>
Message-ID: <20151008060557.GD26883@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08, Rajendra Nayak wrote:
> @@ -3520,11 +3522,26 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> -	return qcom_cc_probe(pdev, match->data);
> +	ret = qcom_cc_probe(pdev, match->data);
> +	if (ret)
> +		return ret;
> +
> +	tsens = platform_device_register_data(&pdev->dev, "qcom-tsens", -1,
> +					      NULL, 0);
> +	if (IS_ERR(tsens)) {
> +		qcom_cc_remove(pdev);
> +		return PTR_ERR(tsens);
> +	}
> +	platform_set_drvdata(pdev, tsens);

We just blew away the pointer that qcom_cc_probe() stores.

> +
> +	return 0;
>  }
>  
>  static int gcc_msm8960_remove(struct platform_device *pdev)
>  {
> +	struct platform_device *tsens = platform_get_drvdata(pdev);
> +
> +	platform_device_unregister(tsens);
>  	qcom_cc_remove(pdev);

So now we've leaked the reset controller.

I suppose the simplest solution is to get the drvdata pointer
after qcom_cc_probe(), allocate a container structure to hold
that as a void * plus the tsens device, i.e.

	struct container {
		void *data;
		struct platform_device *tsens;
	};
	
and then set the drvdata to that. And finally undo all that and
restore the drvdata pointer on remove.

I've also been considering putting some devm stuff inside
qcom_cc_probe() itself so that in the normal case you don't even
need to call qcom_cc_remove(), it just gets done automatically.
That would open up the possibility for drivers to use the drvdata
member as they wish.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
