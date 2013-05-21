From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 May 2013 18:41:47 +0200
Subject: [PATCH v4 09/12] ARM: dove: remove legacy mv643xx_eth setup
In-Reply-To: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1369154510-4927-10-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DT support for mv643xx_eth we do not need legacy platform_data
based setup for DT enabled boards anymore.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: David Miller <davem@davemloft.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-dove/board-dt.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index 0b14280..048e942 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -34,10 +34,6 @@ static void __init dove_legacy_clk_init(void)
 	clkspec.np = np;
 	clkspec.args_count = 1;
 
-	clkspec.args[0] = CLOCK_GATING_BIT_GBE;
-	orion_clkdev_add(NULL, "mv643xx_eth_port.0",
-			 of_clk_get_from_provider(&clkspec));
-
 	clkspec.args[0] = CLOCK_GATING_BIT_PCIE0;
 	orion_clkdev_add("0", "pcie",
 			 of_clk_get_from_provider(&clkspec));
@@ -53,10 +49,6 @@ static void __init dove_of_clk_init(void)
 	dove_legacy_clk_init();
 }
 
-static struct mv643xx_eth_platform_data dove_dt_ge00_data = {
-	.phy_addr = MV643XX_ETH_PHY_ADDR_DEFAULT,
-};
-
 static void __init dove_dt_init(void)
 {
 	pr_info("Dove 88AP510 SoC\n");
@@ -70,7 +62,6 @@ static void __init dove_dt_init(void)
 	dove_of_clk_init();
 
 	/* Internal devices not ported to DT yet */
-	dove_ge00_init(&dove_dt_ge00_data);
 	dove_pcie_init(1, 1);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.7.10.4
