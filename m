From: bryan.wu@canonical.com (Bryan Wu)
Date: Fri, 20 Apr 2012 15:26:13 +0800
Subject: [PATCH 01/18] led-triggers: create a trigger for CPU activity
In-Reply-To: <4F910941.4000702@codeaurora.org>
References: <1334660025-20442-1-git-send-email-bryan.wu@canonical.com>
 <1334660025-20442-2-git-send-email-bryan.wu@canonical.com>
 <4F910941.4000702@codeaurora.org>
Message-ID: <CAK5ve-JFPEqkECrEu28XHuegnEZ9Ao0vhGqxYpz0_2YJkAmuiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 2:59 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 4/17/2012 3:53 AM, Bryan Wu wrote:
>> +static int __init ledtrig_cpu_init(void)
>> +{
>> + ? ? int cpu;
>> +
>> + ? ? /* Supports up to 9999 cpu cores */
>> + ? ? BUILD_BUG_ON(CONFIG_NR_CPUS > 9999);
>> +
>> + ? ? /*
>> + ? ? ?* Registering CPU led trigger for each CPU cores here
>> + ? ? ?* ignores CPU hotplug, but after this CPU hotplug works
>> + ? ? ?* fine with this trigger.
>> + ? ? ?*/
>> + ? ? for_each_possible_cpu(cpu) {
>> + ? ? ? ? ? ? struct led_trigger *trig;
>> + ? ? ? ? ? ? char *name = per_cpu(trig_name, cpu);
>> + ? ? ? ? ? ? struct rw_semaphore *lock = &per_cpu(trig_lock, cpu);
>> +
>> + ? ? ? ? ? ? init_rwsem(lock);
>
> What is this lock protecting?
>
>> +
>> + ? ? ? ? ? ? snprintf(name, MAX_NAME_LEN, "cpu%d", cpu);
>> +
>> + ? ? ? ? ? ? down_write(lock);
>> + ? ? ? ? ? ? led_trigger_register_simple(name, &trig);
>> + ? ? ? ? ? ? per_cpu(cpu_trig, cpu) = trig;
>> + ? ? ? ? ? ? up_write(lock);
>
> This is the only place it is locked and unlocked.
>
> I think the previous comment was about how led_trigger_register_simple()
> exposed a live trigger but it wasn't assigned to the per_cpu variable
> yet. Can we not just reorder the assignment so we have
>
> ?struct led_trigger *trig = NULL;
> ?...
> ?per_cpu(cpu_trig, cpu) = trig;
> ?led_trigger_register_simple();
>

I thinked about reordering like you posted here before, but
led_trigger_register_simple(const char *name, struct led_trigger **tp)
will modify the value of pointer trig here, because it use **tp to do
that.

So a lock here just protects the critical region, looks like safer to
kill race condition pointed out by Tim.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.186-168-78255 Mobile
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
