From: vkoul@kernel.org (Vinod)
Date: Thu, 17 May 2018 16:17:48 +0530
Subject: [PATCH v2] dmaengine: qcom: bam_dma: check if the runtime pm
 enabled
In-Reply-To: <20180517094232.27924-1-srinivas.kandagatla@linaro.org>
References: <20180517094232.27924-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180517104748.GY13271@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-05-18, 10:42, Srinivas Kandagatla wrote:
> Disabling pm runtime at probe is not sufficient to get BAM working
> on remotely controller instances. pm_runtime_get_sync() would return
> -EACCES in such cases.
> So check if runtime pm is enabled before returning error from bam functions.
> 
> Fixes: 5b4a68952a89 ("dmaengine: qcom: bam_dma: disable runtime pm on remote controlled")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index d29275b97e84..4a828c18099a 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -524,6 +524,14 @@ static int bam_alloc_chan(struct dma_chan *chan)
>  	return 0;
>  }
>  
> +static int bam_pm_runtime_get_sync(struct device *dev)
> +{
> +	if (pm_runtime_enabled(dev))
> +		return pm_runtime_get_sync(dev);
> +
> +	return 0;
> +}

This makes it look lot neater :)

Applied, thanks

-- 
~Vinod
