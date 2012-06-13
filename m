From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 13 Jun 2012 14:52:45 +0200
Subject: [PATCH] ARM: Kirkwood: Fix clk problems modular ethernet driver
Message-ID: <1339591965-4741-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the ethernet driver was built as a module, it would lock the
machine when loaded. At boot the ethernet clks are unused, so get
turned off.  Later, when the module is loaded, the probe function
would access the hardware before the clock was restarted, and the
machine would lock. It has also been determined that when the clk is
turned off, the interface forgets its MAC address, which for most
systems, is set by the boot loader.

When the machine setup file creates a platform device for the
interface, prepare and enable the clock for the interface. This will
ensure it is not turned off. However, if the setup file only
instantiates one platform device, the other will have its clk
disabled, thus maybe saving a little power.

Report-by: Simon Baatz <gmbnomis@gmail.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/mach-kirkwood/common.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 97f7d36..4106a5c 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -193,9 +193,11 @@ static struct clk __init *kirkwood_register_gate_fn(const char *name,
 				    bit_idx, 0, &gating_lock, fn);
 }
 
+static struct clk *ge0, *ge1;
+
 void __init kirkwood_clk_init(void)
 {
-	struct clk *runit, *ge0, *ge1, *sata0, *sata1, *usb0, *sdio;
+	struct clk *runit, *sata0, *sata1, *usb0, *sdio;
 	struct clk *crypto, *xor0, *xor1, *pex0, *pex1, *audio;
 
 	tclk = clk_register_fixed_rate(NULL, "tclk", NULL,
@@ -261,6 +263,9 @@ void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 	orion_ge00_init(eth_data,
 			GE00_PHYS_BASE, IRQ_KIRKWOOD_GE00_SUM,
 			IRQ_KIRKWOOD_GE00_ERR);
+	/* The interface forgets the MAC address assigned by u-boot if
+	the clock is turned off, so claim the clk now. */
+	clk_prepare_enable(ge0);
 }
 
 
@@ -272,6 +277,7 @@ void __init kirkwood_ge01_init(struct mv643xx_eth_platform_data *eth_data)
 	orion_ge01_init(eth_data,
 			GE01_PHYS_BASE, IRQ_KIRKWOOD_GE01_SUM,
 			IRQ_KIRKWOOD_GE01_ERR);
+	clk_prepare_enable(ge1);
 }
 
 
-- 
1.7.10
