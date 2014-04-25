From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:46:07 +0100
Subject: [PATCH 158/222] dw-hdmi-audio: add audio driver
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeZz-0007Nq-Jy@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ALSA based HDMI audio driver for imx-hdmi.  The imx-hdmi is a
Synopsis DesignWare module, so let's name it after that.  The only
buffer format supported is its own special IEC958 based format, which
is not compatible with any ALSA format.  To avoid doing too much data
manipulation within the driver, we support only ALSAs IEC958 LE, and
24-bit PCM formats for 2 to 6 channels.

This allows us to modify the buffer in place as each period is passed
for DMA without needing a separate buffer.

A more desirable solution would be to have this conversion in userspace,
but ALSA does not appear to allow such transformations outside of
libasound itself.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/Kconfig         |   8 +
 drivers/staging/imx-drm/Makefile        |   1 +
 drivers/staging/imx-drm/dw-hdmi-audio.c | 547 ++++++++++++++++++++++++++++++++
 drivers/staging/imx-drm/dw-hdmi-audio.h |  14 +
 drivers/staging/imx-drm/imx-hdmi.c      |  29 ++
 5 files changed, 599 insertions(+)
 create mode 100644 drivers/staging/imx-drm/dw-hdmi-audio.c
 create mode 100644 drivers/staging/imx-drm/dw-hdmi-audio.h

diff --git a/drivers/staging/imx-drm/Kconfig b/drivers/staging/imx-drm/Kconfig
index 92fb52cbd3a2..66ed3e5f132a 100644
--- a/drivers/staging/imx-drm/Kconfig
+++ b/drivers/staging/imx-drm/Kconfig
@@ -61,3 +61,11 @@ config DRM_IMX_HDMI
 	depends on DRM_IMX
 	help
 	  Choose this if you want to use HDMI on i.MX6.
+
+config DRM_DW_HDMI_AUDIO
+	tristate "Synopsis Designware Audio interface"
+	depends on DRM_IMX_HDMI != n
+	help
+	  Support the Audio interface which is part of the Synopsis
+	  Designware HDMI block.  This is used in conjunction with
+	  the i.MX HDMI driver.
diff --git a/drivers/staging/imx-drm/Makefile b/drivers/staging/imx-drm/Makefile
index 129e3a3f59f1..34c8b9990a66 100644
--- a/drivers/staging/imx-drm/Makefile
+++ b/drivers/staging/imx-drm/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_DRM_IMX_IPUV3_CORE) += ipu-v3/
 imx-ipuv3-crtc-objs  := ipuv3-crtc.o ipuv3-plane.o
 obj-$(CONFIG_DRM_IMX_IPUV3)	+= imx-ipuv3-crtc.o
 obj-$(CONFIG_DRM_IMX_HDMI) += imx-hdmi.o
+obj-$(CONFIG_DRM_DW_HDMI_AUDIO) += dw-hdmi-audio.o
diff --git a/drivers/staging/imx-drm/dw-hdmi-audio.c b/drivers/staging/imx-drm/dw-hdmi-audio.c
new file mode 100644
index 000000000000..e7d41249c817
--- /dev/null
+++ b/drivers/staging/imx-drm/dw-hdmi-audio.c
@@ -0,0 +1,547 @@
+/*
+ * DesignWare HDMI audio driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Written and tested against the (alleged) DW HDMI Tx found in iMX6S.
+ */
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <sound/asoundef.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+
+#include "dw-hdmi-audio.h"
+
+#define DRIVER_NAME "dw-hdmi-audio"
+
+/* Provide some bits rather than bit offsets */
+enum {
+	HDMI_AHB_DMA_CONF0_SW_FIFO_RST = BIT(7),
+	HDMI_AHB_DMA_CONF0_EN_HLOCK = BIT(3),
+	HDMI_AHB_DMA_START_START = BIT(0),
+	HDMI_AHB_DMA_STOP_STOP = BIT(0),
+	HDMI_IH_MUTE_AHBDMAAUD_STAT0_ERROR = BIT(5),
+	HDMI_IH_MUTE_AHBDMAAUD_STAT0_LOST = BIT(4),
+	HDMI_IH_MUTE_AHBDMAAUD_STAT0_RETRY = BIT(3),
+	HDMI_IH_MUTE_AHBDMAAUD_STAT0_DONE = BIT(2),
+	HDMI_IH_MUTE_AHBDMAAUD_STAT0_BUFFFULL = BIT(1),
+	HDMI_IH_MUTE_AHBDMAAUD_STAT0_BUFFEMPTY = BIT(0),
+	HDMI_IH_MUTE_AHBDMAAUD_STAT0_ALL =
+		HDMI_IH_MUTE_AHBDMAAUD_STAT0_ERROR |
+		HDMI_IH_MUTE_AHBDMAAUD_STAT0_LOST |
+		HDMI_IH_MUTE_AHBDMAAUD_STAT0_RETRY |
+		HDMI_IH_MUTE_AHBDMAAUD_STAT0_DONE |
+		HDMI_IH_MUTE_AHBDMAAUD_STAT0_BUFFFULL |
+		HDMI_IH_MUTE_AHBDMAAUD_STAT0_BUFFEMPTY,
+	HDMI_IH_AHBDMAAUD_STAT0_ERROR = BIT(5),
+	HDMI_IH_AHBDMAAUD_STAT0_LOST = BIT(4),
+	HDMI_IH_AHBDMAAUD_STAT0_RETRY = BIT(3),
+	HDMI_IH_AHBDMAAUD_STAT0_DONE = BIT(2),
+	HDMI_IH_AHBDMAAUD_STAT0_BUFFFULL = BIT(1),
+	HDMI_IH_AHBDMAAUD_STAT0_BUFFEMPTY = BIT(0),
+	HDMI_IH_AHBDMAAUD_STAT0_ALL =
+		HDMI_IH_AHBDMAAUD_STAT0_ERROR |
+		HDMI_IH_AHBDMAAUD_STAT0_LOST |
+		HDMI_IH_AHBDMAAUD_STAT0_RETRY |
+		HDMI_IH_AHBDMAAUD_STAT0_DONE |
+		HDMI_IH_AHBDMAAUD_STAT0_BUFFFULL |
+		HDMI_IH_AHBDMAAUD_STAT0_BUFFEMPTY,
+	HDMI_AHB_DMA_CONF0_INCR16 = 2 << 1,
+	HDMI_AHB_DMA_CONF0_INCR8 = 1 << 1,
+	HDMI_AHB_DMA_CONF0_INCR4 = 0,
+	HDMI_AHB_DMA_CONF0_BURST_MODE = BIT(0),
+	HDMI_AHB_DMA_MASK_DONE = BIT(7),
+	HDMI_REVISION_ID = 0x0001,
+	HDMI_IH_AHBDMAAUD_STAT0 = 0x0109,
+	HDMI_IH_MUTE_AHBDMAAUD_STAT0 = 0x0189,
+	HDMI_AHB_DMA_CONF0 = 0x3600,
+	HDMI_AHB_DMA_START = 0x3601,
+	HDMI_AHB_DMA_STOP = 0x3602,
+	HDMI_AHB_DMA_THRSLD = 0x3603,
+	HDMI_AHB_DMA_STRADDR0 = 0x3604,
+	HDMI_AHB_DMA_STPADDR0 = 0x3608,
+	HDMI_AHB_DMA_MASK = 0x3614,
+	HDMI_AHB_DMA_POL = 0x3615,
+	HDMI_AHB_DMA_CONF1 = 0x3616,
+	HDMI_AHB_DMA_BUFFPOL = 0x361a,
+};
+
+struct snd_dw_hdmi {
+	struct snd_card *card;
+	struct snd_pcm *pcm;
+	struct dw_hdmi_audio_data data;
+	struct snd_pcm_substream *substream;
+	void (*reformat)(struct snd_dw_hdmi *, size_t, size_t);
+	void *buf_src;
+	void *buf_dst;
+	dma_addr_t buf_addr;
+	unsigned buf_offset;
+	unsigned buf_period;
+	unsigned buf_size;
+	unsigned channels;
+	uint8_t revision;
+	uint8_t iec_offset;
+	uint8_t cs[192][8];
+};
+
+static void dw_hdmi_writel(unsigned long val, void __iomem *ptr)
+{
+	writeb_relaxed(val, ptr);
+	writeb_relaxed(val >> 8, ptr + 1);
+	writeb_relaxed(val >> 16, ptr + 2);
+	writeb_relaxed(val >> 24, ptr + 3);
+}
+
+/*
+ * Convert to hardware format: The userspace buffer contains IEC958 samples,
+ * with the PCUV bits in bits 31..28 and audio samples in bits 27..4.  We
+ * need these to be in bits 27..24, with the IEC B bit in bit 28, and audio
+ * samples in 23..0.
+ *
+ * Default preamble in bits 3..0: 8 = block start, 4 = even 2 = odd
+ *
+ * Ideally, we could do with having the data properly formatted in userspace.
+ */
+static void dw_hdmi_reformat_iec958(struct snd_dw_hdmi *dw,
+	size_t offset, size_t bytes)
+{
+	uint32_t *src = dw->buf_src + offset;
+	uint32_t *dst = dw->buf_dst + offset;
+	uint32_t *end = dw->buf_src + offset + bytes;
+
+	do {
+		uint32_t b, sample = *src++;
+
+		b = (sample & 8) << (28 - 3);
+
+		sample >>= 4;
+
+		*dst++ = sample | b;
+	} while (src < end);
+}
+
+static uint32_t parity(uint32_t sample)
+{
+	sample ^= sample >> 16;
+	sample ^= sample >> 8;
+	sample ^= sample >> 4;
+	sample ^= sample >> 2;
+	sample ^= sample >> 1;
+	return (sample & 1) << 27;
+}
+
+static void dw_hdmi_reformat_s24(struct snd_dw_hdmi *dw,
+	size_t offset, size_t bytes)
+{
+	uint32_t *src = dw->buf_src + offset;
+	uint32_t *dst = dw->buf_dst + offset;
+	uint32_t *end = dw->buf_src + offset + bytes;
+
+	do {
+		unsigned i;
+		uint8_t *cs;
+
+		cs = dw->cs[dw->iec_offset++];
+		if (dw->iec_offset >= 192)
+			dw->iec_offset = 0;
+
+		i = dw->channels;
+		do {
+			uint32_t sample = *src++;
+
+			sample &= ~0xff000000;
+			sample |= *cs++ << 24;
+			sample |= parity(sample & ~0xf8000000);
+
+			*dst++ = sample;
+		} while (--i);
+	} while (src < end);
+}
+
+static void dw_hdmi_create_cs(struct snd_dw_hdmi *dw,
+	struct snd_pcm_runtime *runtime)
+{
+	uint8_t cs[4];
+	unsigned ch, i, j;
+
+	cs[0] = IEC958_AES0_CON_NOT_COPYRIGHT | IEC958_AES0_CON_EMPHASIS_NONE;
+	cs[1] = IEC958_AES1_CON_GENERAL;
+	cs[2] = IEC958_AES2_CON_SOURCE_UNSPEC;
+	cs[3] = IEC958_AES3_CON_CLOCK_1000PPM;
+
+	switch (runtime->rate) {
+	case 32000:
+		cs[3] |= IEC958_AES3_CON_FS_32000;
+		break;
+	case 44100:
+		cs[3] |= IEC958_AES3_CON_FS_44100;
+		break;
+	case 48000:
+		cs[3] |= IEC958_AES3_CON_FS_48000;
+		break;
+	case 88200:
+		cs[3] |= IEC958_AES3_CON_FS_88200;
+		break;
+	case 96000:
+		cs[3] |= IEC958_AES3_CON_FS_96000;
+		break;
+	case 176400:
+		cs[3] |= IEC958_AES3_CON_FS_176400;
+		break;
+	case 192000:
+		cs[3] |= IEC958_AES3_CON_FS_192000;
+		break;
+	}
+
+	memset(dw->cs, 0, sizeof(dw->cs));
+
+	for (ch = 0; ch < 8; ch++) {
+		cs[2] &= ~IEC958_AES2_CON_CHANNEL;
+		cs[2] |= (ch + 1) << 4;
+
+		for (i = 0; i < ARRAY_SIZE(cs); i++) {
+			unsigned c = cs[i];
+
+			for (j = 0; j < 8; j++, c >>= 1)
+				dw->cs[i * 8 + j][ch] = (c & 1) << 2;
+		}
+	}
+	dw->cs[0][0] |= BIT(4);
+}
+
+static void dw_hdmi_start_dma(struct snd_dw_hdmi *dw)
+{
+	void __iomem *base = dw->data.base;
+	unsigned offset = dw->buf_offset;
+	unsigned period = dw->buf_period;
+	u32 start, stop;
+
+	dw->reformat(dw, offset, period);
+
+	/* Clear all irqs before enabling irqs and starting DMA */
+	writeb_relaxed(HDMI_IH_AHBDMAAUD_STAT0_ALL,
+		       base + HDMI_IH_AHBDMAAUD_STAT0);
+
+	start = dw->buf_addr + offset;
+	stop = start + period - 1;
+
+	/* Setup the hardware start/stop addresses */
+	dw_hdmi_writel(start, base + HDMI_AHB_DMA_STRADDR0);
+	dw_hdmi_writel(stop, base + HDMI_AHB_DMA_STPADDR0);
+
+	writeb_relaxed((u8)~HDMI_AHB_DMA_MASK_DONE, base + HDMI_AHB_DMA_MASK);
+	writeb(HDMI_AHB_DMA_START_START, base + HDMI_AHB_DMA_START);
+}
+
+static void dw_hdmi_stop_dma(struct snd_dw_hdmi *dw)
+{
+	dw->substream = NULL;
+
+	/* Disable interrupts before disabling DMA */
+	writeb_relaxed(~0, dw->data.base + HDMI_AHB_DMA_MASK);
+	writeb_relaxed(HDMI_AHB_DMA_STOP_STOP, dw->data.base + HDMI_AHB_DMA_STOP);
+}
+
+static irqreturn_t snd_dw_hdmi_irq(int irq, void *data)
+{
+	struct snd_dw_hdmi *dw = data;
+	struct snd_pcm_substream *substream;
+	unsigned stat;
+
+	stat = readb_relaxed(dw->data.base + HDMI_IH_AHBDMAAUD_STAT0);
+	if (!stat)
+		return IRQ_NONE;
+
+	writeb_relaxed(stat, dw->data.base + HDMI_IH_AHBDMAAUD_STAT0);
+
+	substream = dw->substream;
+	if (stat & HDMI_IH_AHBDMAAUD_STAT0_DONE && substream) {
+		dw->buf_offset += dw->buf_period;
+		if (dw->buf_offset >= dw->buf_size)
+			dw->buf_offset = 0;
+
+		snd_pcm_period_elapsed(substream);
+		if (dw->substream)
+			dw_hdmi_start_dma(dw);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct snd_pcm_hardware dw_hdmi_hw = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID,
+	.formats = SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE |
+		   SNDRV_PCM_FMTBIT_S24_LE,
+	.rates = SNDRV_PCM_RATE_32000 |
+		 SNDRV_PCM_RATE_44100 |
+		 SNDRV_PCM_RATE_48000 |
+		 SNDRV_PCM_RATE_88200 |
+		 SNDRV_PCM_RATE_96000 |
+		 SNDRV_PCM_RATE_176400 |
+		 SNDRV_PCM_RATE_192000,
+	.channels_min = 2,
+	.channels_max = 8,
+	.buffer_bytes_max = 64 * 1024,
+	.period_bytes_min = 256,
+	.period_bytes_max = 8192,	/* ERR004323: must limit to 8k */
+	.periods_min = 2,
+	.periods_max = 16,
+	.fifo_size = 0,
+};
+
+static int dw_hdmi_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dw_hdmi *dw = substream->private_data;
+	void __iomem *base = dw->data.base;
+	int ret;
+
+	/* Clear FIFO */
+	writeb_relaxed(HDMI_AHB_DMA_CONF0_SW_FIFO_RST,
+		       base + HDMI_AHB_DMA_CONF0);
+
+	/* Configure interrupt polarities */
+	writeb_relaxed(~0, base + HDMI_AHB_DMA_POL);
+	writeb_relaxed(~0, base + HDMI_AHB_DMA_BUFFPOL);
+
+	/* Keep interrupts masked, and clear any pending */
+	writeb_relaxed(~0, base + HDMI_AHB_DMA_MASK);
+	writeb_relaxed(~0, base + HDMI_IH_AHBDMAAUD_STAT0);
+
+	ret = request_irq(dw->data.irq, snd_dw_hdmi_irq, IRQF_SHARED,
+			  "dw-hdmi-audio", dw);
+	if (ret)
+		return ret;
+
+	/* Un-mute done interrupt */
+	writeb_relaxed(HDMI_IH_MUTE_AHBDMAAUD_STAT0_ALL &
+		       ~HDMI_IH_MUTE_AHBDMAAUD_STAT0_DONE,
+		       base + HDMI_IH_MUTE_AHBDMAAUD_STAT0);
+
+	runtime->hw = dw_hdmi_hw;
+	snd_pcm_limit_hw_rates(runtime);
+
+	return 0;
+}
+
+static int dw_hdmi_close(struct snd_pcm_substream *substream)
+{
+	struct snd_dw_hdmi *dw = substream->private_data;
+
+	/* Mute all interrupts */
+	writeb_relaxed(HDMI_IH_MUTE_AHBDMAAUD_STAT0_ALL,
+		       dw->data.base + HDMI_IH_MUTE_AHBDMAAUD_STAT0);
+
+	free_irq(dw->data.irq, dw);
+
+	return 0;
+}
+
+static int dw_hdmi_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int dw_hdmi_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(params));
+}
+
+static int dw_hdmi_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dw_hdmi *dw = substream->private_data;
+	uint8_t threshold, conf0, conf1;
+
+	/* Setup as per 3.0.5 FSL 4.1.0 BSP */
+	switch (dw->revision) {
+	case 0x0a:
+		conf0 = HDMI_AHB_DMA_CONF0_BURST_MODE |
+			HDMI_AHB_DMA_CONF0_INCR4;
+		if (runtime->channels == 2)
+			threshold = 126;
+		else
+			threshold = 124;
+		break;
+	case 0x1a:
+		conf0 = HDMI_AHB_DMA_CONF0_BURST_MODE |
+			HDMI_AHB_DMA_CONF0_INCR8;
+		threshold = 128;
+		break;
+	default:
+		/* NOTREACHED */
+		return -EINVAL;
+	}
+
+	dw->data.set_sample_rate(dw->data.hdmi, runtime->rate);
+
+	/* Minimum number of bytes in the fifo. */
+	runtime->hw.fifo_size = threshold * 32;
+
+	conf0 |= HDMI_AHB_DMA_CONF0_EN_HLOCK;
+	conf1 = (1 << runtime->channels) - 1;
+
+	writeb_relaxed(threshold, dw->data.base + HDMI_AHB_DMA_THRSLD);
+	writeb_relaxed(conf0, dw->data.base + HDMI_AHB_DMA_CONF0);
+	writeb_relaxed(conf1, dw->data.base + HDMI_AHB_DMA_CONF1);
+
+	switch (runtime->format) {
+	case SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE:
+		dw->reformat = dw_hdmi_reformat_iec958;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		dw_hdmi_create_cs(dw, runtime);
+		dw->reformat = dw_hdmi_reformat_s24;
+		break;
+	}
+	dw->iec_offset = 0;
+	dw->channels = runtime->channels;
+	dw->buf_src  = runtime->dma_area;
+	dw->buf_dst  = substream->dma_buffer.area;
+	dw->buf_addr = substream->dma_buffer.addr;
+	dw->buf_period = snd_pcm_lib_period_bytes(substream);
+	dw->buf_size = snd_pcm_lib_buffer_bytes(substream);
+
+	return 0;
+}
+
+static int dw_hdmi_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_dw_hdmi *dw = substream->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		dw->buf_offset = 0;
+		dw->substream = substream;
+		dw_hdmi_start_dma(dw);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+		dw_hdmi_stop_dma(dw);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t dw_hdmi_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dw_hdmi *dw = substream->private_data;
+
+	return bytes_to_frames(runtime, dw->buf_offset);
+}
+
+static struct snd_pcm_ops snd_dw_hdmi_ops = {
+	.open = dw_hdmi_open,
+	.close = dw_hdmi_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = dw_hdmi_hw_params,
+	.hw_free = dw_hdmi_hw_free,
+	.prepare = dw_hdmi_prepare,
+	.trigger = dw_hdmi_trigger,
+	.pointer = dw_hdmi_pointer,
+	.page = snd_pcm_lib_get_vmalloc_page,
+};
+
+static int snd_dw_hdmi_probe(struct platform_device *pdev)
+{
+	const struct dw_hdmi_audio_data *data = pdev->dev.platform_data;
+	struct device *dev = pdev->dev.parent;
+	struct snd_dw_hdmi *dw;
+	struct snd_card *card;
+	struct snd_pcm *pcm;
+	unsigned revision;
+	int ret;
+
+	writeb_relaxed(HDMI_IH_MUTE_AHBDMAAUD_STAT0_ALL,
+		       data->base + HDMI_IH_MUTE_AHBDMAAUD_STAT0);
+	revision = readb_relaxed(data->base + HDMI_REVISION_ID);
+	if (revision != 0x0a && revision != 0x1a) {
+		dev_err(dev, "dw-hdmi-audio: unknown revision 0x%02x\n",
+			revision);
+		return -ENXIO;
+	}
+
+	ret = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			      THIS_MODULE, sizeof(struct snd_dw_hdmi), &card);
+	if (ret < 0)
+		return ret;
+
+	snd_card_set_dev(card, dev);
+
+	strlcpy(card->driver, DRIVER_NAME, sizeof(card->driver));
+	strlcpy(card->shortname, "DW-HDMI", sizeof(card->shortname));
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s rev 0x%02x, irq %d", card->shortname, revision,
+		 data->irq);
+
+	dw = card->private_data;
+	dw->card = card;
+	dw->data = *data;
+	dw->revision = revision;
+
+	ret = snd_pcm_new(card, "DW HDMI", 0, 1, 0, &pcm);
+	if (ret < 0)
+		goto err;
+
+	dw->pcm = pcm;
+	pcm->private_data = dw;
+	strlcpy(pcm->name, DRIVER_NAME, sizeof(pcm->name));
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_dw_hdmi_ops);
+
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+			dev, 64 * 1024, 64 * 1024);
+
+	ret = snd_card_register(card);
+	if (ret < 0)
+		goto err;
+
+	platform_set_drvdata(pdev, dw);
+
+	return 0;
+
+err:
+	snd_card_free(card);
+	return ret;
+}
+
+static int snd_dw_hdmi_remove(struct platform_device *pdev)
+{
+	struct snd_dw_hdmi *dw = platform_get_drvdata(pdev);
+
+	snd_card_free(dw->card);
+
+	return 0;
+}
+
+static struct platform_driver snd_dw_hdmi_driver = {
+	.probe	= snd_dw_hdmi_probe,
+	.remove	= snd_dw_hdmi_remove,
+	.driver	= {
+		.name = "dw-hdmi-audio",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(snd_dw_hdmi_driver);
+
+MODULE_AUTHOR("Russell King <rmk+kernel@arm.linux.org.uk>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/imx-drm/dw-hdmi-audio.h b/drivers/staging/imx-drm/dw-hdmi-audio.h
new file mode 100644
index 000000000000..f01979d49efd
--- /dev/null
+++ b/drivers/staging/imx-drm/dw-hdmi-audio.h
@@ -0,0 +1,14 @@
+#ifndef DW_HDMI_AUDIO_H
+#define DW_HDMI_AUDIO_H
+
+struct imx_hdmi;
+
+struct dw_hdmi_audio_data {
+	phys_addr_t phys;
+	void __iomem *base;
+	int irq;
+	struct imx_hdmi *hdmi;
+	void (*set_sample_rate)(struct imx_hdmi *, unsigned);
+};
+
+#endif
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 6f5efcc89880..af4cba51e255 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -28,6 +28,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder_slave.h>
 
+#include "dw-hdmi-audio.h"
 #include "ipu-v3/imx-ipu-v3.h"
 #include "imx-hdmi.h"
 #include "imx-drm.h"
@@ -115,6 +116,7 @@ struct imx_hdmi {
 	struct drm_connector connector;
 	struct drm_encoder encoder;
 
+	struct platform_device *audio;
 	enum imx_hdmi_devtype dev_type;
 	struct device *dev;
 	struct clk *isfr_clk;
@@ -360,6 +362,12 @@ static void hdmi_clk_regenerator_update_pixel_clock(struct imx_hdmi *hdmi)
 	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock);
 }
 
+static void imx_hdmi_set_sample_rate(struct imx_hdmi *hdmi, unsigned rate)
+{
+	hdmi->sample_rate = rate;
+	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock);
+}
+
 /*
  * this submodule is responsible for the video data synchronization.
  * for example, for RGB 4:4:4 input, the data map is defined as
@@ -1590,11 +1598,13 @@ MODULE_DEVICE_TABLE(of, imx_hdmi_dt_ids);
 static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device_info pdevinfo;
 	const struct of_device_id *of_id =
 				of_match_device(imx_hdmi_dt_ids, dev);
 	struct drm_device *drm = data;
 	struct device_node *np = dev->of_node;
 	struct device_node *ddc_node;
+	struct dw_hdmi_audio_data audio;
 	struct imx_hdmi *hdmi;
 	struct resource *iores;
 	int ret, irq;
@@ -1708,6 +1718,22 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	/* Unmute interrupts */
 	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
 
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	pdevinfo.parent = dev;
+	pdevinfo.id = PLATFORM_DEVID_AUTO;
+
+	audio.phys = iores->start;
+	audio.base = hdmi->regs;
+	audio.irq = irq;
+	audio.hdmi = hdmi;
+	audio.set_sample_rate = imx_hdmi_set_sample_rate;
+
+	pdevinfo.name = "dw-hdmi-audio";
+	pdevinfo.data = &audio;
+	pdevinfo.size_data = sizeof(audio);
+	pdevinfo.dma_mask = DMA_BIT_MASK(32);
+	hdmi->audio = platform_device_register_full(&pdevinfo);
+
 	dev_set_drvdata(dev, hdmi);
 
 	return 0;
@@ -1725,6 +1751,9 @@ static void imx_hdmi_unbind(struct device *dev, struct device *master,
 {
 	struct imx_hdmi *hdmi = dev_get_drvdata(dev);
 
+	if (!IS_ERR(hdmi->audio))
+		platform_device_unregister(hdmi->audio);
+
 	/* Disable all interrupts */
 	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
 
-- 
1.8.3.1
