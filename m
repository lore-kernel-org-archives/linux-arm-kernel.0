From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Aug 2015 14:31:30 +0100
Subject: [PATCH 4/9] ARM: domains: get rid of manager mode for user domain
In-Reply-To: <20150821133043.GV7557@n2100.arm.linux.org.uk>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZSmPq-0002z5-QI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we switched to early trap initialisation in 94e5a85b3be0
("ARM: earlier initialization of vectors page") we haven't been writing
directly to the vectors page, and so there's no need for this domain
to be in manager mode.  Switch it to client mode.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/domain.h | 2 +-
 arch/arm/kernel/traps.c       | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 4218f88e8f7e..08b601e69ddc 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -59,7 +59,7 @@
 #define domain_val(dom,type)	((type) << (2 * (dom)))
 
 #define DACR_INIT \
-	(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
+	(domain_val(DOMAIN_USER, DOMAIN_CLIENT) | \
 	 domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
 	 domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
 	 domain_val(DOMAIN_IO, DOMAIN_CLIENT))
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index d358226236f2..969f9d9e665f 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -870,7 +870,6 @@ void __init early_trap_init(void *vectors_base)
 	kuser_init(vectors_base);
 
 	flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
-	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
 #else /* ifndef CONFIG_CPU_V7M */
 	/*
 	 * on V7-M there is no need to copy the vector table to a dedicated
-- 
2.1.0
