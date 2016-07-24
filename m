From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:27 -0400
Subject: [PATCH v5 13/15] m68k: fix bFLT executable running on MMU enabled
 systems
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1469374229-21585-14-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@linux-m68k.org>

Even after recent changes to support running flat format executables on
MMU enabled systems (by nicolas.pitre at linaro.org) they still failed to
run on m68k/ColdFire MMU enabled systems. On trying to run a flat format
binary the application would immediately crash with a SIGSEGV.

Code to setup the D5 register with the base of the application data
region was only in the non-MMU code path, so it was not being set for
the MMU enabled case. Flat binaries on m68k/ColdFire use this to support
GOT/PIC flat built application code.

Fix this so that D5 is always setup when loading/running a bFLT executable
on m68k systems.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/m68k/include/asm/flat.h      | 6 ++++++
 arch/m68k/include/asm/processor.h | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/flat.h b/arch/m68k/include/asm/flat.h
index f9454b89a5..f46c2f044f 100644
--- a/arch/m68k/include/asm/flat.h
+++ b/arch/m68k/include/asm/flat.h
@@ -18,4 +18,10 @@ static inline int flat_set_persistent(unsigned long relval,
 	return 0;
 }
 
+#define FLAT_PLAT_INIT(regs) \
+	do { \
+		if (current->mm) \
+			(regs)->d5 = current->mm->start_data; \
+	} while (0)
+
 #endif /* __M68KNOMMU_FLAT_H__ */
diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
index a6ce2ec8d6..46672d1f4d 100644
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -131,8 +131,6 @@ extern int handle_kernel_fault(struct pt_regs *regs);
 do {                                                    \
 	(_regs)->pc = (_pc);                            \
 	setframeformat(_regs);                          \
-	if (current->mm)                                \
-		(_regs)->d5 = current->mm->start_data;  \
 	(_regs)->sr &= ~0x2000;                         \
 	wrusp(_usp);                                    \
 } while(0)
-- 
2.7.4
