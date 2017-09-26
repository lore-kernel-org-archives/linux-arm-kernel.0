From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Sep 2017 15:57:16 +0100
Subject: [PATCH] arm64: Make sure SPsel is always set
Message-ID: <1506437836-18736-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

When the kernel is entered at EL2 on an ARMv8.0 system, we construct
the EL1 pstate and make sure this uses the the EL1 stack pointer
(we perform an exception return to EL1h).

But if the kernel is either entered at EL1 or stays at EL2 (because
we're on a VHE-capable system), we fail to set SPsel, and use whatever
stack selection the higher exception level has choosen for us.

Let's not take any chance, and make sure that SPsel is set to one
before we decide the mode we're going to run in.

Cc: <stable@vger.kernel.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7434ec0c7a27..0b243ecaf7ac 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -384,6 +384,7 @@ ENTRY(kimage_vaddr)
  * booted in EL1 or EL2 respectively.
  */
 ENTRY(el2_setup)
+	msr	SPsel, #1			// We want to use SP_EL{1,2}
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
 	b.eq	1f
-- 
2.1.4
