From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 8 Mar 2018 10:03:58 -0300
Subject: [RFC V4] perf, tools: Support wildcards on pmu name in dynamic
 pmu events
In-Reply-To: <1520454947-16977-1-git-send-email-agustinv@codeaurora.org>
References: <1520454947-16977-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <20180308130358.GC3701@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Wed, Mar 07, 2018 at 03:35:47PM -0500, Agustin Vega-Frias escreveu:
> +++ b/tools/perf/util/parse-events.y
> @@ -8,6 +8,7 @@
> 
>  #define YYDEBUG 1
> 
> +#include <fnmatch.h>
>  #include <linux/compiler.h>
>  #include <linux/list.h>
>  #include <linux/types.h>
> @@ -234,6 +235,10 @@ PE_NAME opt_event_config
>  	if (parse_events_add_pmu(_parse_state, list, $1, $2)) {
>  		struct perf_pmu *pmu = NULL;
>  		int ok = 0;
> +		char *pattern;
> +
> +		if (asprintf(&pattern, "%s*", $1) < 0)
> +			YYABORT;

+               if (asprintf(&pattern, "?(uncore_)%s*", $1) < 0)

I completely overlook that you were using this and thus needed that
extension, duh, thanks for the patience 8-) and for the new patch.

- Arnaldo
