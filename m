From: ddaney.cavm@gmail.com (David Daney)
Date: Fri, 12 Feb 2016 17:47:25 -0800
Subject: [RFC PATCH 1/7] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <20160212173658.GD20262@leverpostej>
References: <cover.1455295032.git.jglauber@cavium.com>
 <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
 <20160212173658.GD20262@leverpostej>
Message-ID: <56BE8B2D.1000001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2016 09:36 AM, Mark Rutland wrote:
> On Fri, Feb 12, 2016 at 05:55:06PM +0100, Jan Glauber wrote:
[...]
>> 2) Counters are summarized across the different units of the same type,
>>     e.g. L2C TAD 0..7 is presented as a single counter (adding the
>>     values from TAD 0 to 7). Although losing the ability to read a
>>     single value the merged values are easier to use and yield
>>     enough information.
>
> I'm not sure I follow this. What is easier? What are you doing, and what
> are you comparing that with to say that your approach is easier?
>
> It sounds like it should be possible to handle multiple counters like
> this, so I don't follow why you want to amalgamate them in-kernel.
>

The values of the individual counters are close to meaningless.  The 
only thing that is meaningful to someone reading the counters is the 
aggregate sum of all the counts.


> [...]
>
>> +#include <asm/cpufeature.h>
>> +#include <asm/cputype.h>
>
> I don't see why you should need these two if this is truly an uncore
> device probed solely from PCI.
>
>> +void thunder_uncore_read(struct perf_event *event)
>> +{
>> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	u64 prev, new = 0;
>> +	s64 delta;
>> +	int i;
>> +
>> +	/*
>> +	 * since we do not enable counter overflow interrupts,
>> +	 * we do not have to worry about prev_count changing on us
>> +	 */
>
> Without overflow interrupts, how do you ensure that you account for
> overflow in a reasonable time window (i.e. before the counter runs past
> its initial value)?

Two reasons:

   1) There are no interrupts.

   2) The counters are 64-bit, they never overflow.

>
>> +
>> +	prev = local64_read(&hwc->prev_count);
>> +
>> +	/* read counter values from all units */
>> +	for (i = 0; i < uncore->nr_units; i++)
>> +		new += readq(map_offset(hwc->event_base, uncore, i));
>
> There's no bit to determine whether an overflow occurred?

No.


>
>> +
>> +	local64_set(&hwc->prev_count, new);
>> +	delta = new - prev;
>> +	local64_add(delta, &event->count);
>> +}
>> +
>> +void thunder_uncore_del(struct perf_event *event, int flags)
>> +{
>> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	int i;
>> +
>> +	event->pmu->stop(event, PERF_EF_UPDATE);
>> +
>> +	for (i = 0; i < uncore->num_counters; i++) {
>> +		if (cmpxchg(&uncore->events[i], event, NULL) == event)
>> +			break;
>> +	}
>> +	hwc->idx = -1;
>> +}
>
> Why not just place the event at uncode->events[hwc->idx] ?
>
> Theat way removing the event is trivial.
>
>> +int thunder_uncore_event_init(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct thunder_uncore *uncore;
>> +
>> +	if (event->attr.type != event->pmu->type)
>> +		return -ENOENT;
>> +
>> +	/* we do not support sampling */
>> +	if (is_sampling_event(event))
>> +		return -EINVAL;
>> +
>> +	/* counters do not have these bits */
>> +	if (event->attr.exclude_user	||
>> +	    event->attr.exclude_kernel	||
>> +	    event->attr.exclude_host	||
>> +	    event->attr.exclude_guest	||
>> +	    event->attr.exclude_hv	||
>> +	    event->attr.exclude_idle)
>> +		return -EINVAL;
>
> We should _really_ make these features opt-in at the core level. It's
> crazy that each and every PMU drivers has to explicitly test and reject
> things it doesn't support.
>
>> +
>> +	/* and we do not enable counter overflow interrupts */
>
> That statement raises far more questions than it answers.
>
> _why_ do we not user overflow interrupts?

As stated above, there are *no* overflow interrupts.

The events we are counting cannot be attributed to any one (or even any) 
CPU, they run asynchronous to the CPU, so even if there were interrupts, 
they would be meaningless.


David Daney
