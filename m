From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 22 Apr 2016 12:43:36 +0100
Subject: [PATCH 3/3] ARM: domain: move {set,get}_domain under config guard
In-Reply-To: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461325416-29570-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Domains is not available on !MMU cores, like R/M class. However,
currently guarding manages M-class only, for the R-class, in case
of fault we get in recursive "undefined instruction" faulting because
__show_regs() tries to get domain information.

Fix it by extending CONFIG_CPU_USE_DOMAINS on {set,get}_domain
functions and providing stubs for the case where Domains is not
supported.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/domain.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index fc8ba16..a031bb9 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -84,6 +84,8 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_CPU_USE_DOMAINS
+
 static inline unsigned int get_domain(void)
 {
 	unsigned int domain;
@@ -104,7 +106,6 @@ static inline void set_domain(unsigned val)
 	isb();
 }
 
-#ifdef CONFIG_CPU_USE_DOMAINS
 #define modify_domain(dom,type)					\
 	do {							\
 		unsigned int domain = get_domain();		\
@@ -114,6 +115,8 @@ static inline void set_domain(unsigned val)
 	} while (0)
 
 #else
+static inline unsigned int get_domain(void) { return 0;}
+static inline void set_domain(unsigned val) { }
 static inline void modify_domain(unsigned dom, unsigned type)	{ }
 #endif
 
-- 
1.7.9.5
