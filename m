From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Tue,  6 Mar 2012 12:45:43 +0400
Subject: [PATCH/RFC 2/2] arm/tegra: add timeout to PCIe PLL lock detection loop
In-Reply-To: <1331023544-6439-1-git-send-email-mad_soft@inbox.ru>
References: <1331023544-6439-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1331023544-6439-3-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra PCIe driver waits for PLL to lock using busy loop.
If PLL fails to lock for some reason, this leads to silent lockup
while booting (as PCIe code is not modular).

Fix by adding timeout, so if PLL doesn't lock in a couple
of seconds, just PCIe driver fails and machine continues to boot.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-tegra/pcie.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 14b29ab..ffdfdd4 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -585,10 +585,10 @@ static void tegra_pcie_setup_translations(void)
 	afi_writel(0, AFI_MSI_BAR_SZ);
 }
 
-static void tegra_pcie_enable_controller(void)
+static int tegra_pcie_enable_controller(void)
 {
 	u32 val, reg;
-	int i;
+	int i, timeout;
 
 	/* Enable slot clock and pulse the reset signals */
 	for (i = 0, reg = AFI_PEX0_CTRL; i < 2; i++, reg += 0x8) {
@@ -639,8 +639,14 @@ static void tegra_pcie_enable_controller(void)
 	pads_writel(0xfa5cfa5c, 0xc8);
 
 	/* Wait for the PLL to lock */
+	timeout = 2000;
 	do {
 		val = pads_readl(PADS_PLL_CTL);
+		mdelay(1);
+		if (--timeout == 0) {
+			pr_err("Tegra PCIe error: timeout waiting for PLL\n");
+			return -EBUSY;
+		}
 	} while (!(val & PADS_PLL_CTL_LOCKDET));
 
 	/* turn off IDDQ override */
@@ -921,7 +927,9 @@ int __init tegra_pcie_init(bool init_port0, bool init_port1)
 	if (err)
 		return err;
 
-	tegra_pcie_enable_controller();
+	err = tegra_pcie_enable_controller();
+	if (err)
+		return err;
 
 	/* setup the AFI address translations */
 	tegra_pcie_setup_translations();
-- 
1.7.5.1.300.gc565c
