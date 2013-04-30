From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Apr 2013 18:59:50 +0100
Subject: [PATCH 4/4] ARM: KVM: fix use of S2_PGD_SIZE
In-Reply-To: <20130430175639.GA6266@gmail.com>
References: <1367331446-28030-1-git-send-email-marc.zyngier@arm.com>
 <1367331446-28030-5-git-send-email-marc.zyngier@arm.com>
 <CAEDV+gK5ifY0atTZqku=Y4J=1pfWY4XAz-ayXJ61Sf7MtjOG4A@mail.gmail.com>
 <518004D8.80801@arm.com> <20130430175639.GA6266@gmail.com>
Message-ID: <51800696.9060105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/04/13 18:56, Christoffer Dall wrote:
> On Tue, Apr 30, 2013 at 06:52:24PM +0100, Marc Zyngier wrote:
>> On 30/04/13 18:40, Christoffer Dall wrote:
>>> On Tue, Apr 30, 2013 at 7:17 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> S2_PGD_SIZE describe the number of pages a used by a stage-2 PGD,
>>>> not the size of the PGD.
>>>>
>>>> Fix the VM_BUG_ON() call that doesn't check much when S2_PGD_SIZE
>>>> is equal to 1.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  arch/arm/kvm/mmu.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>>>> index b978ebe..09ece5c 100644
>>>> --- a/arch/arm/kvm/mmu.c
>>>> +++ b/arch/arm/kvm/mmu.c
>>>> @@ -377,7 +377,7 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>>>>                 return -ENOMEM;
>>>>
>>>>         /* stage-2 pgd must be aligned to its size */
>>>> -       VM_BUG_ON((unsigned long)pgd & (S2_PGD_SIZE - 1));
>>>> +       VM_BUG_ON((unsigned long)pgd & (PAGE_SIZE * S2_PGD_SIZE - 1));
>>>
>>> I think the define is broken and should be fixed and/or renamed instead.
>>
>> To be fair, I wouldn't mind the whole check to be dropped altogether. If
>> __get_free_pages doesn't give you an aligned allocation, the whole
>> kernel is going the way of the dodo, and we shouldn't really care...
>>
>> Your call, really.
>>
> Yeah, this is from way back when, where the whole thing was different
> and we were debugging all sorts of issues, so we can get rid of both the
> check and the define in stead.  Want to take care of it as part of your
> series?

Sure. I'll kill it when I repost the series.

	M.
-- 
Jazz is not dead. It just smells funny...
