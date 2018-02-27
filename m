From: jolsa@redhat.com (Jiri Olsa)
Date: Tue, 27 Feb 2018 10:48:48 +0100
Subject: [PATCH v2 07/11] perf vendor events: add support for arch
 standard events
In-Reply-To: <1519401932-205051-8-git-send-email-john.garry@huawei.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <1519401932-205051-8-git-send-email-john.garry@huawei.com>
Message-ID: <20180227094848.GF21033@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 24, 2018 at 12:05:28AM +0800, John Garry wrote:

SNIP

> +static int save_arch_std_events(void *data, char *name, char *event,
> +				char *desc, char *long_desc, char *pmu,
> +				char *unit, char *perpkg, char *metric_expr,
> +				char *metric_name, char *metric_group)
> +{
> +	struct event_struct *es;
> +	struct stat *sb = data;
> +
> +	es = malloc(sizeof(*es));
> +	if (!es)
> +		return -ENOMEM;
> +	memset(es, 0, sizeof(*es));
> +	FOR_ALL_EVENT_STRUCT_FIELDS(ADD_EVENT_FIELD);
> +	list_add_tail(&es->list, &arch_std_events);
> +	return 0;
> +out_free:
> +	FOR_ALL_EVENT_STRUCT_FIELDS(FREE_EVENT_FIELD);
> +	free(es);
> +	return -ENOMEM;
> +}
> +
>  static void print_events_table_suffix(FILE *outfp)
>  {
>  	fprintf(outfp, "{\n");
> @@ -391,6 +469,27 @@ static char *real_event(const char *name, char *event)
>  	return event;
>  }
>  
> +static int
> +try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> +	  char **name, char **long_desc, char **pmu, char **filter,
> +	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
> +	  char **metric_group)
> +{
> +	/* try to find matching event from arch standard values */
> +	struct event_struct *es;
> +
> +	list_for_each_entry(es, &arch_std_events, list) {
> +		if (!strcmp(arch_std, es->event+sizeof(EVENT_PREFIX))) {

I spent some time figuring out how this can work when there's on '=' in EVENT_PREFIX
is this because sizeof returns +1 size for NULL char also?

thanks,
jirka
