From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 28 Apr 2016 17:51:56 +0100
Subject: [PATCH v2 3/3] ARM: domain: move {set,get}_domain under config guard
In-Reply-To: <1461862316-9877-1-git-send-email-vladimir.murzin@arm.com>
References: <1461862316-9877-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461862316-9877-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recursive undefined instrcution falut is seen with R-class taking an
exception. The reson for that is __show_regs() tries to get domain
information, but domains is not available on !MMU cores, like R/M
class.

Fix it by puting {set,get}_domain functions under CONFIG_CPU_CP15_MMU
guard and providing stubs for the case where domains is not supported.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
Changelog:
    v1 -> v2
       - use CPU_CP15_MMU and don't disable SW PAN (per Russell)

arch/arm/include/asm/domain.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index fc8ba16..99d9f63 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -84,6 +84,7 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_CPU_CP15_MMU
 static inline unsigned int get_domain(void)
 {
 	unsigned int domain;
@@ -103,6 +104,16 @@ static inline void set_domain(unsigned val)
 	  : : "r" (val) : "memory");
 	isb();
 }
+#else
+static inline unsigned int get_domain(void)
+{
+	return 0;
+}
+
+static inline void set_domain(unsigned val)
+{
+}
+#endif
 
 #ifdef CONFIG_CPU_USE_DOMAINS
 #define modify_domain(dom,type)					\
-- 
1.7.9.5
