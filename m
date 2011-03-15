From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Mar 2011 18:13:15 +0000
Subject: [PATCH] ARMv7: Flush the vectors page using the base address
Message-ID: <20110315181314.26384.97754.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the domains removal patch, the vectors page is populated using the
kernel linear mapping address. However, the flush_icache_range()
function must be called on the high vectors address because the I-cache
is allowed to have aliases (or can even be ASID-tagged VIVT).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: <stable@kernel.org>
---
 arch/arm/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index ee57640..3d520c8 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -791,6 +791,6 @@ void __init early_trap_init(void)
 	memcpy((void *)(vectors + KERN_RESTART_CODE - CONFIG_VECTORS_BASE),
 	       syscall_restart_code, sizeof(syscall_restart_code));
 
-	flush_icache_range(vectors, vectors + PAGE_SIZE);
+	flush_icache_range(CONFIG_VECTORS_BASE, CONFIG_VECTORS_BASE+PAGE_SIZE);
 	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
 }
