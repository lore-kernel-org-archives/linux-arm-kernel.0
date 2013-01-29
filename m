From: lizefan@huawei.com (Li Zefan)
Date: Tue, 29 Jan 2013 15:25:26 +0800
Subject: backport patches to 2.6.34 to remove __ARCH_WANT_INTERRUPTS_ON_CTXSW?
Message-ID: <51077966.1060703@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

We got system crashes, and then we managed to trigger the bug within minutes,
and we found this in upstream, which also backported to 2.6.34 stable:

commit cb297a3e433dbdcf7ad81e0564e7b804c941ff0d
Author: Chanho Min <chanho0207@gmail.com>
Date:   Thu Jan 5 20:00:19 2012 +0900

    sched/rt: Fix task stack corruption under __ARCH_WANT_INTERRUPTS_ON_CTXSW

The bug described in this commit resembles to ours. Unfortunately After applying
the fix, we still get crash in hours. We tried to bind each real-time task to a
single cpu to make sure no cpu migration will happen, and it ran without any
problem for ~20 hours.

We're still investigating this issue. One thing I'm doing is backporting patches
that removes __ARCH_WANT_INTERRUPTS_ON_CTXSW. With those patches, I can boot
the kernel, but it hung up when the system automatically start nfs and later
soft-lockup was reported. Things are fine if I disable nfs startup and start it
manually.

So did I miss something when backporting, or is it infeasible to backport them
to 2.6.34? We're using ARMv7. I've attached the patches I backported.

Thanks,
Li Zefan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-Use-TTBR1-instead-of-reserved-context-ID.patch
Type: text/x-diff
Size: 3488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/eed6464f/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-sched-arch-Introduce-the-finish_arch_post_lock_switc.patch
Type: text/x-diff
Size: 1733 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/eed6464f/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-ARM-Remove-__ARCH_WANT_INTERRUPTS_ON_CTXSW-on-ASID-c.patch
Type: text/x-diff
Size: 6790 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/eed6464f/attachment-0002.bin>
