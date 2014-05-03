From: rabin@rab.in (Rabin Vincent)
Date: Sat, 3 May 2014 19:39:03 +0200
Subject: [PATCH] ARM: fix v7-M signal return
In-Reply-To: <20140428082757.GD28564@pengutronix.de>
References: <1398103664-23078-1-git-send-email-rabin@rab.in>
 <20140428082757.GD28564@pengutronix.de>
Message-ID: <20140503173903.GA16300@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 10:27:57AM +0200, Uwe Kleine-K?nig wrote:
> This is a valid fix, but it seems on my efm32 the unpredictable
> behaviour is to just discard the LSB. How did you find that? Is it an
> issue on your machine? Which cpu are you using?

I'm running this on QEMU.  Here is an old qemu-devel thread on this
topic if you are interested:
http://lists.gnu.org/archive/html/qemu-devel/2012-03/msg00158.html

> I'd like to have the instruction clearing the thumb bit above the
> comment about the basic exception frame and please add a comment for
> your instruction, too.

OK, here is a v2 with those changes:

8<------------------
>From 4aa76f95a6ecf781eec89dba8a3884e5e4339182 Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabin@rab.in>
Date: Sat, 3 May 2014 19:27:09 +0200
Subject: [PATCHv2] ARM: fix v7-M signal return

According to the ARM ARM, the behaviour is UNDPREDICTABLE if the PC read
from the exception return stack is not half word aligned.  See the
pseudo code for ExceptionReturn() and PopStack().

The signal handler's address has the bit 0 set, and setup_return()
directly writes this to regs->ARM_pc.  Mask out bit 0 before the
exception return to get predictable behaviour.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/entry-header.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 1420725..743dff6 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -132,6 +132,9 @@
 	orrne	r5, V7M_xPSR_FRAMEPTRALIGN
 	biceq	r5, V7M_xPSR_FRAMEPTRALIGN
 
+	@ ensure bit 0 is cleared in the PC
+	bic	r4, r4, #1
+
 	@ write basic exception frame
 	stmdb	r2!, {r1, r3-r5}
 	ldmia	sp, {r1, r3-r5}
-- 
1.9.2
