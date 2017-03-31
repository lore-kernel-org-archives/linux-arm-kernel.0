From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 31 Mar 2017 10:05:37 +0100
Subject: [PATCH v5 4/9] coresight: refactor with function
 of_coresight_get_cpu
In-Reply-To: <1490466197-29163-5-git-send-email-leo.yan@linaro.org>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-5-git-send-email-leo.yan@linaro.org>
Message-ID: <8f45279c-5768-9a56-3c6d-3ecfd63f4b18@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/03/17 18:23, Leo Yan wrote:
> This is refactor to add function of_coresight_get_cpu(), so it's used to
> retrieve CPU id for coresight component. Finally can use it as a common
> function for multiple places.
>
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> -		if (found)
> -			break;
> -	}
> -	of_node_put(dn);
> -
> -	/* Affinity to CPU0 if no cpu nodes are found */
> -	pdata->cpu = found ? cpu : 0;
> +	pdata->cpu = of_coresight_get_cpu(node);
>
>  	return pdata;
>  }
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 2a5982c..bf96678 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -263,9 +263,11 @@ static inline int coresight_timeout(void __iomem *addr, u32 offset,
>  #endif
>
>  #ifdef CONFIG_OF
> +extern int of_coresight_get_cpu(struct device_node *node);
>  extern struct coresight_platform_data *of_get_coresight_platform_data(
>  				struct device *dev, struct device_node *node);
>  #else
> +static inline int of_coresight_get_cpu(struct device_node *node) { return 0; }
>  static inline struct coresight_platform_data *of_get_coresight_platform_data(
>  	struct device *dev, struct device_node *node) { return NULL; }
>  #endif
>
