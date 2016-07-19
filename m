From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jul 2016 15:07:39 +0100
Subject: [PATCH 3/4] arm64: kprobes: WARN if attempting to step with PSTATE.D=1
In-Reply-To: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
References: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
Message-ID: <1468937260-23988-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stepping with PSTATE.D=1 is bad news. The step won't generate a debug
exception and we'll likely walk off into random data structures. This
should never happen, but when it does, it's a PITA to debug. Add a
WARN_ON to shout if we realise this is about to take place.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/probes/kprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 9c70e8812ea9..c89811d1e294 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -254,6 +254,8 @@ static void __kprobes setup_singlestep(struct kprobe *p,
 
 		if (kcb->kprobe_status == KPROBE_REENTER)
 			spsr_set_debug_flag(regs, 0);
+		else
+			WARN_ON(regs->pstate & PSR_D_BIT);
 
 		/* IRQs and single stepping do not mix well. */
 		kprobes_save_local_irqflag(kcb, regs);
-- 
2.1.4
