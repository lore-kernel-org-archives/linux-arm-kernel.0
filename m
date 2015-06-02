From: gangchen@rdamicro.com (Chen Gang)
Date: Tue,  2 Jun 2015 14:13:29 +0800
Subject: [PATCH 1/1] ARM : missing corrupted reg in __do_div_asm
In-Reply-To: </home/gachen/Re: [PATCH 1_1] ARM:r0 is also corrupted after
 calling __do_div64..eml>
References: </home/gachen/Re: [PATCH 1_1] ARM:r0 is also corrupted after
 calling __do_div64..eml>
Message-ID: <1433225609-7148-1-git-send-email-gangchen@rdamicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__xl (r0 in little endian system, or R1 in big endian system) is corrupted
after calling __do_div64 and compiler is not informed about this in
macro __do_div_asm. If n is used again afterwards, __xl won't be
reloaded and n will contain incorrect value.
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
1.9.1
