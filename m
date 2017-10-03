From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  3 Oct 2017 14:10:17 +0900
Subject: [PATCH v4 1/3] arm64: kgdb: fix single stepping
In-Reply-To: <20171003051019.29714-1-takahiro.akashi@linaro.org>
References: <20171003051019.29714-1-takahiro.akashi@linaro.org>
Message-ID: <20171003051019.29714-2-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After entering kgdb mode, the first 'stepi' can succeed, but the following
'stepi' never executes the next instruction.

This is because a software step cannot get enabled as the software step
bit(SS) in SPSR, which is cleared by the first single stepping, will not
be set again for the following 's' commands.
Please note that this bit, as well as the software step control bit(SS)
in MDSCR, must be set before resuming the execution.

If you want to take a single step with interrupts disabled, please try
the following gdb macro:
===8<===
define my-si
	set $instr = *(int *)$pc
	set $opsr = $cpsr
	set $cpsr = $cpsr | 0x80

	stepi

	# If interrupt was enabled before stepi, restore the I flag.
	if !($opsr & 0x80)
		# msr daifset, <val>
		if (($instr & 0xfffff0ff) == 0xd50340df)
			if !($instr & 0x200)
				set $cpsr = $cpsr & ~0x80
			end
		else
			# msr daif, <reg>
			if (($instr & 0xffffffe0) == 0xd51b4220)
				eval "set $val = $x%d", $instr & 0x1f
				if !($val & 0x80)
					set $cpsr = $cpsr & ~0x80
				end
			else
				set $cpsr = $cpsr & ~0x80
			end

		end
	end
end
===>8===

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
---
 arch/arm64/kernel/kgdb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 2122cd187f19..8d3ec8cf4ec4 100644
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
-- 
2.14.1
