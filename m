From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 25 Aug 2015 16:41:27 +0100
Subject: [PATCH v2 02/10] ARM: domains: provide domain_mask()
In-Reply-To: <20150825154026.GT7557@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZUGLn-0007sZ-1D@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a macro to generate the mask for a domain, rather than using
domain_val(, DOMAIN_MANAGER) which won't work when CPU_USE_DOMAINS
is turned off.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/domain.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 7f2941905714..045b9b453bcd 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -55,7 +55,8 @@
 #define DOMAIN_MANAGER	1
 #endif
 
-#define domain_val(dom,type)	((type) << (2*(dom)))
+#define domain_mask(dom)	((3) << (2 * (dom)))
+#define domain_val(dom,type)	((type) << (2 * (dom)))
 
 #ifndef __ASSEMBLY__
 
@@ -82,7 +83,7 @@ static inline void set_domain(unsigned val)
 #define modify_domain(dom,type)					\
 	do {							\
 		unsigned int domain = get_domain();		\
-		domain &= ~domain_val(dom, DOMAIN_MANAGER);	\
+		domain &= ~domain_mask(dom);			\
 		domain = domain | domain_val(dom, type);	\
 		set_domain(domain);				\
 	} while (0)
-- 
2.1.0
