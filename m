From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Fri, 18 Sep 2009 00:12:25 +0300
Subject: [RFC] ptrace: system call number interpretation during
	PTRACE_SET_SYSCALL request handling
In-Reply-To: <20090917205221.GC12766@n2100.arm.linux.org.uk>
References: <484047C3.4090509@gmail.com>
	<20080601083036.GD5818@flint.arm.linux.org.uk>
	<cc557aab0909150237u451eaab0v82f08eb65ef706a2@mail.gmail.com>
	<cc557aab0909171341w28b2f5b7ye4145132621051ea@mail.gmail.com>
	<20090917205221.GC12766@n2100.arm.linux.org.uk>
Message-ID: <cc557aab0909171412i1399b56s5e55529f46f40318@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2009 at 11:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 17, 2009 at 11:41:43PM +0300, Kirill A. Shutemov wrote:
>> On Tue, Sep 15, 2009 at 12:37 PM, Kirill A. Shutemov
>> <kirill@shutemov.name> wrote:
>> > On Sun, Jun 1, 2008 at 11:30 AM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> >> On Fri, May 30, 2008 at 09:30:27PM +0300, Volodymyr G. Lukiianyk wrote:
>> >>> I've encountered a problem while running strace on the kernel with
>> >>> CONFIG_AEABI not set. This problem can be worked around in userspace,
>> >>> but it looks like the correct place for a fix is the kernel.
>> >>
>> >> I'm really nervous about this. ?I need to check what my own strace
>> >> patches do - and if they don't suffer from this problem I'd say that
>> >> the bug lies in userspace.
>> >
>> > Any results? Do we need to workaround it in user space or it will be
>> > fixed in kernel?
>>
>> Russell?
>
> I've not really been around much the last three days.
>
> What was the issue again?
>


It's about this patch for strace:

Syscall numbers do not start at 0 for OABI, so need
to mask off the high order bits when changing syscall

Signed-off-by: Steve Bennett <steveb@workware.net.au>

diff --git a/process.c b/process.c
index 23bd413..dd5464f 100644
--- a/process.c
+++ b/process.c
@@ -792,7 +792,7 @@ change_syscall(struct tcb *tcp, int new)
 #  define PTRACE_SET_SYSCALL 23
 # endif

-       if (ptrace (PTRACE_SET_SYSCALL, tcp->pid, 0, new) != 0)
+       if (ptrace (PTRACE_SET_SYSCALL, tcp->pid, 0, new & 0xFFFF) != 0)
               return -1;

       return 0;
--

Should it be applied or kernel will be fixed?
