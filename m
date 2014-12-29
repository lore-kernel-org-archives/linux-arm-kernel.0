From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:47:05 +0900
Subject: [PATCH 2/4] ARM: shmobile: Fix is_e2 warning
In-Reply-To: <cover.1419810196.git.horms+renesas@verge.net.au>
References: <cover.1419810196.git.horms+renesas@verge.net.au>
Message-ID: <95abc9de7896bf65e67bf781d709ec453f1f5f84.1419810196.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Fix "is_e2" warning introduced by:

9ce3fa6 ARM: shmobile: rcar-gen2: Add CA7 arch_timer initialization for r8a7794

Only triggers on kernel configurations that have ARCH_ARM_TIMER=n.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 3dd6edd..c35b91d 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -52,15 +52,13 @@ void __init rcar_gen2_timer_init(void)
 {
 #if defined(CONFIG_ARM_ARCH_TIMER) || defined(CONFIG_COMMON_CLK)
 	u32 mode = rcar_gen2_read_mode_pins();
-	bool is_e2 = (bool)of_find_compatible_node(NULL, NULL,
-		"renesas,r8a7794");
 #endif
 #ifdef CONFIG_ARM_ARCH_TIMER
 	void __iomem *base;
 	int extal_mhz = 0;
 	u32 freq;
 
-	if (is_e2) {
+	if (of_machine_is_compatible("renesas,r8a7794")) {
 		freq = 260000000 / 8;	/* ZS / 8 */
 		/* CNTVOFF has to be initialized either from non-secure
 		 * Hypervisor mode or secure Monitor mode with SCR.NS==1.
-- 
2.1.3
