From: alexander.korolkov@gmail.com (Alexander Korolkov)
Date: Sun, 23 Oct 2011 18:53:02 +0400
Subject: Race condition in switch_to() / set_fs()
Message-ID: <1319381582.2233.5.camel@kor2duo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Seems like I've found a race condition in the ARM implementation of
functions switch_to() and set_fs(). These functions modify the domain
access control (DAC) register and current_thread_info()->cpu_domain
without proper locking.

I have a device based on LPC3250 microcontroller. Recently I've noticed
that epoll_wait() system call sometimes returns -EFAULT. After an
investigation I've found that sometimes __put_user() macro fails, but in
the next system call with exactly the same arguments it works correctly!
Then I've found that when __put_user() fails, DAC register contains a
different value, and it isn't equal to cpu_domain.

My test system:
- one process sending a lot of messages to another process via UNIX
socket (i.e. a lot of context switches)
- ethernet driver which sometimes reads unaligned u32 words

What I observe:

__switch_to():
DAC = next_thread->cpu_domain

       ethernet controller interrupt
       access to unaligned u32
       alignment fixup: do_alignment()
       fs = get_fs();
       set_fs(KERNEL_DS);
       ...
       set_fs(fs);
       DAC = current_thread->cpu_domain
       return from ISR

context switch to next_thread
return from __switch_to()
__put_user() returns -EFAULT
system call returns -EFAULT

My conclusion: all interrupts must be disabled in __switch_to() and
set_fs(), see attachment.

This test is really hard to set up, so I'll try to make a simpler test.
Meanwhile, please write me what do you think about this: is this a real
problem, is my solution correct, is it possible that there are other
similar problems?

A lot of kernel versions is affected, at least from 2.6.22 to 3.0.

With best regards,
Alexander Korolkov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: arm-race-condition-fixup.patch
Type: text/x-patch
Size: 1472 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111023/a341cea8/attachment.bin>
