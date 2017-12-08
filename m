From: john.garry@huawei.com (John Garry)
Date: Fri, 8 Dec 2017 15:38:06 +0000
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <20171208123137.GF2799@krava>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171206133752.GB12508@krava>
 <f58001e9-86fa-c6e6-b9c7-fb748d340da1@huawei.com>
 <20171208123137.GF2799@krava>
Message-ID: <df2f2547-85b3-b522-4021-a2aa84333559@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2017 12:31, Jiri Olsa wrote:
> On Wed, Dec 06, 2017 at 02:40:10PM +0000, John Garry wrote:
>> On 06/12/2017 13:37, Jiri Olsa wrote:
>>> On Wed, Dec 06, 2017 at 12:13:16AM +0800, John Garry wrote:
>>>
>>> SNIP
>>>
>>>> ---
>>>>  tools/perf/pmu-events/jevents.c | 215 ++++++++++++++++++++++++++++++++++++----
>>>>  1 file changed, 198 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>>>> index a0d489e..a820ed4 100644
>>>> --- a/tools/perf/pmu-events/jevents.c
>>>> +++ b/tools/perf/pmu-events/jevents.c
>>>> @@ -42,6 +42,7 @@
>>>>  #include <dirent.h>
>>>>  #include <sys/time.h>			/* getrlimit */
>>>>  #include <sys/resource.h>		/* getrlimit */
>>>> +#include <sys/queue.h>
>>>>  #include <ftw.h>
>>>>  #include <sys/stat.h>
>>>>  #include "jsmn.h"
>>>> @@ -366,6 +367,94 @@ static int print_events_table_entry(void *data, char *name, char *event,
>>>>  	return 0;
>>>>  }
>>>>
>>>> +struct event_struct {
>>>> +	char *name;
>>>> +	char *event;
>>>> +	char *desc;
>>>> +	char *long_desc;
>>>> +	char *pmu;
>>>> +	char *unit;
>>>> +	char *perpkg;
>>>> +	char *metric_expr;
>>>> +	char *metric_name;
>>>> +	char *metric_group;
>>>> +	LIST_ENTRY(event_struct) list;
>>>
>>> is there any reason you don't use the 'struct list_head' ?
>>> I dont think we want another thingie involved for lists
>>
>> Hi jirka,
>>

Hi jirka,

>> The linux kernel headers are not used for jevents tool. I would rather use
>> them if possible...
>
> should be as easy as adding  #include <linux/list.h> ;-)
>

Hi jirka,

I think the issue is that jevents is a "hostprogs", which does not use 
kernel headers.

FWIW, here is the symptom:
pmu-events/jevents.c:51:24: fatal error: linux/list.h: No such file or 
directory
  #include <linux/list.h>
                         ^
compilation terminated.
mv: cannot stat ?pmu-events/.jevents.o.tmp?: No such file or directory

perf tool build is different.

Much appreciated,
John


> it's heavily used within perf and I'm pretty sure we want
> to keep around just one way of doing lists
>
> thanks,
> jirka
>
> .
>
