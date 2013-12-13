From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:35 +0900
Subject: [PATCH 1/3] ARM: shmobile: lager: phy fixup needs CONFIG_PHYLIB
In-Reply-To: <cover.1386899269.git.horms+renesas@verge.net.au>
References: <cover.1386899269.git.horms+renesas@verge.net.au>
Message-ID: <6802cdc58d4fe66cffd6cd04ee55e65dd61eeeeb.1386899269.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not build the phy fixup unless CONFIG_PHYLIB is enabled.

Other than not being useful it is also not possible to link
the code under this condition as phy_register_fixup_for_id(),
mdiobus_read() and mdiobus_write() are absent.

arch/arm/mach-shmobile/built-in.o: In function `lager_ksz8041_fixup':
board-lager.c:(.text+0xb8): undefined reference to `mdiobus_read'
board-lager.c:(.text+0xd4): undefined reference to `mdiobus_write'
arch/arm/mach-shmobile/built-in.o: In function `lager_init':
board-lager.c:(.init.text+0xafc): undefined reference to `phy_register_fixup_for_id'

This problem was introduced by 48c8b96f21817aad
("ARM: shmobile: Lager: add Micrel KSZ8041 PHY fixup")

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index a8d3ce6..e0406fd 100644
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
