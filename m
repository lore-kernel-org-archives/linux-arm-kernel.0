From: james.morse@arm.com (James Morse)
Date: Fri, 08 Sep 2017 19:15:02 +0100
Subject: [PATCH v3 1/3] arm64/ras: support sea error recovery
In-Reply-To: <1504770316-4327-2-git-send-email-xiexiuqi@huawei.com>
References: <1504770316-4327-1-git-send-email-xiexiuqi@huawei.com>
 <1504770316-4327-2-git-send-email-xiexiuqi@huawei.com>
Message-ID: <59B2DE26.4060002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xie XiuQi,

(Sorry a few versions of this went past before I caught up with it)

On 07/09/17 08:45, Xie XiuQi wrote:
> With ARM v8.2 RAS Extension, SEA are usually triggered when memory errors
> are consumed. In some cases, if the error address is in a clean page or a
> read-only page, there is a chance to recover. Such as error occurs in a
> instruction page, we can reread this page from disk instead of killing
> process.

> Because memory_failure() may sleep, we can not call it directly in SEA
> exception context.

This is why we have memory_failure_queue() instead, it ... bother. That doesn't
look nmi-safe. (I thought this ended with an llist, but clearly I was looking at
the wrong thing).

It doesn't look like this is a problem for NOTIFY_SEA as it would only interrupt
itself on the same CPU if the memory-failure code/data were corrupt. (which is
not a case we can handle). We need to fix this before any of the asynchronous
NMI-like RAS notifications for arm64 get merged.

(this is one problem, but I don't think its 'the' problem you are trying to
solve with this series).


> So we saved faulting physical address associated with
> a process in the ghes handler and set __TIF_SEA_NOTIFY.

A per-notification type TIF flag looks fishy, surely this would affect all
NMI-like RAS notification methods?


> When we return
> from SEA exception context and get into do_notify_resume() before the
> process running, we could check it and call memory_failure() to do
> recovery. It's safe, because we are in process context.

I'm afraid I don't think this is the best approach for fixing this.
Its tied to the notification type, but the notification should be irrelevant
once we call ghes_proc().
It adds code poking around in CPER and ACPI/GHES to the arm64 arch code, all of
this should be in the core common code.
Most importantly: this means arm64 behaves differently with regard to handling
memory errors to other architectures using ACPI. Two behaviours means twice the
code, review and bugs...


Delaying the handling until we re-enter user-space means faults that may affect
the kernel aren't handled until much later. Just because the fault was
synchronous and user-space was running doesn't mean only user space is affected.
Some examples I've collected so far: the zero-page may be corrupt, this is
mapped into every process and used by the kernel. Similarly corruption in the
vdso affects all user-space. The fault may affect the page tables, this affects
all users of the mm_struct.

(I'm sure we agree that an synchronous-external-abort interrupting the kernel is
fatal for the kernel, but the other way round isn't always true).

Setting a TIF flag to handle the error before re-entering user-space is a
problem as the scheduler may choose to pre-empt this task and run all the other
tasks before this eventually gets handled.


Assuming this is just a problem with memory_failure_queue(), two alternatives I
can suggest are making memory_failure_queue() nmi-safe, or abstracting
NOTIFY_NMI's estatus pool/cache to use for the arm64 NMI-like notifications too.

If there is more to this, can you explain the problem you're trying to solve?
(I suspect there may be an issue with multiple-signals being merged, or exactly
when memory_failure_queue()'s work gets run.) Can you outline the sequence of
events?


You're picking a physical address out of 'ARM Processor Error Information
Structure', these correspond with Cache, TLB, Bus or (the mysterious) 'micro
architectural error'. I don't see anything checking the error type.
Given the physical address, are you adding error-handling for cache-errors with
this series?


Thanks,

James
