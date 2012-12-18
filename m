From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:07:47 +0100
Subject: [PATCH] arm: kirkwood: register DT devices earlier
Message-ID: <1355839667-1487-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board-dt.c initialization functions calls the per-board legacy
init functions (to probe devices that have not yet been converted to
the Device Tree) before probing the devices declared in the Device
Tree.

This unfortunately causes a boot crash on Topkick, because the
board-specific initialization function sets a GPIO to some
value. Unfortunately, since the devices declared in the Device Tree
haven't been probed, the GPIO controllers haven't been probed, and the
gpio_set_value() call causes the following crash:

Unable to handle kernel NULL pointer dereference at virtual address 00000040
pgd = c0004000
[00000040] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0    Not tainted  (3.7.0-rc7-01461-g2ef9d7a-dirty #91)
PC is at __gpio_set_value+0x20/0xb4
LR is at usi_topkick_init+0x18/0x2c

Therefore, we invert the order of initialization: we first probe
Device Tree devices, and then allow per-board initialization functions
to do add more devices if they wish.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/board-dt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index ff4150a..d8a0275 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -97,6 +97,7 @@ static void __init kirkwood_dt_init(void)
 #ifdef CONFIG_KEXEC
 	kexec_reinit = kirkwood_enable_pcie;
 #endif
+	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
 
 	if (of_machine_is_compatible("globalscale,dreamplug"))
 		dreamplug_init();
@@ -146,8 +147,6 @@ static void __init kirkwood_dt_init(void)
 
 	if (of_machine_is_compatible("zyxel,nsa310"))
 		nsa310_init();
-
-	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
 }
 
 static const char * const kirkwood_dt_board_compat[] = {
-- 
1.7.9.5
