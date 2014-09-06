From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  5 Sep 2014 17:06:17 -0700
Subject: [PATCH v2 7/7] arm: LLVMLinux: Use global stack register variable for
 percpu
In-Reply-To: <1409961977-11762-1-git-send-email-behanw@converseincode.com>
References: <1409961977-11762-1-git-send-email-behanw@converseincode.com>
Message-ID: <1409961977-11762-8-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Charlebois <charlebm@gmail.com>

Using global current_stack_pointer works on both clang and gcc.
current_stack_pointer is an unsigned long and needs to be cast
as a pointer to dereference.

Signed-off-by: Mark Charlebois <charlebm@gmail.com>
---
 arch/arm/include/asm/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index 209e650..a89b407 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -30,14 +30,14 @@ static inline void set_my_cpu_offset(unsigned long off)
 static inline unsigned long __my_cpu_offset(void)
 {
 	unsigned long off;
-	register unsigned long *sp asm ("sp");
 
 	/*
 	 * Read TPIDRPRW.
 	 * We want to allow caching the value, so avoid using volatile and
 	 * instead use a fake stack read to hazard against barrier().
 	 */
-	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : "Q" (*sp));
+	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off)
+		: "Q" (*(const unsigned long *)current_stack_pointer));
 
 	return off;
 }
-- 
1.9.1
