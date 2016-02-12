From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:06:22 +0100
Subject: [PATCH 4/8] ARM: shmobile: Move shmobile_scu_base from .text to .data
In-Reply-To: <cover.1455303757.git.horms+renesas@verge.net.au>
References: <cover.1455303757.git.horms+renesas@verge.net.au>
Message-ID: <797eff54b22b76d9f356074ff3c7ed25d9742e54.1455303757.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

shmobile_scu_base is being written to, so it doesn't belong in the .text
section. Fix this by moving it from asm .text to C .data, as it's no
longer used from asm code since commit 4f6da36f7edd5790 ("ARM: shmobile:
Remove old SCU boot code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/headsmp-scu.S | 6 ------
 arch/arm/mach-shmobile/platsmp-scu.c | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index c0008a5aa4ca..936d7011c314 100644
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
index 64663110ab6c..f2198c9c7435 100644
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
2.7.0.rc3.207.g0ac5344
