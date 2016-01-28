From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 28 Jan 2016 16:04:21 +0100
Subject: [PATCH 1/2] ARM: shmobile: Move shmobile_scu_base from .text to .data
In-Reply-To: <1453993462-12210-1-git-send-email-geert+renesas@glider.be>
References: <1453993462-12210-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1453993462-12210-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

shmobile_scu_base is being written to, so it doesn't belong in the .text
section. Fix this by moving it from asm .text to C .data, as it's no
longer used from asm code since commit 4f6da36f7edd5790 ("ARM: shmobile:
Remove old SCU boot code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/headsmp-scu.S | 6 ------
 arch/arm/mach-shmobile/platsmp-scu.c | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index fa5248c52399c9b5..5e503d91ad70ddf2 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -38,9 +38,3 @@ ENTRY(shmobile_boot_scu)
 
 	b	secondary_startup
 ENDPROC(shmobile_boot_scu)
-
-	.text
-	.align	2
-	.globl	shmobile_scu_base
-shmobile_scu_base:
-	.space	4
diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
index 64663110ab6ca0e1..f2198c9c74359736 100644
--- a/arch/arm/mach-shmobile/platsmp-scu.c
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
@@ -17,6 +17,9 @@
 #include <asm/smp_scu.h>
 #include "common.h"
 
+
+void __iomem *shmobile_scu_base;
+
 static int shmobile_smp_scu_notifier_call(struct notifier_block *nfb,
 					  unsigned long action, void *hcpu)
 {
-- 
1.9.1
