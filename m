From: rabin@rab.in (Rabin Vincent)
Date: Sun, 4 May 2014 17:36:18 +0200
Subject: [PATCH] ARM: fix v7-M signal return
In-Reply-To: <20140503184512.GO28564@pengutronix.de>
References: <1398103664-23078-1-git-send-email-rabin@rab.in>
 <20140428082757.GD28564@pengutronix.de>
 <20140503173903.GA16300@debian>
 <20140503184512.GO28564@pengutronix.de>
Message-ID: <20140504153618.GA3795@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 03, 2014 at 08:45:12PM +0200, Uwe Kleine-K?nig wrote:
> On Sat, May 03, 2014 at 07:39:03PM +0200, Rabin Vincent wrote:
> > I'm running this on QEMU.  Here is an old qemu-devel thread on this
> > topic if you are interested:
> > http://lists.gnu.org/archive/html/qemu-devel/2012-03/msg00158.html
> I'm interested in your setup and (if applicable) additional kernel
> patches.

No kernel patches are needed other than the ones I already posted.  My
QEMU patches for EFM32 support are needed.  I put together a small
README here: https://github.com/rabinv/qemu-efm32-tools

> > +	@ ensure bit 0 is cleared in the PC
> Maybe add: , otherwise behaviour is unpredictable
> 
> > +	bic	r4, r4, #1
> I just notice that the coding style is inconsitent here, the
> instructions above don't repeat the dest register. Can you please make
> this "bic r4, #1", too?
> 
> With these two changes you can have my ack.

v3 below.

> What happens on qemu without this fix? If it crashes I'd suggest to get
> this patch into 3.15 with a stable annotation. If not I think 3.16-rc1
> is enough.

User space processes crash because qemu's emulation of the CPU does not
discard the zero bit.

8<--------------------
>From 577b0c0e15057f58f86996da7f363c8a608c389f Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabin@rab.in>
Date: Sat, 3 May 2014 19:27:09 +0200
Subject: [PATCHv3] ARM: fix v7-M signal return

According to the ARM ARM, the behaviour is UNDPREDICTABLE if the PC read
from the exception return stack is not half word aligned.  See the
pseudo code for ExceptionReturn() and PopStack().

The signal handler's address has the bit 0 set, and setup_return()
directly writes this to regs->ARM_pc.  Mask out bit 0 before the
exception return to get predictable behaviour.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/entry-header.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 1420725..efb208d 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -132,6 +132,10 @@
 	orrne	r5, V7M_xPSR_FRAMEPTRALIGN
 	biceq	r5, V7M_xPSR_FRAMEPTRALIGN
 
+	@ ensure bit 0 is cleared in the PC, otherwise behaviour is
+	@ unpredictable
+	bic	r4, #1
+
 	@ write basic exception frame
 	stmdb	r2!, {r1, r3-r5}
 	ldmia	sp, {r1, r3-r5}
-- 
2.0.0.rc0
