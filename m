From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 27 Jan 2013 11:40:22 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that kirkwood_ge0[01]_init()
 finds its clock
In-Reply-To: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1611f87 (ARM: Kirkwood: switch to DT clock providers) broke the
functions to initialize the ethernet interfaces (kirkwood_ge00_init() and
kirkwood_ge01_init()).  In the DT case, the functions could not enable the
correct clocks.

Fix this by looking up the clocks through the device name.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/mach-kirkwood/common.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index bac21a5..2c97847 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -218,11 +218,10 @@ static struct clk __init *kirkwood_register_gate_fn(const char *name,
 				    bit_idx, 0, &gating_lock, fn_en, fn_dis);
 }
 
-static struct clk *ge0, *ge1;
 
 void __init kirkwood_clk_init(void)
 {
-	struct clk *runit, *sata0, *sata1, *usb0, *sdio;
+	struct clk *runit, *ge0, *ge1, *sata0, *sata1, *usb0, *sdio;
 	struct clk *crypto, *xor0, *xor1, *pex0, *pex1, *audio;
 
 	tclk = clk_register_fixed_rate(NULL, "tclk", NULL,
@@ -288,12 +287,15 @@ void __init kirkwood_ehci_init(void)
  ****************************************************************************/
 void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 {
+	struct clk *ge0;
 	orion_ge00_init(eth_data,
 			GE00_PHYS_BASE, IRQ_KIRKWOOD_GE00_SUM,
 			IRQ_KIRKWOOD_GE00_ERR, 1600);
 	/* The interface forgets the MAC address assigned by u-boot if
 	the clock is turned off, so claim the clk now. */
-	clk_prepare_enable(ge0);
+	ge0 = clk_get_sys(MV643XX_ETH_NAME ".0", NULL);
+	if (!IS_ERR(ge0))
+		clk_prepare_enable(ge0);
 }
 
 
@@ -302,10 +304,13 @@ void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
  ****************************************************************************/
 void __init kirkwood_ge01_init(struct mv643xx_eth_platform_data *eth_data)
 {
+	struct clk *ge1;
 	orion_ge01_init(eth_data,
 			GE01_PHYS_BASE, IRQ_KIRKWOOD_GE01_SUM,
 			IRQ_KIRKWOOD_GE01_ERR, 1600);
-	clk_prepare_enable(ge1);
+	ge1 = clk_get_sys(MV643XX_ETH_NAME ".1", NULL);
+	if (!IS_ERR(ge1))
+		clk_prepare_enable(ge1);
 }
 
 
-- 
1.7.9.5
