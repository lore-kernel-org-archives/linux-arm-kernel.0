From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 1 Dec 2015 10:25:31 -0700
Subject: [PATCH V5 21/26] coresight: etm-perf: new PMU driver for ETM
 tracers
In-Reply-To: <87poyrysve.fsf@ashishki-desk.ger.corp.intel.com>
References: <1448849687-5724-1-git-send-email-mathieu.poirier@linaro.org>
 <1448849687-5724-22-git-send-email-mathieu.poirier@linaro.org>
 <87poyrysve.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkwEJsm-MXVPPvMd=ZJ6UR656v8duLS_ei+cWB_oHLwc9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 November 2015 at 16:23, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> +static void etm_event_destroy(struct perf_event *event) {}
>> +
>> +static int etm_event_init(struct perf_event *event)
>> +{
>> +     if (event->attr.type != etm_pmu.type)
>> +             return -ENOENT;
>> +
>> +     if (event->cpu >= nr_cpu_ids)
>> +             return -EINVAL;
>> +
>> +     event->destroy = etm_event_destroy;
>
> You don't have to do this if it's a nop, event::destroy can be NULL.

ACK

>
>> +
>> +     return 0;
>> +}
>
>
>> +static void *alloc_event_data(int cpu)
>> +{
>> +     int lcpu, size;
>> +     cpumask_t *mask;
>> +     struct etm_cpu_data *cpu_data;
>> +     struct etm_event_data *event_data;
>> +
>> +     /* First get memory for the session's data */
>> +     event_data = kzalloc(sizeof(struct etm_event_data), GFP_KERNEL);
>> +      if (!event_data)
>
> Looks like a whitespace mixup.

ACK

>
>> +             return NULL;
>> +
>> +     /* Make sure nothing disappears under us */
>> +     get_online_cpus();
>> +     size = num_online_cpus();
>> +
>> +     mask = &event_data->mask;
>> +     if (cpu != -1)
>> +             cpumask_set_cpu(cpu, mask);
>> +     else
>> +             cpumask_copy(mask, cpu_online_mask);
>
> It would be nice to have a comment somewhere here explaining that you
> have to set up tracer on each cpu in case of per-thread counter and
> why. We must have discussed this, but I forgot already.

That's a very good idea and I'm not entirely sure I've explained it
plainly before either.  Coresight has several types of tracers and
each have their little differences with configuration registers
changing often from one version to another.  It is also possible to
have different types of tracers on one SoC (ex. big.LITTLE platforms).
As such the global configuration from Perf can be interpreted
differently depending on the implemented tracer version.  Sorting out
tracer configuration on each CPU before a run is started is much more
efficient than parsing the Perf configuration each time an event is
scheduled on a CPU.

Last but not least Coresight tracers have many configuration options
that I haven't exposed to Perf yet.  One such option is address range
filtering.  Processing those each time an event is about to be
scheduled would be highly inefficient.

>
> Btw, do you want to also set 'size' to 1 for cpu != -1 case?

I thought long and hard about that one.  Per CPU tracing is really a
corner case of the general scenario where all CPUs are part of an
event.  The 'size' variable is to allocate an array of 'struct
etm_cpu_data' pointers, where the index of the array is the CPU the
data pertains to.  Whether one or all CPUs are involved in a trace
session, I decided to allocate that array the same way in order to 1)
make access to CPU data generic and 2) make trace configuration
retrieval for a CPU very fast by using that CPU number as an index.

We could have an an array with only the CPUs that were configured but
that would also mean that we'd loose the quick access CPU indexing
provides.  In my opinion that was much worse than the extra memory
needed for corner cases.

>
>> +     put_online_cpus();
>> +
>> +     /* Allocate an array of cpu_data to work with */
>> +     event_data->cpu_data = kcalloc(size,
>> +                                    sizeof(struct etm_cpu_data *),
>> +                                    GFP_KERNEL);
>> +     if (!event_data->cpu_data)
>> +             goto free_event_data;
>> +
>> +     /* Allocate a cpu_data for each CPU this event is dealing with */
>> +     for_each_cpu(lcpu, mask) {
>> +             cpu_data = kzalloc(sizeof(struct etm_cpu_data), GFP_KERNEL);
>> +             if (!cpu_data)
>> +                     goto free_event_data;
>> +
>> +             event_data->cpu_data[lcpu] = cpu_data;
>> +     }
>
> Wouldn't it be easier to allocate the whole thing with one
>
> event_data->cpu_data = kcalloc(size, sizeof(struct etm_cpu_data), GFP_KERNEL);
>
> ?

Right, that would work if 'cpu_data[]' wasn't used as an index table.
As I said above, I thought it was better to loose a few bytes of
memory to quicken access to trace configuration when events are
scheduled in.

Special thanks for taking the time to review this.
Mathieu

>
> Regards,
> --
> Alex
