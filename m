From: john.garry@huawei.com (John Garry)
Date: Thu, 8 Feb 2018 15:57:35 +0000
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <20180208135409.GA10234@krava>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
 <20180208135409.GA10234@krava>
Message-ID: <e8e1ab1d-8008-b1dc-62d9-6f42a78b4780@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2018 13:54, Jiri Olsa wrote:
> On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:
>

Hi Jirka,

I'll try to combine some responses, below:

> SNIP
>
>> +static void fixup_field(char *from, char **to)
>> +{
>> +	*to = malloc(strlen(from));
>> +
>> +	strcpy(*to, from);
>> +}
>> +
>> +#define EVENT_PREFIX "event="
>> +
>> +#define TRY_FIXUP_FIELD(string)	do { if (es->string && !*string)\
>> +			fixup_field(es->string, string);	\
>> +} while (0)
>
> please indent the code in the macro like normal code
>

Ok

>> +
>> +static int
>> +try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>> +	  char **name, char **long_desc, char **pmu, char **filter,
>> +	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
>> +	  char **metric_group)
>> +{
>> +	/* try to find matching event from arch standard values */
>> +	struct event_struct *es;
>> +
>> +	list_for_each_entry(es, &arch_std_events, list) {
>> +		if (!strcmp(arch_std, es->event+strlen(EVENT_PREFIX))) {
>
> you could use just sizeof(EVENT_PREFIX). no need to call strlen
>

Right,

 >> +
 >> +static LIST_HEAD(arch_std_events);
 >> +
 >> +#define ADD_EVENT_STRING(string) do { if (string) {		\
 >> +	es->string = strings;					\
 >> +	strings += snprintf(strings, len, "%s", string) + 1;	\
 >> +} } while (0)
 >
 > please indent the code in macro like normal code

This looked ok, with a single tab indent. It is same style as "EXPECT" 
macro.

 >>  	mapfile = NULL;
 >> +	rc = nftw(ldirname, preprocess_arch_std_files, get_maxfds(), 0);
 >
 > you could use maxfds variable in here

sure

 >>
 >> +free_standard_arch_events:
 >> +	list_for_each_entry_safe(es1, es2, &arch_std_events, list)
 >> +		free(es1);
 >
 > that could go into a function and be used also above

fine

 >>  		free(metric_name);
 >>  		free(metric_group);
 >> +
 >
 > should you call free(arch_std) in here?

Right, that's sloppy

 >>  	if (rc && verbose) {
 >>  		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
 >> -		goto empty_map;
 >> +		goto free_standard_arch_events;
 >>  	} else if (rc < 0) {
 >>  		/* Make build fail */
 >>  		return 1;
 >> -	} else if (rc) {
 >> -		goto empty_map;
 >>  	}
 >
 > please put this change into separate patch
 >
 > thanks,

Sure, I just couldn't see how a value > 0 could be returned in the 
current code paths.

> jirka
>
> .
>

Thanks,
John
