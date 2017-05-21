From: gengdj.1984@gmail.com (gengdongjiu)
Date: Sun, 21 May 2017 17:23:08 +0800
Subject: [PATCH v3 3/3] arm/arm64: signal SIBGUS and inject SEA Error
In-Reply-To: <5915EFF9.1020405@arm.com>
References: <CAMj-D2BGTDKpOcMu2ip41_MTTj8VDwvs59Ds7yvLHcD8PeQzhg@mail.gmail.com>
 <5910AAA2.4030304@arm.com> <75907fb5-440f-2cbe-762a-d139c4bfdd2d@huawei.com>
 <5915EFF9.1020405@arm.com>
Message-ID: <CAMj-D2Bsgh8y+UZdp+LZ-rcv3ZCwm5RJFVs6SEP0WzxuV4Zbjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-05-13 1:25 GMT+08:00, James Morse <james.morse@arm.com>:
> Hi gengdongjiu,
>
> On 10/05/17 09:44, gengdongjiu wrote:
>> On 2017/5/9 1:28, James Morse wrote:
>>>>> (hwpoison for KVM is a corner case as Qemu's memory effectively has two
>>>>> users,
>>>>> Qemu and KVM. This isn't the example of how user-space gets
>>>>> signalled.)
>>>
>>> KVM creates guests as if they were additional users of Qemu's memory. The
>>> code
>>> in mm/memory-failure.c may find that Qemu didn't have the affected page
>>> mapped
>>> to user-space - but it may have been in use by stage2.
>>>
>>> The KVM+SIGBUS patch hides this difference, meaning Qemu gets a signal
>>> when the
>>> guest touches the hwpoison page as if Qemu had touched the page itself.
>>>
>>> Signals from KVM is a corner case, for firmware-first decisions should
>>> happen in
>>> the APEI code based on CPER records.
>
>>>> If so, how the KVM handle the SEA type other than hwpoison?
>
>>> To deliver to a guest? It shouldn't have to know, user space should use a
>>> KVM
>>> API to drive this.
>>>
>>> When received from hardware? It shouldn't have to care, these things
>>> should be
>>> passed into the APEI code for handling. KVM just needs to put the host
>>> registers
>>> back.
>
>> Recently I confirmed with the hardware team. they said almost all the SEA
>> errors have the
>> Poison flag, so may be there is no need to consider other SEA errors other
>> than  hwPoison.
>> only consider SEA hwpoison errors can be enough.
>
> We should be careful here, by hwpoison I meant the Linux feature.
> From Documentation/vm/hwpoison.txt:
>> Upcoming Intel CPUs have support for recovering from some memory errors
>> (``MCA recovery''). This requires the OS to declare a page "poisoned",
>> kill the processes associated with it and avoid using it in the future.
>
> We were talking about KVM's reaction to 'the OS declaring a page poisoned'.
> Lets try to call this one memory-failure, as that is its Kconfig name. (now
> I
> understand why we've been confusing each other!)
>
> Your hwpoison looks like something the CPU reports in the ERR<n>STATUS
> registers
> (4.6.10 of DDI0587). This is something firmware should read, then describe
> to
> the OS via CPER records. Depending on these CPER records linux may invoke
> its
> memory-failure code.
  yes

>
>
>>>> injection a SEA is no more than setting some registers: elr_el1, PC,
>>>> PSTATE, SPSR_el1, far_el1, esr_el1
>>>> I seen this KVM API do the same thing as Qemu.  do you found call this
>>>> API will have issue and necessary to choose another ESR value?
>>>
>>> Should we let user-space pick the ESR to deliver to the guest? Yes,
>>> letting
>>> user-space specify the ESR gives the most flexibility to do something
>>> clever in
>>> the future. An obvious choice for SEA is between the external-abort and
>>> 'parity
>>> or ECC error' codes. If we tell user-space which of these happened (I
>>> don't
>>> think Linux does today) then Qemu can relay that information to the
>>> guest.
>
>> may be the ESR is delivered by the KVM.
>> (1) guest OS EL0 happen SEA due to hwpoison
>> (2) CPU traps to EL3 firmware, and update the ESR_EL3
>> (3) the EL3 firmware copies the ESR_EL3 to ESR_EL2
>> (4) then jump to EL2 hypervisor, hypervisor uses the ESR_EL2 to inject the
>> SEA.
>>
>> May be the esr_el2 can provide the accurate error information.
>> or do you think user-space specify the ESR instead of esr_el2 is better?
>
> I think the severity needs to be considered as the notification is handled
> by
> each exception level. There are cases where it will need to be upgraded
> from
> 'contained' to 'uncontained'. (more discussion on another part of the
> thread).
  understand it.

>
>
> Thanks,
>
> James
>
