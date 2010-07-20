From: janboe.ye@gmail.com (ye janboe)
Date: Tue, 20 Jul 2010 23:54:17 +0800
Subject: [PATCH] arm: show_regs dump stack when ARM_UNWIND enable
In-Reply-To: <1279640276.10002.35.camel@e102109-lin.cambridge.arm.com>
References: <20100720152431.GA17092@localhost.localdomain>
	<1279640276.10002.35.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTimbxrdFeA513Y59OX6y9lwfh3OBjqerazKcwIXx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes. both are same.

Is it ok to remove backtrace.S if ARM_UNWIND is enable?

Catalin

Is it ok to merge this patch first and then try replace __bactrace in
next patch?

Janboe

2010/7/20 Catalin Marinas <catalin.marinas@arm.com>:
> On Tue, 2010-07-20 at 23:24 +0800, janboe wrote:
>> __backtrace is empty when ARM_UNWIND enable, so instead dump_stack
>>
>> Signed-off-by: janboe <janboe.ye@gmail.com>
>> ---
>> ?arch/arm/kernel/process.c | ? ?4 ++++
>> ?1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>> index acf5e6f..e7ad878 100644
>> --- a/arch/arm/kernel/process.c
>> +++ b/arch/arm/kernel/process.c
>> @@ -271,7 +271,11 @@ void show_regs(struct pt_regs * regs)
>> ? ? ? printk("\n");
>> ? ? ? printk("Pid: %d, comm: %20s\n", task_pid_nr(current), current->comm);
>> ? ? ? __show_regs(regs);
>> +#ifdef CONFIG_ARM_UNWIND
>> + ? ? dump_stack();
>> +#else
>> ? ? ? __backtrace();
>> +#endif
>> ?}
>
> It looks like both dump_stack() and __backtrace() (with FRAME_POINTER)
> have pretty much the same semantics. Maybe we could define __backtrace()
> to just call dump_stack() when ARM_UNWIND.
>
> --
> Catalin
>
>
