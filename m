From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 15:08:02 +0200
Subject: [PATCH] ARM: Use arch_virt_to_idmap() only when available
Message-ID: <1382533682-4835-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch_virt_to_idmap variable is only available when patching of the
physical to virtual translations at runtime is enabled via the Kconfig
ARM_PATCH_PHYS_VIRT option.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/include/asm/memory.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 6748d62..38f2437 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -297,9 +297,11 @@ static inline void *phys_to_virt(phys_addr_t x)
  */
 static inline phys_addr_t __virt_to_idmap(unsigned long x)
 {
+#ifdef CONFIG_ARM_PATCH_VIRT_PHYS
 	if (arch_virt_to_idmap)
 		return arch_virt_to_idmap(x);
 	else
+#endif
 		return __virt_to_phys(x);
 }
 
-- 
1.8.4
