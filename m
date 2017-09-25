From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Sep 2017 16:08:30 +0100
Subject: [PATCH] perf: qcom_l2_pmu: add event names
In-Reply-To: <1505417413-30757-1-git-send-email-nleeder@codeaurora.org>
References: <1505417413-30757-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <20170925150829.GA30917@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 03:30:13PM -0400, Neil Leeder wrote:
> Add event names so that common events can be
> specified symbolically, for example:
> 
> l2cache_0/total-reads/,l2cache_0/cycles/
> 
> Event names are displayed in 'perf list'.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> ---
>  drivers/perf/qcom_l2_pmu.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
> index b242cce..4fdc848 100644
> --- a/drivers/perf/qcom_l2_pmu.c
> +++ b/drivers/perf/qcom_l2_pmu.c
> @@ -92,6 +92,21 @@
>  
>  #define reg_idx(reg, i)         (((i) * IA_L2_REG_OFFSET) + reg##_BASE)
>  
> +/*
> + * Events
> + */
> +#define L2_EVENT_CYCLES                    0xfe
> +#define L2_EVENT_DCACHE_OPS                0x400
> +#define L2_EVENT_ICACHE_OPS                0x401
> +#define L2_EVENT_TLBI                      0x402
> +#define L2_EVENT_BARRIERS                  0x403
> +#define L2_EVENT_TOTAL_READS               0x405
> +#define L2_EVENT_TOTAL_WRITES              0x406
> +#define L2_EVENT_TOTAL_REQUESTS            0x407
> +#define L2_EVENT_LDREX                     0x420
> +#define L2_EVENT_STREX                     0x421
> +#define L2_EVENT_CLREX                     0x422
> +
>  static DEFINE_RAW_SPINLOCK(l2_access_lock);
>  
>  /**
> @@ -700,9 +715,12 @@ static ssize_t l2_cache_pmu_cpumask_show(struct device *dev,
>  /* CCG format for perf RAW codes. */
>  PMU_FORMAT_ATTR(l2_code,   "config:4-11");
>  PMU_FORMAT_ATTR(l2_group,  "config:0-3");
> +PMU_FORMAT_ATTR(event,     "config:0-11");
> +
>  static struct attribute *l2_cache_pmu_formats[] = {
>  	&format_attr_l2_code.attr,
>  	&format_attr_l2_group.attr,
> +	&format_attr_event.attr,
>  	NULL,
>  };
>  
> @@ -711,9 +729,45 @@ static ssize_t l2_cache_pmu_cpumask_show(struct device *dev,
>  	.attrs = l2_cache_pmu_formats,
>  };
>  
> +static ssize_t l2cache_pmu_event_show(struct device *dev,
> +				      struct device_attribute *attr, char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);

Nit: do you want a 0x%03llx here?

(I'm happy to take the patch either way, so just let me know)

Will
