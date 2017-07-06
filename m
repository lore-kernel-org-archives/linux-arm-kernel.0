From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 6 Jul 2017 15:13:13 +0530
Subject: [PATCH] input: coresight: Fix redefinition error on compilation.
In-Reply-To: <6333cde19a5c0adc8faf41531c2ae431cd79e7a6.1499332268.git.arvind.yadav.cs@gmail.com>
References: <6333cde19a5c0adc8faf41531c2ae431cd79e7a6.1499332268.git.arvind.yadav.cs@gmail.com>
Message-ID: <bd1d5998-c1e1-663b-22c7-1825d6efb339@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for noise. Please ignore this patch.


On Thursday 06 July 2017 02:45 PM, Arvind Yadav wrote:
> If CONFIG_CORESIGHT is disable, it'll through compilation error.
>
> drivers/hwtracing/coresight/coresight-etm-perf.c:462:5: error: redefinition of ?etm_perf_symlink?
>   int etm_perf_symlink(struct coresight_device *csdev, bool link)
>       ^
> In file included from drivers/hwtracing/coresight/coresight-etm-perf.c:30:0:
> drivers/hwtracing/coresight/coresight-etm-perf.h:61:19: note: previous definition of ?etm_perf_symlink? was here
>   static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index e97775d..74ce6a5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -458,7 +458,7 @@ static void etm_addr_filters_sync(struct perf_event *event)
>   
>   	filters->nr_filters = i;
>   }
> -
> +#ifdef CONFIG_CORESIGHT
>   int etm_perf_symlink(struct coresight_device *csdev, bool link)
>   {
>   	char entry[sizeof("cpu9999999")];
> @@ -483,7 +483,7 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
>   
>   	return 0;
>   }
> -
> +#endif
>   static int __init etm_perf_init(void)
>   {
>   	int ret;
