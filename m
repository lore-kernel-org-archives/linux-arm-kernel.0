From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  5 Jul 2018 15:16:51 +0100
Subject: [PATCHv2 4/7] arm64: ptrace: map SPSR_ELx<->PSR for compat tasks
In-Reply-To: <20180705141654.8714-1-mark.rutland@arm.com>
References: <20180705141654.8714-1-mark.rutland@arm.com>
Message-ID: <20180705141654.8714-5-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPSR_ELx format for exceptions taken from AArch32 is slightly
different to the AArch32 PSR format.

Map between the two in the compat ptrace code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 7206dc93a58fb764 ("arm64: Expose Arm v8.4 features")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/ptrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index fff665988e21..bc07e8ec062b 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1076,6 +1076,7 @@ static int compat_gpr_get(struct task_struct *target,
 			break;
 		case 16:
 			reg = task_pt_regs(target)->pstate;
+			reg = pstate_to_compat_psr(reg);
 			break;
 		case 17:
 			reg = task_pt_regs(target)->orig_x0;
@@ -1143,6 +1144,7 @@ static int compat_gpr_set(struct task_struct *target,
 			newregs.pc = reg;
 			break;
 		case 16:
+			reg = compat_psr_to_pstate(reg);
 			newregs.pstate = reg;
 			break;
 		case 17:
-- 
2.11.0
