From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:19:46 +0900
Subject: [PATCH] ARM: shmobile: kzm9g-reference: Add restart callback
In-Reply-To: <cover.1415756816.git.horms+renesas@verge.net.au>
References: <cover.1415756816.git.horms+renesas@verge.net.au>
Message-ID: <534547c036afad3f23d49d8352896f5d05709685.1415756816.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Port the sh73a0 restart handling from the kzm9g-legacy board code to the
kzm9g-reference board code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index d9cdf9a..0e1de74 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -43,6 +43,13 @@ static void __init kzm_init(void)
 #endif
 }
 
+#define RESCNT2 IOMEM(0xe6188020)
+static void kzm9g_restart(enum reboot_mode mode, const char *cmd)
+{
+	/* Do soft power on reset */
+	writel((1 << 31), RESCNT2);
+}
+
 static const char *kzm9g_boards_compat_dt[] __initdata = {
 	"renesas,kzm9g-reference",
 	NULL,
@@ -54,5 +61,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.init_early	= shmobile_init_delay,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
+	.restart	= kzm9g_restart,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
-- 
2.1.1
