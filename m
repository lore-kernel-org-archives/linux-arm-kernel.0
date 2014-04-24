From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 24 Apr 2014 10:33:38 -0400
Subject: [PATCH v6 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <CAJ5Y-eZMKZYOaQnFPu31Vzg6KXDy7J5gFKh3hAy+GuLz66Wgwg@mail.gmail.com>
References: <1397762146-8337-1-git-send-email-ashwin.chaugule@linaro.org>
 <1397762146-8337-4-git-send-email-ashwin.chaugule@linaro.org>
 <20140417195009.GC24195@e106331-lin.cambridge.arm.com>
 <CAJ5Y-eZMKZYOaQnFPu31Vzg6KXDy7J5gFKh3hAy+GuLz66Wgwg@mail.gmail.com>
Message-ID: <CAJ5Y-ebZ9M9GM5R40-Yrbx=iNhB4_j-vw=8mBA=1cwZGnhixLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2014 11:21, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> Hi Mark,
>
>
> On 17 April 2014 15:50, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Thu, Apr 17, 2014 at 08:15:46PM +0100, Ashwin Chaugule wrote:
>>> PSCIv0.2 adds a new function called AFFINITY_INFO, which
>>> can be used to query if a specified CPU has actually gone
>>> offline. Calling this function via cpu_kill ensures that
>>> a CPU has quiesced after a call to cpu_die.
>>>
>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  arch/arm/kernel/psci_smp.c | 21 +++++++++++++++++++++
>>>  include/uapi/linux/psci.h  |  5 +++++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
>>> index 570a48c..c6f1420 100644
>>> --- a/arch/arm/kernel/psci_smp.c
>>> +++ b/arch/arm/kernel/psci_smp.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/init.h>
>>>  #include <linux/smp.h>
>>>  #include <linux/of.h>
>>> +#include <uapi/linux/psci.h>
>>>
>>>  #include <asm/psci.h>
>>>  #include <asm/smp_plat.h>
>>> @@ -66,6 +67,25 @@ void __ref psci_cpu_die(unsigned int cpu)
>>>         /* We should never return */
>>>         panic("psci: cpu %d failed to shutdown\n", cpu);
>>>  }
>>> +
>>> +int __ref psci_cpu_kill(unsigned int cpu)
>>> +{
>>> +     int err;
>>> +
>>> +     if (!psci_ops.affinity_info)
>>> +             return 1;
>>> +
>>> +     err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>>> +
>>> +     if (err != PSCI_AFFINITY_INFO_RET_OFF) {
>>> +             pr_err("psci: Cannot kill CPU:%d, psci ret val: %d\n",
>>> +                             cpu, err);
>>> +             /* Make platform_cpu_kill() fail. */
>>> +             return 0;
>>> +     }
>>
>> We can race with the dying CPU here -- if we call AFFINITY_INFO before
>> the dying cpu is sufficiently far through its CPU_OFF call it won't
>> register as OFF.
>>
>> Could we poll here instead (with a reasonable limit on the number of
>> iterations)? That would enable us to not spuriously declare a CPU to be
>> dead when it happened to take slightly longer than we expect to turn
>> off.
>
> True. How about something like this?
>
>  int __ref psci_cpu_kill(unsigned int cpu)
>  {
> -       int err;
> +       int err, retries;
>
>         if (!psci_ops.affinity_info)
>                 return 1;
> -
> +       /*
> +        * cpu_kill could race with cpu_die and we can
> +        * potentially end up declaring this cpu undead
> +        * while it is dying. So retry a couple of times.
> +        */
> +retry:
>         err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>
>         if (err != PSCI_AFFINITY_INFO_RET_OFF) {
> +               if (++retries < 3) {
> +                       pr_info("Retrying check for CPU kill: %d\n", retries);
> +                       goto retry;
> +               }
>                 pr_err("psci: Cannot kill CPU:%d, psci ret val: %d\n",
>                                 cpu, err);
>                 /* Make platform_cpu_kill() fail. */
>
>
>


Hi Rob, I've already got your Reviewed-by on this patch without this
"retry" thing. Are you okay with this as well? I can then roll it up
in one patch.

Cheers,
Ashwin
