From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 30 Jun 2013 02:48:57 +0400
Subject: [PATCH 2/3] ARM: shmobile: r8a7778: add HPB-DMAC support
In-Reply-To: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
References: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
Message-ID: <201306300248.57898.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Max Filippov <max.filippov@cogentembedded.com>

Add HPB-DMAC platform device on R8A7778 SoC along with its slave and channel
configurations.

Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/setup-r8a7778.c |  115 +++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

Index: renesas/arch/arm/mach-shmobile/setup-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -24,6 +24,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/dma-rcar-hpbdma.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/platform_device.h>
@@ -36,6 +37,7 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/dma-mapping.h>
+#include <mach/dma.h>
 #include <mach/irqs.h>
 #include <mach/r8a7778.h>
 #include <mach/common.h>
@@ -333,6 +335,118 @@ void __init r8a7778_add_mmc_device(struc
 		info, sizeof(*info));
 }
 
+/* HPB-DMA */
+
+/* Asynchronous mode register (ASYNCMDR) bits */
+#define	ASYNCMDR_ASMD22_MASK	BIT(2)	/* SDHI0 */
+#define	ASYNCMDR_ASMD22_SINGLE	BIT(2)	/* SDHI0 */
+#define	ASYNCMDR_ASMD22_MULTI	0	/* SDHI0 */
+#define	ASYNCMDR_ASMD21_MASK	BIT(1)	/* SDHI0 */
+#define	ASYNCMDR_ASMD21_SINGLE	BIT(1)	/* SDHI0 */
+#define	ASYNCMDR_ASMD21_MULTI	0	/* SDHI0 */
+
+static const struct hpb_dmae_slave_config hpb_dmae_slaves[] = {
+	{
+		.id	= HPBDMA_SLAVE_SDHI0_TX,
+		.addr	= 0xffe4c000 + 0x30,
+		.dcr	= DCR_SPDS_16BIT | DCR_DMDL | DCR_DPDS_16BIT,
+		.rstr	= ASYNCRSTR_ASRST21 | ASYNCRSTR_ASRST22 |
+			  ASYNCRSTR_ASRST23,
+		.mdr	= ASYNCMDR_ASMD21_SINGLE,
+		.mdm	= ASYNCMDR_ASMD21_MASK,
+		.port	= 0x0D0C,
+		.flags	= HPB_DMAE_SET_ASYNC_RESET | HPB_DMAE_SET_ASYNC_MODE,
+		.dma_ch	= 21,
+	}, {
+		.id	= HPBDMA_SLAVE_SDHI0_RX,
+		.addr	= 0xffe4c000 + 0x30,
+		.dcr	= DCR_SMDL | DCR_SPDS_16BIT | DCR_DPDS_16BIT,
+		.rstr	= ASYNCRSTR_ASRST21 | ASYNCRSTR_ASRST22 |
+			  ASYNCRSTR_ASRST23,
+		.mdr	= ASYNCMDR_ASMD22_SINGLE,
+		.mdm	= ASYNCMDR_ASMD22_MASK,
+		.port	= 0x0D0C,
+		.flags	= HPB_DMAE_SET_ASYNC_RESET | HPB_DMAE_SET_ASYNC_MODE,
+		.dma_ch	= 22,
+	}, {
+		.id	= HPBDMA_SLAVE_SSI0_TX_ST,
+		.addr	= 0xffd90000 + 0x1008,
+		.dcr	= DCR_CT | DCR_DIP | DCR_SPDS_32BIT | DCR_DMDL |
+			  DCR_DPDS_32BIT,
+		.port	= 0x0000,
+		.dma_ch	= 28,
+	}, {
+		.id	= HPBDMA_SLAVE_SSI0_TX_MN,
+		.addr	= 0xffd90000 + 0x1008,
+		.dcr	= DCR_CT | DCR_DIP | DCR_SPDS_16BIT | DCR_DMDL |
+			  DCR_DPDS_16BIT,
+		.port	= 0x0000,
+		.dma_ch	= 28,
+	}, {
+		.id	= HPBDMA_SLAVE_SSI1_RX_ST,
+		.addr	= 0xffd90000 + 0x104c,
+		.dcr	= DCR_CT | DCR_DIP | DCR_SMDL | DCR_SPDS_32BIT |
+			  DCR_DPDAM | DCR_DPDS_32BIT,
+		.port	= 0x0101,
+		.dma_ch	= 29,
+	}, {
+		.id	= HPBDMA_SLAVE_SSI1_RX_MN,
+		.addr	= 0xffd90000 + 0x104c,
+		.dcr	= DCR_CT | DCR_DIP | DCR_SMDL | DCR_SPDS_16BIT |
+			  DCR_DPDAM | DCR_DPDS_16BIT,
+		.port	= 0x0101,
+		.dma_ch	= 29,
+	},
+};
+
+static const struct hpb_dmae_channel hpb_dmae_channels[] = {
+	/* ch.21 SD0 */
+	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_TX),
+	/* ch.22 SD0 */
+	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_RX),
+	/* ch.28 SSI0 */
+	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_SSI0_TX_ST),
+	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_SSI0_TX_MN),
+	/* ch.29 SSI1 */
+	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_SSI1_RX_ST),
+	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_SSI1_RX_MN),
+};
+
+static struct hpb_dmae_pdata dma_platform_data __initdata = {
+	.slaves			= hpb_dmae_slaves,
+	.num_slaves		= ARRAY_SIZE(hpb_dmae_slaves),
+	.channels		= hpb_dmae_channels,
+	.num_channels		= ARRAY_SIZE(hpb_dmae_channels),
+	.ts_shift		= {
+		[XMIT_SZ_8BIT]	= 0,
+		[XMIT_SZ_16BIT]	= 1,
+		[XMIT_SZ_32BIT]	= 2,
+	},
+	.num_hw_channels	= 39,
+};
+
+static struct resource hpb_dmae_resources[] __initdata = {
+	/* Channel registers */
+	DEFINE_RES_MEM(0xffc08000, 0x1000),
+	/* Common registers */
+	DEFINE_RES_MEM(0xffc09000, 0x170),
+	/* Asynchronous reset registers */
+	DEFINE_RES_MEM(0xffc00300, 4),
+	/* Asynchronous mode registers */
+	DEFINE_RES_MEM(0xffc00400, 4),
+	/* IRQ for DMA channels */
+	DEFINE_RES_NAMED(gic_iid(0x7b), 5, NULL, IORESOURCE_IRQ),
+};
+
+static void __init r8a7778_register_hpb_dmae(void)
+{
+	platform_device_register_resndata(&platform_bus, "hpb-dma-engine", -1,
+					  hpb_dmae_resources,
+					  ARRAY_SIZE(hpb_dmae_resources),
+					  &dma_platform_data,
+					  sizeof(dma_platform_data));
+}
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
@@ -355,6 +469,7 @@ void __init r8a7778_add_standard_devices
 
 	r8a7778_register_tmu(0);
 	r8a7778_register_tmu(1);
+	r8a7778_register_hpb_dmae();
 }
 
 void __init r8a7778_init_late(void)
