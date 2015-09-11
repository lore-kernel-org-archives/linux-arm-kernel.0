From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 11 Sep 2015 10:56:17 +0100
Subject: [PATCH 2/2] ARM: domains: add memory dependencies to
 get_domain/set_domain
In-Reply-To: <20150911095438.GL21084@n2100.arm.linux.org.uk>
References: <20150911095438.GL21084@n2100.arm.linux.org.uk>
Message-ID: <E1ZaL45-0003fs-1k@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to have memory dependencies on get_domain/set_domain to avoid
the compiler over-optimising these inline assembly instructions.

Loads/stores must not be reordered across a set_domain(), so introduce
a compiler barrier for that assembly.

The value of get_domain() must not be cached across a set_domain(), but
we still want to allow the compiler to optimise it away.  Introduce a
dependency on current_thread_info()->cpu_domain to avoid this; the new
memory clobber in set_domain() should therefore cause the compiler to
re-load this.  The other advantage of using this is we should have its
address in the register set already, or very soon after at most call
sites.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/domain.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index e878129f2fee..fc8ba1663601 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -12,6 +12,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/barrier.h>
+#include <asm/thread_info.h>
 #endif
 
 /*
@@ -89,7 +90,8 @@ static inline unsigned int get_domain(void)
 
 	asm(
 	"mrc	p15, 0, %0, c3, c0	@ get domain"
-	 : "=r" (domain));
+	 : "=r" (domain)
+	 : "m" (current_thread_info()->cpu_domain));
 
 	return domain;
 }
@@ -98,7 +100,7 @@ static inline void set_domain(unsigned val)
 {
 	asm volatile(
 	"mcr	p15, 0, %0, c3, c0	@ set domain"
-	  : : "r" (val));
+	  : : "r" (val) : "memory");
 	isb();
 }
 
-- 
2.1.0
