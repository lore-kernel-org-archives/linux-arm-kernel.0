From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 7 Jan 2013 10:09:53 +0530
Subject: [slave-dma:next 10/44] arch/arm/mach-spear13xx/spear1310.c:50:2:
 error: 'DMAC0_BASE' undeclared here (not in a function)
In-Reply-To: <50e9c0da.1vFAsky7xkvAf1HF%fengguang.wu@intel.com>
References: <50e9c0da.1vFAsky7xkvAf1HF%fengguang.wu@intel.com>
Message-ID: <CAKohpo=Z2Y1Vo3T4x3y__Xp_dKETtO-MCQDHhRYNwJ5-YztgVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 6 January 2013 23:52, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   git://git.infradead.org/users/vkoul/slave-dma.git next
> head:   3c1eea5112859d9467a27d4f6671cb3162481420
> commit: 9a1e6fbf2b084ff903d33671b3f7fb09cd633f78 [10/44] ARM: SPEAr13xx: Pass DW DMAC platform data from DT
> config: make ARCH=arm spear13xx_defconfig
>
> All error/warnings:
>
> FATAL ERROR: Unable to parse input tree
> --
> arch/arm/mach-spear13xx/spear1310.c:50:2: error: 'DMAC0_BASE' undeclared here (not in a function)
> arch/arm/mach-spear13xx/spear1310.c:51:2: error: 'DMAC1_BASE' undeclared here (not in a function)

There were multiple issues with the latest rebase done on 3.8-rc2.
Over that there is an issue in
this patch, due to which merge with ARM-SoC tree was broken... I have
fixed rebase
and merge issues in below patch. Please pick it up:

(ARM mail servers are facing some issues now a days and so patch would
be broken,
hence attaching it too)

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 16 Oct 2012 09:49:18 +0530
Subject: [PATCH] ARM: SPEAr13xx: Pass DW DMAC platform data from DT

This patch adds dw_dmac's platform data to DT node. It also creates slave info
node for SPEAr13xx, for the devices which were using dw_dmac.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 arch/arm/boot/dts/spear1340.dtsi             | 19 ++++++++++
 arch/arm/boot/dts/spear13xx.dtsi             | 38 +++++++++++++++++++
 arch/arm/mach-spear13xx/include/mach/spear.h |  2 -
 arch/arm/mach-spear13xx/spear1310.c          |  5 +--
 arch/arm/mach-spear13xx/spear1340.c          | 33 +++++------------
 arch/arm/mach-spear13xx/spear13xx.c          | 55 ++--------------------------
 6 files changed, 72 insertions(+), 80 deletions(-)

diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 34da11a..b2d41b7 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -88,6 +88,25 @@
 			status = "disabled";
 		};

+		dma at ea800000 {
+			slave_info {
+				uart1_tx {
+					bus_id = "uart1_tx";
+					cfg_hi = <0x6000>;	/* 0xC << 11 */
+					cfg_lo = <0>;
+					src_master = <0>;
+					dst_master = <1>;
+				};
+				uart1_tx {
+					bus_id = "uart1_tx";
+					cfg_hi = <0x680>;	/* 0xD << 7 */
+					cfg_lo = <0>;
+					src_master = <1>;
+					dst_master = <0>;
+				};
+			};
+		};
+
 		spi1: spi at 5d400000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x5d400000 0x1000>;
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index b4ca60f..585f641 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -105,6 +105,37 @@
 			reg = <0xea800000 0x1000>;
 			interrupts = <0 19 0x4>;
 			status = "disabled";
+
+			nr_channels = <8>;
+			chan_allocation_order = <1>;
+			chan_priority = <1>;
+			block_size = <0xfff>;
+			nr_masters = <2>;
+			data_width = <3 3 0 0>;
+
+			slave_info {
+				ssp0_tx {
+					bus_id = "ssp0_tx";
+					cfg_hi = <0x2000>;	/* 0x4 << 11 */
+					cfg_lo = <0>;
+					src_master = <0>;
+					dst_master = <0>;
+				};
+				ssp0_rx {
+					bus_id = "ssp0_rx";
+					cfg_hi = <0x280>;	/* 0x5 << 7 */
+					cfg_lo = <0>;
+					src_master = <0>;
+					dst_master = <0>;
+				};
+				cf {
+					bus_id = "cf";
+					cfg_hi = <0>;
+					cfg_lo = <0>;
+					src_master = <0>;
+					dst_master = <0>;
+				};
+			};
 		};

 		dma at eb000000 {
@@ -112,6 +143,13 @@
 			reg = <0xeb000000 0x1000>;
 			interrupts = <0 59 0x4>;
 			status = "disabled";
+
+			nr_channels = <8>;
+			chan_allocation_order = <1>;
+			chan_priority = <1>;
+			block_size = <0xfff>;
+			nr_masters = <2>;
+			data_width = <3 3 0 0>;
 		};

 		fsmc: flash at b0000000 {
diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h
b/arch/arm/mach-spear13xx/include/mach/spear.h
index 7cfa681..972a151 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -43,8 +43,6 @@
 #define VA_L2CC_BASE				IOMEM(UL(0xFB000000))

 /* others */
-#define DMAC0_BASE				UL(0xEA800000)
-#define DMAC1_BASE				UL(0xEB000000)
 #define MCIF_CF_BASE				UL(0xB2800000)

 /* Debug uart for linux, will be used for debug and uncompress messages */
diff --git a/arch/arm/mach-spear13xx/spear1310.c
b/arch/arm/mach-spear13xx/spear1310.c
index 02f4724..ec72c47 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -36,7 +36,7 @@
 static struct arasan_cf_pdata cf_pdata = {
 	.cf_if_clk = CF_IF_CLK_166M,
 	.quirk = CF_BROKEN_UDMA,
-	.dma_priv = &cf_dma_priv,
+	.dma_priv = "cf",
 };

 /* ssp device registration */
@@ -47,10 +47,7 @@ static struct pl022_ssp_controller ssp1_plat_data = {
 /* Add SPEAr1310 auxdata to pass platform data */
 static struct of_dev_auxdata spear1310_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_pdata),
-	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC0_BASE, NULL, &dmac_plat_data),
-	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC1_BASE, NULL, &dmac_plat_data),
 	OF_DEV_AUXDATA("arm,pl022", SSP_BASE, NULL, &pl022_plat_data),
-
 	OF_DEV_AUXDATA("arm,pl022", SPEAR1310_SSP1_BASE, NULL, &ssp1_plat_data),
 	{}
 };
diff --git a/arch/arm/mach-spear13xx/spear1340.c
b/arch/arm/mach-spear13xx/spear1340.c
index 081014f..69c8f72 100644
--- a/arch/arm/mach-spear13xx/spear1340.c
+++ b/arch/arm/mach-spear13xx/spear1340.c
@@ -18,9 +18,9 @@
 #include <linux/delay.h>
 #include <linux/dw_dmac.h>
 #include <linux/of_platform.h>
+#include <linux/pata_arasan_cf_data.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
-#include <mach/dma.h>
 #include <mach/generic.h>
 #include <mach/spear.h>

@@ -78,26 +78,16 @@
 			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
 			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))

-static struct dw_dma_slave uart1_dma_param[] = {
-	{
-		/* Tx */
-		.cfg_hi = DWC_CFGH_DST_PER(SPEAR1340_DMA_REQ_UART1_TX),
-		.cfg_lo = 0,
-		.src_master = DMA_MASTER_MEMORY,
-		.dst_master = SPEAR1340_DMA_MASTER_UART1,
-	}, {
-		/* Rx */
-		.cfg_hi = DWC_CFGH_SRC_PER(SPEAR1340_DMA_REQ_UART1_RX),
-		.cfg_lo = 0,
-		.src_master = SPEAR1340_DMA_MASTER_UART1,
-		.dst_master = DMA_MASTER_MEMORY,
-	}
+static struct amba_pl011_data uart1_data = {
+	.dma_filter = dw_dma_generic_filter,
+	.dma_tx_param = "uart1_tx",
+	.dma_rx_param = "uart1_rx",
 };

-static struct amba_pl011_data uart1_data = {
-	.dma_filter = dw_dma_filter,
-	.dma_tx_param = &uart1_dma_param[0],
-	.dma_rx_param = &uart1_dma_param[1],
+static struct arasan_cf_pdata cf_pdata = {
+	.cf_if_clk = CF_IF_CLK_166M,
+	.quirk = CF_BROKEN_UDMA,
+	.dma_priv = "cf",
 };

 /* SATA device registration */
@@ -158,11 +148,8 @@ static struct ahci_platform_data sata_pdata = {

 /* Add SPEAr1340 auxdata to pass platform data */
 static struct of_dev_auxdata spear1340_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_dma_priv),
-	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC0_BASE, NULL, &dmac_plat_data),
-	OF_DEV_AUXDATA("snps,dma-spear1340", DMAC1_BASE, NULL, &dmac_plat_data),
+	OF_DEV_AUXDATA("arasan,cf-spear1340", MCIF_CF_BASE, NULL, &cf_pdata),
 	OF_DEV_AUXDATA("arm,pl022", SSP_BASE, NULL, &pl022_plat_data),
-
 	OF_DEV_AUXDATA("snps,spear-ahci", SPEAR1340_SATA_BASE, NULL,
 			&sata_pdata),
 	OF_DEV_AUXDATA("arm,pl011", SPEAR1340_UART1_BASE, NULL, &uart1_data),
diff --git a/arch/arm/mach-spear13xx/spear13xx.c
b/arch/arm/mach-spear13xx/spear13xx.c
index c4af775..b074db8 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -22,63 +22,16 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 #include <asm/smp_twd.h>
-#include <mach/dma.h>
 #include <mach/generic.h>
 #include <mach/spear.h>

-/* common dw_dma filter routine to be used by peripherals */
-bool dw_dma_filter(struct dma_chan *chan, void *slave)
-{
-	struct dw_dma_slave *dws = (struct dw_dma_slave *)slave;
-
-	if (chan->device->dev == dws->dma_dev) {
-		chan->private = slave;
-		return true;
-	} else {
-		return false;
-	}
-}
-
 /* ssp device registration */
-static struct dw_dma_slave ssp_dma_param[] = {
-	{
-		/* Tx */
-		.cfg_hi = DWC_CFGH_DST_PER(DMA_REQ_SSP0_TX),
-		.cfg_lo = 0,
-		.src_master = DMA_MASTER_MEMORY,
-		.dst_master = DMA_MASTER_SSP0,
-	}, {
-		/* Rx */
-		.cfg_hi = DWC_CFGH_SRC_PER(DMA_REQ_SSP0_RX),
-		.cfg_lo = 0,
-		.src_master = DMA_MASTER_SSP0,
-		.dst_master = DMA_MASTER_MEMORY,
-	}
-};
-
 struct pl022_ssp_controller pl022_plat_data = {
 	.enable_dma = 1,
-	.dma_filter = dw_dma_filter,
-	.dma_rx_param = &ssp_dma_param[1],
-	.dma_tx_param = &ssp_dma_param[0],
-};
-
-/* CF device registration */
-struct dw_dma_slave cf_dma_priv = {
-	.cfg_hi = 0,
-	.cfg_lo = 0,
-	.src_master = 0,
-	.dst_master = 0,
-};
-
-/* dmac device registeration */
-struct dw_dma_platform_data dmac_plat_data = {
-	.nr_channels = 8,
-	.chan_allocation_order = CHAN_ALLOCATION_DESCENDING,
-	.chan_priority = CHAN_PRIORITY_DESCENDING,
-	.block_size = 4095U,
-	.nr_masters = 2,
-	.data_width = { 3, 3, 0, 0 },
+	.dma_filter = dw_dma_generic_filter,
+	.dma_rx_param = "ssp0_rx",
+	.dma_tx_param = "ssp0_tx",
+	.num_chipselect = 3,
 };

 void __init spear13xx_l2x0_init(void)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-SPEAr13xx-Pass-DW-DMAC-platform-data-from-DT.patch
Type: application/octet-stream
Size: 8485 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130107/3b08b2d0/attachment-0001.obj>
