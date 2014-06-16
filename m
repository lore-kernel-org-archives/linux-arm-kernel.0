From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 16 Jun 2014 20:27:24 +0900
Subject: [PATCH] ARM: shmobile: rcar-gen2: correct return value of
 shmobile_smp_apmu_suspend_init
Message-ID: <1402918044-29961-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dummy shmobile_smp_apmu_suspend_init() function provided when
CPU_IDLE is not set should not return a value as per the signature
of the function.

This problem appears to have been introduced by
867ba81f728f1daa ("ARM: shmobile: APMU: Add Core-Standby-state for Suspend
to RAM").

Cc: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch resolves the following build warnings:
In file included from arch/arm/mach-shmobile/clock.c:53:0:
arch/arm/mach-shmobile/include/mach/common.h: In function 'shmobile_smp_apmu_suspend_init':
arch/arm/mach-shmobile/include/mach/common.h:41:130: warning: 'return' with a value, in function returning void [enabled by default]
In file included from arch/arm/mach-shmobile/console.c:22:0:
arch/arm/mach-shmobile/include/mach/common.h: In function 'shmobile_smp_apmu_suspend_init':
arch/arm/mach-shmobile/include/mach/common.h:41:130: warning: 'return' with a value, in function returning void [enabled by default]
  CC      arch/arm/mach-shmobile/board-bockw-reference.o
In file included from arch/arm/mach-shmobile/clock-r8a7778.c:43:0:
arch/arm/mach-shmobile/include/mach/common.h: In function 'shmobile_smp_apmu_suspend_init':
arch/arm/mach-shmobile/include/mach/common.h:41:130: warning: 'return' with a value, in function returning void [enabled by default]
In file included from arch/arm/mach-shmobile/board-bockw-reference.c:22:0:
arch/arm/mach-shmobile/include/mach/common.h: In function 'shmobile_smp_apmu_suspend_init':
arch/arm/mach-shmobile/include/mach/common.h:41:130: warning: 'return' with a value, in function returning void [enabled by default]
In file included from arch/arm/mach-shmobile/setup-r8a7778.c:42:0:
arch/arm/mach-shmobile/include/mach/common.h: In function 'shmobile_smp_apmu_suspend_init':
arch/arm/mach-shmobile/include/mach/common.h:41:130: warning: 'return' with a value, in function returning void [enabled by default]
---
 arch/arm/mach-shmobile/include/mach/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 8f0cd57..46766fc 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -38,7 +38,7 @@ int shmobile_suspend_init(void);
 void shmobile_smp_apmu_suspend_init(void);
 #else
 static inline int shmobile_suspend_init(void) { return 0; }
-static inline void shmobile_smp_apmu_suspend_init(void) { return 0; }
+static inline void shmobile_smp_apmu_suspend_init(void) { return; }
 #endif
 
 #ifdef CONFIG_CPU_IDLE
-- 
2.0.0.rc2
