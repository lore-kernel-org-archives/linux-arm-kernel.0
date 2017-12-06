From: jolsa@redhat.com (Jiri Olsa)
Date: Wed, 6 Dec 2017 14:37:52 +0100
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <1512490399-94107-3-git-send-email-john.garry@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
Message-ID: <20171206133752.GB12508@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 12:13:16AM +0800, John Garry wrote:

SNIP

> ---
>  tools/perf/pmu-events/jevents.c | 215 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 198 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index a0d489e..a820ed4 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -42,6 +42,7 @@
>  #include <dirent.h>
>  #include <sys/time.h>			/* getrlimit */
>  #include <sys/resource.h>		/* getrlimit */
> +#include <sys/queue.h>
>  #include <ftw.h>
>  #include <sys/stat.h>
>  #include "jsmn.h"
> @@ -366,6 +367,94 @@ static int print_events_table_entry(void *data, char *name, char *event,
>  	return 0;
>  }
>  
> +struct event_struct {
> +	char *name;
> +	char *event;
> +	char *desc;
> +	char *long_desc;
> +	char *pmu;
> +	char *unit;
> +	char *perpkg;
> +	char *metric_expr;
> +	char *metric_name;
> +	char *metric_group;
> +	LIST_ENTRY(event_struct) list;

is there any reason you don't use the 'struct list_head' ?
I dont think we want another thingie involved for lists

jirka
