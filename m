From: pjohn@mvista.com (Philby John)
Date: Sat, 17 Apr 2010 15:57:40 +0530
Subject: [PATCH v2] ARM: Fix "BUG: scheduling while atomic:
	swapper/0/0x00000002
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C4F1657E@dbde02.ent.ti.com>
References: <1271492144-26995-1-git-send-email-santosh.shilimkar@ti.com>
	<4BC984BC.2060800@mvista.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4F1657E@dbde02.ent.ti.com>
Message-ID: <4BC98D1C.2010702@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2010 03:29 PM, Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: Philby John [mailto:pjohn at mvista.com]
>> Sent: Saturday, April 17, 2010 3:22 PM
>> To: Shilimkar, Santosh
>> Cc: linux-arm-kernel at lists.infradead.org; Russell King; Sundar R IYER; Catalin Marinas
>> Subject: Re: [PATCH v2] ARM: Fix "BUG: scheduling while atomic: swapper/0/0x00000002
>>
>> Hello Santosh,
>>
>> On 04/17/2010 01:45 PM, Santosh Shilimkar wrote:
>>> This patch fixes the preempt leak in the cpuidle path invoked from
>>> cpu-hotplug. The fix is suggested by Russell King and is based
>>> on x86 idea of calling init_idle() on the idle task when it's
>>> re-used which also resets the preempt count amongst other things
>>>
>>> dump:
>>> BUG: scheduling while atomic: swapper/0/0x00000002
>>> Modules linked in:
>>> Backtrace:
>>> [<c0024f90>] (dump_backtrace+0x0/0x110) from [<c0173bc4>] (dump_stack+0x18/0x1c)
>>>    r7:c02149e4 r6:c033df00 r5:c7836000 r4:00000000
>>> [<c0173bac>] (dump_stack+0x0/0x1c) from [<c003b4f0>] (__schedule_bug+0x60/0x70)
>>> [<c003b490>] (__schedule_bug+0x0/0x70) from [<c0174214>] (schedule+0x98/0x7b8)
>>>    r5:c7836000 r4:c7836000
>>> [<c017417c>] (schedule+0x0/0x7b8) from [<c00228c4>] (cpu_idle+0xb4/0xd4)
>>> # [<c0022810>] (cpu_idle+0x0/0xd4) from [<c0171dd8>] (secondary_start_kernel+0xe0/0xf0)
>>>    r5:c7836000 r4:c0205f40
>>> [<c0171cf8>] (secondary_start_kernel+0x0/0xf0) from [<c002d57c>] (prm_rmw_mod_reg_bits+0x88/0xa4)
>>>    r7:c02149e4 r6:00000001 r5:00000001 r4:c7836000
>>> Backtrace aborted due to bad frame pointer<c7837fbc>
>>>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Russell King<rmk+kernel@arm.linux.org.uk>
>>> Cc: Catalin Marinas<catalin.marinas@arm.com>
>>> Cc: Sundar R IYER<sundar.iyer@stericsson.com>
>>> ---
>>>    arch/arm/kernel/smp.c |    8 +++++++-
>>>    1 files changed, 7 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
>>> index 57162af..3e14629 100644
>>> --- a/arch/arm/kernel/smp.c
>>> +++ b/arch/arm/kernel/smp.c
>>> @@ -86,8 +86,14 @@ int __cpuinit __cpu_up(unsigned int cpu)
>>>    			return PTR_ERR(idle);
>>>    		}
>>>    		ci->idle = idle;
>>> +	} else {
>>> +		/*
>>> +		 * Since idle thread getting re-used, call
>>> +		 * init_idle() to set up the idle thread for given
>>> +		 * CPU. Additionally it also resets the preempt count
>>> +		 */
>>> +		init_idle(idle, cpu);
>>
>> Since Sundar was the first to suggest this fix, shouldn't his SOB be
>> included as well instead of CC ? Or did I miss a mail thread ?
> Probably you missed the initial thread. Russell suggested this some time
> back and top of my alternate patch and not Sundar.

Ah! ok. Sorry for the fuss.

Regards,
Philby
