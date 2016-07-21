From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 21 Jul 2016 09:47:38 +0200
Subject: [PATCH V2 4/6] perf tools: pushing driver configuration down to
 the kernel
In-Reply-To: <1469047100-18131-5-git-send-email-mathieu.poirier@linaro.org>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
 <1469047100-18131-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160721074738.GD7192@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 02:38:18PM -0600, Mathieu Poirier wrote:
> Now that PMU specific driver configuration are queued in
> evsel::drv_config_terms, all we need to do is re-use the current
> ioctl() mechanism to push down the information to the kernel
> driver.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  tools/perf/builtin-record.c |  9 +++++++++
>  tools/perf/util/evlist.c    | 24 ++++++++++++++++++++++++
>  tools/perf/util/evlist.h    |  3 +++
>  tools/perf/util/evsel.c     | 32 ++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.h     |  3 +++
>  5 files changed, 71 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8f2c16d9275f..dffea1033b8e 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -383,6 +383,7 @@ static int record__open(struct record *rec)
>  	struct perf_evlist *evlist = rec->evlist;
>  	struct perf_session *session = rec->session;
>  	struct record_opts *opts = &rec->opts;
> +	struct perf_evsel_config_term *err_term;
>  	int rc = 0;
>  
>  	perf_evlist__config(evlist, opts, &callchain_param);
> @@ -412,6 +413,14 @@ try_again:
>  		goto out;
>  	}
>  
> +	if (perf_evlist__apply_drv_configs(evlist, &pos, &err_term)) {
> +		error("failed to set config \"%s\" on event %s with %d (%s)\n",
> +			err_term->val.drv_cfg, perf_evsel__name(pos), errno,
> +			strerror_r(errno, msg, sizeof(msg)));
> +		rc = -1;
> +		goto out;
> +	}
> +

how about 'perf top' and 'perf stat', should they support this too?

thanks,
jirka
