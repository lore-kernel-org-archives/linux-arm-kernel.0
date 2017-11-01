From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 1 Nov 2017 16:58:20 +0000
Subject: [PATCH 2/2] perf: Fix ftrace builtin when kernel doesn't have
 function_graph
In-Reply-To: <20171101124433.1a6ed9c6@gandalf.local.home>
References: <1509546824-46165-1-git-send-email-julien.thierry@arm.com>
 <1509546824-46165-3-git-send-email-julien.thierry@arm.com>
 <20171101124433.1a6ed9c6@gandalf.local.home>
Message-ID: <047da0c7-6552-e6bb-d044-7cb5e05c431d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/11/17 16:44, Steven Rostedt wrote:
> On Wed,  1 Nov 2017 14:33:44 +0000
> Julien Thierry <julien.thierry@arm.com> wrote:
> 
>> When linux is built without support for function graph tracer, the ftrace
>> builtin of perf will fail when trying to reset max_graph_depth because the
>> file does not exist. This prevents the use of function tracer from perf.
>>
>> Do not attempt to write this file when the tracer in use is not
>> function_graph.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: linux-kernel at vger.kernel.org
>> ---
>>   tools/perf/builtin-ftrace.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
>> index 25a42ac..48120f2 100644
>> --- a/tools/perf/builtin-ftrace.c
>> +++ b/tools/perf/builtin-ftrace.c
>> @@ -130,7 +130,8 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
>>   	if (reset_tracing_cpu() < 0)
>>   		return -1;
>>
>> -	if (write_tracing_file("max_graph_depth", "0") < 0)
>> +	if (!strcmp(ftrace->tracer, "function_graph") &&
>> +	    write_tracing_file("max_graph_depth", "0") < 0)
> 
> Hmm, instead of doing this, could we just do a stat on the file first.
> As with trace-cmd, I like to reset files like this even when not
> enabling function_graph tracer.
> 

Sounds reasonable.

I'll include that change in the next version of the patches.

Thanks,

-- 
Julien Thierry
