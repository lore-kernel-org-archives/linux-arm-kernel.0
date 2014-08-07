From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  6 Aug 2014 21:39:58 -0300
Subject: [PATCH] ARM: mx6: Fix suspend/resume with PCI
Message-ID: <1407371998-11437-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When PCI is used and a suspend/resume sequence is done we see the following
kernel hang:

root at freescale /$ echo mem > /sys/power/state 
[   16.099018] PM: Syncing filesystems ... done.
[   16.141010] Freezing user space processes ... (elapsed 0.002 seconds) done.
[   16.150840] Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
[   16.199438] random: nonblocking pool is initialized
[   16.229639] PM: suspend of devices complete after 64.793 msecs
[   16.235488] PM: suspend devices took 0.070 seconds
[   16.245301] PM: late suspend of devices complete after 4.968 msecs
[   16.257063] PM: noirq suspend of devices complete after 5.538 msecs
[   16.263425] Disabling non-boot CPUs ...
[   16.274666] CPU1: shutdown
[   16.286351] CPU2: shutdown
[   16.294169] CPU3: shutdown
[   16.299551] Enabling non-boot CPUs ...
[   16.304155] CPU1: Booted secondary processor
[   16.305717] CPU1 is up
[   16.313078] CPU2: Booted secondary processor
[   16.313456] CPU2 is up
[   16.320778] CPU3: Booted secondary processor
[   16.321174] CPU3 is up
	(hangs here)

Implement a workaround for the erratum ERR005723: "PCIe does not support L2
Power Down", which consists in toggling bit 18 (TEST_POWERDOWN) of GPR1 register.

Tested on a mx6qsabresd TO1.2 revC2.

Reported-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Richard,

Is there any better method to fix this issue? Or should we do the same
as in the FSL kernel?

I also tried to add pm ops into the imx6 pci driver and did the toggle there,
but I still got the kernel hang.

 arch/arm/mach-imx/pm-imx6.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 5c3af8f..92511cf 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -341,6 +341,23 @@ static int imx6q_suspend_finish(unsigned long val)
 
 static int imx6q_pm_enter(suspend_state_t state)
 {
+	struct regmap *gpr;
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(gpr)) {
+		pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
+		return PTR_ERR(gpr);
+	}
+
+	/*
+	 * L2 can exit by 'reset' or Inband beacon (from remote EP)
+	 * toggling phy_powerdown has same effect as 'inband beacon'
+	 * So, toggle bit18 of GPR1 as a workaround of erratum
+	 * ERR005723 - "PCIe does not support L2 Power Down"
+	 */
+	if (IS_ENABLED(CONFIG_PCI_IMX6) && !cpu_is_imx6sx())
+		regmap_update_bits(gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD,
+				   IMX6Q_GPR1_PCIE_TEST_PD);
+
 	switch (state) {
 	case PM_SUSPEND_STANDBY:
 		imx6q_set_lpm(STOP_POWER_ON);
@@ -383,6 +400,16 @@ static int imx6q_pm_enter(suspend_state_t state)
 		return -EINVAL;
 	}
 
+	/*
+	 * L2 can exit by 'reset' or Inband beacon (from remote EP)
+	 * toggling phy_powerdown has same effect as 'inband beacon'
+	 * So, toggle bit18 of GPR1 as a workaround of erratum
+	 * ERR005723 - "PCIe does not support L2 Power Down"
+	 */
+	if (IS_ENABLED(CONFIG_PCI_IMX6) && !cpu_is_imx6sx())
+		regmap_update_bits(gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD,
+				   !IMX6Q_GPR1_PCIE_TEST_PD);
+
 	return 0;
 }
 
-- 
1.9.1
