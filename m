From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:12:10 +0100
Subject: [PATCH 28/32] ARM: ux500: Pass remnant platform data though to DMA40
 driver
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-29-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ironically, in order to remove lots of the auxdata assignments, we have
to add just one more. A lot of them require DMA information to be passed
into clients for DMA channel allocation, but we now have this capability
in Device Tree. However, the DMA40 driver still relies on a reverse table
look-up to obtain DMA addresses. Until all of the clients are converted,
over to the new API, we're stuck with this.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.h   |    1 +
 arch/arm/mach-ux500/cpu-db8500.c     |    3 +++
 arch/arm/mach-ux500/devices-db8500.c |    2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index d38951b..2c5139d 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -93,6 +93,7 @@ extern struct amba_pl011_data uart0_plat;
 extern struct amba_pl011_data uart1_plat;
 extern struct amba_pl011_data uart2_plat;
 extern struct pl022_ssp_controller ssp0_plat;
+extern struct stedma40_platform_data dma40_plat_data;
 
 extern void mop500_sdi_init(struct device *parent);
 extern void snowball_sdi_init(struct device *parent);
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index eae3e3a..b216233 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -273,6 +273,9 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 		"ux500-msp-i2s.2", &msp2_platform_data),
 	OF_DEV_AUXDATA("stericsson,ux500-msp-i2s", 0x80125000,
 		"ux500-msp-i2s.3", &msp3_platform_data),
+	/* Requires clock name bindings and channel address lookup table. */
+	OF_DEV_AUXDATA("stericsson,db8500-dma40", 0x801C0000,
+		       "dma40.0", &dma40_plat_data),
 	{},
 };
 
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 2fcb8c2..3e4993e 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -120,7 +120,7 @@ static const dma_addr_t dma40_rx_map[DB8500_DMA_NR_DEV] = {
 	[DB8500_DMA_DEV48_CAC1] = U8500_CRYP1_BASE + CRYP1_RX_REG_OFFSET,
 };
 
-static struct stedma40_platform_data dma40_plat_data = {
+struct stedma40_platform_data dma40_plat_data = {
 	.dev_rx = dma40_rx_map,
 	.dev_tx = dma40_tx_map,
 	.disabled_channels = {-1},
-- 
1.7.10.4
