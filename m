From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu, 18 Feb 2016 14:46:30 +0300
Subject: KASAN issues with idle / hotplug area
In-Reply-To: <20160218111516.GM32647@leverpostej>
References: <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com> <20160217143950.GC32647@leverpostej>
 <20160217170110.GE32647@leverpostej> <20160217175656.GJ32647@leverpostej>
 <20160217191643.GK32647@leverpostej> <56C57F40.3050500@virtuozzo.com>
 <20160218111516.GM32647@leverpostej>
Message-ID: <56C5AF16.7020904@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/18/2016 02:15 PM, Mark Rutland wrote:
> On Thu, Feb 18, 2016 at 11:22:24AM +0300, Andrey Ryabinin wrote:
>>
>> On 02/17/2016 10:16 PM, Mark Rutland wrote:
>>> Looking at the assembly, functions seem to get instrumented regardless
>>> of the __no_sanitize_address annotation. The assembly of
>>> __invoke_psci_fn_{smc,hvc} look identical, even if one has the
>>> annotation and one does not.
>>>
>>> In the case below, it looks like __invoke_psci_fn_hvc is storing to the
>>> shadow area even though it's anotated with __no_sanitize_address.  Note
>>> that the adrp symbol resolution is bogus; psci_to_linux_errno happens to
>>> be at offset 0 in the as-yet unlinked psci.o object.
>>>
>>
>> ...
>>> I also tried using __attribute__((no_sanitize_address)) directly, in
>>> case there was some header issue, but that doesn't seem to be the case.
>>>
>>> I'm using the Linaro 15.08 AArch64 GCC 5.1. Is anyone else able to
>>> confirm whether they see the same? Does the same happen for x86?
>>
>> Confirming, this happens on every GCC I have (including x86).
>> It seems that 'no_sanitize_address' in gcc removes only memory access checks
>> but it doesn't remove stack redzones.
>> I think this is wrong, e.g. clang removes instrumentation completely. I'll submit a bug.
> 
> Ok.
> 
> Unless there's some clever trickery that we can employ, the above
> renders the Linux __no_sanitize_address annotation useless for this
> style of code.
> 
> We should certianly call that out in the commentary in
> include/linux/compiler-gcc.h.
> 
>> But we need fix this in kernel.
>> I see two options here:
>>  * completely disable instrumentation for drivers/firmware/psci.c
> 
> This is somewhat overkill, and we'd also have to disable instrumentation
> for arch/arm64/kernel/psci.c (for psci_suspend_finisher).
> 
> I would like to have instrumentation for everything we can safely
> instrument.
> 
> This is probably the least worst option, though.
> 
>>  * get back to assembly implementation
> 
> We'd also have to convert psci_suspend_finisher and psci_cpu_suspend,
> the latter being generic code. That goes against the consolidation we
> were aiming for.
> 

Yup, I missed these two.
In that case the only way is to manually unpoison stack.
