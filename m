From: bryan.wu@canonical.com (Bryan Wu)
Date: Fri, 13 Apr 2012 19:29:36 +0800
Subject: [PATCH 01/18] led-triggers: create a trigger for CPU activity
In-Reply-To: <20120406151505.4eeb01ba.akpm@linux-foundation.org>
References: <1333108713-12707-1-git-send-email-bryan.wu@canonical.com>
 <1333108713-12707-2-git-send-email-bryan.wu@canonical.com>
 <20120406151505.4eeb01ba.akpm@linux-foundation.org>
Message-ID: <CAK5ve-LiRKnph8cvUD5+D39UTd=yKCAiYUwshariJ2Naa2EF4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 7, 2012 at 6:15 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri, 30 Mar 2012 19:58:16 +0800
> Bryan Wu <bryan.wu@canonical.com> wrote:
>
>> Attempting to consolidate the ARM LED code, this removes the
>> custom RealView LED trigger code to turn LEDs on and off in
>> response to CPU activity and replace it with a standard trigger.
>>
>> (bryan.wu at canonical.com:
>> It moves arch/arm/kernel/leds.c syscore stubs into this trigger.
>> It also provides ledtrig_cpu trigger event stub in <linux/leds.h>.
>> Although it was inspired by ARM work, it can be used in other arch.)
>>
>>
>> ...
>>
>> +#include <linux/percpu.h>
>> +#include <linux/syscore_ops.h>
>> +#include "leds.h"
>> +
>> +#define MAX_NAME_LEN 8
>
> The kernel already has at least eight different definitions of
> MAX_NAME_LEN. ?I guess a ninth won't hurt ;)
>
>>
>> ...
>>
>> +static void __init ledtrig_cpu_register(void)
>> +{
>> + ? ? int cpuid = smp_processor_id();
>> + ? ? struct led_trigger *trig;
>> + ? ? char *name = __get_cpu_var(trig_name);
>> +
>> + ? ? snprintf(name, MAX_NAME_LEN, "cpu%d", cpuid);
>> + ? ? led_trigger_register_simple(name, &trig);
>> +
>> + ? ? pr_info("LED trigger %s indicate activity on CPU %d\n",
>> + ? ? ? ? ? ? trig->name, cpuid);
>> +
>> + ? ? __get_cpu_var(cpu_trig) = trig;
>> +}
>> +
>> +static void __exit ledtrig_cpu_unregister(void)
>> +{
>> + ? ? struct led_trigger *trig = __get_cpu_var(cpu_trig);
>> + ? ? char *name = __get_cpu_var(trig_name);
>> +
>> + ? ? led_trigger_unregister_simple(trig);
>> + ? ? __get_cpu_var(cpu_trig) = NULL;
>> + ? ? memset(name, 0, MAX_NAME_LEN);
>> +}
>> +
>> +static int __init ledtrig_cpu_init(void)
>> +{
>> + ? ? int cpu;
>> +
>> + ? ? for_each_possible_cpu(cpu)
>> + ? ? ? ? ? ? ledtrig_cpu_register();
>> +
>> + ? ? register_syscore_ops(&ledtrig_cpu_syscore_ops);
>> +
>> + ? ? return 0;
>> +}
>> +module_init(ledtrig_cpu_init);
>
> This all looks horridly broken. ?We call ledtrig_cpu_register() once
> for each CPU, but we call it on the same CPU each time, and it uses
> smp_processor_id() which a) is wrong and b) will emit a runtime
> preemption-is-enabled warning.
>

Indeed, my bad. I've already rewritten this function by using per_cpu() API.

> I'm assuming this wasn't tested on SMP. ?It needs to be, please.
>

Yeah, tested on my OMAP4 dual core SMP panda board.

> Also, the code uses for_each_possible_cpu, ignoring CPU hotplug.
> That's probably justifiable for this small storage size and not-hotpath
> code, but the decision should be given prominence and justified in the
> changelog or, better, in code comments please.
>

I tested with CPU hotplug after this initial function on Panda and
added comments.

>>
>> ...
>>
>
> The patchset is basically an ARM thing. ?Is there some ARM tree via
> which we can get it merged?

I put these patches in my git tree, but might need Russell or Arnd to
help review and merge.

And I just resent the patchset.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.186-168-78255 Mobile
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
