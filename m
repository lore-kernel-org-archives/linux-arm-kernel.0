From: m.k.edwards@gmail.com (Michael K. Edwards)
Date: Mon, 13 Jun 2011 10:55:59 -0700
Subject: [Linaro-mm-sig] [RFC 0/2] ARM: DMA-mapping & IOMMU integration
In-Reply-To: <BANLkTikkCV=rWM_Pq6t6EyVRHcWeoMPUqw@mail.gmail.com>
References: <1306308920-8602-1-git-send-email-m.szyprowski@samsung.com>
	<BANLkTi=HtrFETnjk1Zu0v9wqa==r0OALvA@mail.gmail.com>
	<201106131707.49217.arnd@arndb.de>
	<BANLkTikR5AE=-wTWzrSJ0TUaks0_rA3mcg@mail.gmail.com>
	<20110613154033.GA29185@1n450.cable.virginmedia.net>
	<BANLkTikkCV=rWM_Pq6t6EyVRHcWeoMPUqw@mail.gmail.com>
Message-ID: <BANLkTi=C6NKT94Fk6Rq6wmhndVixOqC6mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The need to allocate pages for "write combining" access goes deeper
than anything to do with DMA or IOMMUs.  Please keep "write combine"
distinct from "coherent" in the allocation/mapping APIs.

Write-combining is a special case because it's an end-to-end
requirement, usually architecturally invisible, and getting it to
happen requires a very specific combination of mappings and code.
There's a good explanation here of the requirements on some Intel
implementations of the x86 architecture:
http://software.intel.com/en-us/articles/copying-accelerated-video-decode-frame-buffers/
.  As I understand it, similar considerations apply on at least some
ARMv7 implementations, with NEON multi-register load/store operations
taking the place of MOVNTDQ.  (See
http://www.arm.com/files/pdf/A8_Paper.pdf for instance; although I
don't think there's enough detail about the conditions under which "if
the full cache line is written, the Level-2 line is simply marked
dirty and no external memory requests are required.")

As far as I can tell, there is not yet any way to get real
cache-bypassing write-combining from userland in a mainline kernel,
for x86/x86_64 or ARM.  I have been able to do it from inside a driver
on x86, including in an ISR with some fixes to the kernel's FPU
context save/restore code (patch attached, if you're curious);
otherwise I haven't yet seen write-combining in operation on Linux.
The code that needs to bypass the cache is part of a SoC silicon
erratum workaround supplied by Intel.  It didn't work as delivered --
it oopsed the kernel -- but is now shipping inside our product, and no
problems have been reported from QA or the field.  So I'm fairly sure
that the changes I made are effective.

I am not expert in this area; I was just forced to learn something
about it in order to make a product work.  My assertion that "there's
no way to do it yet" is almost certainly wrong.  I am hoping and
expecting to be immediately contradicted, with a working code example
and benchmarks that show that cache lines are not being fetched,
clobbered, and stored again, with the latencies hidden inside the
cache architecture.  :-)  (Seriously: there are four bits in the
Cortex-A8's "L2 Cache Auxiliary Control Register" that control various
aspects of this mechanism, and if you don't have a fairly good
explanation of which bits do and don't affect your benchmark, then I
contend that the job isn't done.  I don't begin to understand the
equivalent for the multi-core A9 I'm targeting next.)

If some kind person doesn't help me see the error of my ways, I'm
going to have to figure it out for myself on ARM in the next couple of
months, this time for performance reasons rather than to work around
silicon errata.  Unfortunately, I do not expect it to be particularly
low-hanging fruit.  I expect to switch to the hard-float ABI first
(the only remaining obstacle being a couple of TI-supplied binary-only
libraries).  That might provide enough of a system-level performance
win (by allowing the compiler to reorder fetches to NEON registers
across function/method calls) to obviate the need.

Cheers,
- Michael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0011-Clean-up-task-FPU-state-thoroughly-during-exec-and-p.patch
Type: application/octet-stream
Size: 2039 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110613/7461e0e6/attachment.obj>
