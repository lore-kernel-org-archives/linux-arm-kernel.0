From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 23 Apr 2014 20:08:38 +0100
Subject: [PATCH 29/38] mmc: sdhci-tegra: get rid of special PRESENT_STATE
 register handling
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wd2X8-0003wE-HW@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdhci-tegra provides a get_ro method, which overrides the checking
of the write protect bit in the PRESENT_STATE register in sdhci.c:

        if (host->flags & SDHCI_DEVICE_DEAD)
                is_readonly = 0;
        else if (host->ops->get_ro)
                is_readonly = host->ops->get_ro(host);
        else
                is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
                                & SDHCI_WRITE_PROTECT);

This means it's pointless detecting accesses to this register and
manually setting the SDHCI_WRITE_PROTECT as it has no effect.

This means that the whole of tegra_sdhci_readl() can be removed and
we can use the builtin sdhci readl functionality here.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-tegra.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index d06b6ff60432..985247649f46 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -48,19 +48,6 @@ struct sdhci_tegra {
 	int power_gpio;
 };
 
-static u32 tegra_sdhci_readl(struct sdhci_host *host, int reg)
-{
-	u32 val;
-
-	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
-		/* Use wp_gpio here instead? */
-		val = readl(host->ioaddr + reg);
-		return val | SDHCI_WRITE_PROTECT;
-	}
-
-	return readl(host->ioaddr + reg);
-}
-
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -150,7 +137,6 @@ static void tegra_sdhci_set_bus_width(struct sdhci_host *host, int bus_width)
 
 static const struct sdhci_ops tegra_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
-	.read_l     = tegra_sdhci_readl,
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = sdhci_set_clock,
-- 
1.8.3.1
