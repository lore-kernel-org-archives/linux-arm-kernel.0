From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Aug 2011 16:19:36 +0100
Subject: try_to_freeze() called with IRQs disabled on ARM
Message-ID: <20110823151936.GM9232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent series of commits reworking the freezer appear to have
caused serious issues on ARM.  The kernel constantly complains that
try_to_freeze() is bring called with interrupts disabled:

[   75.380000] BUG: sleeping function called from invalid context at include/linux/freezer.h:44
[   75.380000] in_atomic(): 0, irqs_disabled(): 128, pid: 1517, name: Xorg
[   75.380000] no locks held by Xorg/1517.
[   75.380000] [<c0014308>] (unwind_backtrace+0x0/0x12c) from
[<c0464400>] (dump_stack+0x20/0x24)
[   75.380000] [<c0464400>] (dump_stack+0x20/0x24) from [<c0022b80>]
(__might_sleep+0xfc/0x11c)
[   75.380000] [<c0022b80>] (__might_sleep+0xfc/0x11c) from [<c0011520>]
(do_signal+0x94/0x230)
[   75.380000] [<c0011520>] (do_signal+0x94/0x230) from [<c00116e4>]
(do_notify_resume+0x28/0x6c)
[   75.380000] [<c00116e4>] (do_notify_resume+0x28/0x6c) from
[<c000eaf8>] (work_pending+0x24/0x28)

and the boot runs very slowly.  Reverting the series merged in 56f0be
appears to resolve the issue, though looking at the changes I'd expect
there's some underlying bug here that just doesn't trigger very often.
I don't really have the bandwidth to understand what's gone wrong right
now but should be able to run tests if you've got anything you'd like
looking atl.
