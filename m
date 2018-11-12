From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:57:12 +0000
Subject: [PATCH v6 21/24] arm64: Handle serror in NMI context
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-22-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per definition of the daifflags, Serrors can occur during any interrupt
context, that includes NMI contexts. Trying to nmi_enter in an nmi context
will crash.

Skip nmi_enter/nmi_exit when serror occurred during an NMI.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/traps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5f4d9ac..66344cd 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -897,13 +897,17 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
 
 asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
 {
-	nmi_enter();
+	const bool was_in_nmi = in_nmi();
+
+	if (!was_in_nmi)
+		nmi_enter();
 
 	/* non-RAS errors are not containable */
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
 		arm64_serror_panic(regs, esr);
 
-	nmi_exit();
+	if (!was_in_nmi)
+		nmi_exit();
 }
 
 void __pte_error(const char *file, int line, unsigned long val)
-- 
1.9.1
