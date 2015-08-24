From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 24 Aug 2015 20:14:03 +0800
Subject: [PATCH v3 15/31] arm64: SMP support
In-Reply-To: <55D7559E.8080609@codeaurora.org>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-16-git-send-email-catalin.marinas@arm.com>
 <CAOZdJXVoDJM3y2mnKO+91yf2EHogKfMjumjhhi85REAfhcJM=Q@mail.gmail.com>
 <20150806095621.GB17691@e104818-lin.cambridge.arm.com>
 <55C8843D.8050600@linaro.org> <55C8D9DB.5080207@codeaurora.org>
 <55D7559E.8080609@codeaurora.org>
Message-ID: <55DB0A8B.3090700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

On 08/22/2015 12:45 AM, Timur Tabi wrote:
> On 08/10/2015 12:05 PM, Timur Tabi wrote:
>>>>
>>>> This code was inherited from arch/arm which initially was always
>>>> dumping
>>>> the stack but it later gained the system_state check. Unless it's
>>>> useful
>>>> to anyone for debugging purposes, I'm ok with removing it.
>>>
>>> Do you have patch for this one? My colleagues said that they met the
>>> same problem :)
>>
>> Dropping the call to dump_stack() would probably be sufficient.
>
> Actually, I think we need to keep it.  I just heard from another
> developer who does actually use it for debugging.

Hmm, could you please give a example for how it used?

>
> I think the real problem is that emergency_restart() should not be
> causing these outputs.  Shouldn't machine_restart() change the
> system_state to SYSTEM_RESTART before it calls smp_send_stop()?

The system_state is set to SYSTEM_RESTART in kernel_restart_prepare(),
and kernel_restart() will call kernel_restart_prepare() and
machine_restart(), so if we change the system_state to SYSTEM_RESTART
in machine_restart(), it seems duplicate.

Could we just wait longer than one second in the following function?

void smp_send_stop(void)
{
         unsigned long timeout;

         if (num_online_cpus() > 1) {
                 cpumask_t mask;

                 cpumask_copy(&mask, cpu_online_mask);
                 cpumask_clear_cpu(smp_processor_id(), &mask);

                 smp_cross_call(&mask, IPI_CPU_STOP);
         }

         /* Wait up to one second for other CPUs to stop */
         timeout = USEC_PER_SEC;
         while (num_online_cpus() > 1 && timeout--)
                 udelay(1);

If we have lots of CPUs, one second seems not enough as it
print lots dump message.

Thanks
Hanjun
