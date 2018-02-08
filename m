From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 8 Feb 2018 14:55:12 +0100
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <1517939104-230881-6-git-send-email-john.garry@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
Message-ID: <20180208135512.GG10234@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:

SNIP

> +	char *perpkg;
> +	char *unit;
> +	char *metric_expr;
> +	char *metric_name;
> +	char *metric_group;
> +	struct list_head list;
> +	char strings[];
> +};
> +
> +static LIST_HEAD(arch_std_events);
> +
> +#define ADD_EVENT_STRING(string) do { if (string) {		\
> +	es->string = strings;					\
> +	strings += snprintf(strings, len, "%s", string) + 1;	\
> +} } while (0)
> +
> +static int save_arch_std_events(void *data, char *name, char *event,
> +				char *desc, char *long_desc, char *pmu,
> +				char *unit, char *perpkg, char *metric_expr,
> +				char *metric_name, char *metric_group)
> +{
> +	struct event_struct *es;
> +	struct stat *sb = data;
> +	int len;
> +	char *strings;
> +
> +	/*
> +	 * Lazily allocate size of the json file to hold the
> +	 * strings, which would be more than large enough.
> +	 */
> +	len = sb->st_size;
> +
> +	es = malloc(sizeof(*es) + len);

hum, so for single event you allocate buffer of the size
of the entire file this event is defined in?

what do I miss? I assume there're more of those arch-defined
events defined in the single file..

jirka
