From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Mon, 8 Aug 2016 11:49:57 -0400
Subject: [PATCH v6 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <20160808135711.GA13300@pathway.suse.cz>
References: <1468529432-28026-1-git-send-email-cmetcalf@mellanox.com>
 <1468529432-28026-2-git-send-email-cmetcalf@mellanox.com>
 <20160808135711.GA13300@pathway.suse.cz>
Message-ID: <d023a7b0-d3e0-4318-3a62-d0b2da99d2e4@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/8/2016 9:57 AM, Petr Mladek wrote:
> On Thu 2016-07-14 16:50:29, Chris Metcalf wrote:
>> Currently you can only request a backtrace of either all cpus, or
>> all cpus but yourself.  It can also be helpful to request a remote
>> backtrace of a single cpu, and since we want that, the logical
>> extension is to support a cpumask as the underlying primitive.
>>
>> This change modifies the existing lib/nmi_backtrace.c code to take
>> a cpumask as its basic primitive, and modifies the linux/nmi.h code
>> to use either the old "all/all_but_self" arch methods, or the new
>> "cpumask" method, depending on which is available.
> I triggered this function using
>    echo l >/proc/sysrq-trigger
>
>
> and got
>
> [  270.791328] -----------  All but itself: ---------------------
>
> [  270.791331] ===============================
> [  270.791331] [ INFO: suspicious RCU usage. ]
> [  270.791333] 4.8.0-rc1-4-default+ #3086 Not tainted
> [  270.791333] -------------------------------
> [  270.791335] ./include/linux/rcupdate.h:556 Illegal context switch in RCU read-side critical section!

Ah hah, you tested this with CPUMASK_OFFSTACK, which I didn't.
That explains why you got RCU kmalloc warnings.

>> +	cpumask_copy(mask, cpu_online_mask);
>> +	cpumask_clear_cpu(cpu, mask);
>> +	arch_trigger_cpumask_backtrace(mask);
>> +	put_cpu();
>> +	free_cpumask_var(mask);
>> +	return true;
> Also this looks too much code for an inlined function.
> It is rather slow and there is not a big gain. I would move
> the definition to lib/nmi_backtrace.c.

After some thought, I ended up just removing both cpumask allocation
sites.  For the allbutself() case, I just re-introduced the "include_self"
boolean that the code used to have.  If it is false when we get into the inner
nmi_trigger_cpumask_backtrace(), I just clear the cpu bit of the current
cpu.  It requires passing a funny boolean around with the mask, but the
alternative (if we don't want to allocate a mask on this path) is to
break apart the nmi_trigger_cpumask_backtrace() function so we can
piggy-back on its locking and its cpumask and set up the cpumask the
way we want, which I think is too much added ugliness.

For the trigger_single_cpu_backtrace() case, I remembered that there was
a cpumask_of() function that we can use that is fast and doesn't allocate,
even with CPUMASK_OFFSTACK, so I just used that instead.

> PS: I am sorry for sending this so late in the game. I was
> curious why the patch had not been upstream yet and. I made
> a closer look to give a Reviewed-by tag...

No worries - even a late review is much better than none!  I'll
send v7 shortly and please do let me know if it works for you.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
