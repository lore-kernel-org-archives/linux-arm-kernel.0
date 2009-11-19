From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 16:48:20 +0100
Subject: [PATCH 06/12] imx-ssi sound driver
In-Reply-To: <1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/Makefile           |    1 +
 arch/arm/plat-mxc/include/mach/ssi.h |   17 +
 arch/arm/plat-mxc/ssi-fiq.S          |  134 ++++
 sound/soc/imx/devdma.c               |   80 ++
 sound/soc/imx/devdma.h               |    3 +
 sound/soc/imx/imx-ssi.c              | 1349 ++++++++++++++++++++++++++++++++++
 sound/soc/imx/imx-ssi.h              |   24 +
 7 files changed, 1608 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/ssi.h
 create mode 100644 arch/arm/plat-mxc/ssi-fiq.S
 create mode 100644 sound/soc/imx/devdma.c
 create mode 100644 sound/soc/imx/devdma.h
 create mode 100644 sound/soc/imx/imx-ssi.c
 create mode 100644 sound/soc/imx/imx-ssi.h

diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index 4cbca9d..1f013ea 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_MXC_PWM)  += pwm.o
 obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
+obj-$(CONFIG_SND_IMX_SOC) += ssi-fiq.o
diff --git a/arch/arm/plat-mxc/include/mach/ssi.h b/arch/arm/plat-mxc/include/mach/ssi.h
new file mode 100644
index 0000000..144a2ac
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/ssi.h
@@ -0,0 +1,17 @@
+#ifndef __MACH_SSI_H
+#define __MACH_SSI_H
+
+struct snd_ac97;
+
+extern unsigned char imx_ssi_fiq_start, imx_ssi_fiq_end;
+extern unsigned long imx_ssi_fiq_base, imx_ssi_fiq_tx_buffer, imx_ssi_fiq_rx_buffer;
+
+struct imx_ssi_platform_data {
+	unsigned int flags;
+#define IMX_SSI_DMA		(1 << 0)
+#define IMX_SSI_USE_AC97	(1 << 1)
+	void (*ac97_reset) (struct snd_ac97 *ac97);
+	void (*ac97_warm_reset)(struct snd_ac97 *ac97);
+};
+
+#endif /* __MACH_SSI_H */
diff --git a/arch/arm/plat-mxc/ssi-fiq.S b/arch/arm/plat-mxc/ssi-fiq.S
new file mode 100644
index 0000000..4ddce56
--- /dev/null
+++ b/arch/arm/plat-mxc/ssi-fiq.S
@@ -0,0 +1,134 @@
+/*
+ *  Copyright (C) 2009 Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/*
+ * r8  = bit 0-15: tx offset, bit 16-31: tx buffer size
+ * r9  = bit 0-15: rx offset, bit 16-31: rx buffer size
+ */
+
+#define SSI_STX0	0x00
+#define SSI_SRX0	0x08
+#define SSI_SISR	0x14
+#define SSI_SIER	0x18
+#define SSI_SACNT	0x38
+
+#define SSI_SACNT_AC97EN	(1 << 0)
+
+#define SSI_SIER_TFE0_EN	(1 << 0)
+#define SSI_SISR_TFE0		(1 << 0)
+#define SSI_SISR_RFF0		(1 << 2)
+#define SSI_SIER_RFF0_EN	(1 << 2)
+
+		.text
+		.global	imx_ssi_fiq_start
+		.global	imx_ssi_fiq_end
+		.global imx_ssi_fiq_base
+		.global imx_ssi_fiq_rx_buffer
+		.global imx_ssi_fiq_tx_buffer
+
+imx_ssi_fiq_start:
+		ldr r12, imx_ssi_fiq_base
+
+		/* TX */
+		ldr r11, imx_ssi_fiq_tx_buffer
+
+		/* shall we send? */
+		ldr r13, [r12, #SSI_SIER]
+		tst r13, #SSI_SIER_TFE0_EN
+		beq 1f
+
+		/* TX FIFO empty? */
+		ldr r13, [r12, #SSI_SISR]
+		tst r13, #SSI_SISR_TFE0
+		beq 1f
+
+		mov r10, #0x10000
+		sub r10, #1
+		and r10, r10, r8	/* r10: current buffer offset */
+
+		add r11, r11, r10
+
+		ldrh r13, [r11]
+		strh r13, [r12, #SSI_STX0]
+
+		ldrh r13, [r11, #2]
+		strh r13, [r12, #SSI_STX0]
+
+		ldrh r13, [r11, #4]
+		strh r13, [r12, #SSI_STX0]
+
+		ldrh r13, [r11, #6]
+		strh r13, [r12, #SSI_STX0]
+
+		add r10, #8
+		lsr r13, r8, #16	/* r13: buffer size */
+		cmp r10, r13
+		lslgt r8, r13, #16
+		addle r8, #8
+1:
+		/* RX */
+
+		/* shall we receive? */
+		ldr r13, [r12, #SSI_SIER]
+		tst r13, #SSI_SIER_RFF0_EN
+		beq 1f
+
+		/* RX FIFO full? */
+		ldr r13, [r12, #SSI_SISR]
+		tst r13, #SSI_SISR_RFF0
+		beq 1f
+
+		ldr r11, imx_ssi_fiq_rx_buffer
+
+		mov r10, #0x10000
+		sub r10, #1
+		and r10, r10, r9	/* r10: current buffer offset */
+
+		add r11, r11, r10
+
+		ldr r13, [r12, #SSI_SACNT]
+		tst r13, #SSI_SACNT_AC97EN
+
+		ldr r13, [r12, #SSI_SRX0]
+		strh r13, [r11]
+
+		ldr r13, [r12, #SSI_SRX0]
+		strh r13, [r11, #2]
+
+		/* dummy read to skip slot 12 */
+		ldrne r13, [r12, #SSI_SRX0]
+
+		ldr r13, [r12, #SSI_SRX0]
+		strh r13, [r11, #4]
+
+		ldr r13, [r12, #SSI_SRX0]
+		strh r13, [r11, #6]
+
+		/* dummy read to skip slot 12 */
+		ldrne r13, [r12, #SSI_SRX0]
+
+		add r10, #8
+		lsr r13, r9, #16	/* r13: buffer size */
+		cmp r10, r13
+		lslgt r9, r13, #16
+		addle r9, #8
+
+1:
+		@ return from FIQ
+		subs	pc, lr, #4
+imx_ssi_fiq_base:
+		.word 0x0
+imx_ssi_fiq_rx_buffer:
+		.word 0x0
+imx_ssi_fiq_tx_buffer:
+		.word 0x0
+imx_ssi_fiq_end:
+
diff --git a/sound/soc/imx/devdma.c b/sound/soc/imx/devdma.c
new file mode 100644
index 0000000..9d1e666
--- /dev/null
+++ b/sound/soc/imx/devdma.c
@@ -0,0 +1,80 @@
+/*
+ *  linux/sound/arm/devdma.c
+ *
+ *  Copyright (C) 2003-2004 Russell King, All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  ARM DMA shim for ALSA.
+ */
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+
+#include "devdma.h"
+
+void devdma_hw_free(struct device *dev, struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dma_buffer *buf = runtime->dma_buffer_p;
+
+	if (runtime->dma_area == NULL)
+		return;
+
+	if (buf != &substream->dma_buffer) {
+		dma_free_coherent(buf->dev.dev, buf->bytes, buf->area, buf->addr);
+		kfree(runtime->dma_buffer_p);
+	}
+
+	snd_pcm_set_runtime_buffer(substream, NULL);
+}
+
+int devdma_hw_alloc(struct device *dev, struct snd_pcm_substream *substream, size_t size)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dma_buffer *buf = runtime->dma_buffer_p;
+	int ret = 0;
+
+	if (buf) {
+		if (buf->bytes >= size)
+			goto out;
+		devdma_hw_free(dev, substream);
+	}
+
+	if (substream->dma_buffer.area != NULL && substream->dma_buffer.bytes >= size) {
+		buf = &substream->dma_buffer;
+	} else {
+		buf = kmalloc(sizeof(struct snd_dma_buffer), GFP_KERNEL);
+		if (!buf)
+			goto nomem;
+
+		buf->dev.type = SNDRV_DMA_TYPE_DEV;
+		buf->dev.dev = dev;
+		buf->area = dma_alloc_coherent(dev, size, &buf->addr, GFP_KERNEL);
+		buf->bytes = size;
+		buf->private_data = NULL;
+
+		if (!buf->area)
+			goto free;
+	}
+	snd_pcm_set_runtime_buffer(substream, buf);
+	ret = 1;
+ out:
+	runtime->dma_bytes = size;
+	return ret;
+
+ free:
+	kfree(buf);
+ nomem:
+	return -ENOMEM;
+}
+
+int devdma_mmap(struct device *dev, struct snd_pcm_substream *substream, struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	return dma_mmap_coherent(dev, vma, runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
+}
diff --git a/sound/soc/imx/devdma.h b/sound/soc/imx/devdma.h
new file mode 100644
index 0000000..d025329
--- /dev/null
+++ b/sound/soc/imx/devdma.h
@@ -0,0 +1,3 @@
+void devdma_hw_free(struct device *dev, struct snd_pcm_substream *substream);
+int devdma_hw_alloc(struct device *dev, struct snd_pcm_substream *substream, size_t size);
+int devdma_mmap(struct device *dev, struct snd_pcm_substream *substream, struct vm_area_struct *vma);
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
new file mode 100644
index 0000000..225379d
--- /dev/null
+++ b/sound/soc/imx/imx-ssi.c
@@ -0,0 +1,1349 @@
+/*
+ * imx-ssi.c  --  ALSA Soc Audio Layer
+ *
+ * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *
+ * The i.MX SSI core has some nasty limitations in AC97 mode. While most
+ * sane processor vendors have a FIFO per AC97 slot, the i.MX has only
+ * one FIFO which combines all valid receive slots. We cannot even select
+ * which slots we want to receive. The WM9712 with which this driver
+ * was developped with always sends GPIO status data in slot 12 which
+ * we receive in our (PCM-) data stream. The only chance we have is to
+ * manually skip this data in the FIQ handler. With sampling rates different
+ * from 48000Hz not every frame has valid receive data, so the ratio
+ * between pcm data and GPIO status data changes. Our FIQ handler is not
+ * able to handle this, hence this driver only works with 48000Hz sampling
+ * rate.
+ * Reading and writing AC97 registers is another challange. The core
+ * provides us status bits when the read register is updated with *another*
+ * value. When we read the same register two times (and the register still
+ * contains the same value) these status bits are not set. We work
+ * around this by not polling these bits but only wait a fixed delay.
+ * 
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/fiq.h>
+
+#include <mach/dma-mx1-mx2.h>
+#include <mach/ssi.h>
+
+#include "devdma.h"
+#include "imx-ssi.h"
+#include "../codecs/ac97.h"
+
+#define DRV_NAME "imx-ssi"
+
+#define DMA_RXFIFO_BURST      0x4
+#define DMA_TXFIFO_BURST      0x6
+
+#ifdef CONFIG_MACH_MX27
+#define IMX_SSI_MX1_MX2_DMA
+#define use_dma(ssi)	(ssi->flags & IMX_SSI_DMA) 
+#else
+#define use_dma(ssi)	0
+#endif
+
+#define SSI_STX0	0x00
+#define SSI_STX1	0x04
+#define SSI_SRX0	0x08
+#define SSI_SRX1	0x0c
+
+#define SSI_SCR		0x10
+#define SSI_SCR_CLK_IST		(1 << 9)
+#define SSI_SCR_CLK_IST_SHIFT	9
+#define SSI_SCR_TCH_EN		(1 << 8)
+#define SSI_SCR_SYS_CLK_EN	(1 << 7)
+#define SSI_SCR_I2S_MODE_NORM	(0 << 5)
+#define SSI_SCR_I2S_MODE_MSTR	(1 << 5)
+#define SSI_SCR_I2S_MODE_SLAVE	(2 << 5)
+#define SSI_I2S_MODE_MASK	(3 << 5)
+#define SSI_SCR_SYN		(1 << 4)
+#define SSI_SCR_NET		(1 << 3)
+#define SSI_SCR_RE		(1 << 2)
+#define SSI_SCR_TE		(1 << 1)
+#define SSI_SCR_SSIEN		(1 << 0)
+
+#define SSI_SISR	0x14
+#define SSI_SISR_MASK		((1 << 19) - 1)
+#define SSI_SISR_CMDAU		(1 << 18)
+#define SSI_SISR_CMDDU		(1 << 17)
+#define SSI_SISR_RXT		(1 << 16)
+#define SSI_SISR_RDR1		(1 << 15)
+#define SSI_SISR_RDR0		(1 << 14)
+#define SSI_SISR_TDE1		(1 << 13)
+#define SSI_SISR_TDE0		(1 << 12)
+#define SSI_SISR_ROE1		(1 << 11)
+#define SSI_SISR_ROE0		(1 << 10)
+#define SSI_SISR_TUE1		(1 << 9)
+#define SSI_SISR_TUE0		(1 << 8)
+#define SSI_SISR_TFS		(1 << 7)
+#define SSI_SISR_RFS		(1 << 6)
+#define SSI_SISR_TLS		(1 << 5)
+#define SSI_SISR_RLS		(1 << 4)
+#define SSI_SISR_RFF1		(1 << 3)
+#define SSI_SISR_RFF0		(1 << 2)
+#define SSI_SISR_TFE1		(1 << 1)
+#define SSI_SISR_TFE0		(1 << 0)
+
+#define SSI_SIER	0x18
+#define SSI_SIER_RDMAE		(1 << 22)
+#define SSI_SIER_RIE		(1 << 21)
+#define SSI_SIER_TDMAE		(1 << 20)
+#define SSI_SIER_TIE		(1 << 19)
+#define SSI_SIER_CMDAU_EN	(1 << 18)
+#define SSI_SIER_CMDDU_EN	(1 << 17)
+#define SSI_SIER_RXT_EN		(1 << 16)
+#define SSI_SIER_RDR1_EN	(1 << 15)
+#define SSI_SIER_RDR0_EN	(1 << 14)
+#define SSI_SIER_TDE1_EN	(1 << 13)
+#define SSI_SIER_TDE0_EN	(1 << 12)
+#define SSI_SIER_ROE1_EN	(1 << 11)
+#define SSI_SIER_ROE0_EN	(1 << 10)
+#define SSI_SIER_TUE1_EN	(1 << 9)
+#define SSI_SIER_TUE0_EN	(1 << 8)
+#define SSI_SIER_TFS_EN		(1 << 7)
+#define SSI_SIER_RFS_EN		(1 << 6)
+#define SSI_SIER_TLS_EN		(1 << 5)
+#define SSI_SIER_RLS_EN		(1 << 4)
+#define SSI_SIER_RFF1_EN	(1 << 3)
+#define SSI_SIER_RFF0_EN	(1 << 2)
+#define SSI_SIER_TFE1_EN	(1 << 1)
+#define SSI_SIER_TFE0_EN	(1 << 0)
+
+#define SSI_STCR	0x1c
+#define SSI_STCR_TXBIT0		(1 << 9)
+#define SSI_STCR_TFEN1		(1 << 8)
+#define SSI_STCR_TFEN0		(1 << 7)
+#define SSI_FIFO_ENABLE_0_SHIFT 7
+#define SSI_STCR_TFDIR		(1 << 6)
+#define SSI_STCR_TXDIR		(1 << 5)
+#define SSI_STCR_TSHFD		(1 << 4)
+#define SSI_STCR_TSCKP		(1 << 3)
+#define SSI_STCR_TFSI		(1 << 2)
+#define SSI_STCR_TFSL		(1 << 1)
+#define SSI_STCR_TEFS		(1 << 0)
+
+#define SSI_SRCR	0x20
+#define SSI_SRCR_RXBIT0		(1 << 9)
+#define SSI_SRCR_RFEN1		(1 << 8)
+#define SSI_SRCR_RFEN0		(1 << 7)
+#define SSI_FIFO_ENABLE_0_SHIFT 7
+#define SSI_SRCR_RFDIR		(1 << 6)
+#define SSI_SRCR_RXDIR		(1 << 5)
+#define SSI_SRCR_RSHFD		(1 << 4)
+#define SSI_SRCR_RSCKP		(1 << 3)
+#define SSI_SRCR_RFSI		(1 << 2)
+#define SSI_SRCR_RFSL		(1 << 1)
+#define SSI_SRCR_REFS		(1 << 0)
+
+#define SSI_SRCCR		0x28
+#define SSI_SRCCR_DIV2		(1 << 18)
+#define SSI_SRCCR_PSR		(1 << 17)
+#define SSI_SRCCR_WL(x)		((((x) - 2) >> 1) << 13)
+#define SSI_SRCCR_DC(x)		(((x) & 0x1f) << 8)
+#define SSI_SRCCR_PM(x)		(((x) & 0xff) << 0)
+#define SSI_SRCCR_WL_MASK	(0xf << 13)
+#define SSI_SRCCR_DC_MASK	(0x1f << 8)
+#define SSI_SRCCR_PM_MASK	(0xff << 0)
+
+#define SSI_STCCR		0x24
+#define SSI_STCCR_DIV2		(1 << 18)
+#define SSI_STCCR_PSR		(1 << 17)
+#define SSI_STCCR_WL(x)		((((x) - 2) >> 1) << 13)
+#define SSI_STCCR_DC(x)		(((x) & 0x1f) << 8)
+#define SSI_STCCR_PM(x)		(((x) & 0xff) << 0)
+#define SSI_STCCR_WL_MASK	(0xf << 13)
+#define SSI_STCCR_DC_MASK	(0x1f << 8)
+#define SSI_STCCR_PM_MASK	(0xff << 0)
+
+#define SSI_SFCSR	0x2c
+#define SSI_SFCSR_RFCNT1(x)	(((x) & 0xf) << 28)
+#define SSI_RX_FIFO_1_COUNT_SHIFT 28
+#define SSI_SFCSR_TFCNT1(x)	(((x) & 0xf) << 24)
+#define SSI_TX_FIFO_1_COUNT_SHIFT 24
+#define SSI_SFCSR_RFWM1(x)	(((x) & 0xf) << 20)
+#define SSI_SFCSR_TFWM1(x)	(((x) & 0xf) << 16)
+#define SSI_SFCSR_RFCNT0(x)	(((x) & 0xf) << 12)
+#define SSI_RX_FIFO_0_COUNT_SHIFT 12
+#define SSI_SFCSR_TFCNT0(x)	(((x) & 0xf) <<  8)
+#define SSI_TX_FIFO_0_COUNT_SHIFT 8
+#define SSI_SFCSR_RFWM0(x)	(((x) & 0xf) <<  4)
+#define SSI_SFCSR_TFWM0(x)	(((x) & 0xf) <<  0)
+#define SSI_SFCSR_RFWM0_MASK	(0xf <<  4)
+#define SSI_SFCSR_TFWM0_MASK	(0xf <<  0)
+
+#define SSI_STR		0x30
+#define SSI_STR_TEST		(1 << 15)
+#define SSI_STR_RCK2TCK		(1 << 14)
+#define SSI_STR_RFS2TFS		(1 << 13)
+#define SSI_STR_RXSTATE(x)	(((x) & 0xf) << 8)
+#define SSI_STR_TXD2RXD		(1 <<  7)
+#define SSI_STR_TCK2RCK		(1 <<  6)
+#define SSI_STR_TFS2RFS		(1 <<  5)
+#define SSI_STR_TXSTATE(x)	(((x) & 0xf) << 0)
+
+#define SSI_SOR		0x34
+#define SSI_SOR_CLKOFF		(1 << 6)
+#define SSI_SOR_RX_CLR		(1 << 5)
+#define SSI_SOR_TX_CLR		(1 << 4)
+#define SSI_SOR_INIT		(1 << 3)
+#define SSI_SOR_WAIT(x)		(((x) & 0x3) << 1)
+#define SSI_SOR_WAIT_MASK	(0x3 << 1)
+#define SSI_SOR_SYNRST		(1 << 0)
+
+#define SSI_SACNT	0x38
+#define SSI_SACNT_FRDIV(x)	(((x) & 0x3f) << 5)
+#define SSI_SACNT_WR		(1 << 4)
+#define SSI_SACNT_RD		(1 << 3)
+#define SSI_SACNT_TIF		(1 << 2)
+#define SSI_SACNT_FV		(1 << 1)
+#define SSI_SACNT_AC97EN	(1 << 0)
+
+#define SSI_SACADD	0x3c
+#define SSI_SACDAT	0x40
+#define SSI_SATAG	0x44
+#define SSI_STMSK	0x48
+#define SSI_SRMSK	0x4c
+#define SSI_SACCST	0x50
+#define SSI_SACCEN	0x54
+#define SSI_SACCDIS	0x58
+
+#define SSI_SACNT_DEFAULT (SSI_SACNT_AC97EN | SSI_SACNT_FV)
+
+struct imx_channel {
+	int sg_count;
+	struct scatterlist *sg_list;
+	int period;
+	int periods;
+	unsigned long dma_addr;
+	int dma;
+	struct snd_pcm_substream *substream;
+	unsigned long offset;
+	unsigned long size;
+	unsigned long period_cnt;
+	void *buf;
+	struct timer_list timer;
+	int period_time;
+};
+
+struct imx_ssi {
+	struct snd_soc_dai dai;
+	struct platform_device *ac97_dev;
+
+	struct snd_soc_device imx_ac97;
+	struct clk *clk;
+	void __iomem *base;
+	int irq;
+	int fiq_enable;
+	unsigned int offset;
+
+	struct imx_channel rxc, txc;
+	unsigned int flags;
+
+	void (*ac97_reset) (struct snd_ac97 *ac97);
+	void (*ac97_warm_reset)(struct snd_ac97 *ac97);
+};
+
+/*
+ * SSI Network Mode or TDM slots configuration.
+ * Should only be called when port is inactive (i.e. SSIEN = 0).
+ */
+static int imx_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
+{
+	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	u32 sccr;
+
+	sccr = readl(ssi->base + SSI_STCCR);
+	sccr &= ~SSI_STCCR_DC_MASK;
+	sccr |= SSI_STCCR_DC(slots - 1);
+	writel(sccr, ssi->base + SSI_STCCR);
+
+	sccr = readl(ssi->base + SSI_SRCCR);
+	sccr &= ~SSI_STCCR_DC_MASK;
+	sccr |= SSI_STCCR_DC(slots - 1);
+	writel(sccr, ssi->base + SSI_SRCCR);
+
+	writel(tx_mask, ssi->base + SSI_STMSK);
+	writel(rx_mask, ssi->base + SSI_SRMSK);
+
+	return 0;
+}
+
+/*
+ * SSI DAI format configuration.
+ * Should only be called when port is inactive (i.e. SSIEN = 0).
+ * Note: We don't use the I2S modes but instead manually configure the
+ * SSI for I2S.
+ */
+static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	u32 strcr = 0, scr;
+
+	scr = readl(ssi->base + SSI_SCR) & ~(SSI_SCR_SYN | SSI_SCR_NET);
+
+	/* DAI mode */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		/* data on rising edge of bclk, frame low 1clk before data */
+		strcr |= SSI_STCR_TFSI | SSI_STCR_TEFS | SSI_STCR_TXBIT0;
+		scr |= SSI_SCR_NET;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		/* data on rising edge of bclk, frame high with data */
+		strcr |= SSI_STCR_TXBIT0;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		/* data on rising edge of bclk, frame high with data */
+		strcr |= SSI_STCR_TFSL;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		/* data on rising edge of bclk, frame high 1clk before data */
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TEFS;
+		break;
+	}
+
+	/* DAI clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		strcr |= SSI_STCR_TFSI;
+		strcr &= ~SSI_STCR_TSCKP;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		strcr &= ~(SSI_STCR_TSCKP | SSI_STCR_TFSI);
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		strcr |= SSI_STCR_TFSI | SSI_STCR_TSCKP;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		strcr &= ~SSI_STCR_TFSI;
+		strcr |= SSI_STCR_TSCKP;
+		break;
+	}
+
+	/* DAI clock master masks */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		strcr |= SSI_STCR_TFDIR | SSI_STCR_TXDIR;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		strcr |= SSI_STCR_TFDIR;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		strcr |= SSI_STCR_TXDIR;
+		break;
+	}
+
+	strcr |= SSI_STCR_TFEN0;
+
+	writel(strcr, ssi->base + SSI_STCR);
+	writel(strcr, ssi->base + SSI_SRCR);
+	writel(scr, ssi->base + SSI_SCR);
+
+	return 0;
+}
+
+/*
+ * SSI system clock configuration.
+ * Should only be called when port is inactive (i.e. SSIEN = 0).
+ */
+static int imx_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	u32 scr;
+
+	scr = readl(ssi->base + SSI_SCR);
+
+	switch (clk_id) {
+	case IMX_SSP_SYS_CLK:
+		if (dir == SND_SOC_CLOCK_OUT)
+			scr |= SSI_SCR_SYS_CLK_EN;
+		else
+			scr &= ~SSI_SCR_SYS_CLK_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel(scr, ssi->base + SSI_SCR);
+
+	return 0;
+}
+
+/*
+ * SSI Clock dividers
+ * Should only be called when port is inactive (i.e. SSIEN = 0).
+ */
+static int imx_ssi_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
+				  int div_id, int div)
+{
+	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	u32 stccr, srccr;
+
+	stccr = readl(ssi->base + SSI_STCCR);
+	srccr = readl(ssi->base + SSI_SRCCR);
+
+	switch (div_id) {
+	case IMX_SSI_TX_DIV_2:
+		stccr &= ~SSI_STCCR_DIV2;
+		stccr |= div;
+		break;
+	case IMX_SSI_TX_DIV_PSR:
+		stccr &= ~SSI_STCCR_PSR;
+		stccr |= div;
+		break;
+	case IMX_SSI_TX_DIV_PM:
+		stccr &= ~0xff;
+		stccr |= SSI_STCCR_PM(div);
+		break;
+	case IMX_SSI_RX_DIV_2:
+		stccr &= ~SSI_STCCR_DIV2;
+		stccr |= div;
+		break;
+	case IMX_SSI_RX_DIV_PSR:
+		stccr &= ~SSI_STCCR_PSR;
+		stccr |= div;
+		break;
+	case IMX_SSI_RX_DIV_PM:
+		stccr &= ~0xff;
+		stccr |= SSI_STCCR_PM(div);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel(stccr, ssi->base + SSI_STCCR);
+	writel(srccr, ssi->base + SSI_SRCCR);
+
+	return 0;
+}
+
+/*
+ * Should only be called when port is inactive (i.e. SSIEN = 0),
+ * although can be called multiple times by upper layers.
+ */
+static int imx_ssi_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *cpu_dai)
+{
+	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	u32 reg, sccr;
+
+	/* Tx/Rx config */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		reg = SSI_STCCR;
+	else
+		reg = SSI_SRCCR;
+
+	sccr = readl(ssi->base + reg) & ~SSI_STCCR_WL_MASK;
+
+	/* DAI data (word) size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		sccr |= SSI_SRCCR_WL(16);
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		sccr |= SSI_SRCCR_WL(20);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		sccr |= SSI_SRCCR_WL(24);
+		break;
+	}
+
+	writel(sccr, ssi->base + reg);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops imx_ssi_pcm_dai_ops = {
+	.hw_params	= imx_ssi_hw_params,
+	.set_fmt	= imx_ssi_set_dai_fmt,
+	.set_clkdiv	= imx_ssi_set_dai_clkdiv,
+	.set_sysclk	= imx_ssi_set_dai_sysclk,
+	.set_tdm_slot	= imx_ssi_set_dai_tdm_slot,
+};
+
+#define IMX_SSI_RATES \
+	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
+	SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
+	SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | \
+	SNDRV_PCM_RATE_96000)
+
+static struct snd_soc_dai imx_ssi_dai = {
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = IMX_SSI_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = IMX_SSI_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &imx_ssi_pcm_dai_ops,
+};
+
+static int snd_imx_pcm_mmap(struct snd_pcm_substream *substream, struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
+
+	ret = dma_mmap_coherent(NULL, vma, runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
+
+	pr_debug("%s: ret: %d %p 0x%08x 0x%08x\n", __func__, ret,
+			runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
+	return ret;
+}
+
+static snd_pcm_uframes_t snd_imx_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	struct imx_channel *ch;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ch = &ssi->txc;
+	else
+		ch = &ssi->rxc;
+
+	return bytes_to_frames(substream->runtime, ch->offset);
+}
+
+static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	int i, err = 0;
+	struct imx_channel *ch;
+	unsigned long dma_addr;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ch = &ssi->txc;
+	else
+		ch = &ssi->rxc;
+
+	ch->size = params_buffer_bytes(params);
+	ch->periods = params_periods(params);
+	ch->period = params_period_bytes(params);
+	ch->offset = 0;
+	ch->period_time = HZ / (params_rate(params) / params_period_size(params));
+
+	err = devdma_hw_alloc(NULL, substream, ch->size);
+	if (err < 0)
+		return err;
+
+	if (!use_dma(ssi))
+		return 0;
+
+	if (ch->sg_count != ch->periods) {
+		if (ch->sg_list)
+			kfree(ch->sg_list);
+		/* using sg_alloc_table() instead? */
+		ch->sg_list = kcalloc(ch->periods + 1,
+				sizeof(struct scatterlist), GFP_KERNEL);
+		if (!ch->sg_list)
+			return -ENOMEM;
+		ch->sg_count = ch->periods + 1;
+	}
+
+	sg_init_table(ch->sg_list, ch->sg_count);
+	dma_addr = runtime->dma_addr;
+
+	for (i = 0; i < ch->periods; i++) {
+		ch->sg_list[i].page_link = 0;
+		ch->sg_list[i].offset = 0;	/* FIXME */
+		ch->sg_list[i].dma_address = dma_addr;
+		ch->sg_list[i].length = ch->period;
+		dma_addr += ch->period;
+	}
+
+	/* close the loop */
+	ch->sg_list[ch->sg_count - 1].offset = 0;
+	ch->sg_list[ch->sg_count - 1].length = 0;
+	ch->sg_list[ch->sg_count - 1].page_link =
+			((unsigned long) ch->sg_list | 0x01) & ~0x02;
+	return 0;
+}
+
+static int snd_imx_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		devdma_hw_free(NULL, substream);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		devdma_hw_free(NULL, substream);
+	return 0;
+}
+
+static int snd_imx_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	struct imx_channel *ch;
+	u32 val, mode;
+	int err;
+	struct pt_regs regs;
+
+	val = readl(ssi->base + SSI_SCR);
+	val |= SSI_SCR_SSIEN;
+	writel(val, ssi->base + SSI_SCR);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		mode = DMA_MODE_WRITE;
+		ch = &ssi->txc;
+	} else {
+		mode = DMA_MODE_READ;
+		ch = &ssi->rxc;
+	}
+
+	ch->substream = substream;
+	ch->buf = (unsigned int *)substream->dma_buffer.area;
+	ch->period_cnt = 0;
+
+	pr_debug("%s: buf: %p period: %d periods: %d\n",
+			__func__, ch->buf, ch->period, ch->periods);
+
+	if (use_dma(ssi)) {
+		err = imx_dma_setup_sg(ch->dma, ch->sg_list,
+				       ch->sg_count,
+				       IMX_DMA_LENGTH_LOOP,
+				       ch->dma_addr,
+				       mode);
+		if (err)
+			return err;
+	} else {
+		get_fiq_regs(&regs);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			regs.ARM_r8 = (ch->period * ch->periods - 1) << 16;
+		else
+			regs.ARM_r9 = (ch->period * ch->periods - 1) << 16;
+
+		/* FIXME: need to disable fiqs here? */
+		set_fiq_regs(&regs);
+	}
+
+	return 0;
+}
+
+static int snd_imx_pcm_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+/*
+ * Do not change this as the FIQ handler depends on this size
+ */
+#define IMX_SSI_DMABUF_SIZE	(64 * 1024)
+
+static struct snd_pcm_hardware snd_imx_hardware = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_RESUME,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	.rate_min = 8000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
+	.period_bytes_min = 128,
+	.period_bytes_max = 16 * 1024,
+	.periods_min = 2,
+	.periods_max = 255,
+	.fifo_size = 0,
+};
+
+static int snd_imx_open(struct snd_pcm_substream *substream)
+{
+	int ret;
+
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
+			SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
+	return 0;
+}
+
+static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	struct imx_channel *ch;
+	unsigned int sier, sier_bits, scr;
+
+	sier = readl(ssi->base + SSI_SIER);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (use_dma(ssi))
+			sier_bits = SSI_SIER_TDMAE;
+		else
+			sier_bits = SSI_SIER_TIE | SSI_SIER_TFE0_EN;
+		ch = &ssi->txc;
+	} else {
+		if (use_dma(ssi))
+			sier_bits = SSI_SIER_RDMAE;
+		else
+			sier_bits = SSI_SIER_RIE | SSI_SIER_RFF0_EN;
+		ch = &ssi->rxc;
+	}
+
+	if (ssi->flags & IMX_SSI_USE_AC97) {
+		if (use_dma(ssi))
+			sier_bits = SSI_SIER_TDMAE | SSI_SIER_RDMAE;
+		else {
+			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+				sier_bits = SSI_SIER_TIE | SSI_SIER_TFE0_EN;
+			else
+				sier_bits = SSI_SIER_RIE | SSI_SIER_RFF0_EN;
+		}
+	}
+
+	scr = readl(ssi->base + SSI_SCR);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		sier |= sier_bits;
+		if (use_dma(ssi)) {
+			writel(sier, ssi->base + SSI_SIER);
+			imx_dma_enable(ch->dma);
+		} else {
+			writel(sier, ssi->base + SSI_SIER);
+			ch->timer.expires = jiffies + ch->period_time;
+			add_timer(&ch->timer);
+			if (ssi->flags & IMX_SSI_USE_AC97) {
+				while(!(readl(ssi->base + SSI_SISR) & (1<<7)))
+					readl(ssi->base + SSI_SRX0);
+				writel((1<<5) | SSI_SOR_WAIT(3), ssi->base + SSI_SOR);
+			}
+			if (++ssi->fiq_enable == 1)
+				enable_fiq(ssi->irq);
+		}
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			scr |= SSI_SCR_TE;
+		else
+			scr |= SSI_SCR_RE;
+
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		sier &= ~sier_bits;
+		if (use_dma(ssi)) {
+			imx_dma_disable(ch->dma);
+		} else {
+			writel(sier, ssi->base + SSI_SIER);
+			del_timer(&ch->timer);
+			if (--ssi->fiq_enable == 0)
+				disable_fiq(ssi->irq);
+		}
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			scr &= ~SSI_SCR_TE;
+		else
+			scr &= ~SSI_SCR_RE;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!(ssi->flags & IMX_SSI_USE_AC97))
+		/* rx/tx are always enabled to read/write ac97 registers */
+		writel(scr, ssi->base + SSI_SCR);
+
+	return 0;
+}
+
+static int imx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = IMX_SSI_DMABUF_SIZE;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
+					   &buf->addr, GFP_KERNEL);
+	if (!buf->area)
+		return -ENOMEM;
+	buf->bytes = size;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		imx_ssi_fiq_tx_buffer = (unsigned long)buf->area;
+	else
+		imx_ssi_fiq_rx_buffer = (unsigned long)buf->area;
+
+	return 0;
+}
+
+static u64 imx_pcm_dmamask = DMA_BIT_MASK(32);
+
+static int imx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
+	struct snd_pcm *pcm)
+{
+#ifdef IMX_SSI_MX1_MX2_DMA
+	struct imx_ssi *ssi = container_of(dai, struct imx_ssi, dai);
+#endif
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &imx_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	if (dai->playback.channels_min) {
+		ret = imx_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto out;
+	}
+
+	if (dai->capture.channels_min) {
+		ret = imx_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto out;
+	}
+
+	if (!use_dma(ssi)) {
+		set_fiq_handler(&imx_ssi_fiq_start,
+			&imx_ssi_fiq_end - &imx_ssi_fiq_start);
+	}
+out:
+	return ret;
+}
+
+static void imx_pcm_free(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+
+		dma_free_writecombine(pcm->card->dev, buf->bytes,
+				      buf->area, buf->addr);
+		buf->area = NULL;
+	}
+}
+
+static struct snd_pcm_ops imx_pcm_ops = {
+	.open		= snd_imx_open,
+	.close		= snd_imx_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= snd_imx_pcm_hw_params,
+	.hw_free	= snd_imx_pcm_hw_free,
+	.prepare	= snd_imx_pcm_prepare,
+	.trigger	= snd_imx_pcm_trigger,
+	.pointer	= snd_imx_pcm_pointer,
+	.mmap		= snd_imx_pcm_mmap
+};
+
+struct snd_soc_platform imx_soc_platform = {
+	.name		= "imx-audio",
+	.pcm_ops 	= &imx_pcm_ops,
+	.pcm_new	= imx_pcm_new,
+	.pcm_free	= imx_pcm_free,
+};
+EXPORT_SYMBOL_GPL(imx_soc_platform);
+
+#ifdef IMX_SSI_MX1_MX2_DMA
+/* Called by the DMA framework when a period has elapsed */
+static void imx_ssi_dma_progression(int channel, void *data,
+					struct scatterlist *sg)
+{
+	struct imx_ssi *ssi = data;
+	struct imx_channel *ch;
+	struct snd_pcm_runtime *runtime;
+
+	if (!sg)
+		return;
+
+	if (ssi->txc.dma == channel)
+		ch = &ssi->txc;
+	else
+		ch = &ssi->rxc;
+
+	runtime = ch->substream->runtime;
+
+	ch->offset = sg->dma_address - runtime->dma_addr;
+
+	snd_pcm_period_elapsed(ch->substream);
+}
+
+static void imx_ssi_dma_callback(int channel, void *data)
+{
+	pr_err("%s shouldn't be called\n", __func__);
+}
+
+static void snd_imx_dma_err_callback(int channel, void *data, int err)
+{
+	pr_err("DMA error callback called\n");
+
+	pr_err("DMA timeout on channel %d -%s%s%s%s\n",
+		 channel,
+		 err & IMX_DMA_ERR_BURST ?    " burst":"",
+		 err & IMX_DMA_ERR_REQUEST ?  " request":"",
+		 err & IMX_DMA_ERR_TRANSFER ? " transfer":"",
+		 err & IMX_DMA_ERR_BUFFER ?   " buffer":"");
+}
+
+static int imx_ssi_dma_alloc(struct platform_device *pdev, struct imx_ssi *ssi, int tx)
+{
+	struct imx_channel *ch;
+	struct resource *res;
+	int ret;
+
+	ch = tx ? &ssi->txc : &ssi->rxc;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
+			tx ? "tx0" : "rx0");
+	if (!res) {
+		dev_err(&pdev->dev, "platform_get_resource_byname tx0 failed\n");
+		return -ENODEV;
+	}
+
+	ch->dma = imx_dma_request_by_prio(DRV_NAME, DMA_PRIO_HIGH);
+	if (ch->dma < 0) {
+		pr_err("Failed to claim the audio DMA\n");
+		return -ENODEV;
+	}
+
+	ret = imx_dma_setup_handlers(ch->dma,
+				imx_ssi_dma_callback,
+				snd_imx_dma_err_callback, ssi);
+	if (ret) {
+		dev_err(&pdev->dev, "imx_dma_setup_handlers tx0 failed: %d\n",
+				ret);
+		goto out;
+	}
+
+	ret = imx_dma_setup_progression_handler(ch->dma,
+			imx_ssi_dma_progression);
+	if (ret) {
+		pr_err("Failed to setup the DMA handler\n");
+		goto out;
+	}
+
+	ret = imx_dma_config_channel(ch->dma,
+			IMX_DMA_MEMSIZE_16 | IMX_DMA_TYPE_FIFO,
+			IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_LINEAR,
+			res->start, 1);
+	if (ret < 0) {
+		pr_err("Cannot configure DMA channel: %d\n", ret);
+		goto out;
+	}
+
+	imx_dma_config_burstlen(ch->dma,
+			(tx ? DMA_TXFIFO_BURST : DMA_RXFIFO_BURST) * 2);
+
+	return 0;
+out:
+	imx_dma_free(ch->dma);
+	return ret;
+}
+#endif
+
+static struct snd_soc_dai imx_ac97_dai = {
+	.name = "AC97",
+	.ac97_control = 1,
+	.playback = {
+		.stream_name = "AC97 Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "AC97 Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &imx_ssi_pcm_dai_ops,
+};
+
+static void setup_channel_to_ac97(struct imx_ssi *imx_ssi)
+{
+	void __iomem *base = imx_ssi->base;
+
+	writel(0x0, base + SSI_SCR);
+	writel(0x0, base + SSI_SIER);
+	writel(0x0, base + SSI_STCR);
+	writel(0x0, base + SSI_SRCR);
+
+	writel(SSI_SCR_SYN | SSI_SCR_NET, base + SSI_SCR);
+
+	writel(SSI_SFCSR_RFWM0(8) |
+		SSI_SFCSR_TFWM0(8) |
+		SSI_SFCSR_RFWM1(8) |
+		SSI_SFCSR_TFWM1(8), base + SSI_SFCSR);
+
+	writel(SSI_STCCR_WL(16) | SSI_STCCR_DC(12), base + SSI_STCCR);
+	writel(SSI_STCCR_WL(16) | SSI_STCCR_DC(12), base + SSI_SRCCR);
+
+	writel(SSI_SCR_SYN | SSI_SCR_NET | SSI_SCR_SSIEN, base + SSI_SCR);
+	writel(SSI_SOR_WAIT(3), base + SSI_SOR);
+
+	writel(SSI_SCR_SYN | SSI_SCR_NET | SSI_SCR_SSIEN |
+			SSI_SCR_TE | SSI_SCR_RE,
+			base + SSI_SCR);
+
+	writel(SSI_SACNT_DEFAULT, base + SSI_SACNT);
+	writel(0xff, base + SSI_SACCDIS);
+	writel(0x300, base + SSI_SACCEN);
+}
+
+static void imx_ssi_timer_callback(unsigned long data)
+{
+	struct imx_channel *ch = (void *)data;
+	struct pt_regs regs;
+
+	get_fiq_regs(&regs);
+
+	if (ch->substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ch->offset = regs.ARM_r8 & 0xffff;
+	else
+		ch->offset = regs.ARM_r9 & 0xffff;
+
+	ch->timer.expires = jiffies + ch->period_time;
+	add_timer(&ch->timer);
+	snd_pcm_period_elapsed(ch->substream);
+}
+
+static struct imx_ssi *ac97_ssi;
+
+static void imx_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
+		unsigned short val)
+{
+	struct imx_ssi *imx_ssi = ac97_ssi;
+	void __iomem *base = imx_ssi->base;
+	unsigned int lreg;
+	unsigned int lval;
+
+	if (reg > 0x7f)
+		return;
+
+	pr_debug("%s: 0x%02x 0x%04x\n", __func__, reg, val);
+
+	lreg = reg <<  12;
+	writel(lreg, base + SSI_SACADD);
+
+	lval = val << 4;
+	writel(lval , base + SSI_SACDAT);
+
+	writel(SSI_SACNT_DEFAULT | SSI_SACNT_WR, base + SSI_SACNT);
+	udelay(100);
+}
+
+static unsigned short imx_ssi_ac97_read(struct snd_ac97 *ac97,
+		unsigned short reg)
+{
+	struct imx_ssi *imx_ssi = ac97_ssi;
+	void __iomem *base = imx_ssi->base;
+
+	unsigned short val = -1;
+	unsigned int lreg;
+
+	lreg = (reg & 0x7f) <<  12 ;
+	writel(lreg, base + SSI_SACADD);
+	writel(SSI_SACNT_DEFAULT | SSI_SACNT_RD, base + SSI_SACNT);
+
+	udelay(100);
+
+	val = (readl(base + SSI_SACDAT) >> 4) & 0xffff;
+
+	pr_debug("%s: 0x%02x 0x%04x\n", __func__, reg, val);
+
+	return val;
+}
+
+static void imx_ssi_ac97_reset(struct snd_ac97 *ac97)
+{
+	struct imx_ssi *imx_ssi = ac97_ssi;
+
+	if (imx_ssi->ac97_reset)
+		imx_ssi->ac97_reset(ac97);
+}
+
+static void imx_ssi_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	struct imx_ssi *imx_ssi = ac97_ssi;
+
+	if (imx_ssi->ac97_warm_reset)
+		imx_ssi->ac97_warm_reset(ac97);
+}
+
+struct snd_ac97_bus_ops soc_ac97_ops = {
+	.read		= imx_ssi_ac97_read,
+	.write		= imx_ssi_ac97_write,
+	.reset		= imx_ssi_ac97_reset,
+	.warm_reset	= imx_ssi_ac97_warm_reset
+};
+EXPORT_SYMBOL_GPL(soc_ac97_ops);
+
+static struct fiq_handler fh = {
+	.name		= DRV_NAME,
+};
+
+struct snd_soc_dai *imx_ssi_pcm_dai[2];
+
+static int imx_ssi_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct imx_ssi *ssi;
+	struct imx_ssi_platform_data *pdata = pdev->dev.platform_data;
+	int ret = 0;
+	unsigned int val;
+
+	ssi = kzalloc(sizeof (*ssi), GFP_KERNEL);
+	if (!ssi)
+		return -ENOMEM;
+
+	if (pdata) {
+		ssi->ac97_reset = pdata->ac97_reset;
+		ssi->ac97_warm_reset = pdata->ac97_warm_reset;
+		ssi->flags = pdata->flags;
+	}
+
+	imx_ssi_pcm_dai[pdev->id] = &ssi->dai;
+
+	ssi->irq = platform_get_irq(pdev, 0);
+
+	if (!use_dma(ssi)) {
+		ret = claim_fiq(&fh);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to claim fiq: %d", ret);
+			goto failed_fiq;
+		}
+
+		mxc_set_irq_fiq(ssi->irq, 1);
+
+		init_timer(&ssi->txc.timer);
+		ssi->txc.timer.data = (unsigned long)&ssi->txc;
+		ssi->txc.timer.function = imx_ssi_timer_callback;
+
+		init_timer(&ssi->rxc.timer);
+		ssi->rxc.timer.data = (unsigned long)&ssi->rxc;
+		ssi->rxc.timer.function = imx_ssi_timer_callback;
+	}
+
+	ssi->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ssi->clk)) {
+		ret = PTR_ERR(ssi->clk);
+		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
+			ret);
+		goto failed_clk;
+	}
+	clk_enable(ssi->clk);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		goto failed_get_resource;
+	}
+
+	ssi->txc.dma_addr = res->start + SSI_STX0;
+	ssi->rxc.dma_addr = res->start + SSI_SRX0;
+
+	if (!request_mem_region(res->start, resource_size(res), DRV_NAME)) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		ret = -EBUSY;
+		goto failed_get_resource;
+	}
+
+	ssi->base = ioremap(res->start, resource_size(res));
+	if (!ssi->base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -ENODEV;
+		goto failed_ioremap;
+	}
+
+	imx_ssi_fiq_base = (unsigned long)ssi->base;
+
+#ifdef IMX_SSI_MX1_MX2_DMA
+	if (use_dma(ssi)) {
+		ret = imx_ssi_dma_alloc(pdev, ssi, 1);
+		if (ret)
+			goto failed_dma1;
+
+		ret = imx_ssi_dma_alloc(pdev, ssi, 0);
+		if (ret)
+			goto failed_dma2;
+	}
+#endif
+
+	if (ssi->flags & IMX_SSI_USE_AC97) {
+		if (ac97_ssi) {
+			ret = -EBUSY;
+			goto failed_dma2;
+		}
+		ac97_ssi = ssi;
+		setup_channel_to_ac97(ssi);
+		memcpy(&ssi->dai, &imx_ac97_dai, sizeof(imx_ac97_dai));
+	} else
+		memcpy(&ssi->dai, &imx_ssi_dai, sizeof(imx_ssi_dai));
+	ssi->dai.id = pdev->id;
+	ssi->dai.dev = &pdev->dev;
+	ssi->dai.name = kasprintf(GFP_KERNEL, "imx-ssi.%d", pdev->id);
+
+	if (use_dma(ssi)) {
+		val = SSI_SFCSR_RFWM0(DMA_RXFIFO_BURST) |
+			SSI_SFCSR_TFWM0(DMA_TXFIFO_BURST);
+	} else {
+		val = SSI_SFCSR_TFWM0(4) | SSI_SFCSR_RFWM0(6);
+	}
+
+	writel(val, ssi->base + SSI_SFCSR);
+
+	ret = snd_soc_register_dai(&ssi->dai);
+	if (ret) {
+		dev_err(&pdev->dev, "register DAI failed\n");
+		goto failed_register;
+	}
+
+	return 0;
+
+failed_register:
+#ifdef IMX_SSI_MX1_MX2_DMA
+	if (use_dma(ssi))
+		imx_dma_free(ssi->rxc.dma);
+#endif
+failed_dma2:
+#ifdef IMX_SSI_MX1_MX2_DMA
+	if (use_dma(ssi))
+		imx_dma_free(ssi->txc.dma);
+failed_dma1:
+#endif
+
+	iounmap(ssi->base);
+failed_ioremap:
+	release_mem_region(res->start, resource_size(res));
+failed_get_resource:
+	clk_disable(ssi->clk);
+	clk_put(ssi->clk);
+failed_clk:
+	if (!use_dma(ssi)) {
+		mxc_set_irq_fiq(ssi->irq, 0);
+		release_fiq(&fh);
+	}
+failed_fiq:
+	kfree(ssi);
+
+	return ret;
+}
+
+static int __devexit imx_ssi_remove(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct imx_ssi *ssi = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_dai(&ssi->dai);
+
+	if (ssi->flags & IMX_SSI_USE_AC97)
+		ac97_ssi = NULL;
+
+#ifdef IMX_SSI_MX1_MX2_DMA
+	if (use_dma(ssi)) {
+		imx_dma_free(ssi->rxc.dma);
+		imx_dma_free(ssi->txc.dma);
+	}
+#endif
+	iounmap(ssi->base);
+	release_mem_region(res->start, resource_size(res));
+	clk_disable(ssi->clk);
+	clk_put(ssi->clk);
+	kfree(ssi);
+
+	return 0;
+}
+
+static struct platform_driver imx_ssi_driver = {
+	.probe = imx_ssi_probe,
+	.remove = __devexit_p(imx_ssi_remove),
+
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init imx_ssi_init(void)
+{
+	int ret;
+
+	ret = snd_soc_register_platform(&imx_soc_platform);
+	if (ret) {
+		pr_err("failed to register soc platform: %d\n", ret);
+		return ret;
+	}
+
+	ret = platform_driver_register(&imx_ssi_driver);
+	if (ret) {
+		snd_soc_unregister_platform(&imx_soc_platform);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit imx_ssi_exit(void)
+{
+	platform_driver_unregister(&imx_ssi_driver);
+	snd_soc_unregister_platform(&imx_soc_platform);
+}
+
+device_initcall(imx_ssi_init);
+module_exit(imx_ssi_exit);
+
+/* Module information */
+MODULE_AUTHOR("Sascha Hauer, <s.hauer@pengutronix.de>");
+MODULE_DESCRIPTION("i.MX I2S/ac97 SoC Interface");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/imx/imx-ssi.h b/sound/soc/imx/imx-ssi.h
new file mode 100644
index 0000000..d836fd9
--- /dev/null
+++ b/sound/soc/imx/imx-ssi.h
@@ -0,0 +1,24 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _IMX_SSI_H
+#define _IMX_SSI_H
+
+/* SSI clock sources */
+#define IMX_SSP_SYS_CLK		0
+
+/* SSI audio dividers */
+#define IMX_SSI_TX_DIV_2	0
+#define IMX_SSI_TX_DIV_PSR	1
+#define IMX_SSI_TX_DIV_PM	2
+#define IMX_SSI_RX_DIV_2	3
+#define IMX_SSI_RX_DIV_PSR	4
+#define IMX_SSI_RX_DIV_PM	5
+
+extern struct snd_soc_dai *imx_ssi_pcm_dai[2];
+extern struct snd_soc_platform imx_soc_platform;
+
+#endif /* _IMX_SSI_H */
-- 
1.6.5.2
