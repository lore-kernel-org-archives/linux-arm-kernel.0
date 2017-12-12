From: vinmenon@codeaurora.org (Vinayak Menon)
Date: Tue, 12 Dec 2017 09:00:50 +0530
Subject: [PATCH 0/2] Fixes for SW PAN
In-Reply-To: <d2e49626-5c8a-470a-33d9-619475aa3525@codeaurora.org>
References: <1512558968-28980-1-git-send-email-will.deacon@arm.com>
 <5ee0b1f1-c7fc-af92-2b34-4555e59d7a20@codeaurora.org>
 <20171206175641.GA26554@arm.com>
 <20171206180135.5zorlmaij45grg25@armageddon.cambridge.arm.com>
 <20171206180706.GB26554@arm.com>
 <20171206181801.igg5i6qepm4da56g@armageddon.cambridge.arm.com>
 <20171206182657.GA27883@arm.com>
 <d2e49626-5c8a-470a-33d9-619475aa3525@codeaurora.org>
Message-ID: <5ec01c59-8400-88f9-c753-2fb7b9fdac57@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/7/2017 2:25 PM, Vinayak Menon wrote:
> On 12/6/2017 11:56 PM, Will Deacon wrote:
>> On Wed, Dec 06, 2017 at 06:18:01PM +0000, Catalin Marinas wrote:
>>> On Wed, Dec 06, 2017 at 06:07:07PM +0000, Will Deacon wrote:
>>>> On Wed, Dec 06, 2017 at 06:01:35PM +0000, Catalin Marinas wrote:
>>>>> On Wed, Dec 06, 2017 at 05:56:42PM +0000, Will Deacon wrote:
>>>>>> On Wed, Dec 06, 2017 at 11:01:46PM +0530, Vinayak Menon wrote:
>>>>>>> On 12/6/2017 4:46 PM, Will Deacon wrote:
>>>>>>>> After lots of collective head scratching in response to Vinayak's mail
>>>>>>>> here:
>>>>>>>>
>>>>>>>>   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545641.html
>>>>>>>>
>>>>>>>> It turns out that we have a problem with SW PAN and kernel threads, where
>>>>>>>> the saved ttbr0 value for a kernel thread can be stale and subsequently
>>>>>>>> inherited by other kernel threads over a fork.
>>>>>>>>
>>>>>>>> These two patches attempt to fix that. We've not be able to reproduce
>>>>>>>> the exact failure reported above, but I added some assertions to the
>>>>>>>> uaccess routines to check for discrepancies between the active_mm pgd
>>>>>>>> and the saved ttbr0 value (ignoring the zero page) and these no longer
>>>>>>>> fire with these changes, but do fire without them if EFI runtime services
>>>>>>>> are enabled on my Seattle board.
>>>>>>> Thanks Will. So these 2 patches fix the case of kthreads having a stale saved ttbr0. The callstack I had shared
>>>>>>> in the original issue description was not of a kthread (its user task with PF_KTHREAD not set. The tsk->mm was
>>>>>>> set to NULL by exit_mm I think). So do you think this could be a different problem ?
>>>>>>> I had a look at the dumps again and what I see is that, the PA part of the saved ttbr0
>>>>>>> (from thread_info) is not the same as the pa(tsk->active_mm->pgd). The PA derived from saved ttbr0 actually
>>>>>>> points to a page which is "now" owned by slab.
>>>>>> Having not been able to reproduce the failure you described, I can't give
>>>>>> you a good answer to this.
>> Looking at the code (again), if we context switch in do_exit after exit_mm,
>> then the thread behaves an awful lot like a kernel thread: current->mm is
>> NULL and we're in lazy TLB mode.
> Yes, that could be the case.
> I am going to try out these 2 patches and see if the issue gets resolved. It usually takes more
> than a day to reproduce the problem. Will update you as soon as I get the results.

The patches seem to fix the issue. The original issue with non-kthreads is not seen even after 3 days of testing. Thanks Will.

>> Furthermore, that context switch will drop
>> the last reference to the old mm and the pgd will finally be freed.
>>
>> So I think my patches will solve your case too because we'll call
>> enter_lazy_tlb again when getting scheduled back in. If you have any way
>> to test them, that would be great.
