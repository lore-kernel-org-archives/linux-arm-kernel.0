From: jolsa@redhat.com (Jiri Olsa)
Date: Wed, 20 Jul 2016 09:26:20 +0200
Subject: [PATCH 3/6] perf tools: add infrastructure for PMU specific
 configuration
In-Reply-To: <1468968836-12695-4-git-send-email-mathieu.poirier@linaro.org>
References: <1468968836-12695-1-git-send-email-mathieu.poirier@linaro.org>
 <1468968836-12695-4-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160720072620.GA26497@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 04:53:53PM -0600, Mathieu Poirier wrote:
> This patchset adds PMU driver specific configuration to the parser
> infrastructure by preceding any term with the '@' letter.  As such
> doing something like:
> 
> perf record -e some_event/@cfg1, at cfg2=config/ ...
> 
> will see 'cfg1' and 'cfg2=config' being added to the list of evsel config
> terms.  Token 'cfg1' and 'cfg2=config' are not processed in user space
> and are meant to be interpreted by the PMU driver.
> 
> First the lexer/parser are supplemented with the required definitions to
> recognise the driver specific configuration.  From there they are simply
> added to the list of event terms.  The bulk of the work is done in
> function "parse_events_add_pmu()" where driver config event terms are
> added to a new list of driver config terms, which in turn spliced with
> the event's new driver configuration list.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  tools/perf/util/evsel.c        |  1 +
>  tools/perf/util/evsel.h        |  4 +++
>  tools/perf/util/parse-events.c | 67 +++++++++++++++++++++++++++++++-----------
>  tools/perf/util/parse-events.h |  1 +
>  tools/perf/util/parse-events.l | 12 ++++++++
>  tools/perf/util/parse-events.y | 11 +++++++
>  6 files changed, 79 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5d7037ef7d3b..7f97bae594ff 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -213,6 +213,7 @@ void perf_evsel__init(struct perf_evsel *evsel,
>  	evsel->bpf_fd	   = -1;
>  	INIT_LIST_HEAD(&evsel->node);
>  	INIT_LIST_HEAD(&evsel->config_terms);
> +	INIT_LIST_HEAD(&evsel->drv_config_terms);
>  	perf_evsel__object.init(evsel);
>  	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
>  	perf_evsel__calc_id_pos(evsel);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index c1f10159804c..0441be00a366 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -44,6 +44,7 @@ enum {
>  	PERF_EVSEL__CONFIG_TERM_CALLGRAPH,
>  	PERF_EVSEL__CONFIG_TERM_STACK_USER,
>  	PERF_EVSEL__CONFIG_TERM_INHERIT,
> +	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
>  	PERF_EVSEL__CONFIG_TERM_MAX,

Arnaldo just merged changes that adds new terms, so this patch
won't apply.. could you please rebase to [1] and resend?

We don't change it too often, you just hit the window ;-)

thanks,
jirka

[1] git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
