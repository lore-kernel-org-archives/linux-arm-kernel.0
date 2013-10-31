From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Oct 2013 15:31:38 +0900
Subject: [PATCH] RM: shmobile: lager: phy fixup needs CONFIG_PHYLIB
Message-ID: <1383201098-4258-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not build the phy fixup unless CONFIG_PHYLIB is enabled.
Other than not being useful it is also not possible to compile
the code under this condition as phy_register_fixup_for_id()
is not defined.

This problem was introduced by 48c8b96f21817aad
("ARM: shmobile: Lager: add Micrel KSZ8041 PHY fixup")

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 78a31b6..d1a8ddd 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -245,7 +245,9 @@ static void __init lager_init(void)
 {
 	lager_add_standard_devices();
 
-	phy_register_fixup_for_id("r8a7790-ether-ff:01", lager_ksz8041_fixup);
+	if (IS_ENABLED(CONFIG_PHYLIB))
+		phy_register_fixup_for_id("r8a7790-ether-ff:01",
+					  lager_ksz8041_fixup);
 }
 
 static const char * const lager_boards_compat_dt[] __initconst = {
-- 
1.8.4
