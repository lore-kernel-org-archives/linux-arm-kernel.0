From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Nov 2016 12:39:54 +0000
Subject: [RFC v2 PATCH 12/23] ARM: setup: move call to erratum_a15_798181_init
 under CONFIG_MMU
In-Reply-To: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480423205-48436-13-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building for NOMMU link time error shows up:

arch/arm/kernel/built-in.o: In function `setup_arch':
arch/arm/kernel/smccc-call.o:(.init.text+0xa50): undefined reference to `erratum_a15_798181_init'

It happens because erratum_a15_798181_init() lives under smp_tlb.c
which is build only for MMU configurations. So do call this function
only if build with CONFIG_MMU.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 34e3f3c..2254396 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -717,9 +717,9 @@ static void __init setup_processor(void)
 #endif
 #ifdef CONFIG_MMU
 	init_default_cache_policy(list->__cpu_mm_mmu_flags);
-#endif
-	erratum_a15_798181_init();
 
+	erratum_a15_798181_init();
+#endif
 	elf_hwcap_fixup();
 
 	cacheid_init();
-- 
1.7.9.5
