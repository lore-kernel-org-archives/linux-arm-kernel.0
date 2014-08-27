From: behanw@converseincode.com (behanw at converseincode.com)
Date: Tue, 26 Aug 2014 21:29:33 -0700
Subject: [PATCH V2 5/6] arm64: LLVMLinux: Use global stack register variable
 for aarch64
In-Reply-To: <1409113774-3172-1-git-send-email-behanw@converseincode.com>
References: <20140826141608.GT23445@arm.com>
 <1409113774-3172-1-git-send-email-behanw@converseincode.com>
Message-ID: <1409113774-3172-6-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Charlebois <charlebm@gmail.com>

To support both Clang and GCC, use the global stack register variable vs
a local register variable.

Author: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
---
 arch/arm64/include/asm/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 453a179..5279e57 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -26,13 +26,13 @@ static inline void set_my_cpu_offset(unsigned long off)
 static inline unsigned long __my_cpu_offset(void)
 {
 	unsigned long off;
-	register unsigned long *sp asm ("sp");
 
 	/*
 	 * We want to allow caching the value, so avoid using volatile and
 	 * instead use a fake stack read to hazard against barrier().
 	 */
-	asm("mrs %0, tpidr_el1" : "=r" (off) : "Q" (*sp));
+	asm("mrs %0, tpidr_el1" : "=r" (off) :
+		"Q" (*(const unsigned long *)current_stack_pointer));
 
 	return off;
 }
-- 
1.9.1
