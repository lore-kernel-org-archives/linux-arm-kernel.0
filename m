From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 18 Apr 2017 09:24:47 -0600
Subject: [PATCH v6 5/8] coresight: use const for device_node structures
In-Reply-To: <1491485461-22800-6-git-send-email-leo.yan@linaro.org>
References: <1491485461-22800-1-git-send-email-leo.yan@linaro.org>
 <1491485461-22800-6-git-send-email-leo.yan@linaro.org>
Message-ID: <20170418152447.GB22806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 09:30:58PM +0800, Leo Yan wrote:
> Almost low level functions from open firmware have used const to
> qualify device_node structures, so add const for device_node
> parameters in of_coresight related functions.
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

I agree with these changes but the patch needs to be split up - please see
below.

> ---
>  drivers/hwtracing/coresight/of_coresight.c | 6 +++---
>  include/linux/coresight.h                  | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index 78d2399..46eec0f 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -52,7 +52,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
>  			       endpoint, of_dev_node_match);
>  }
>  
> -static void of_coresight_get_ports(struct device_node *node,
> +static void of_coresight_get_ports(const struct device_node *node,
>  				   int *nr_inport, int *nr_outport)

Move this to a patch by itself as it is not related to this driver.

>  {
>  	struct device_node *ep = NULL;
> @@ -101,7 +101,7 @@ static int of_coresight_alloc_memory(struct device *dev,
>  	return 0;
>  }
>  
> -int of_coresight_get_cpu(struct device_node *node)
> +int of_coresight_get_cpu(const struct device_node *node)

Move this to the previous patch in this set.  There is not need to undo what you
just did there.

>  {
>  	int cpu;
>  	bool found;
> @@ -128,7 +128,7 @@ int of_coresight_get_cpu(struct device_node *node)
>  EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>  
>  struct coresight_platform_data *of_get_coresight_platform_data(
> -				struct device *dev, struct device_node *node)
> +			struct device *dev, const struct device_node *node)

Same here, move this to a new patch (the same one as of_coresight_get_ports()).

>  {
>  	int i = 0, ret = 0;
>  	struct coresight_platform_data *pdata;
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index bf96678..4915254 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -263,13 +263,13 @@ static inline int coresight_timeout(void __iomem *addr, u32 offset,
>  #endif
>  
>  #ifdef CONFIG_OF
> -extern int of_coresight_get_cpu(struct device_node *node);
> +extern int of_coresight_get_cpu(const struct device_node *node);
>  extern struct coresight_platform_data *of_get_coresight_platform_data(
> -				struct device *dev, struct device_node *node);
> +	struct device *dev, const struct device_node *node);
>  #else
> -static inline int of_coresight_get_cpu(struct device_node *node) { return 0; }
> +static inline int of_coresight_get_cpu(const struct device_node *node) { return 0; }
>  static inline struct coresight_platform_data *of_get_coresight_platform_data(
> -	struct device *dev, struct device_node *node) { return NULL; }
> +	struct device *dev, const struct device_node *node) { return NULL; }
>  #endif
>  
>  #ifdef CONFIG_PID_NS
> -- 
> 2.7.4
> 
