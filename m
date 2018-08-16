From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 16 Aug 2018 16:44:47 +0100
Subject: [PATCH 2/2] coresight: etb10: Splitting function etb_enable()
In-Reply-To: <1534284866-2523-2-git-send-email-mathieu.poirier@linaro.org>
References: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
 <1534284866-2523-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <500292f8-d2ef-534d-9331-6a4ea7471c19@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/18 23:14, Mathieu Poirier wrote:
> Up until now the relative simplicity of enabling the ETB made it
> possible to accommodate processing for both sysFS and perf methods.
> But work on claimtags and CPU-wide trace scenarios is adding some
> complexity, making the current code messy and hard to maintain.
> 
> As such follow what has been done for ETF and ETR components and split
> function etb_enable() so that processing for both API can be done
> cleanly.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---

> +static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
> +{
> +	int ret;
> +	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	switch (mode) {
> +	case CS_MODE_SYSFS:
> +		ret = etb_enable_sysfs(csdev);
> +		break;
> +	case CS_MODE_PERF:
> +		ret = etb_enable_perf(csdev, data);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(drvdata->dev, "ETB enabled\n");
> +	return 0;
> +}
> +

Looks good.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
