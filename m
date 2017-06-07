From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 7 Jun 2017 13:43:33 +0900
Subject: [PATCH v3 1/4] arm64: kgdb: fix single stepping
In-Reply-To: <20170605162925.GO21944@arm.com>
References: <20170523043058.5463-1-takahiro.akashi@linaro.org>
 <20170523043058.5463-2-takahiro.akashi@linaro.org>
 <20170605162925.GO21944@arm.com>
Message-ID: <20170607044331.GD26483@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 05:29:25PM +0100, Will Deacon wrote:
> On Tue, May 23, 2017 at 01:30:55PM +0900, AKASHI Takahiro wrote:
> > After entering kgdb mode, the first 'stepi' can succeed, but the following
> > 'stepi' never executes the next instruction.
> > 
> > This is because a software step cannot get enabled as the software step
> > bit(SS) in SPSR, which is cleared by the first single stepping, will not
> > be set again for the following 's' commands.
> 
> For userspace, we have user_rewind_single_step to re-arm the state machine
> on an unhandled step exception. It sounds like we need the kernel version of
> that?

Bingo. All what we needed here is:
---8<---
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 2122cd187f19..a04c4242c3f8 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -253,6 +253,10 @@ static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 		return DBG_HOOK_ERROR;
 
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
+
+	/* rewind a single step */
+	regs->pstate |= DBG_SPSR_SS;
+
 	return 0;
 }
 NOKPROBE_SYMBOL(kgdb_step_brk_fn);
--->8---

> > Please note that this bit, as well as the software step control bit(SS)
> > in MDSCR, must be set before resuming the execution.
> > kernel_active_single_step() called by kgdb_arch_handle_exception() checks
> > only for the bit in MDSCR, and so kgdb_enable_single_step() will never be
> > called.
> 
> MDSCR.SS shouldn't get cleared by the hardware, so I don't understand your
> point here.

I think I saw some description in ARM ARM, but don't find out any now.
Maybe I confused SPSR.SS with MDSCR.

Thanks,
-Takahiro AKASHI


> Will
