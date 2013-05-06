From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  6 May 2013 17:33:40 +0200
Subject: [PATCH v3 7/7] ARM: kirkwood: remove legacy clk alias for mv643xx_eth
In-Reply-To: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1367854420-8006-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all boards converted to DT enabled mv643xx_eth we can now
remove the clock alias for gbe clocks.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jamie Lentin <jm@lentin.co.uk>
Cc: Michael Walle <michael@walle.cc>
Cc: Eric Hutter <hutter.eric@gmail.com>
Cc: Joshua Coombs <josh.coombs@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Simon Baatz <gmbnomis@gmail.com>
Cc: Alan M Butler <alanbutty12@gmail.com>
Cc: Nigel Roberts <nigel@nobiscuit.com>
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>
Cc: Stefan Peter <s.peter@mpl.ch>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: netdev at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-kirkwood/board-dt.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 7904758..f474cb9 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -42,7 +42,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	struct device_node *np = of_find_compatible_node(
 		NULL, NULL, "marvell,kirkwood-gating-clock");
 	struct of_phandle_args clkspec;
-	struct clk *clk;
 
 	clkspec.np = np;
 	clkspec.args_count = 1;
@@ -58,21 +57,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	clkspec.args[0] = CGC_BIT_SDIO;
 	orion_clkdev_add(NULL, "mvsdio",
 			 of_clk_get_from_provider(&clkspec));
-
-	/*
-	 * The ethernet interfaces forget the MAC address assigned by
-	 * u-boot if the clocks are turned off. Until proper DT support
-	 * is available we always enable them for now.
-	 */
-	clkspec.args[0] = CGC_BIT_GE0;
-	clk = of_clk_get_from_provider(&clkspec);
-	orion_clkdev_add(NULL, "mv643xx_eth_port.0", clk);
-	clk_prepare_enable(clk);
-
-	clkspec.args[0] = CGC_BIT_GE1;
-	clk = of_clk_get_from_provider(&clkspec);
-	orion_clkdev_add(NULL, "mv643xx_eth_port.1", clk);
-	clk_prepare_enable(clk);
 }
 
 static void __init kirkwood_of_clk_init(void)
-- 
1.7.2.5
