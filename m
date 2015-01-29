From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 29 Jan 2015 10:59:45 +0000
Subject: [PATCH 7/8] arm64/kexec: Add checks for KVM
In-Reply-To: <54CA041C.6020403@linaro.org>
References: <cover.1421449714.git.geoff@infradead.org>
 <a3353cf2ac47f49c20bbbb88405301cbaa359805.1421449714.git.geoff@infradead.org>
 <20150126191942.GQ23313@leverpostej> <54CA041C.6020403@linaro.org>
Message-ID: <54CA12A1.8090508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 29/01/15 09:57, AKASHI Takahiro wrote:
> Hello,
> 
> On 01/27/2015 04:19 AM, Mark Rutland wrote:
>> On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
>>> Add runtime checks that fail the arm64 kexec syscall for situations that would
>>> result in system instability do to problems in the KVM kernel support.
>>> These checks should be removed when the KVM problems are resolved fixed.
>>>
>>> Signed-off-by: Geoff Levand <geoff@infradead.org>
>>> ---
>>>   arch/arm64/kernel/machine_kexec.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>>> index 3d84759..a36459d 100644
>>> --- a/arch/arm64/kernel/machine_kexec.c
>>> +++ b/arch/arm64/kernel/machine_kexec.c
>>> @@ -16,6 +16,9 @@
>>>   #include <asm/cacheflush.h>
>>>   #include <asm/system_misc.h>
>>>
>>> +/* TODO: Remove this include when KVM can support a kexec reboot. */
>>> +#include <asm/virt.h>
>>> +
>>>   /* Global variables for the relocate_kernel routine. */
>>>   extern const unsigned char relocate_new_kernel[];
>>>   extern const unsigned long relocate_new_kernel_size;
>>> @@ -100,6 +103,13 @@ int machine_kexec_prepare(struct kimage *image)
>>>
>>>   	kexec_image_info(image);
>>>
>>> +	/* TODO: Remove this message when KVM can support a kexec reboot. */
>>> +	if (IS_ENABLED(CONFIG_KVM) && is_hyp_mode_available()) {
>>> +		pr_err("%s: Your kernel is configured with KVM support (CONFIG_KVM=y) which currently does not allow for kexec re-boot.\n",
>>> +			__func__);
>>> +		return -ENOSYS;
>>> +	}
>>
>> If you really don't want to implement KVM teardown, surely this should
>> be at the start of the series, so we don't have a point in the middle
>> where things may explode in this case?
> 
> I'm going to fix this KVM issue (teardown) in cooperation with Geoff.
> 
> Looking into kvm init code, kvm_arch_init() in particular,
> I guess that teardown function (kvm_arch_exit()) should do
>    (reverting kvm_timer_hyp_init() per cpu)
> - stop arch timer

No need, there shouldn't be any guest running at that point.

>    (reverting cpu_init_hyp_mode() per cpu)
> - flush TLB
> - jump into identical mapping (using boot_hyp_pgd?)
> - disable MMU?

Yes, and for that, you need to go back to an idmap

> - restore vbar_el2 to __hyp_stub_vectors (or NULL?)

It doesn't matter, you want to stay in HYP for the next kernel.

>    (reverting kvm_mmu_init())
> - Do we need to free page tables and a bounce(trampoline) page?

I don't think that's useful, you've killed the kernel already.

> Is this good enough for safely shutting down kvm?
> Do I miss anything essential, or can I skip anyhing?

I've outlined the steps a couple of days ago there:
http://www.spinics.net/lists/arm-kernel/msg395177.html

and the outline above should give you a nice list of things to look at.
All in all, it is pretty straightforward, provided that you're careful
enough about (commit 5a677ce044f has most of the information, just read
it backward... ;-).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
