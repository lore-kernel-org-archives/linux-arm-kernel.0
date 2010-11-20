From: ccross@android.com (Colin Cross)
Date: Fri, 19 Nov 2010 18:16:53 -0800
Subject: [PATCH] ARM: Fix spinlock bad magic on disabling nonboot cpu
Message-ID: <1290219413-21026-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init_mm.context.id_lock spinlock is not initialized, which
causes a spinlock bad magic warning when nonboot cpus are disabled,
either through hotplug or during suspend.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/include/asm/mmu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 68870c7..1556f6a 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -13,6 +13,8 @@ typedef struct {
 
 #ifdef CONFIG_CPU_HAS_ASID
 #define ASID(mm)	((mm)->context.id & 255)
+#define INIT_MM_CONTEXT(name)                                                 \
+        .context.id_lock = __SPIN_LOCK_UNLOCKED(name.context.id_lock),
 #else
 #define ASID(mm)	(0)
 #endif
-- 
1.7.3.1
