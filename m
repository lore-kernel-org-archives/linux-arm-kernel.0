From: agraf@suse.de (Alexander Graf)
Date: Tue, 10 Dec 2013 23:34:27 +0100
Subject: [PATCH 1/2] KVM: Add KVM_EXIT_RESET to user space API header
In-Reply-To: <20131210223057.GB2871@cbox>
References: <1385394599-15439-1-git-send-email-anup.patel@linaro.org>
 <1385394599-15439-2-git-send-email-anup.patel@linaro.org>
 <B781AC83-E85A-45E5-BD8C-3979D1E74D34@suse.de>
 <CAAhSdy3yApns95J0T=-OCmpNvf0ZTBV-USmsS=9h+JMuQ40YyQ@mail.gmail.com>
 <206A8D38-6E3D-44FE-83C4-E9B1923AF33B@suse.de> <20131210223057.GB2871@cbox>
Message-ID: <29E9D7B0-E40B-49E3-ACCB-14A5D9443A31@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10.12.2013, at 23:30, Christoffer Dall <christoffer.dall@linaro.org> wrote:

> On Tue, Dec 10, 2013 at 04:49:19PM +0100, Alexander Graf wrote:
>> 
>> On 10.12.2013, at 05:23, Anup Patel <anup@brainfault.org> wrote:
>> 
>>> On Tue, Dec 10, 2013 at 7:43 AM, Alexander Graf <agraf@suse.de> wrote:
>>>> 
>>>> On 25.11.2013, at 16:49, Anup Patel <anup.patel@linaro.org> wrote:
>>>> 
>>>>> Currently, we don't have an exit reason for VM reset emulation
>>>>> in user space hence this patch adds exit reason KVM_EXIT_RESET
>>>>> for this purpose.
>>>>> 
>>>>> This newly added KVM_EXIT_RESET will be used by KVM arm/arm64
>>>>> in-kernel PSCI support to reset VMs.
>>>>> 
>>>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>>>> ---
>>>>> include/uapi/linux/kvm.h |    1 +
>>>>> 1 file changed, 1 insertion(+)
>>>>> 
>>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>>> index 902f124..64a04cc 100644
>>>>> --- a/include/uapi/linux/kvm.h
>>>>> +++ b/include/uapi/linux/kvm.h
>>>>> @@ -171,6 +171,7 @@ struct kvm_pit_config {
>>>>> #define KVM_EXIT_WATCHDOG         21
>>>>> #define KVM_EXIT_S390_TSCH        22
>>>>> #define KVM_EXIT_EPR              23
>>>>> +#define KVM_EXIT_RESET            24
>>>> 
>>>> I have to admit that I'm not particularly happy with the exit name. It's not obvious from the name under which circumstances it gets triggered. Does it get triggered when a core level reset happens? Does it get triggered when a system level reset happened? When the guest requests one?
>>> 
>>> The KVM_EXIT_RESET gets triggered when system level reset is
>>> initiated by VCPU. For arm/arm64, this is through SYSTEM_RESET
>>> PSCI call. In KVM x86 SVM/VMX, we have KVM_EXIT_SHUTDOWN
>>> being used for system shutdown which we have re-used for arm/arm64.
>> 
>> Yeah, that name already did mislead you once :).
>> 
>> KVM_EXIT_SHUTDOWN happens on
>> 
>>  * triple fault
>>  * CPU internal severe problems
>> 
>> the latter is defined as:
>> 
>> In contrast, an error that cannot be contained and is of such severity that it has compromised the continued operation of a processor core requires immediate action to terminate system processing and may result in a hardware-enforced shutdown. In the shutdown state, the execution of instructions by that processor core is halted. See Section 8.2.9 ?#DF?Double-Fault Exception (Vector 8)? on page 220 for a description of the shutdown processor state.
>> 
>> Triple faults are used commonly in 286 code to switch from PG to real mode. So they _have_ to be emulated as core reset. Otherwise you break old guests.
>> 
>> However, the scope of this exit is definitely vcpu wide. What you are looking for is a system wide notification. Commonly this happens through MMIO, but I can see why you wouldn't want that with PSCI interpreted in the kernel. That's why I asked you to create a completely new one to not add up the the confusion.
>> 
> 
> Did you grab this documentation from somewhere that I can't find with
> grep, or did you just come up with it?

That was from the AMD64 architecture reference manual :).

> Shouldn't we have all exit reasons documented in
> Documentation/virtual/kvm/... ?

Yes, that would be great. The only reason I knew something was fishy was that there's no way for a guest to trigger a non-MMIO/PIO/HCALL event that would end up in a genuine shutdown request ;).


Alex
