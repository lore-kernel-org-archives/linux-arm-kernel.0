From: andreiw@motorola.com (Andrei Warkentin)
Date: Wed, 15 Dec 2010 17:45:13 -0600
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
Message-ID: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is my first time on linux-arm-kernel, and while I've read the
FAQ, hopefully I don't screw up too badly :).

Anyway, we're on a dual-core ARMv7 running 2.6.36, and during
stability stress testing saw the following:
1) After a number hotplug iterations, CPU1 fails to set its online bit
quickly enough and __cpu_up() times-out.
2) CPU1 eventually completes its startup and sets the bit, however,
since _cpu_up() failed, CPU1's active bit is never set.
3) On the next call to cpu_down(), the function checks that the online
bit is set and proceeds.
4) The workqueue receives a CPU_DOWN_PENDING notification and creates
a trustee_thread to run on CPU1.
5) Since CPU1's active bit is not set, the scheduler runs the thread
on CPU0 instead and the BUG_ON at kernel/workqueue.c:3111 fires (check
that CPU run on is the desired one)

I have a patch that resolves this in two ways -
1) I only wait with timeouts to make sure the CPU registers the SIPI
and enters secondary_start_kernel. After that we're in "safe"
territory and it doesn't matter how long the rest of initialization
takes. So that puts the waited time into deterministic land.

2) Additionally I ensure that if the CPU comes up later than it were
supposed to (shouldn't, but...), then it will not start initializing
behind cpu_up's back (which is not really undoable). This solves the
problem with both cpu_up+secondary_start_kernel races and with
platform_cpu_kill+secondary_start_kernel races.

Tested this by injecting mdelays into secondary_start_kernel (before
clearing the booting bit and after), and by putting a while(1) into
secondary_start_kernel at different points.

There were concerns brought up that this patch might conflict with all
the ARM SMP work going into .38, so I wanted to check with the list
first.

Thank You,
A
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-Make-SMP-init-more-resilient-to-failures.patch
Type: text/x-patch
Size: 4678 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101215/ec26c93b/attachment.bin>
