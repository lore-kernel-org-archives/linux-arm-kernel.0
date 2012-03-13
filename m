From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Tue, 13 Mar 2012 09:46:27 +0400
Subject: [PATCH] arm/tegra: pcie: fix return value of function
In-Reply-To: <CAOesGMi0aqCjLsJ5wWXwFVQL2T8wtUuE14rFZ9h7NKHXcWAoqQ@mail.gmail.com>
References: <CAOesGMi0aqCjLsJ5wWXwFVQL2T8wtUuE14rFZ9h7NKHXcWAoqQ@mail.gmail.com>
Message-ID: <1331617587-10714-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In previous patch (arm/tegra: add timeout to PCIe PLL lock detection loop)
tegra_pcie_enable_controller() function type has been changed from
void to int, but the last return statement wasn't converted, so
function returns undefined value. Fix it.

Also while at it, address couple of minor concerns raised by reviewers:
use usleep_range for delay, and lower the value of timeout to 300ms
to be consistent with Nvidia Vibrante kernel.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-tegra/pcie.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 7313059..54a816f 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -639,10 +639,10 @@ static int tegra_pcie_enable_controller(void)
 	pads_writel(0xfa5cfa5c, 0xc8);
 
 	/* Wait for the PLL to lock */
-	timeout = 2000;
+	timeout = 300;
 	do {
 		val = pads_readl(PADS_PLL_CTL);
-		mdelay(1);
+		usleep_range(1000, 1000);
 		if (--timeout == 0) {
 			pr_err("Tegra PCIe error: timeout waiting for PLL\n");
 			return -EBUSY;
@@ -677,7 +677,7 @@ static int tegra_pcie_enable_controller(void)
 	/* Disable all execptions */
 	afi_writel(0, AFI_FPCI_ERROR_MASKS);
 
-	return;
+	return 0;
 }
 
 static void tegra_pcie_xclk_clamp(bool clamp)
-- 
1.7.5.1.300.gc565c
