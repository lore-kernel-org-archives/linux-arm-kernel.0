From: anup@brainfault.org (Anup Patel)
Date: Thu, 17 Oct 2013 17:00:50 +0530
Subject: [RFC PATCH 1/5] ARM/ARM64: KVM: Update user space API header for
 PSCI emulation
In-Reply-To: <525FC82D.7030904@arm.com>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
 <1381942954-22388-2-git-send-email-anup.patel@linaro.org>
 <20131016221132.GE24837@cbox>
 <CAAhSdy2jgz24HEH1_CGCEYSGoBuy-4bA-ACYxLEWwCD33a9_XQ@mail.gmail.com>
 <525FA41F.1050204@arm.com>
 <CAAhSdy1o9nYu9Mp18M+wTtZGHJkge0eDA6oqyt-J9wYYEqXtGg@mail.gmail.com>
 <525FC82D.7030904@arm.com>
Message-ID: <CAAhSdy1quhekbE6nXWWK7B4Ak3PjN+FVRMnQqj8gk1urPgKDkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 4:51 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 17/10/13 12:10, Anup Patel wrote:
>> On Thu, Oct 17, 2013 at 2:17 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 17/10/13 07:45, Anup Patel wrote:
>>>> On Thu, Oct 17, 2013 at 3:41 AM, Christoffer Dall
>>>> <christoffer.dall@linaro.org> wrote:
>>>>> On Wed, Oct 16, 2013 at 10:32:30PM +0530, Anup Patel wrote:
>>>>>> Update user space API interface headers for providing information to
>>>>>> user space needed to emulate PSCI function calls in user space (i.e.
>>>>>> QEMU or KVMTOOL).
>>>>>>
>>>>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>>>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>>>>> ---
>>>>>>  include/uapi/linux/kvm.h |    7 +++++++
>>>>>>  1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>>>> index e32e776..dae2664 100644
>>>>>> --- a/include/uapi/linux/kvm.h
>>>>>> +++ b/include/uapi/linux/kvm.h
>>>>>> @@ -171,6 +171,7 @@ struct kvm_pit_config {
>>>>>>  #define KVM_EXIT_WATCHDOG         21
>>>>>>  #define KVM_EXIT_S390_TSCH        22
>>>>>>  #define KVM_EXIT_EPR              23
>>>>>> +#define KVM_EXIT_PSCI             24
>>>>>>
>>>>>>  /* For KVM_EXIT_INTERNAL_ERROR */
>>>>>>  /* Emulate instruction failed. */
>>>>>> @@ -301,6 +302,12 @@ struct kvm_run {
>>>>>>               struct {
>>>>>>                       __u32 epr;
>>>>>>               } epr;
>>>>>> +             /* KVM_EXIT_PSCI */
>>>>>> +             struct {
>>>>>> +                     __u32 fn;
>>>>>> +                     __u64 args[7];
>>>>>> +                     __u64 ret[4];
>>>>>> +             } psci;
>>>>>>               /* Fix the size of the union. */
>>>>>>               char padding[256];
>>>>>>       };
>>>>>> --
>>>>>> 1.7.9.5
>>>>>>
>>>>> I am also wondering if this is not solving a very specific need without
>>>>> thinking a little more carefully about this problem.
>>>>
>>>> No, its not solving a specific problem.
>>>>
>>>> In fact, its more general because we pass complete info required to
>>>> emulate a PSCI call in user space.
>>>> (Please refer PSCI calling convention)
>>>>
>>>>>
>>>>> We have previously discussed the need for some secure side emulation
>>>>> in QEMU, and I think perhaps we need something more generic which allows
>>>>> user space to handle SMC calls and/or allows user space to "inject" some
>>>>> secure world runtime that the kernel can run in a partially or fully
>>>>> isolated container to handle SMC calls.
>>>>>
>>>>> Peter raised this issue previously and pointed to a proposal he had as
>>>>> well.
>>>>
>>>> If required we can have an additional field in kvm_run->psci which tells
>>>> whether the PSCI call is an SMC call or HVC call.
>>>>
>>>>>
>>>>> Is there a technical reason why we need something specifically directed
>>>>> to PSCI?
>>>>
>>>> Its quite natural to add this to PSCI emulation in KVM ARM/ARM64 instead
>>>> of adding a separate VirtIO device for System reboot and System poweroff.
>>>>
>>>> Also in the process of implementing SYSTEM_OFF and SYSTEM_RESET
>>>> emulation in user space we would also have an infrastructure for adding
>>>> emulation of new PSCI calls in user space.
>>>
>>> And I strongly oppose to that. It creates consistency issues (what if
>>> userspace implements one version of PSCI, and the kernel another?), and
>>> also some really horrible situations: Imagine you implement the SUSPEND
>>> operation in userspace, and want to wake the vcpu up with an interrupt.
>>> You'd end-up having to keep track of the state in the kernel, having to
>>> forward the interrupt event to userspace...
>>
>> It is not about emulating all PSCI functions in user space. Its about forwarding
>> system-level PSCI functions or PSCI functions which cannot be emulated in
>> kernel to user space.
>
> The CPU parts of PSCI can perfectly be implemented in the kernel.

Agreed. This patches does the same.

>
> Then you can return something to userspace indicating what just
> happened. And it doesn't have to be PSCI specific.

Are you suggesting that everytime we want to emulate some new
PSCI call with help from user space (e.g. SYSTEM_OFF and
SYSTEM_RESET), we add new exit reasons and just keep on
increasing KVM exit reasons ?

Why can't the exit reason and exit info in struct kvm_run be
PSCI specific ?

On the contrary, it will be good to have exit reason and exit info
PSCI specific because we have PSCI specification which tells
how it is to be emulated ?

--
Anup

>
>         M.
> --
> Jazz is not dead. It just smells funny...
>
