From: dave.long@linaro.org (David Long)
Date: Tue, 15 Apr 2014 15:39:18 -0400
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415174330.GA10558@redhat.com>
References: <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com> <20140411152207.GA28188@redhat.com>
 <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
 <20140414185916.GA30672@redhat.com>
 <CAA3XUr3BGA55JF_cgH=cqbo1wAK0773P1fvnG9dBjLU2KzBdKA@mail.gmail.com>
 <20140415154637.GA3560@redhat.com> <534D6A1F.70102@linaro.org>
 <20140415174330.GA10558@redhat.com>
Message-ID: <534D8AE6.3090609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/14 13:43, Oleg Nesterov wrote:
> On 04/15, David Long wrote:
>>
>> On 04/15/14 11:46, Oleg Nesterov wrote:
>>>
>>> But. Please do not add copy_to_user_page() into copy_to_page() (as your patch
>>> did). This is certainly not what uprobe_write_opcode() wants, we do not want
>>> or need "flush" in this case. The same for __create_xol_area().
>>>
>>
>> It looked me like a call to a new __copy_to_user_page(current->mm, ...) in xol_get_insn_slot()
>> would be in line with David Miller's suggestion and would cure the problem on ARM (and hopefuly
>> be more philosophically correct for all architectures):
>
> David, let me repeat. I am not going to argue even if I obviously like
> the Linus's suggestion more.
>
> I only argued with the suggestions to follow the __access_remote_vm()
> logic.
>
>> @@ -1297,13 +1298,11 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>>                  return 0;
>>
>>          /* Initialize the slot */
>> -       copy_to_page(area->page, xol_vaddr,
>> -                       &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
>> -       /*
>> -        * We probably need flush_icache_user_range() but it needs vma.
>> -        * This should work on supported architectures too.
>> -        */
>> -       flush_dcache_page(area->page);
>> +       kaddr = kmap_atomic(area->page);
>> +       __copy_to_user_page(current->mm, area->page, xol_vaddr,
>> +                       kaddr + (xol_vaddr & ~PAGE_MASK),
>> +                       &uprobe->arch.ixol, sizeof(uprobe->arch.ixol), true);
>> +       kunmap_atomic(kaddr);
>
> This all is fine, but you need to introduce __copy_to_user_page() first.
>

Yes, I have that coded for 14 out of 24 architectures (the easy ones). 
The remaining ones need more work.  Some may prove problematic.  The 
whole approach could yet prove impractical.  More recent suggested 
approaches may be better too (or Linus's relatively simple change).

> And you need to do this for every arch. And you need to verify that it
> does not need mmap_sem. It seems that at least alpha needs this lock.
> And as Russel pointed out (again, again, I could easily misunderstood him)
> you need preempt_disable() around memcpy + flush, so down_read(mmap_sem)
> should probably go into __copy_to_user_page(). And I am not sure this
> helper needs "struct mm_struct *mm" argument, but this is minor.
>

I will look at the locking.  I'm not sure yet if anything needs struct 
mm_struct either.

> Finally, let me repeat, you should verify that this
> __copy_to_user_page(page, uaddr, kaddr) will not something bad if uaddr
> is not mmapped, or its mapping do not match area->page.
>
> Good luck ;)
>
> Oleg.
>
