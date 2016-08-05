From: jolsa@redhat.com (Jiri Olsa)
Date: Fri, 5 Aug 2016 12:32:46 +0200
Subject: [PATCH V4 4/6] perf tools: pushing driver configuration down to
 the kernel
In-Reply-To: <1470329604-14356-5-git-send-email-mathieu.poirier@linaro.org>
References: <1470329604-14356-1-git-send-email-mathieu.poirier@linaro.org>
 <1470329604-14356-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160805103246.GC12528@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 10:53:22AM -0600, Mathieu Poirier wrote:

SNIP

> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 418ed94756d3..df74bdbb7524 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -940,6 +940,10 @@ static int callchain_param__setup_sample_type(struct callchain_param *callchain)
>  
>  static int __cmd_top(struct perf_top *top)
>  {
> +	char msg[512];
> +	struct perf_evsel *pos;
> +	struct perf_evsel_config_term *err_term;
> +	struct perf_evlist *evlist = top->evlist;
>  	struct record_opts *opts = &top->record_opts;
>  	pthread_t thread;
>  	int ret;
> @@ -976,6 +980,13 @@ static int __cmd_top(struct perf_top *top)
>  	if (ret)
>  		goto out_delete;
>  
> +	if (perf_evlist__apply_drv_configs(evlist, &pos, &err_term)) {
> +		error("failed to set config \"%s\" on event %s with %d (%s)\n",
> +			err_term->val.drv_cfg, perf_evsel__name(pos), errno,
> +			strerror_r(errno, msg, sizeof(msg)));

hum ret is 0 in here..

> +		goto out_delete;
> +	}

thanks,
jirka
