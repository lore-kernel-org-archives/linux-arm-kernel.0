From: gangchen@rdamicro.com (Chen Gang)
Date: Tue, 12 May 2015 14:33:06 +0800
Subject: [PATCH 1/1] ARM:r0 is also corrupted after calling __do_div64.
Message-ID: <1431412386-1249-1-git-send-email-gangchen@rdamicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R0 is corrupted after calling __do_div64 and compiler is not informed
about this in macro __do_div_asm. If n is to be used again after this
macro, r0 is not reloaded and n will contain incorrect value

Signed-off-by: Chen Gang <gangchen@rdamicro.com>
---
 arch/arm/include/asm/div64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index a66061a..93a9985 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -34,13 +34,13 @@
 	register unsigned long long __n   asm("r0") = n;	\
 	register unsigned long long __res asm("r2");		\
 	register unsigned int __rem       asm(__xh);		\
-	asm(	__asmeq("%0", __xh)				\
+	asm(	__asmeq("%R0", __xh)				\
 		__asmeq("%1", "r2")				\
 		__asmeq("%2", "r0")				\
 		__asmeq("%3", "r4")				\
 		"bl	__do_div64"				\
-		: "=r" (__rem), "=r" (__res)			\
-		: "r" (__n), "r" (__base)			\
+		: "=r" (__n), "=r" (__res)			\
+		: "0"(__n), "r" (__base)			\
 		: "ip", "lr", "cc");				\
 	n = __res;						\
 	__rem;							\
-- 
1.9.1
