From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Fri, 30 Jan 2015 17:17:51 +0530
Subject: [Patch v2 1/2] dmaengine: Add ADM driver
In-Reply-To: <1420687572-7116-2-git-send-email-agross@codeaurora.org>
References: <1420687572-7116-1-git-send-email-agross@codeaurora.org>
 <1420687572-7116-2-git-send-email-agross@codeaurora.org>
Message-ID: <54CB6F67.9080600@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,
A minor doubt.

On Thursday 08 January 2015 08:56 AM, Andy Gross wrote:
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  drivers/dma/Kconfig    |   10 +
>  drivers/dma/Makefile   |    1 +
>  drivers/dma/qcom_adm.c |  899 ++++++++++++++++++++++++++++++++++++++++++++++++

<snip>

> +
> +	return ret;
> +}
> +
> +static struct dma_chan *adm_dma_xlate(struct of_phandle_args *dma_spec,
> +	struct of_dma *of)
> +{
> +	struct adm_device *adev = container_of(of->of_dma_data,
> +			struct adm_device, common);
> +	struct adm_chan *achan;
I don't see achan being used anywhere in this function? apart from below.
> +	struct dma_chan *chan;
> +	unsigned int request;
> +
> +	if (dma_spec->args_count != 1) {
> +		dev_err(adev->dev, "incorrect number of dma arguments\n");
> +		return NULL;
> +	}
> +
> +	request = dma_spec->args[0];
> +	if (request >= adev->num_channels)
> +		return NULL;
> +
> +	chan = dma_get_slave_channel(&(adev->channels[request].vc.chan));
> +
> +	if (!chan)
> +		return NULL;
> +
> +	achan = to_adm_chan(chan);
Could not understand the use of achan here. unused code?

> +
> +	return chan;
> +}
> +
> +/**
> + * adm_issue_pending - starts pending transactions
> + * @chan: dma channel

<snip>

> +module_platform_driver(adm_dma_driver);
> +
> +MODULE_AUTHOR("Andy Gross <agross@codeaurora.org>");
> +MODULE_DESCRIPTION("QCOM ADM DMA engine driver");
> +MODULE_LICENSE("GPL v2");
> 
