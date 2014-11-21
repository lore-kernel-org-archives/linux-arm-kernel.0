From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 21 Nov 2014 11:45:51 +0000
Subject: [RFC PATCH] arm: imx: Workaround i.MX6 PMU interrupts muxed to
 one SPI
In-Reply-To: <alpine.DEB.2.11.1411211138050.6439@nanos>
References: <1416483757-24165-1-git-send-email-daniel.thompson@linaro.org>
 <alpine.DEB.2.11.1411210016360.6439@nanos> <546F0ACA.7010007@linaro.org>
 <alpine.DEB.2.11.1411211138050.6439@nanos>
Message-ID: <546F25EF.5080309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/14 10:41, Thomas Gleixner wrote:
> On Fri, 21 Nov 2014, Daniel Thompson wrote:
>> On 20/11/14 23:30, Thomas Gleixner wrote:
>>> On Thu, 20 Nov 2014, Daniel Thompson wrote:
>>>> +/*
>>>> + * The PMU IRQ lines of all cores are muxed onto a single interrupt.
>>>> + * Rotate the interrupt around the cores if the current CPU cannot
>>>> + * figure out why the interrupt has been triggered.
>>>> + */
>>>> +static irqreturn_t imx6q_pmu_handler(int irq, void *dev, irq_handler_t handler)
>>>> +{
>>>> +	irqreturn_t ret = handler(irq, dev);
>>>> +	int next;
>>>> +
>>>> +	if (ret == IRQ_NONE && num_online_cpus() > 1) {
>>>
>>> What guarantees that ret == IRQ_HANDLED is a sign for 'this is only
>>> for this particular core' interrupt ?
>>
>> It isn't guaranteed. We rely on re-entering the interrupt handler if
>> more than one PMU is raising the interrupt simultaneously.
>>
>>>
>>>> +		next = cpumask_next(smp_processor_id(), cpu_online_mask);
>>>> +		if (next > nr_cpu_ids)
>>>> +			next = cpumask_next(-1, cpu_online_mask);
>>>> +		irq_set_affinity(irq, cpumask_of(next));
>>>> +	}
>>>
>>> Aside of the fact, that the hardware designers who came up with such a
>>> brainfart should be put on sane drugs, this is just silly.
>>>
>>> Rotating that thing around will introduce arbitrary latencies and
>>> dependencies on other interrupts to be handled.
>>
>> To be honest I viewed the only real merits of the rotation workaround to
>> be that it is simple and minimally invasive. I am in total agreement
>> that there are profiling use cases that it will handle badly (although
>> there are a useful set which this workaround is sufficient to support).
>>
>>> So if there is really no way to figure out which of the cores is the
>>> actual target of the PMU interrupt
>>
>> PMU is only accessible via the bus if you are a external debugger
>> (signals external to the cluster control the register windowing). From
>> the kernel we have to use the co-processor interface and can only see
>> our own PMU.
>>
>>> then you should simply broadcast
>>> that interrupt to a designated per cpu vector async from the one which
>>> handles it in the first place and be done with it. That's the only
>>> sane option you have.
>>
>> As it happens I was planning to do some work on rebroadcasting next
>> anyway regardless of this discussion because I can't call
>> irq_set_affinity() from a FIQ handler...
>>
>> Options I considered to rebroadcast are either direct use of an (new and
>> ARM specific?) IPI or use of smp_call_function() from a tasklet. I was
> 
>> inclined to rule out the tasklet because it has the potential for far
>> greater timing jitter than rotating the affinity (doesn't it?).
> 
> You cannot schedule a tasklet from FIQ.

Indeed, that was another black mark against it. However I would prefer
to be able to convince people to rule out for performance reasons.
My FIQ work for perf isn't mainlined at this point so using FIQ to show
why I prefer one solution (for mainline) over another isn't entirely
reasonable.

> The only options you have are:
> 
>     - Async IPI (direct call into the architecture code). I have no
>       idea whether thats possible on ARM

I think this may be where I have to go eventually (sigh). If I can get
to the stage where we can deliver PMU events via FIQ then ideally the
workaround would also have to broadcast via FIQ.

Its a real shame that one of the best chips to do FIQ work suffers has
such an annoying hardware bug.

>     - irq_work

I'm currently trying this approach. It makes sense today without FIQ
and, fortunately for me, the workaround should mostly still work if it
were deployed from a FIQ handler.

BTW thanks very much for the listing options here; I was a little
worried I might have overlooked some really obvious way to deploy the
workaround.


Daniel.
