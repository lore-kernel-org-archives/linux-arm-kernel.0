From: john.garry@huawei.com (John Garry)
Date: Thu, 8 Feb 2018 14:45:37 +0000
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <20180208135512.GG10234@krava>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
 <20180208135512.GG10234@krava>
Message-ID: <77588a26-e216-b44d-fc9e-cea6c05444df@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2018 13:55, Jiri Olsa wrote:
> On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:
>
> SNIP
>
>> +	char *perpkg;
>> +	char *unit;
>> +	char *metric_expr;
>> +	char *metric_name;
>> +	char *metric_group;
>> +	struct list_head list;
>> +	char strings[];
>> +};
>> +
>> +static LIST_HEAD(arch_std_events);
>> +
>> +#define ADD_EVENT_STRING(string) do { if (string) {		\
>> +	es->string = strings;					\
>> +	strings += snprintf(strings, len, "%s", string) + 1;	\
>> +} } while (0)
>> +
>> +static int save_arch_std_events(void *data, char *name, char *event,
>> +				char *desc, char *long_desc, char *pmu,
>> +				char *unit, char *perpkg, char *metric_expr,
>> +				char *metric_name, char *metric_group)
>> +{
>> +	struct event_struct *es;
>> +	struct stat *sb = data;
>> +	int len;
>> +	char *strings;
>> +
>> +	/*
>> +	 * Lazily allocate size of the json file to hold the
>> +	 * strings, which would be more than large enough.
>> +	 */
>> +	len = sb->st_size;
>> +
>> +	es = malloc(sizeof(*es) + len);
>
> hum, so for single event you allocate buffer of the size
> of the entire file this event is defined in?
>
> what do I miss? I assume there're more of those arch-defined
> events defined in the single file..

Hi Jirka,

Yes, allocating the file size per event was just to make the code more 
concise (instead of finding each string length), but obviously it is an 
inefficient practice in terms of memory usage.

But since the JSONs are generally not huge, and in practice we would 
only be accessing a fraction of the buffer's physical memory to save the 
event strings, I thought it ok.

Anyway, I'll see if there is something more efficient I can do.

Thanks,
John

>
> jirka
>
> .
>
