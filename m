From: wad@chromium.org (Will Drewry)
Date: Wed, 6 Nov 2013 15:20:44 -0600
Subject: [libseccomp-discuss] ARM audit, seccomp,
 etc are broken wrt OABI syscalls
In-Reply-To: <20131106155104.GZ16735@n2100.arm.linux.org.uk>
References: <CALCETrUt7Ojh5Yy4KYgBPj_wBr=fzKKJ=OOgGP9BtXoKrr9QnA@mail.gmail.com>
 <1383751951.28218.64.camel@flatline.rdu.redhat.com>
 <20131106155104.GZ16735@n2100.arm.linux.org.uk>
Message-ID: <CABqD9hbaZhAztYF_H8RTuTdhh+J4WHaGpdRLR3EqHbtH2OLU+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 9:51 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 06, 2013 at 10:32:31AM -0500, Eric Paris wrote:
>> On Tue, 2013-11-05 at 14:36 -0800, Andy Lutomirski wrote:
>> > 1. Set a different audit arch for OABI syscalls (e.g.
>> > AUDIT_ARCH_ARMOABI).  That is, treat OABI syscall entries the same way
>> > that x86_64 treats int 80.
>>
>> As the audit maintainer, I like #1.  It might break ABI, but the ABI is
>> flat wrong now and not maintainable...
>
> If you read the whole thread, you will see that this corner case is just
> not worth the effort to support.  Audit may as well be disabled by
> kernel config if any OABI support is enabled.

This might be the best move for seccomp too (as Kees suggested).  I'd
love to have audit arch visibility, but it's not clear that it's worth
any sort of larger changes ...

... like adding a task_thread_info.compat flag that bubbles up to
syscall_get_arch(), or if we assume consumers of syscall_get_nr() are
broken today (I haven't checked), then it would be possible to at
least re-add the 0x900000 bits, if compat, before handing back the
system call number but leave the audit arch pieces alone.
