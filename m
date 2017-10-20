From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 20 Oct 2017 13:34:25 +0100
Subject: [PATCH 02/17] coresight tmc: Hide trace buffer handling for file
 read
In-Reply-To: <20171019171553.24056-3-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-3-suzuki.poulose@arm.com>
Message-ID: <190b4a4a-6d54-51e5-52d3-2a313fea714d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 19/10/17 18:15, Suzuki K Poulose wrote:
> At the moment we adjust the buffer pointers for reading the trace
> data via misc device in the common code for ETF/ETB and ETR. Since
> we are going to change how we manage the buffer for ETR, let us
> move the buffer manipulation to the respective driver files, hiding
> it from the common code. We do so by adding type specific helpers
> for finding the length of data and the pointer to the buffer,
> for a given length at a file position.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 16 ++++++++++++
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 33 ++++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tmc.c     | 34 ++++++++++++++-----------
>   drivers/hwtracing/coresight/coresight-tmc.h     |  4 +++
>   4 files changed, 72 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index e2513b786242..0b6f1eb746de 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -120,6 +120,22 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
>   	CS_LOCK(drvdata->base);
>   }
>   
> +/*
> + * Return the available trace data in the buffer from @pos, with
> + * a maximum limit of @len, updating the @bufpp on where to
> + * find it.
> + */
> +ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
> +				  loff_t pos, size_t len, char **bufpp)
> +{
> +	/* Adjust the len to available size @pos */
> +	if (pos + len > drvdata->len)
> +		len = drvdata->len - pos;
> +	if (len > 0)

Do we have some guarantee that "pos <= drvdata->len"? because since len 
is unsigned this check only covers the case were len is 0.

Maybe it would be better to use a signed variable to store the result of 
the difference.

> +		*bufpp = drvdata->buf + pos;
> +	return len;
> +}
> +
>   static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
>   {
>   	int ret = 0;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index d0208f01afd9..063f253f1c99 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -69,6 +69,39 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>   	CS_LOCK(drvdata->base);
>   }
>   
> +/*
> + * Return the available trace data in the buffer @pos, with a maximum
> + * limit of @len, also updating the @bufpp on where to find it.
> + */
> +ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
> +			    loff_t pos, size_t len, char **bufpp)
> +{
> +	char *bufp = drvdata->buf + pos;
> +	char *bufend = (char *)(drvdata->vaddr + drvdata->size);
> +
> +	/* Adjust the len to available size @pos */
> +	if (pos + len > drvdata->len)
> +		len = drvdata->len - pos;
> +
> +	if (len <= 0)
> +		return len;

Similar issue here.

Cheers,

-- 
Julien Thierry
