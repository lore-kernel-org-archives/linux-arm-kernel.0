From: jistone@redhat.com (Josh Stone)
Date: Thu, 14 May 2015 12:13:40 -0700
Subject: arm syscall fast path can miss a ptrace syscall-exit
Message-ID: <5554F3E4.8020307@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've discovered a case where both arm and arm64 will miss a ptrace
syscall-exit that they should report.  If the syscall is entered without
TIF_SYSCALL_TRACE set, then it goes on the fast path.  It's then
possible to have TIF_SYSCALL_TRACE added in the middle of the syscall,
but ret_fast_syscall doesn't check this flag again.

For instance, with PTRACE_O_TRACEFORK set, we could enter a fork() and
report PTRACE_EVENT_FORK to the tracer from do_fork(), in the middle of
the syscall.  That tracer may resume with PTRACE_SYSCALL, which sets
TIF_SYSCALL_TRACE; then do_fork() returns, and we *should* then get a
ptrace syscall-exit-stop.  But with arm and arm64, the syscall fast path
doesn't notice the added flag and just returns.

The attached program demonstrates the bug.  Note that it's important not
to have any other slow-path flags either, like TIF_SYSCALL_AUDIT.  On
x86_64, this program outputs:

  event-syscall-exit: stopped 18
  event-syscall-exit: ptrace event 1
  event-syscall-exit: syscall
  event-syscall-exit: stopped 11
  event-syscall-exit: signaled 11

But I confirmed that if you get arm64 on the fast path, that syscall
event will be missing.

Does my diagnosis sound reasonable?  I'm no arm expert, so I hesitate to
attempt patching entry.S myself, but I'd be happy to test patches.

Thanks,
Josh Stone
-------------- next part --------------
A non-text attachment was scrubbed...
Name: event-syscall-exit.c
Type: text/x-csrc
Size: 2048 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150514/7c1f6fb2/attachment.bin>
