From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Thu, 4 Apr 2013 08:32:41 -0700
Subject: [PATCH 4/7] ARM: KVM: enforce page alignment for identity mapped
 code
In-Reply-To: <515D5A44.9030909@arm.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-5-git-send-email-marc.zyngier@arm.com>
 <20130403095024.GC11040@mudshark.cambridge.arm.com>
 <515BFDC7.9020401@arm.com> <20130403231504.GD29227@gmail.com>
 <515D5A44.9030909@arm.com>
Message-ID: <CAEDV+gLG8zEzu2eUa5Kk18wQ6k3g=mMpWBdYKhyFk29ReLv6fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 3:47 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 04/04/13 00:15, Christoffer Dall wrote:
>> On Wed, Apr 03, 2013 at 11:00:39AM +0100, Marc Zyngier wrote:
>>> On 03/04/13 10:50, Will Deacon wrote:
>>>> On Tue, Apr 02, 2013 at 02:25:12PM +0100, Marc Zyngier wrote:
>>>>> We're about to move to a init procedure where we rely on the
>>>>> fact that the init code fits in a single page. Make sure we
>>>>> align the idmap text on a page boundary, and that the code is
>>>>> not bigger than a single page.
>>>>>
>>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>>> ---
>>>>>  arch/arm/kernel/vmlinux.lds.S | 2 +-
>>>>>  arch/arm/kvm/init.S           | 7 +++++++
>>>>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>>>>> index b571484..d9dd265 100644
>>>>> --- a/arch/arm/kernel/vmlinux.lds.S
>>>>> +++ b/arch/arm/kernel/vmlinux.lds.S
>>>>> @@ -20,7 +20,7 @@
>>>>>    VMLINUX_SYMBOL(__idmap_text_start) = .;                         \
>>>>>    *(.idmap.text)                                                  \
>>>>>    VMLINUX_SYMBOL(__idmap_text_end) = .;                           \
>>>>> -  ALIGN_FUNCTION();                                               \
>>>>> +  . = ALIGN(PAGE_SIZE);                                           \
>>>>>    VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;                     \
>>>>>    *(.hyp.idmap.text)                                              \
>>>>>    VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
>>>>> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
>>>>> index 9f37a79..35a463f 100644
>>>>> --- a/arch/arm/kvm/init.S
>>>>> +++ b/arch/arm/kvm/init.S
>>>>> @@ -111,4 +111,11 @@ __do_hyp_init:
>>>>>    .globl __kvm_hyp_init_end
>>>>>  __kvm_hyp_init_end:
>>>>>
>>>>> +  /*
>>>>> +   * The above code *must* fit in a single page for the trampoline
>>>>> +   * madness to work. Whoever decides to change it must make sure
>>>>> +   * we map the right amount of memory for the trampoline to work.
>>>>> +   * The line below ensures any breakage will get noticed.
>>
>> This comment is a little funny. What's this about changing it? And why
>> madness? OK, it's a little mad.
>>
>> I think the nice thing to explain here is why .org would complain - I
>> had to look in the AS reference to figure out that it will complain if
>> the location pointer is forwarded outside the section - if that is the
>> right reason?
>>
>>>>> +   */
>>>>> +  .org    __kvm_hyp_init + PAGE_SIZE
>>>>>    .popsection
>>>>
>>>> What effect does this have on the size of the kernel image? I'd expect the
>>>> idmap code to be pretty small, so aligning to a page might be overkill a lot
>>>> of the time.
>>>
>>> So we're indeed wasting memory between the kernel and the HYP idmaps.
>>> The reason for this is to ensure that the init code is not spread across
>>> two pages, which would make the trampoline harder to allocate.
>>>
>>> If there's a way to ensure that the init.S code will fit a single page,
>>> then we can remove this ALIGN(PAGE_SIZE).
>>
>> Just allocate a temporary page and copy the bit of code into there?  It
>> should be easy enough to make sure it's location independent.  We can
>> even give that page back later if we want and re-do the trick when a CPU
>> gets hot-plugged if we want. No?
>
> I'd really like to avoid freeing stuff, because it gives us even more
> chances to screw our TLBs (we'd have to invalidate on unmap, and deal
> with potential races between CPUs coming up).
>
> We could allocate this page *if* the HYP init code happens to cross a
> page boundary, and only then. I'll have a look at implementing this as
> it should solve Will's issue (which is even worse on arm64 with 64k pages).
>
The freeing stuff was a minor point, that I don't care much about, but
reducing the kernel size is a valid concern I guess.

-Christoffer
