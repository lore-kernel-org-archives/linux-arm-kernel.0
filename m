From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 12 Jun 2014 17:09:31 +0200
Subject: [PATCHv5 2/3] ARM: mvebu: move Armada 375 external abort logic as a
 quirk
In-Reply-To: <1402585772-10405-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1402585772-10405-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1402585772-10405-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to a small re-organization of the initialization
sequence in board-v7.c, this commit moves the registration of the
custom external abort handler on Armada 375 later in the boot
sequence, and makes it more similar to the other quirks that we
already have. There is indeed no need to register this abort handler
particularly early, it simply needs to be registered before switching
to userspace.

In addition to this, this commit makes the registration of the custom
abort handler conditional on Armada 375 Z1, because Armada 375 A0 and
later iterations are not affected by the issue.

This commit was tested on both Armada 375 Z1 and Armada 375 A0
platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 8bb742f..804c952 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -78,10 +78,17 @@ static void __init mvebu_timer_and_clk_init(void)
 	mvebu_scu_enable();
 	coherency_init();
 	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
+}
+
+static void __init external_abort_quirk(void)
+{
+	u32 dev, rev;
 
-	if (of_machine_is_compatible("marvell,armada375"))
-		hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
-				"imprecise external abort");
+	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > ARMADA_375_Z1_REV)
+		return;
+
+	hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
+			"imprecise external abort");
 }
 
 static void __init i2c_quirk(void)
@@ -169,8 +176,10 @@ static void __init mvebu_dt_init(void)
 {
 	if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
 		i2c_quirk();
-	if (of_machine_is_compatible("marvell,a375-db"))
+	if (of_machine_is_compatible("marvell,a375-db")) {
+		external_abort_quirk();
 		thermal_quirk();
+	}
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
2.0.0
