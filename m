From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Tue, 28 Jun 2016 14:59:46 +0800
Subject: [PATCH V2 1/4] trace: Introduce an output interface from ftrace
 to STM
In-Reply-To: <87mvmdu5qj.fsf@ashishki-desk.ger.corp.intel.com>
References: <1466563613-31578-1-git-send-email-zhang.chunyan@linaro.org>
 <1466563613-31578-2-git-send-email-zhang.chunyan@linaro.org>
 <87mvmdu5qj.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CAG2=9p_rVX9bWUB2VuTumxkK2BxcLg3=JfWMdZzjBda6BNMqoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 1:56 PM, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> [adding Felipe for his sudden interest in the subject matter]
>
> Chunyan Zhang <zhang.chunyan@linaro.org> writes:
>
>> +static struct stm_ftrace *trace_output;
>
> What you want is a possibility to have different ftrace outputs, not
> different STM outputs for ftrace (again, STM core already does this).
> In other words, here, you want to have the notion of "output" be
> stm-agnostic, but be a generalized output driver object.

Ok, I will make it more generic, i.e. an agnostic of the exact output devices.

>
>> +
>> +void trace_func_to_stm(unsigned long ip, unsigned long parent_ip)
>> +{
>> +     unsigned long ip_array[2] = {ip, parent_ip};
>> +
>> +     if (trace_output)
>> +             trace_output->write(&trace_output->data, (char *)ip_array,
>> +                                 sizeof(unsigned long) * 2, STM_FTRACE_CHAN);
>> +}
>
> The ip+parent_ip pair is still not a useful output from ftrace
> data. Moreover, doing this is basically like inventing another binary
> protocol for ftrace data over stm, where ftrace is in and of itself
> already a binary protocol, why not just use that? The decoder will
> basically depend on the kernel binary from whence the traces are
> coming, but this is a requirement even if we want to decypher the
> ip+parent_ip data you're proposing.
>
> We would need to take some time to think this through. What we might
> consider is:
>
>  * bypassing ftrace ring buffer, sending data directly to an "output",
>    which has a drawback of ending up in a driver callback, which needs
>    to serialize on its driver stuff and write registers (I did try to
>    make stm_write as light as possible when I wrote it, though); the
>    good part is that data goes into the wire as soon as it is produced
>    instead of being buffered along the way;

I want to try this way, if I remember correctly, Steven Rostedt said
the similar solution before, use a jump label to switch which "output"
traces should be sent to.  And yes like you said, the drawback is
exporting trace data to STM by writing registers is slower than
writing ring buffer, it would slow down the process.

>  * starting a work (or multiple works) that would traverse new data in
>    ftrace buffer and feed it to an "output", such as stm; this has a
>    problem of producers being potentially faster than consumers
>    (consider 'function' tracer, for example) and hogging the cpus by
>    simply exporting trace data; this also botches the stm timestamps,

With stm timestamps on each trace data, we can sync up every events
happened on the system, not only on CPU but also on other processors,
this is useful if only the timestamps are nearly real-time, from this
view, the second way seems not so more feasible than the first one.

Please correct me if I'm missing something.

Thanks for your comments,
Chunyan

>    which will then be representative of nothing in particular.
>
>> +
>> +void trace_add_output(struct stm_ftrace *stm)
>> +{
>> +     trace_output = stm;
>> +}
>> +EXPORT_SYMBOL_GPL(trace_add_output);
>> +
>> +void trace_rm_output(void)
>> +{
>> +     trace_output = NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(trace_rm_output);
>
> These, of course, only work because they are implicitly serialized on
> stm core's link locks.
>
> Regards,
> --
> Alex
