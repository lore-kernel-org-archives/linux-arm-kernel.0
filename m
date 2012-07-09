From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Mon, 9 Jul 2012 16:48:58 +0530
Subject: [PATCH 6/6] ARM: SPEAr13xx: Add auxdata for Ethernet controller.
In-Reply-To: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
References: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
Message-ID: <1341832738-27368-1-git-send-email-shiraz.hashim@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

Ethernet phy interface on SPEAr platform requires proper clock sources
and clock rate to be configured. We use AUXDATA presently to pass
callback to the driver to let platform configure the right clocks.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    2 +
 arch/arm/mach-spear13xx/include/mach/spear.h   |    3 +
 arch/arm/mach-spear13xx/spear1340.c            |   32 +++++++++
 arch/arm/mach-spear13xx/spear13xx.c            |   85 ++++++++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index dac57fd..8c8fbaa 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -15,6 +15,7 @@
 #define __MACH_GENERIC_H
 
 #include <linux/dmaengine.h>
+#include <linux/platform_device.h>
 #include <asm/mach/time.h>
 
 /* Add spear13xx structure declarations here */
@@ -31,6 +32,7 @@ void __init spear13xx_map_io(void);
 void __init spear13xx_dt_init_irq(void);
 void __init spear13xx_l2x0_init(void);
 bool dw_dma_filter(struct dma_chan *chan, void *slave);
+int spear13xx_eth_phy_clk_cfg(struct platform_device *pdev);
 void spear_restart(char, const char *);
 void spear13xx_secondary_startup(void);
 
diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
index 65f27de..0ce064b 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -59,4 +59,7 @@
 #define SPEAR_DBG_UART_BASE			UART_BASE
 #define VA_SPEAR_DBG_UART_BASE			VA_UART_BASE
 
+/* Ethernet base address */
+#define SPEAR13XX_GETH_BASE			UL(0xE2000000)
+
 #endif /* __MACH_SPEAR13XX_H */
diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear13xx/spear1340.c
index 81e4ed7..ab282ed 100644
--- a/arch/arm/mach-spear13xx/spear1340.c
+++ b/arch/arm/mach-spear13xx/spear1340.c
@@ -18,6 +18,9 @@
 #include <linux/delay.h>
 #include <linux/dw_dmac.h>
 #include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/stmmac.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <mach/dma.h>
@@ -100,6 +103,34 @@ static struct amba_pl011_data uart1_data = {
 	.dma_rx_param = &uart1_dma_param[1],
 };
 
+/* Ethernet platform data */
+static struct stmmac_mdio_bus_data mdio0_private_data = {
+	.bus_id = 0,
+	.phy_mask = 0,
+};
+
+static struct stmmac_dma_cfg dma0_private_data = {
+	.pbl = 16,
+	.fixed_burst = 1,
+	.burst_len = DMA_AXI_BLEN_ALL,
+};
+
+static struct plat_stmmacenet_data eth_data = {
+	.bus_id = 0,
+	.phy_addr = -1,
+	.interface = PHY_INTERFACE_MODE_RGMII,
+	.has_gmac = 1,
+	.enh_desc = 1,
+	.tx_coe = 1,
+	.dma_cfg = &dma0_private_data,
+	.rx_coe = STMMAC_RX_COE_TYPE2,
+	.bugged_jumbo = 1,
+	.pmt = 1,
+	.mdio_bus_data = &mdio0_private_data,
+	.init = spear13xx_eth_phy_clk_cfg,
+	.clk_csr = STMMAC_CSR_150_250M,
+};
+
 /* SATA device registration */
 static int sata_miphy_init(struct device *dev, void __iomem *addr)
 {
@@ -166,6 +197,7 @@ static struct of_dev_auxdata spear1340_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("snps,spear-ahci", SPEAR1340_SATA_BASE, NULL,
 			&sata_pdata),
 	OF_DEV_AUXDATA("arm,pl011", SPEAR1340_UART1_BASE, NULL, &uart1_data),
+	OF_DEV_AUXDATA("st,spear600-gmac", SPEAR13XX_GETH_BASE, NULL, &eth_data),
 	{}
 };
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index cf936b1..285948a 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -18,6 +18,9 @@
 #include <linux/dw_dmac.h>
 #include <linux/err.h>
 #include <linux/of_irq.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/stmmac.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
@@ -80,6 +83,88 @@ struct dw_dma_platform_data dmac_plat_data = {
 	.chan_priority = CHAN_PRIORITY_DESCENDING,
 };
 
+/* Ethernet clock initialization */
+int spear13xx_eth_phy_clk_cfg(struct platform_device *pdev)
+{
+	int ret;
+	struct clk *input_clk, *input_pclk, *phy_pclk, *phy_clk;
+	struct plat_stmmacenet_data *pdata = dev_get_platdata(&pdev->dev);
+	const char *phy_clk_src_name[] = {
+		"phy_input_mclk",
+		"phy_synth_gclk",
+	};
+	const char *input_clk_src_name[] = {
+		"pll2_clk",
+		"gmii_pad_clk",
+		"osc_25m_clk",
+	};
+	const char *phy_clk_name[] = {
+		"stmmacphy.0"
+	};
+
+	if (pdata == NULL)
+		return -EINVAL;
+
+	/* Get the Pll-2 Clock as parent for PHY Input Clock Source */
+	input_pclk = clk_get(NULL, input_clk_src_name[0]);
+	if (IS_ERR(input_pclk)) {
+		ret = PTR_ERR(input_pclk);
+		goto fail_get_input_pclk;
+	}
+
+	/*
+	 * Get the Phy Input clock source as parent for Phy clock. Default
+	 * selection is gmac_phy_input_clk. This selection would be driving both
+	 * the synthesizer and phy clock.
+	 */
+	input_clk = clk_get(NULL, phy_clk_src_name[0]);
+	if (IS_ERR(input_clk)) {
+		ret = PTR_ERR(input_clk);
+		goto fail_get_input_clk;
+	}
+
+	/* Fetch the phy clock */
+	phy_clk = clk_get(NULL, phy_clk_name[pdata->bus_id]);
+	if (IS_ERR(phy_clk)) {
+		ret = PTR_ERR(phy_clk);
+		goto fail_get_phy_clk;
+	}
+
+	/* Set the pll-2 to 125 MHz */
+	clk_set_rate(input_pclk, 125000000);
+
+	/* Set the Pll-2 as parent for gmac_phy_input_clk */
+	clk_set_parent(input_clk, input_pclk);
+
+	if (pdata->interface == PHY_INTERFACE_MODE_RMII) {
+		/*
+		 * For the rmii interface select gmac_phy_synth_clk
+		 * as the parent and set the clock to 50 Mhz
+		 */
+		phy_pclk = clk_get(NULL, phy_clk_src_name[1]);
+		clk_set_rate(phy_pclk, 50000000);
+	} else {
+		/*
+		 * Set the gmac_phy_input_clk as the parent,
+		 * and pll-2 is already running as parent of
+		 * gmac_phy_input_clk at 125 Mhz
+		 */
+		phy_pclk = input_clk;
+	}
+
+	/* Select the parent for phy clock */
+	clk_set_parent(phy_clk, phy_pclk);
+	ret = clk_prepare_enable(phy_clk);
+
+	return ret;
+fail_get_phy_clk:
+	clk_put(input_clk);
+fail_get_input_clk:
+	clk_put(input_pclk);
+fail_get_input_pclk:
+	return ret;
+}
+
 void __init spear13xx_l2x0_init(void)
 {
 	/*
-- 
1.7.10
