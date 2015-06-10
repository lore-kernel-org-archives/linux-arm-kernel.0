From: gangchen@rdamicro.com (Chen Gang)
Date: Wed, 10 Jun 2015 17:53:24 +0800
Subject: [PATCH v2 1/1] ARM : missing corrupted reg in __do_div_asm
Message-ID: <20150610095324.GA29556@localhost.rdamicro.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__xl (R0 in little endian system, or R1 in big endian system) is corrupted
after calling __do_div64 and compiler is not informed about this in
macro __do_div_asm. If n is used again afterwards, __xl won't be
reloaded and n will contain incorrect value.

Signed-off-by: Chen Gang <gangchen@rdamicro.com>
---
 arch/arm/include/asm/div64.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 662c7bd..fa9489e 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -34,12 +34,14 @@
 	register unsigned long long __n   asm("r0") = n;	\
 	register unsigned long long __res asm("r2");		\
 	register unsigned int __rem       asm(__xh);		\
+	register unsigned int __clobber   asm(__xl);		\
 	asm(	__asmeq("%0", __xh)				\
-		__asmeq("%1", "r2")				\
-		__asmeq("%2", "r0")				\
-		__asmeq("%3", "r4")				\
+		__asmeq("%1", __xl)				\
+		__asmeq("%2", "r2")				\
+		__asmeq("%3", "r0")				\
+		__asmeq("%4", "r4")				\
 		"bl	__do_div64"				\
-		: "=r" (__rem), "=r" (__res)			\
+		: "=r" (__rem), "=r" (__clobber), "=r" (__res)  \
 		: "r" (__n), "r" (__base)			\
 		: "ip", "lr", "cc");				\
 	n = __res;						\
-- 
2.4.2
