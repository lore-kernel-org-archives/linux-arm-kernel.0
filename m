From: balbi@ti.com (Felipe Balbi)
Date: Tue, 28 Oct 2014 10:01:48 -0500
Subject: [PATCH V4 3/3] rtc: omap: Support regulator supply for RTC
In-Reply-To: <1414490332-14856-4-git-send-email-lokeshvutla@ti.com>
References: <1414490332-14856-1-git-send-email-lokeshvutla@ti.com>
 <1414490332-14856-4-git-send-email-lokeshvutla@ti.com>
Message-ID: <20141028150148.GE8123@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 03:28:52PM +0530, Lokesh Vutla wrote:
> Certain SoCs such as DRA7, RTC is an independent voltage domain of it's own
> and on platforms such as DRA7-evm, this may be supplied by individual
> regulator on it's own.
> So make the OMAP RTC driver support a power regulator.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> - Dropped the Reviewed-by tags as this patch is changed from previous version.
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  6 ++++
>  drivers/rtc/rtc-omap.c                             | 41 +++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> index 750efd4..c1d84ac 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -15,6 +15,9 @@ Required properties:
>  Optional properties:
>  - ti,system-power-controller: whether the rtc is controlling the system power
>    through pmic_power_en
> +- vrtc-supply: phandle to the regulator device tree node.
> +- vrtc-minuV: Minimum required voltage in uV, If default voltage needs to be changed
> +- vrtc-maxuV: Maximum acceptable voltage in uV, If default voltage needs to be changed

huh ? minuV and maxuV is already part of the regulator binding itself.

> @@ -514,6 +516,37 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (IS_ERR(rtc->base))
>  		return PTR_ERR(rtc->base);
>  
> +	rtc->supply = devm_regulator_get_optional(&pdev->dev, "vrtc");

I'm not sure if this is optional either, it's just that many of our
current DTS don't really pass a regulator to RTC, right ?

> +	if (IS_ERR(rtc->supply)) {
> +		if (PTR_ERR(rtc->supply) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		rtc->supply = NULL;
> +	}
> +
> +	if (rtc->supply) {
> +		of_property_read_u32(pdev->dev.of_node, "vrtc-minuV",
> +				     &vrtc_minuV);
> +		of_property_read_u32(pdev->dev.of_node, "vrtc-maxuV",
> +				     &vrtc_maxuV);
> +		if (vrtc_minuV && vrtc_maxuV) {
> +			ret = regulator_set_voltage(rtc->supply,
> +						    vrtc_minuV, vrtc_maxuV);
> +			if (ret) {
> +				dev_err(&pdev->dev, "failed to set volt %d\n",
> +					ret);
> +				return ret;
> +			}
> +		}

I'd really like to Mark's comments here but I was under the impression
that if the binding already gives min_microvolt == max_microvolt then
driver shouldn't really care about a set_voltage. Mark ?

> +
> +		ret = regulator_enable(rtc->supply);
> +		if (ret) {
> +			dev_err(&pdev->dev, "regulator enable failed %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
>  	platform_set_drvdata(pdev, rtc);
>  
>  	/* Enable the clock/module so that we can access the registers */
> @@ -624,6 +657,9 @@ err:
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> +	if (rtc->supply)
> +		regulator_disable(rtc->supply);
> +
>  	return ret;
>  }
>  
> @@ -649,6 +685,9 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> +	if (rtc->supply)
> +		regulator_disable(rtc->supply);
> +
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/a12a912a/attachment.sig>
