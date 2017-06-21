From: james.morse@arm.com (James Morse)
Date: Wed, 21 Jun 2017 13:44:53 +0100
Subject: [PATCH v2] KVM: arm/arm64: Signal SIGBUS when stage2 discovers
 hwpoison memory
In-Reply-To: <3a02e425-5782-dad4-efda-fdc5df73dcf7@huawei.com>
References: <20170524163250.29281-1-james.morse@arm.com>
 <3dbafd74-57f2-e724-ace2-0f84abb57e59@huawei.com> <594A4205.70201@arm.com>
 <3a02e425-5782-dad4-efda-fdc5df73dcf7@huawei.com>
Message-ID: <594A6A45.60909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 21/06/17 11:59, gengdongjiu wrote:
> On 2017/6/21 17:53, James Morse wrote:
>> I think we discussed this before[0], your CPU has a feature called 'hwpoison'
>> that is uses to support RAS. Linux also has a feature called 'hwpoison' [1][2],
>> which handles the offline-ing of memory pages when it receives a notification
>> through APEI. I've tried to call this memory_failure() to avoid this confusion.
>>
>> This patch is to handle stage2 faults when the page was removed from the stage2
>> mapping by the memory_failure() code. v3 of this patch[3] does a much better job
>> of describing this.
>>
>> (... I don't think your question is related to this patch ...)
> 
> I know your meaning about the Linux 'hwpoison' feature.

Okay, I assume we are also talking about firmware-first RAS events and your APEI
notifications use SEA.


I think we are looking at different parts of the code, here is what I see should
happen:

For a Synchronous External Abort the ESR {D,I}FSC bits will be in the range that
indicates an external abort. For a data:external-abort kvm_handle_guest_abort()
will matches this with kvm_vcpu_dabt_isextabt() and makes no further attempt to
handle the fault.

Tyler's RAS series added an earlier check:
> /*
>  * The host kernel will handle the synchronous external abort. There
>  * is no need to pass the error into the guest.
>  */
> if (is_abort_sea(fault_status)) {
> 	if (!handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
> 		return 1;
>?}
>

This goes on to call ghes_notify_sea() which will handle the error and cause KVM
to exit this function. KVM makes no further attempt to handle the fault as APEI
should have done everything necessary. KVM will re-enter the guest, unless there
are signals pending.

(You're right that here the fault_ipa is the wrong thing to pass, but
handle_guest_sea() doesn't use it...)

We do need to enable HCR_EL2.TEA which was added with v8.2s RAS extensions, but
the cpufeature patch is a pre-requisite.


> Let see the code that how to get the "pfn"
> 
> ///get the pfn
> fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
> gfn = fault_ipa >> PAGE_SHIFT;
> pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);

> As shown in above code, when happen SEA, the fault_ipa is got from the HPFAR_EL2 register.
> if the HPFAR_EL2 does not record the IPA. the fault_ipa is zero, then gfn is zero, so the pfn is unknown.

> so below judgement always false although firmware notify the memory_failure through APEI, because we do not get the right fault memory page.
> using this API "kvm_vcpu_get_fault_ipa" can not get the right fault memory page if cpu does not update the HPFAR_EL2.

The path to the below code that uses fault_ipa->gfn->pfn->hva is:
kvm_handle_guest_abort()
user_mem_abort()
kvm_send_hwpoison_signal().

But for an external abort due to RAS we never get past kvm_handle_guest_abort()
as we call out to the APEI ghes to handle the RAS error instead.

For a data external abort that wasn't due to RAS we still don't get here as KVM
will hit the vcpu with kvm_inject_vabt() instead.


> +	if (pfn == KVM_PFN_ERR_HWPOISON) {
> +		kvm_send_hwpoison_signal(hva, vma);
> +		return 0;
> +	}

Are you seeing a guest repeatedly trigger external-abort on the same address?
If so, can you add debug messages to check if handle_guest_sea() is called? Does
it find work to do? If so kvm_handle_guest_abort() should exit.
Do your CPER records cause memory_failure() to be run?
Does try_to_unmap() in hwpoison_user_mappings() run and succeed? If so the
faulty page should be unmapped from stage2, from now on the guest should only
trigger normal stage2 faults for this address.

How does your firmware choose to route injected-External-Aborts for APEI
notifications? Do we need to enable HCR_EL2.TEA to make this work properly?


> so may be you need to double confirm that whether armv8.0/armv8.2  standard
> CPU can always update the  HPFAR_EL2 registers.

I don't know what the CPUs do, but the ARM-ARM allows the FAR to be not-valid
for some external aborts. This is indicated by the Far-not-Valid bit in the ESR.

With firmware-first RAS the only external aborts that Linux should see are SEA
APEI notifications. We shouldn't expect firmware to set much beyond the minimum
for these. The KVM code touched by this patch shouldn't run for an APEI
notification.


Thanks,

James
