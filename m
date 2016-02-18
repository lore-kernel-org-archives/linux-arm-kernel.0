From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu, 18 Feb 2016 11:22:24 +0300
Subject: KASAN issues with idle / hotplug area
In-Reply-To: <20160217191643.GK32647@leverpostej>
References: <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com> <20160217143950.GC32647@leverpostej>
 <20160217170110.GE32647@leverpostej> <20160217175656.GJ32647@leverpostej>
 <20160217191643.GK32647@leverpostej>
Message-ID: <56C57F40.3050500@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/17/2016 10:16 PM, Mark Rutland wrote:
> On Wed, Feb 17, 2016 at 05:56:56PM +0000, Mark Rutland wrote:
>> On Wed, Feb 17, 2016 at 05:01:11PM +0000, Mark Rutland wrote:
>>> On Wed, Feb 17, 2016 at 02:39:51PM +0000, Mark Rutland wrote:
>>>> Perhaps the simplest option is to not instrument invoke_psci_fn_* and
>>>> psci_suspend_finisher. Do we have a per-function annotation to avoid
>>>> KASAN instrumentation, like notrace? I need to investigate, but we may
>>>> also need notrace for similar reasons.
>>>
>>> I came up with the patch below, per the reasoning above.
>>>
>>> It _changes_ the KASAN splats (I see errors in tick_program_event rather
>>> than find_busiest_group), but doesn't seem to get rid of them. I'm not
>>> sure if I've missed something, or if we also have another latent issue.
>>>
>>> Ideas?
>>
>> I'd missed annotating __cpu_suspend_save. I've fixed that up locally
>> (along with s/virt_to_phys/__virt_to_phys due to the inlining issue).
> 
> Thinking about it more, I shouldn't have to annotate __cpu_suspend_save,
> as it returns (and hence should have cleaned up after itself).
> 

Right, we need to no-sanitize only functions that passed to 'cpu_suspend(arg, fn);'


> Looking at the assembly, functions seem to get instrumented regardless
> of the __no_sanitize_address annotation. The assembly of
> __invoke_psci_fn_{smc,hvc} look identical, even if one has the
> annotation and one does not.
> 
> In the case below, it looks like __invoke_psci_fn_hvc is storing to the
> shadow area even though it's anotated with __no_sanitize_address.  Note
> that the adrp symbol resolution is bogus; psci_to_linux_errno happens to
> be at offset 0 in the as-yet unlinked psci.o object.
> 

...
> I also tried using __attribute__((no_sanitize_address)) directly, in
> case there was some header issue, but that doesn't seem to be the case.
> 
> I'm using the Linaro 15.08 AArch64 GCC 5.1. Is anyone else able to
> confirm whether they see the same? Does the same happen for x86?
> 

Confirming, this happens on every GCC I have (including x86).
It seems that 'no_sanitize_address' in gcc removes only memory access checks
but it doesn't remove stack redzones.
I think this is wrong, e.g. clang removes instrumentation completely. I'll submit a bug.

But we need fix this in kernel.
I see two options here:
 * completely disable instrumentation for drivers/firmware/psci.c
 * get back to assembly implementation

> Thanks,
> Mark.
> 
