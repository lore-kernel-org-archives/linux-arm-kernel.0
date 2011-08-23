From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 23 Aug 2011 23:51:55 +0200
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <20110823151936.GM9232@opensource.wolfsonmicro.com>
References: <20110823151936.GM9232@opensource.wolfsonmicro.com>
Message-ID: <201108232351.55432.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 23, 2011, Mark Brown wrote:
> The recent series of commits reworking the freezer appear to have
> caused serious issues on ARM.  The kernel constantly complains that
> try_to_freeze() is bring called with interrupts disabled:
> 
> [   75.380000] BUG: sleeping function called from invalid context at include/linux/freezer.h:44
> [   75.380000] in_atomic(): 0, irqs_disabled(): 128, pid: 1517, name: Xorg
> [   75.380000] no locks held by Xorg/1517.
> [   75.380000] [<c0014308>] (unwind_backtrace+0x0/0x12c) from
> [<c0464400>] (dump_stack+0x20/0x24)
> [   75.380000] [<c0464400>] (dump_stack+0x20/0x24) from [<c0022b80>]
> (__might_sleep+0xfc/0x11c)
> [   75.380000] [<c0022b80>] (__might_sleep+0xfc/0x11c) from [<c0011520>]
> (do_signal+0x94/0x230)
> [   75.380000] [<c0011520>] (do_signal+0x94/0x230) from [<c00116e4>]
> (do_notify_resume+0x28/0x6c)
> [   75.380000] [<c00116e4>] (do_notify_resume+0x28/0x6c) from
> [<c000eaf8>] (work_pending+0x24/0x28)
> 
> and the boot runs very slowly.  Reverting the series merged in 56f0be
> appears to resolve the issue,

In fact, the patch from:

https://patchwork.kernel.org/patch/1083602/

is sufficient to make the calltrace go away.
