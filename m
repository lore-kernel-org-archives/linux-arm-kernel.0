From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 13 Apr 2018 11:02:04 +0100
Subject: [RFC PATCH] arm64: fault: Don't leak data in ESR context for user
 fault on kernel VA
Message-ID: <20180413100204.9674-1-peter.maydell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If userspace faults on a kernel address, handing them the raw ESR
value on the sigframe as part of the delivered signal can leak data
useful to attackers who are using information about the underlying hardware
fault type (e.g. translation vs permission) as a mechanism to defeat KASLR.

However there are also legitimate uses for the information provided
in the ESR -- notably the GCC and LLVM sanitizers would like to be
able to report whether wild pointer accesses by the application are
reads or writes (since a wild write is a more serious bug than a
wild read), so we don't want to drop the ESR information entirely.

For faulting addresses in the kernel, sanitize the ESR. We choose
to present userspace with the illusion that there is nothing mapped
in the kernel's part of the address space at all, by reporting all
faults as level 0 translation faults.

These fields are safe to pass through to userspace as they depend
only on the instruction that userspace used to provoke the fault:
 EC IL ISV SAS SSE SRT SF AR CM WNR
All the other fields in ESR except DFSC are architecturally zero
for an L1 translation fault, so can be zeroed out without confusing
userspace.

The illusion is not entirely perfect, as there is a tiny wrinkle
where we will report an alignment fault that was not due to the memory
type (for instance a LDREX to an unaligned address) as a translation
fault, whereas if you do this on real unmapped memory the alignment
fault takes precedence. This is not likely to trip anybody up in
practice, as the only users we know of for the ESR information who
care about the behaviour for kernel addresses only really want to
know about the WnR bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This RFC patch is an alternative proposal to Will's patch
https://patchwork.kernel.org/patch/10258781/
which simply removed the ESR record entirely for kernel addresses.

 arch/arm64/mm/fault.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index bff11553eb05..933c6d3b906e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -307,6 +307,57 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		__show_regs(regs);
 	}
 
+	/*
+	 * If the faulting address is in the kernel, we must sanitize the ESR.
+	 * From userspace's point of view, kernel-only mappings don't exist
+	 * at all, so we report them as level 0 translation faults.
+	 * (This is not quite the way that "no mapping there at all" behaves:
+	 * an alignment fault not caused by the memory type would take
+	 * precedence over translation fault for a real access to empty
+	 * space. Unfortunately we can't easily distinguish "alignment fault
+	 * not caused by memory type" from "alignment fault caused by memory
+	 * type", so we ignore this wrinkle and just return the translation
+	 * fault.)
+	 */
+	if (addr >= TASK_SIZE) {
+		switch (ESR_ELx_EC(esr)) {
+		case ESR_ELx_EC_DABT_CUR:
+		case ESR_ELx_EC_DABT_LOW:
+			/*
+			 * These bits provide only information about the
+			 * faulting instruction, which userspace knows already.
+			 * All other bits are architecturally required to be
+			 * zero for faults reported with a DFSCR indicating
+			 * a level 0 translation fault.
+			 */
+			esr &= ESR_ELx_EC_MASK | ESR_ELx_IL | ESR_ELx_ISV |
+				ESR_ELx_SAS | ESR_ELx_SSE | ESR_ELx_SRT_MASK |
+				ESR_ELx_SF | ESR_ELx_AR | ESR_ELx_CM |
+				ESR_ELx_WNR;
+			esr |= ESR_ELx_FSC_FAULT;
+			break;
+		case ESR_ELx_EC_IABT_CUR:
+		case ESR_ELx_EC_IABT_LOW:
+			/*
+			 * Claim a level 0 translation fault.
+			 * All other bits are architecturally required to be
+			 * zero for faults reported with that DFSC value.
+			 */
+			esr &= ESR_ELx_EC_MASK | ESR_ELx_IL;
+			esr |= ESR_ELx_FSC_FAULT;
+			break;
+		default:
+			/*
+			 * This should never happen (entry.S only brings us
+			 * into this code for insn and data aborts). Fail
+			 * safe by not providing an ESR context record at all.
+			 */
+			WARN(1, "ESR 0x%x is not DABT or IABT\n", esr);
+			esr = 0;
+			break;
+		}
+	}
+
 	tsk->thread.fault_address = addr;
 	tsk->thread.fault_code = esr;
 	si.si_signo = sig;
-- 
2.16.2
