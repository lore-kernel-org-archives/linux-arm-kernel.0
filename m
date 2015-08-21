From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Aug 2015 14:31:25 +0100
Subject: [PATCH 3/9] ARM: domains: move initial domain setting value to
 asm/domains.h
In-Reply-To: <20150821133043.GV7557@n2100.arm.linux.org.uk>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZSmPl-0002yx-MO@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/domain.h | 6 ++++++
 arch/arm/kernel/head.S        | 5 +----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 045b9b453bcd..4218f88e8f7e 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -58,6 +58,12 @@
 #define domain_mask(dom)	((3) << (2 * (dom)))
 #define domain_val(dom,type)	((type) << (2 * (dom)))
 
+#define DACR_INIT \
+	(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
+	 domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
+	 domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
+	 domain_val(DOMAIN_IO, DOMAIN_CLIENT))
+
 #ifndef __ASSEMBLY__
 
 static inline unsigned int get_domain(void)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index bd755d97e459..d56e5e9a9e1e 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -461,10 +461,7 @@ __enable_mmu:
 #ifdef CONFIG_ARM_LPAE
 	mcrr	p15, 0, r4, r5, c2		@ load TTBR0
 #else
-	mov	r5, #(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
-		      domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
-		      domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
-		      domain_val(DOMAIN_IO, DOMAIN_CLIENT))
+	mov	r5, #DACR_INIT
 	mcr	p15, 0, r5, c3, c0, 0		@ load domain access register
 	mcr	p15, 0, r4, c2, c0, 0		@ load page table pointer
 #endif
-- 
2.1.0
