From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Jun 2014 15:40:22 +0200
Subject: [PATCH 2/4] ARM: shmobile: r8a7791: Add SYS-DMAC support
In-Reply-To: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
References: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1401716424-29740-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables SYS-DMAC0 (= Low), it doesn't support
SYS-DMAC1 (= HI) today.
Because, SYS-DMAC HI/Low interrupt mapping is not
good match to SH-DMAC driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[Geert: Rebased]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/include/mach/r8a7791.h |  5 ++
 arch/arm/mach-shmobile/setup-r8a7791.c        | 81 +++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7791.h b/arch/arm/mach-shmobile/include/mach/r8a7791.h
index 86eae7bceb6f..533999916e73 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7791.h
@@ -1,6 +1,11 @@
 #ifndef __ASM_R8A7791_H__
 #define __ASM_R8A7791_H__
 
+/* DMA slave IDs */
+enum {
+	RCAR_DMA_SLAVE_INVALID,
+};
+
 void r8a7791_add_standard_devices(void);
 void r8a7791_add_dt_devices(void);
 void r8a7791_clock_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 04a96ddb3224..77e1bc2b2870 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -25,13 +25,93 @@
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <mach/common.h>
+#include <mach/dma-register.h>
 #include <mach/irqs.h>
 #include <mach/r8a7791.h>
 #include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
 
+#define DMAE_CHANNEL(a, b)			\
+{						\
+	.offset		= (a) - 0x20,		\
+	.dmars		= (a) - 0x20 + 0x40,	\
+	.chclr_bit	= (b),			\
+	.chclr_offset	= 0x80 - 0x20,		\
+}
+
+/* Sys-DMAC */
+#define SYS_DMAC_SLAVE(_id, _bit, _addr, toffset, roffset, t, r)\
+{								\
+	.slave_id	= SYS_DMAC_SLAVE_## _id ##_TX,		\
+	.addr		= _addr + toffset,			\
+	.chcr		= CHCR_TX(XMIT_SZ_## _bit ##BIT),	\
+	.mid_rid	= t,					\
+}, {								\
+	.slave_id	= SYS_DMAC_SLAVE_## _id ##_RX,		\
+	.addr		= _addr + roffset,			\
+	.chcr		= CHCR_RX(XMIT_SZ_## _bit ##BIT),	\
+	.mid_rid	= r,					\
+}
+
+static const struct sh_dmae_slave_config r8a7791_sys_dmac_slaves[] = {
+};
+
+static const struct sh_dmae_channel r8a7791_sys_dmac_channels[] = {
+	DMAE_CHANNEL(0x8000, 0),
+	DMAE_CHANNEL(0x8080, 1),
+	DMAE_CHANNEL(0x8100, 2),
+	DMAE_CHANNEL(0x8180, 3),
+	DMAE_CHANNEL(0x8200, 4),
+	DMAE_CHANNEL(0x8280, 5),
+	DMAE_CHANNEL(0x8300, 6),
+	DMAE_CHANNEL(0x8380, 7),
+	DMAE_CHANNEL(0x8400, 8),
+	DMAE_CHANNEL(0x8480, 9),
+	DMAE_CHANNEL(0x8500, 10),
+	DMAE_CHANNEL(0x8580, 11),
+	DMAE_CHANNEL(0x8600, 12),
+	DMAE_CHANNEL(0x8680, 13),
+	DMAE_CHANNEL(0x8700, 14),
+};
+
+static struct sh_dmae_pdata r8a7791_sys_dmac_platform_data = {
+	.slave		= r8a7791_sys_dmac_slaves,
+	.slave_num	= ARRAY_SIZE(r8a7791_sys_dmac_slaves),
+	.channel	= r8a7791_sys_dmac_channels,
+	.channel_num	= ARRAY_SIZE(r8a7791_sys_dmac_channels),
+	.ts_low_shift	= TS_LOW_SHIFT,
+	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
+	.ts_high_shift	= TS_HI_SHIFT,
+	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
+	.ts_shift	= dma_ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
+	.dmaor_init	= DMAOR_DME,
+	.chclr_present	= 1,
+	.chclr_bitwise	= 1,
+};
+
+static struct resource r8a7791_sys_dmac_resources[] = {
+	/* Channel registers and DMAOR for low */
+	DEFINE_RES_MEM(0xe6700020, 0x8763 - 0x20),
+	DEFINE_RES_IRQ(gic_spi(197)),
+	DEFINE_RES_NAMED(gic_spi(200), 15, NULL, IORESOURCE_IRQ),
+
+	/*
+	 * HI is not supported
+	 * since IRQ has strange mapping
+	 */
+};
+
+#define r8a7791_register_sys_dmac(id)				\
+	platform_device_register_resndata(			\
+		&platform_bus, "sh-dma-engine", id,		\
+		&r8a7791_sys_dmac_resources[id * 3],	3,	\
+		&r8a7791_sys_dmac_platform_data,		\
+		sizeof(r8a7791_sys_dmac_platform_data))
+
 static const struct resource pfc_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6060000, 0x250),
 };
@@ -205,6 +285,7 @@ void __init r8a7791_add_standard_devices(void)
 	r8a7791_add_dt_devices();
 	r8a7791_register_irqc(0);
 	r8a7791_register_thermal();
+	r8a7791_register_sys_dmac(0);
 }
 
 #ifdef CONFIG_USE_OF
-- 
1.9.1
