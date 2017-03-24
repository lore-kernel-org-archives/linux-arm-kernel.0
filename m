From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 24 Mar 2017 11:14:21 -0700
Subject: [PATCH v4 3/7] coresight: refactor with function
 of_coresight_get_cpu
In-Reply-To: <1489762943-25849-4-git-send-email-leo.yan@linaro.org>
References: <1489762943-25849-1-git-send-email-leo.yan@linaro.org>
 <1489762943-25849-4-git-send-email-leo.yan@linaro.org>
Message-ID: <20170324181421.GB25840@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17, Leo Yan wrote:
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index 917ca39..7a60f2b 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -101,15 +101,38 @@ static int of_coresight_alloc_memory(struct device *dev,
>  	return 0;
>  }
>  
> +int of_coresight_get_cpu(struct device_node *node)

const node?

> +{
> +	int cpu;
> +	bool found;
> +	struct device_node *dn, *np;
> +
> +	dn = of_parse_phandle(node, "cpu", 0);
> +
> +	/* Affinity defaults to CPU0 */
> +	if (!dn)
> +		return 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		np = of_get_cpu_node(cpu, NULL);

of_cpu_device_node_get()?

> +		found = (dn == np);
> +		of_node_put(np);
> +		if (found)
> +			break;
> +	}
> +	of_node_put(dn);
> +
> +	/* Affinity to CPU0 if no cpu nodes are found */
> +	return found ? cpu : 0;
> +}
> +
>  struct coresight_platform_data *of_get_coresight_platform_data(
>  				struct device *dev, struct device_node *node)
>  {
> -	int i = 0, ret = 0, cpu;
> +	int i = 0, ret = 0;
>  	struct coresight_platform_data *pdata;
>  	struct of_endpoint endpoint, rendpoint;
>  	struct device *rdev;
> -	bool found;
> -	struct device_node *dn, *np;
>  	struct device_node *ep = NULL;
>  	struct device_node *rparent = NULL;
>  	struct device_node *rport = NULL;
> @@ -176,18 +199,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
>  		} while (ep);
>  	}
>  
> -	dn = of_parse_phandle(node, "cpu", 0);
> -	for_each_possible_cpu(cpu) {
> -		np = of_get_cpu_node(cpu, NULL);
> -		found = (dn == np);
> -		of_node_put(np);
> -		if (found)
> -			break;
> -	}
> -	of_node_put(dn);
> -

Ok yeah the code is moving, so perhaps another patch to make the
changes suggested above.

> -	/* Affinity to CPU0 if no cpu nodes are found */
> -	pdata->cpu = found ? cpu : 0;
> +	pdata->cpu = of_coresight_get_cpu(node);
>  
>  	return pdata;
>  }
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 2a5982c..7b29743 100644
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
> +static int of_coresight_get_cpu(struct device_node *node) { return 0; }

inline?

>  static inline struct coresight_platform_data *of_get_coresight_platform_data(
>  	struct device *dev, struct device_node *node) { return NULL; }
>  #endif
> -- 
> 2.7.4
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
