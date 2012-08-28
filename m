From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 Aug 2012 09:18:36 +0900
Subject: [PATCH] ARM: shmobile: kzm9g: enable restarting
In-Reply-To: <1346113116-20252-1-git-send-email-horms@verge.net.au>
References: <1346113116-20252-1-git-send-email-horms@verge.net.au>
Message-ID: <1346113116-20252-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

Do soft-power-on-reset in sys_reboot system call.

How to test this patch
  Execute "sudo reboot" from command line. The system will start shutdown
  sequence and finally reboot and U-Boot restarts.

Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 53b7ea9..fd21fb6 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -763,6 +763,13 @@ static void __init kzm_init(void)
 	platform_add_devices(kzm_devices, ARRAY_SIZE(kzm_devices));
 }
 
+static void kzm9g_restart(char mode, const char *cmd)
+{
+#define RESCNT2 0xe6188020
+	/* Do soft power on reset */
+	writel((1 << 31), RESCNT2);
+}
+
 static const char *kzm9g_boards_compat_dt[] __initdata = {
 	"renesas,kzm9g",
 	NULL,
@@ -777,5 +784,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g")
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
+	.restart	= kzm9g_restart,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
-- 
1.7.10.2.484.gcd07cc5
