From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:19 +0000
Subject: [RFC v3 PATCH 01/25] ARM: NOMMU: define stubs for fixup
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When build for NOMMU following errors show up:

arch/arm/kernel/patch.c: In function 'patch_map':
arch/arm/kernel/patch.c:39:2: error: implicit declaration of function 'set_fixmap' [-Werror=implicit-function-declaration]
  set_fixmap(fixmap, page_to_phys(page));
  ^
arch/arm/kernel/patch.c:41:2: error: implicit declaration of function '__fix_to_virt' [-Werror=implicit-function-declaration]
  return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
  ^
arch/arm/kernel/patch.c: In function 'patch_unmap':
arch/arm/kernel/patch.c:47:2: error: implicit declaration of function 'clear_fixmap' [-Werror=implicit-function-declaration]
  clear_fixmap(fixmap);
  ^
cc1: some warnings being treated as errors

Fixup does not make much sense in NOMMU configurations, so provide
stub definitions.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/fixmap.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 5c17d2d..0bfc2e3 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -59,6 +59,12 @@ enum fixed_addresses {
 
 #else
 
+#define set_fixmap(idx, phys)
+#define clear_fixmap(idx)
+
+#define __fix_to_virt(x)	(x)
+#define __virt_to_fix(x)	(x)
+
 static inline void early_fixmap_init(void) { }
 
 #endif
-- 
1.7.9.5
