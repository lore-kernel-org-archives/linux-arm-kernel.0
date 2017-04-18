From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 18 Apr 2017 09:09:10 -0600
Subject: [PATCH v6 3/8] coresight: of_get_coresight_platform_data: Add
 missing of_node_put
In-Reply-To: <1491485461-22800-4-git-send-email-leo.yan@linaro.org>
References: <1491485461-22800-1-git-send-email-leo.yan@linaro.org>
 <1491485461-22800-4-git-send-email-leo.yan@linaro.org>
Message-ID: <20170418150910.GA22806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 09:30:56PM +0800, Leo Yan wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> The of_get_coresight_platform_data iterates over the possible CPU nodes
> to find a given cpu phandle. However it does not drop the reference
> to the node pointer returned by the of_get_coresight_platform_data.
> 
> This patch also introduces another minor fix is to use
> of_cpu_device_node_get() to replace of_get_cpu_node().
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> [Leo: minor tweaks for of_get_coresight_platform_data]
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Suzuki sent a Reviewed-by for this, it should be added here.

> ---
>  drivers/hwtracing/coresight/of_coresight.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index 629e031..1a77280 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -108,7 +108,8 @@ struct coresight_platform_data *of_get_coresight_platform_data(
>  	struct coresight_platform_data *pdata;
>  	struct of_endpoint endpoint, rendpoint;
>  	struct device *rdev;
> -	struct device_node *dn;
> +	bool found;
> +	struct device_node *dn, *np;
>  	struct device_node *ep = NULL;
>  	struct device_node *rparent = NULL;
>  	struct device_node *rport = NULL;
> @@ -175,17 +176,19 @@ struct coresight_platform_data *of_get_coresight_platform_data(
>  		} while (ep);
>  	}
>  
> -	/* Affinity defaults to CPU0 */
> -	pdata->cpu = 0;
>  	dn = of_parse_phandle(node, "cpu", 0);
> -	for (cpu = 0; dn && cpu < nr_cpu_ids; cpu++) {
> -		if (dn == of_get_cpu_node(cpu, NULL)) {
> -			pdata->cpu = cpu;
> +	for_each_possible_cpu(cpu) {
> +		np = of_cpu_device_node_get(cpu);
> +		found = (dn == np);
> +		of_node_put(np);
> +		if (found)
>  			break;
> -		}
>  	}
>  	of_node_put(dn);
>  
> +	/* Affinity to CPU0 if no cpu nodes are found */
> +	pdata->cpu = found ? cpu : 0;
> +
>  	return pdata;
>  }
>  EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
> -- 
> 2.7.4
> 
