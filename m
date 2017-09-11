From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Mon, 11 Sep 2017 22:11:26 +0800
Subject: [PATCH v3 1/3] arm64/ras: support sea error recovery
In-Reply-To: <59B2DE26.4060002@arm.com>
References: <1504770316-4327-1-git-send-email-xiexiuqi@huawei.com>
 <1504770316-4327-2-git-send-email-xiexiuqi@huawei.com>
 <59B2DE26.4060002@arm.com>
Message-ID: <52d2868c-79cd-8ff8-8e1d-6078d02d5a0c@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Thank you very much for your carefully review.

I first describe the approach of this patchset:

A memory access error on the execution path usually triggers SEA.
According to the existing process, errors occurred in the kernel,
leading to direct panic, if it occurred the user-space, we should
just kill process.

But there is a class of error, in fact, is not necessary to kill
process, you can recover and continue to run the process. Such as
the instruction data corrupted, where the memory page might be
read-only, which is has not been modified, the disk might have the
correct data, so you can directly drop the page, ant reload it when
necessary.

So this patchset is just try to solve such problem: if the error is
consumed in user-space and the error occurs on a clean page, you can
directly drop the memory page without killing process.

This is implemented in memory_failure, which is generic process.

memory_failure
  -> hwpoison_user_mappings

	/*
	 * Propagate the dirty bit from PTEs to struct page first, because we
	 * need this to decide if we should kill or just drop the page.
	 * XXX: the dirty test could be racy: set_page_dirty() may not always
	 * be called inside page lock (it's recommended but not enforced).
	 */
	mapping = page_mapping(hpage);
	if (!(flags & MF_MUST_KILL) && !PageDirty(hpage) && mapping &&
	    mapping_cap_writeback_dirty(mapping)) {
		if (page_mkclean(hpage)) {
			SetPageDirty(hpage);
		} else {
			kill = 0;
			ttu |= TTU_IGNORE_HWPOISON;
			pr_info("Memory failure: %#lx: corrupted page was clean: dropped without side effects\n",
				pfn);
		}
	}

The error reported by SEA should be handled before re-enter the process,
or we must kill the process to prevent error propagation.

memory_failure_queue() is asynchronous, in which, error info was saved
at ghes_proc, but handled in kworker. During this period there is a context
switching, so we can not determine which process would be switch to. So
memory_failure_queue is not suitable for handling the problem.

And memory_failure is not nmi-safe, so it can not be called directly in the
SEA context. So we just handle this error at SEA exit path, and before context
switching.

In FFH mode, physical address can only be obtained by parsing the GHES table.
But we only care about SEA, so the error handling is tied to the type of notification.

The TIF flag is checked on a generic path, but it will only be set when SEA occurs.
And if we use unlikely optimization, it should have little impact on performance.

And the TIF flag approach was used on x86 platform for years, until commit d4812e169d
(x86, mce: Get rid of TIF_MCE_NOTIFY and associated mce tricks)[0]. On currently arm64
platform, there is no IST interrupt[1] function, so we could not call memory_failure
directly in SEA context. So the way to use TIF notification, is also a good choice,
after all, the same way on x86 platform is verified.

Any comment is welcome, thanks.

[0] https://patchwork.kernel.org/patch/5571021/
[1] [PATCH v4 0/5] x86: Rework IST interrupts https://lkml.org/lkml/2014/11/21/632

On 2017/9/9 2:15, James Morse wrote:
> Hi Xie XiuQi,
> 
> (Sorry a few versions of this went past before I caught up with it)
> 
> On 07/09/17 08:45, Xie XiuQi wrote:
>> With ARM v8.2 RAS Extension, SEA are usually triggered when memory errors
>> are consumed. In some cases, if the error address is in a clean page or a
>> read-only page, there is a chance to recover. Such as error occurs in a
>> instruction page, we can reread this page from disk instead of killing
>> process.
> 
>> Because memory_failure() may sleep, we can not call it directly in SEA
>> exception context.
> 
> This is why we have memory_failure_queue() instead, it ... bother. That doesn't
> look nmi-safe. (I thought this ended with an llist, but clearly I was looking at
> the wrong thing).
> 
> It doesn't look like this is a problem for NOTIFY_SEA as it would only interrupt
> itself on the same CPU if the memory-failure code/data were corrupt. (which is
> not a case we can handle). We need to fix this before any of the asynchronous
> NMI-like RAS notifications for arm64 get merged.
> 
> (this is one problem, but I don't think its 'the' problem you are trying to
> solve with this series).
> 
> 
>> So we saved faulting physical address associated with
>> a process in the ghes handler and set __TIF_SEA_NOTIFY.
> 
> A per-notification type TIF flag looks fishy, surely this would affect all
> NMI-like RAS notification methods?
> 
> 
>> When we return
>> from SEA exception context and get into do_notify_resume() before the
>> process running, we could check it and call memory_failure() to do
>> recovery. It's safe, because we are in process context.
> 
> I'm afraid I don't think this is the best approach for fixing this.
> Its tied to the notification type, but the notification should be irrelevant
> once we call ghes_proc().
> It adds code poking around in CPER and ACPI/GHES to the arm64 arch code, all of
> this should be in the core common code.
> Most importantly: this means arm64 behaves differently with regard to handling
> memory errors to other architectures using ACPI. Two behaviours means twice the
> code, review and bugs...

Yes, I agree.

I try to avoid the introduction of architecture-related code in CPER and ACPI / GHES,
but CPER_SEC_PROC_ARM is ARM specific, so if you want to do some recovery action,
it will inevitably call the ARM-related function interface. I'll try to optimize it,
and try to reduce the arch specific code introduction.

> 
> 
> Delaying the handling until we re-enter user-space means faults that may affect
> the kernel aren't handled until much later. Just because the fault was
> synchronous and user-space was running doesn't mean only user space is affected.
> Some examples I've collected so far: the zero-page may be corrupt, this is
> mapped into every process and used by the kernel. Similarly corruption in the
> vdso affects all user-space. The fault may affect the page tables, this affects
> all users of the mm_struct.

In fact, compared to the current processing, we did not delay for a long time.

1) For kernel-space errors, TIF flag is ignored, die() is called directly.
2) For user-space errors, the current processing is to send SIGBUS directly.
   In this patchset, the memory_failure() is inserted before do_signal().

And for error itself, memory_failure() could detect the page type and do appropriate action.

> 
> (I'm sure we agree that an synchronous-external-abort interrupting the kernel is
> fatal for the kernel, but the other way round isn't always true).
> 
> Setting a TIF flag to handle the error before re-entering user-space is a
> problem as the scheduler may choose to pre-empt this task and run all the other
> tasks before this eventually gets handled.
> 
> 
> Assuming this is just a problem with memory_failure_queue(), two alternatives I
> can suggest are making memory_failure_queue() nmi-safe, or abstracting
> NOTIFY_NMI's estatus pool/cache to use for the arm64 NMI-like notifications too.
> 
> If there is more to this, can you explain the problem you're trying to solve?
> (I suspect there may be an issue with multiple-signals being merged, or exactly
> when memory_failure_queue()'s work gets run.) Can you outline the sequence of
> events?
> 
> 
> You're picking a physical address out of 'ARM Processor Error Information
> Structure', these correspond with Cache, TLB, Bus or (the mysterious) 'micro
> architectural error'. I don't see anything checking the error type.
> Given the physical address, are you adding error-handling for cache-errors with
> this series?

Yes, we only care about cache-errors. So we could just pick physical address
for cache errors.

> 
> 
> Thanks,
> 
> James
> 
> 
> .
> 

-- 
Thanks,
Xie XiuQi
