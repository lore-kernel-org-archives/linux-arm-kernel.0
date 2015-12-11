From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 11 Dec 2015 14:18:09 -0700
Subject: [PATCH V6 21/26] coresight: etm-perf: new PMU driver for ETM
 tracers
In-Reply-To: <87zixhau95.fsf@ashishki-desk.ger.corp.intel.com>
References: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
 <1449176702-13213-22-git-send-email-mathieu.poirier@linaro.org>
 <87zixhau95.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkxZfMCUHizYPvWB0gd-X68kQoveCuiXDmd=vAmydtaqMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 December 2015 at 08:18, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> +static void etm_event_start(struct perf_event *event, int flags)
>> +{
>> +     int cpu = smp_processor_id();
>> +     struct etm_cpu_data *cpu_data;
>> +     struct etm_event_data *event_data;
>> +     struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
>> +     struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
>> +
>> +     if (!csdev)
>> +             goto fail;
>> +
>> +     /*
>> +      * Deal with the ring buffer API and get a handle on the
>> +      * session's information.
>> +      */
>> +     event_data = perf_aux_output_begin(handle, event);
>> +     if (WARN_ON_ONCE(!event_data))
>> +             goto fail;
>
> Hmm, perf_aux_output_begin() returning NULL is not WARN-worthy and is
> actually a normal situation, for example, if the buffer is not
> configured yet (which like I suggested in the other email should be a
> separate thing from the *event* configuration).
>
> perf_aux_output_begin() will also return NULL if there's no room in the
> buffer.

You are correct - I'll revise this.

>
> Regards,
> --
> Alex
