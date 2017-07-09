From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sun, 9 Jul 2017 16:16:00 +0800
Subject: [PATCH] arm64: arch_timer: fix the infinite recursion when enable
 ftrace and erratum workaround
In-Reply-To: <20170706143552.GB31734@leverpostej>
References: <43ec809d-b8f2-eb73-8ad6-9966cf67625f@huawei.com>
 <20170706143552.GB31734@leverpostej>
Message-ID: <28e3901c-3f5f-b27e-1f94-960dff2af0bc@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/7/6 22:35, Mark Rutland wrote:
> On Thu, Jul 06, 2017 at 08:49:33PM +0800, Ding Tianhong wrote:
>> When enable preempt and ftrace, and perform the following steps, the system will hang:
>> mount -t debugfs nodev /sys/kernel/debug/
>> cd /sys/kernel/debug/tracing/
>> echo function_graph > current_tracer
>>
>> This is because the preempt_disable and preempt_enable calls would cause infinite
>> recursion for some chips which needs the timer erratum workaround and the system
>> will hang, so use the preempt_disable/enable_notrace calls to prevent recursion.
> 
> Nit: Please wrap commit messages at 72 characters, unless you have
> something that wrapping would destroy.
> 
OK

> That aside, this looks sane, but a better expanation would be
> worthwhile. What exactly causes the recursion? Does ftrace instrument
> preempt_{disable,enable} ?
> 
> Can you give an example of the recursion?
> 

As the 96b3d28bf4(sched/clock: Prevent tracing recursion in sched_clock_cpu()) said, the
preempt_disable/enable() are traced and this cause trace_clock() users to get the local timer
again, it will cause the infinite recursion.

> Thanks,
> Mark.
> 
>>
>> Fixes: 6acc71ccac71 ("arm64: arch_timer: Allows a CPU-specific erratum to only affect a subset of CPUs")
>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>> ---
>>  arch/arm64/include/asm/arch_timer.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>> index 74d08e4..67bb7a4 100644
>> --- a/arch/arm64/include/asm/arch_timer.h
>> +++ b/arch/arm64/include/asm/arch_timer.h
>> @@ -65,13 +65,13 @@ struct arch_timer_erratum_workaround {
>>  	u64 _val;							\
>>  	if (needs_unstable_timer_counter_workaround()) {		\
>>  		const struct arch_timer_erratum_workaround *wa;		\
>> -		preempt_disable();					\
>> +		preempt_disable_notrace();				\
>>  		wa = __this_cpu_read(timer_unstable_counter_workaround); \
>>  		if (wa && wa->read_##reg)				\
>>  			_val = wa->read_##reg();			\
>>  		else							\
>>  			_val = read_sysreg(reg);			\
>> -		preempt_enable();					\
>> +		preempt_enable_notrace();				\
>>  	} else {							\
>>  		_val = read_sysreg(reg);				\
>>  	}								\
>> -- 
>> 1.9.0
>>
>>
> 
> .
> 
