From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 17 Mar 2017 15:09:23 +0000
Subject: [PATCH v4 2/7] coresight: of_get_coresight_platform_data: Add
 missing of_node_put
In-Reply-To: <1489762943-25849-3-git-send-email-leo.yan@linaro.org>
References: <1489762943-25849-1-git-send-email-leo.yan@linaro.org>
 <1489762943-25849-3-git-send-email-leo.yan@linaro.org>
Message-ID: <574d8e6b-cd2d-c1be-6c14-09e8be147e93@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/17 15:02, Leo Yan wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> The of_get_coresight_platform_data iterates over the possible CPU nodes
> to find a given cpu phandle. However it does not drop the reference
> to the node pointer returned by the of_get_coresight_platform_data.
>
> [Leo: minor tweaks for of_get_coresight_platform_data]
>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

You should add your Signed-off-by here when you send somebody's patch, irrespective
of whether you have modified it or not.
e.g:

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[Leo: minor tweaks for of_get_coresight_platform_data]
Signed-off-by: Leo Yan <leo.yan@linaro.org>


> ---
>  drivers/hwtracing/coresight/of_coresight.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index 629e031..917ca39 100644
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
> +		np = of_get_cpu_node(cpu, NULL);
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
>
