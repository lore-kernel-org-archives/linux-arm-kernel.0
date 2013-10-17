From: agraf@suse.de (Alexander Graf)
Date: Fri, 18 Oct 2013 00:26:38 +0200
Subject: [RFC PATCH 1/5] ARM/ARM64: KVM: Update user space API header for
 PSCI emulation
In-Reply-To: <20131017222401.GV24837@cbox>
References: <CAAhSdy2jgz24HEH1_CGCEYSGoBuy-4bA-ACYxLEWwCD33a9_XQ@mail.gmail.com>
 <525FA41F.1050204@arm.com>
 <CAAhSdy1o9nYu9Mp18M+wTtZGHJkge0eDA6oqyt-J9wYYEqXtGg@mail.gmail.com>
 <525FC82D.7030904@arm.com>
 <CAAhSdy1quhekbE6nXWWK7B4Ak3PjN+FVRMnQqj8gk1urPgKDkg@mail.gmail.com>
 <F0B97457-E92C-4A3D-8466-F7B13F96DE44@suse.de> <525FD02A.6070902@arm.com>
 <3855FC99-2CC3-4347-AA56-1BBD28B03BC1@suse.de> <20131017190459.GU24837@cbox>
 <CC69302A-8EED-43E6-8AF8-3FA89365831B@suse.de> <20131017222401.GV24837@cbox>
Message-ID: <6FDD1DA5-3E1E-4653-9DF3-3E906F8DBEAD@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 18.10.2013, at 00:24, Christoffer Dall <christoffer.dall@linaro.org> wrote:

> On Fri, Oct 18, 2013 at 12:06:29AM +0200, Alexander Graf wrote:
>> 
>> On 17.10.2013, at 21:04, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> 
>>> On Thu, Oct 17, 2013 at 02:01:18PM +0200, Alexander Graf wrote:
>>>> 
>>>> On 17.10.2013, at 13:55, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> 
>>>>> On 17/10/13 12:49, Alexander Graf wrote:
>>>>>> 
>>>>>> On 17.10.2013, at 13:30, Anup Patel <anup@brainfault.org> wrote:
>>>>>> 
>>>>>>> On Thu, Oct 17, 2013 at 4:51 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>>>>> On 17/10/13 12:10, Anup Patel wrote:
>>>>>>>>> On Thu, Oct 17, 2013 at 2:17 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>>>>>>> On 17/10/13 07:45, Anup Patel wrote:
>>>>>>>>>>> On Thu, Oct 17, 2013 at 3:41 AM, Christoffer Dall
>>>>>>>>>>> <christoffer.dall@linaro.org> wrote:
>>>>>>>>>>>> On Wed, Oct 16, 2013 at 10:32:30PM +0530, Anup Patel wrote:
>>>>>>>>>>>>> Update user space API interface headers for providing information to
>>>>>>>>>>>>> user space needed to emulate PSCI function calls in user space (i.e.
>>>>>>>>>>>>> QEMU or KVMTOOL).
>>>>>>>>>>>>> 
>>>>>>>>>>>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>>>>>>>>>>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>> include/uapi/linux/kvm.h |    7 +++++++
>>>>>>>>>>>>> 1 file changed, 7 insertions(+)
>>>>>>>>>>>>> 
>>>>>>>>>>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>>>>>>>>>>> index e32e776..dae2664 100644
>>>>>>>>>>>>> --- a/include/uapi/linux/kvm.h
>>>>>>>>>>>>> +++ b/include/uapi/linux/kvm.h
>>>>>>>>>>>>> @@ -171,6 +171,7 @@ struct kvm_pit_config {
>>>>>>>>>>>>> #define KVM_EXIT_WATCHDOG         21
>>>>>>>>>>>>> #define KVM_EXIT_S390_TSCH        22
>>>>>>>>>>>>> #define KVM_EXIT_EPR              23
>>>>>>>>>>>>> +#define KVM_EXIT_PSCI             24
>>>>>>>>>>>>> 
>>>>>>>>>>>>> /* For KVM_EXIT_INTERNAL_ERROR */
>>>>>>>>>>>>> /* Emulate instruction failed. */
>>>>>>>>>>>>> @@ -301,6 +302,12 @@ struct kvm_run {
>>>>>>>>>>>>>           struct {
>>>>>>>>>>>>>                   __u32 epr;
>>>>>>>>>>>>>           } epr;
>>>>>>>>>>>>> +             /* KVM_EXIT_PSCI */
>>>>>>>>>>>>> +             struct {
>>>>>>>>>>>>> +                     __u32 fn;
>>>>>>>>>>>>> +                     __u64 args[7];
>>>>>>>>>>>>> +                     __u64 ret[4];
>>>>>>>>>>>>> +             } psci;
>>>>>>>>>>>>>           /* Fix the size of the union. */
>>>>>>>>>>>>>           char padding[256];
>>>>>>>>>>>>>   };
>>>>>>>>>>>>> --
>>>>>>>>>>>>> 1.7.9.5
>>>>>>>>>>>>> 
>>>>>>>>>>>> I am also wondering if this is not solving a very specific need without
>>>>>>>>>>>> thinking a little more carefully about this problem.
>>>>>>>>>>> 
>>>>>>>>>>> No, its not solving a specific problem.
>>>>>>>>>>> 
>>>>>>>>>>> In fact, its more general because we pass complete info required to
>>>>>>>>>>> emulate a PSCI call in user space.
>>>>>>>>>>> (Please refer PSCI calling convention)
>>>>>>>>>>> 
>>>>>>>>>>>> 
>>>>>>>>>>>> We have previously discussed the need for some secure side emulation
>>>>>>>>>>>> in QEMU, and I think perhaps we need something more generic which allows
>>>>>>>>>>>> user space to handle SMC calls and/or allows user space to "inject" some
>>>>>>>>>>>> secure world runtime that the kernel can run in a partially or fully
>>>>>>>>>>>> isolated container to handle SMC calls.
>>>>>>>>>>>> 
>>>>>>>>>>>> Peter raised this issue previously and pointed to a proposal he had as
>>>>>>>>>>>> well.
>>>>>>>>>>> 
>>>>>>>>>>> If required we can have an additional field in kvm_run->psci which tells
>>>>>>>>>>> whether the PSCI call is an SMC call or HVC call.
>>>>>>>>>>> 
>>>>>>>>>>>> 
>>>>>>>>>>>> Is there a technical reason why we need something specifically directed
>>>>>>>>>>>> to PSCI?
>>>>>>>>>>> 
>>>>>>>>>>> Its quite natural to add this to PSCI emulation in KVM ARM/ARM64 instead
>>>>>>>>>>> of adding a separate VirtIO device for System reboot and System poweroff.
>>>>>>>>>>> 
>>>>>>>>>>> Also in the process of implementing SYSTEM_OFF and SYSTEM_RESET
>>>>>>>>>>> emulation in user space we would also have an infrastructure for adding
>>>>>>>>>>> emulation of new PSCI calls in user space.
>>>>>>>>>> 
>>>>>>>>>> And I strongly oppose to that. It creates consistency issues (what if
>>>>>>>>>> userspace implements one version of PSCI, and the kernel another?), and
>>>>>>>>>> also some really horrible situations: Imagine you implement the SUSPEND
>>>>>>>>>> operation in userspace, and want to wake the vcpu up with an interrupt.
>>>>>>>>>> You'd end-up having to keep track of the state in the kernel, having to
>>>>>>>>>> forward the interrupt event to userspace...
>>>>>>>>> 
>>>>>>>>> It is not about emulating all PSCI functions in user space. Its about forwarding
>>>>>>>>> system-level PSCI functions or PSCI functions which cannot be emulated in
>>>>>>>>> kernel to user space.
>>>>>>>> 
>>>>>>>> The CPU parts of PSCI can perfectly be implemented in the kernel.
>>>>>>> 
>>>>>>> Agreed. This patches does the same.
>>>>>>> 
>>>>>>>> 
>>>>>>>> Then you can return something to userspace indicating what just
>>>>>>>> happened. And it doesn't have to be PSCI specific.
>>>>>>> 
>>>>>>> Are you suggesting that everytime we want to emulate some new
>>>>>>> PSCI call with help from user space (e.g. SYSTEM_OFF and
>>>>>>> SYSTEM_RESET), we add new exit reasons and just keep on
>>>>>>> increasing KVM exit reasons ?
>>>>>>> 
>>>>>>> Why can't the exit reason and exit info in struct kvm_run be
>>>>>>> PSCI specific ?
>>>>>>> 
>>>>>>> On the contrary, it will be good to have exit reason and exit info
>>>>>>> PSCI specific because we have PSCI specification which tells
>>>>>>> how it is to be emulated ?
>>>>>> 
>>>>>> I completely agree with Marc that split-brain ownership of any address space (and PSCI is basically one) is a very bad idea.
>>>>>> 
>>>>>> However, so far the only solution I've seen mentioned is that the kernel owns PSCI (read: decodes it) and then drives user space with explicit commands.
>>>>>> 
>>>>>> Couldn't we reverse this logic? User space owns PSCI. By default all PSCI calls go to user space. If a PSCI call makes more sense to be executed by kvm, it can explicitly route it to be handled by kvm instead.
>>>>>> 
>>>>>> That way the owner is still at a single spot and we can fast path the few cases that may be performance critical or a lot easier to handle in kvm.
>>>>>> 
>>>>>> The good part about this is that we get consistency in QEMU with the TCG PSCI handlers along the way.
>>>>> 
>>>>> The only nag here is that you can't do that for every function: SUSPEND
>>>>> is one, for example. Once your vcpu is suspended, you need to to wake it
>>>>> up with an interrupt, which are not routed to userspace (TFFT!).
>>>> 
>>>> Not sure I understand. Can't you just vcpu_kick() it with a posix signal to get it out of vcpu_run() and unset the "suspended" state? If you guarantee that you don't get spurious exits out of SUSPEND you need to be able to set/unset that bit anyways for migration.
>>>> 
>>> Right now the suspended state is private on the vcpu (the
>>> vcpu->arch.pause if I'm not mistaken), so QEMU does not have a way to
>>> set/unset this.
>>> 
>>> I think we got around this for migration, because a suspended CPU could
>>> always be woken up spuriously according to the ARM specs (Peter, am I
>>> mixing things up here?) so we simply wake everything up after migration
>>> and it's up to the VM to go to sleep again... Of course, this may not be
>>> ideal anyhow, and we could implement something to coordinate this state
>>> between user space and the kernel.
>> 
>> This is basically how we deal with this on ppc as well. You are never guaranteed that sleeping doesn't wake you up randomly. But this also means that you want to unset vcpu->arch.pause every time you stop waiting for events and go back to user space (-EINTR).
>> 
> 
> Not sure what you mean, in which case do you need to unset the
> vcpu->arch.pause?  We unset this is there's an interrupt to the vcpu
> detected inside the kernel, coming from either user space or from within
> a device inside the kernel (like the arch timer).
> 
>>> If user space puts the thread to sleep waiting for a signal, does
>>> vcpu_kick() currently send such a signal and wake you up or is it
>>> something we'd have to add?
>> 
>> Why would user space put a thread to sleep? The kernel pauses the vcpu and user space would just send a signal, sending it back into user space which realizes it doesn't have to do anything, goes back into kvm_run() and thus breaks the pausing.
>> 
>> Or did I misunderstand the problem? :)
>> 
> Oh, I mean if you wanted to implement vcpu suspend in user space, you
> could either somehow set vcpu->pause from user space or you could idle,
> not call KVM_VCPU_RUN until you receive a signal on that thread.  Is
> this crazy rambling?

Ah, I thing I get where you're aiming at. I think it makes sense to leave ownership of the vcpu in the kernel's hands. So you would indicate that the vcpu should be suspended and then call VCPU_RUN.

But take a look at x86's mpstate. IIRC that's one of the problems it's trying to solve.


Alex
