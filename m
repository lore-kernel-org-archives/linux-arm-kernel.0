From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 29 Sep 2012 20:33:51 -0400
Subject: [kvmarm] [PATCH 10/15] KVM: ARM: World-switch implementation
In-Reply-To: <2f4c4963f36aabf6e5f48ad42bf145f2@localhost>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153533.21241.82489.stgit@ubuntu>
 <20120925170031.GF28728@mudshark.cambridge.arm.com>
 <CAFEAcA-69tmRdZkZ9dsSk9ck-AC7tKmYvxyxGGVA6ocKDRB25A@mail.gmail.com>
 <2f4c4963f36aabf6e5f48ad42bf145f2@localhost>
Message-ID: <CANM98q+gBZ-msYxp=aOhHLJboweuJ35CQQ602gcqE7-PjsYe-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 1:42 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Tue, 25 Sep 2012 18:15:50 +0100, Peter Maydell
> <peter.maydell@linaro.org> wrote:
>> On 25 September 2012 18:00, Will Deacon <will.deacon@arm.com> wrote:
>>> On Sat, Sep 15, 2012 at 04:35:33PM +0100, Christoffer Dall wrote:
>>>>  ENTRY(__kvm_tlb_flush_vmid)
>>>> +       hvc     #0                      @ Switch to Hyp mode
>>>> +       push    {r2, r3}
>>>> +
>>>> +       add     r0, r0, #KVM_VTTBR
>>>> +       ldrd    r2, r3, [r0]
>>>> +       mcrr    p15, 6, r2, r3, c2      @ Write VTTBR
>>>> +       isb
>>>> +       mcr     p15, 0, r0, c8, c3, 0   @ TLBIALLIS (rt ignored)
>>>> +       dsb
>>>> +       isb
>>>> +       mov     r2, #0
>>>> +       mov     r3, #0
>>>> +       mcrr    p15, 6, r2, r3, c2      @ Back to VMID #0
>>>> +       isb
>>>
>>> Do you need this isb, given that you're about to do an hvc?
>>>
>>>> +       pop     {r2, r3}
>>>> +       hvc     #0                      @ Back to SVC
>>>>         bx      lr
>>
>> ...you probably don't want to do the memory accesses involved
>> in the 'pop' under the wrong VMID ?
>
> Well, we're still in HYP mode when performing the pop, so the VMID is
> pretty much irrelevant. Same for the initial push, actually. As long as
> we're sure VTTBR has been updated when we do the exception return, I think
> we're safe.
>
yeah we're safe, but I can't find anywhere that says the ISB is
implied from exception handling/hvc, even though I seem to recall
having read this, so I put this here not to worry other readers.

-Christoffer
