From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 14:53:53 +0530
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet controller.
In-Reply-To: <cover.1342171151.git.vipulkumar.samar@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
Message-ID: <214127499f10b0099e6f3542e1e879fdd8c1bdcf.1342171151.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use AUXDATA to pass platform data for Ethernet controller.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    2 +
 arch/arm/mach-spear13xx/include/mach/spear.h   |    1 +
 arch/arm/mach-spear13xx/spear1340.c            |   32 +++++++
 arch/arm/mach-spear13xx/spear13xx.c            |  104 ++++++++++++++++++++++++
 4 files changed, 139 insertions(+), 0 deletions(-)

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
index 65f27de..b0b6f91 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -46,6 +46,7 @@
 #define DMAC0_BASE				UL(0xEA800000)
 #define DMAC1_BASE				UL(0xEB000000)
 #define MCIF_CF_BASE				UL(0xB2800000)
+#define SPEAR13XX_GETH_BASE			UL(0xE2000000)
 
 /* Devices present in SPEAr1310 */
 #ifdef CONFIG_MACH_SPEAR1310
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
index cf936b1..9ab3b47 100644
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
@@ -80,6 +83,107 @@ struct dw_dma_platform_data dmac_plat_data = {
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
+		"phy_syn_gclk",
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
+	if (!pdata)
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
+	ret = clk_set_rate(input_pclk, 125000000);
+	if (IS_ERR_VALUE(ret)) {
+		pr_err("%s:couldn't set rate for input phy clk\n", __func__);
+		goto fail_set_rate;
+	}
+
+	/* Set the Pll-2 as parent for gmac_phy_input_clk */
+	ret = clk_set_parent(input_clk, input_pclk);
+	if (IS_ERR_VALUE(ret)) {
+		pr_err("%s:couldn't set parent for inout phy clk \n", __func__);
+		goto fail_set_rate;
+	}
+	if (pdata->interface == PHY_INTERFACE_MODE_RMII) {
+		/*
+		 * For the rmii interface select gmac_phy_synth_clk
+		 * as the parent and set the clock to 50 Mhz
+		 */
+		phy_pclk = clk_get(NULL, phy_clk_src_name[1]);
+		ret = clk_set_rate(phy_pclk, 50000000);
+		if (IS_ERR_VALUE(ret)) {
+			pr_err("%s:couldn't set rate for phy synth clk\n",
+					__func__);
+			goto fail_set_rate;
+		}
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
+	ret = clk_set_parent(phy_clk, phy_pclk);
+	if (IS_ERR_VALUE(ret)) {
+		pr_err("%s:couldn't set parent for phy clk \n", __func__);
+		goto fail_set_rate;
+	}
+
+	ret = clk_prepare_enable(phy_clk);
+
+	return ret;
+fail_set_rate:
+	clk_put(phy_clk);
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
1.7.2.2
