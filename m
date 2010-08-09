From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 11:05:39 +0200
Subject: [PATCH 4/8] ARM i.MX: add SDMA driver
In-Reply-To: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281344743-2029-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA support for i.MX25/31/35/51 based SoCs.
The SDMA engine is a scatter/gather DMA engine which is implemented
as a seperate coprocessor. SDMA needs its own firmware which is
requested using the standard request_firmware mechanism. The firmware
has different entry points for each peripheral type, so drivers
have to pass the peripheral type to the DMA engine which in turn
picks the correct firmware entry point from a table contained in
the firmware image itself.
The original Freescale code also supports support for transfering
data to the internal SRAM which needs different entry points to
the firmware. Support for this is currently not implemented. Also,
support for the ASRC (asymmetric sample rate converter) is skipped.

This code has been tested with sound on i.MX31/35 and with SD/MMC on
i.MX31. It should work on i.MX25/51, but this is currently untested.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig             |    2 +
 arch/arm/plat-mxc/Kconfig             |   10 +
 arch/arm/plat-mxc/Makefile            |    1 +
 arch/arm/plat-mxc/include/mach/sdma.h |    8 +
 arch/arm/plat-mxc/sdma.c              | 1181 +++++++++++++++++++++++++++++++++
 5 files changed, 1202 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/sdma.h
 create mode 100644 arch/arm/plat-mxc/sdma.c

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 85beece..301375c 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -3,12 +3,14 @@ if ARCH_MX3
 config ARCH_MX31
 	select ARCH_HAS_RNGA
 	select ARCH_MXC_AUDMUX_V2
+	select IMX_HAVE_SDMA
 	bool
 
 config ARCH_MX35
 	bool
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
+	select IMX_HAVE_SDMA
 
 comment "MX3 platforms:"
 
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 0527e65..6741625 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -109,4 +109,14 @@ config ARCH_MXC_AUDMUX_V1
 config ARCH_MXC_AUDMUX_V2
 	bool
 
+config IMX_HAVE_SDMA
+	bool
+
+config IMX_SDMA
+	depends on IMX_HAVE_SDMA
+	tristate "Enable SDMA support"
+	help
+	  Include support for the SDMA engine. The SDMA engine needs additional
+	  firmware support. SDMA can be compiled as a module to support loading
+	  the firmware when a rootfs is present.
 endif
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index ff9880c..378f8ca 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
 obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
+obj-$(CONFIG_IMX_SDMA) += sdma.o
 ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
diff --git a/arch/arm/plat-mxc/include/mach/sdma.h b/arch/arm/plat-mxc/include/mach/sdma.h
new file mode 100644
index 0000000..5d542b8
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/sdma.h
@@ -0,0 +1,8 @@
+#ifndef __MACH_MXC_SDMA_H__
+#define __MACH_MXC_SDMA_H__
+
+struct sdma_platform_data {
+	int sdma_version;
+};
+
+#endif /* __MACH_MXC_SDMA_H__ */
diff --git a/arch/arm/plat-mxc/sdma.c b/arch/arm/plat-mxc/sdma.c
new file mode 100644
index 0000000..3fbc8d8
--- /dev/null
+++ b/arch/arm/plat-mxc/sdma.c
@@ -0,0 +1,1181 @@
+/*
+ * arch/arm/plat-mxc/sdma.c
+ *
+ * This file contains a driver for the Freescale Smart DMA engine
+ *
+ * Copyright 2010 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ *
+ * Based on code from Freescale:
+ *
+ * Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/semaphore.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#include <asm/irq.h>
+#include <mach/sdma.h>
+#include <mach/dma.h>
+#include <mach/hardware.h>
+
+/* SDMA registers */
+#define SDMA_H_C0PTR		(sdma_base + 0x000)
+#define SDMA_H_INTR		(sdma_base + 0x004)
+#define SDMA_H_STATSTOP		(sdma_base + 0x008)
+#define SDMA_H_START		(sdma_base + 0x00c)
+#define SDMA_H_EVTOVR		(sdma_base + 0x010)
+#define SDMA_H_DSPOVR		(sdma_base + 0x014)
+#define SDMA_H_HOSTOVR		(sdma_base + 0x018)
+#define SDMA_H_EVTPEND		(sdma_base + 0x01c)
+#define SDMA_H_DSPENBL		(sdma_base + 0x020)
+#define SDMA_H_RESET		(sdma_base + 0x024)
+#define SDMA_H_EVTERR		(sdma_base + 0x028)
+#define SDMA_H_INTRMSK		(sdma_base + 0x02c)
+#define SDMA_H_PSW		(sdma_base + 0x030)
+#define SDMA_H_EVTERRDBG	(sdma_base + 0x034)
+#define SDMA_H_CONFIG		(sdma_base + 0x038)
+#define SDMA_ONCE_ENB		(sdma_base + 0x040)
+#define SDMA_ONCE_DATA		(sdma_base + 0x044)
+#define SDMA_ONCE_INSTR		(sdma_base + 0x048)
+#define SDMA_ONCE_STAT		(sdma_base + 0x04c)
+#define SDMA_ONCE_CMD		(sdma_base + 0x050)
+#define SDMA_EVT_MIRROR		(sdma_base + 0x054)
+#define SDMA_ILLINSTADDR	(sdma_base + 0x058)
+#define SDMA_CHN0ADDR		(sdma_base + 0x05c)
+#define SDMA_ONCE_RTB		(sdma_base + 0x060)
+#define SDMA_XTRIG_CONF1	(sdma_base + 0x070)
+#define SDMA_XTRIG_CONF2	(sdma_base + 0x074)
+#define SDMA_CHNENBL_0		(sdma_base + (sdma_version == 2 ? 0x200 : 0x80))
+#define SDMA_CHNPRI_0		(sdma_base + 0x100)
+
+/*
+ * Buffer descriptor status values.
+ */
+#define BD_DONE  0x01
+#define BD_WRAP  0x02
+#define BD_CONT  0x04
+#define BD_INTR  0x08
+#define BD_RROR  0x10
+#define BD_LAST  0x20
+#define BD_EXTD  0x80
+
+/*
+ * Data Node descriptor status values.
+ */
+#define DND_END_OF_FRAME  0x80
+#define DND_END_OF_XFER   0x40
+#define DND_DONE          0x20
+#define DND_UNUSED        0x01
+
+/*
+ * IPCV2 descriptor status values.
+ */
+#define BD_IPCV2_END_OF_FRAME  0x40
+
+#define IPCV2_MAX_NODES        50
+/*
+ * Error bit set in the CCB status field by the SDMA,
+ * in setbd routine, in case of a transfer error
+ */
+#define DATA_ERROR  0x10000000
+
+/*
+ * Buffer descriptor commands.
+ */
+#define C0_ADDR             0x01
+#define C0_LOAD             0x02
+#define C0_DUMP             0x03
+#define C0_SETCTX           0x07
+#define C0_GETCTX           0x03
+#define C0_SETDM            0x01
+#define C0_SETPM            0x04
+#define C0_GETDM            0x02
+#define C0_GETPM            0x08
+/*
+ * Change endianness indicator in the BD command field
+ */
+#define CHANGE_ENDIANNESS   0x80
+
+/*
+ * Mode/Count of data node descriptors - IPCv2
+ */
+#ifdef __BIG_ENDIAN
+struct sdma_mode_count {
+	u32 command :  8; /* command mostlky used for channel 0 */
+	u32 status  :  8; /* E,R,I,C,W,D status bits stored here */
+	u32 count   : 16; /* size of the buffer pointed by this BD */
+};
+#else
+struct sdma_mode_count {
+	u32 count   : 16; /* size of the buffer pointed by this BD */
+	u32 status  :  8; /* E,R,I,C,W,D status bits stored here */
+	u32 command :  8; /* command mostlky used for channel 0 */
+};
+#endif
+
+/*
+ * Buffer descriptor
+ */
+struct sdma_buffer_descriptor {
+	struct sdma_mode_count  mode;
+	void *buffer_addr;    /* address of the buffer described */
+	void *ext_buffer_addr; /* extended buffer address */
+};
+
+/*
+ * Channel control Block
+ */
+struct sdma_channel_control {
+	struct sdma_buffer_descriptor *currentBDptr; /* current buffer descriptor processed */
+	struct sdma_buffer_descriptor *baseBDptr;    /* first element of buffer descriptor array */
+	void *unused;
+	void *unused1;
+};
+
+/**
+ * Context structure.
+ */
+#ifdef __BIG_ENDIAN
+struct sdma_state_registers {
+	u32 sf     : 1; /* source falut while loading data */
+	u32 unused0: 1;
+	u32 rpc    :14; /* return program counter */
+	u32 t      : 1; /* test bit:status of arithmetic & test instruction*/
+	u32 unused1: 1;
+	u32 pc     :14; /* program counter */
+	u32 lm     : 2; /* loop mode */
+	u32 epc    :14; /* loop end program counter */
+	u32 df     : 1; /* destiantion falut while storing data */
+	u32 unused2: 1;
+	u32 spc    :14; /* loop start program counter */
+};
+#else
+struct sdma_state_registers {
+	u32 pc     :14; /* program counter */
+	u32 unused1: 1;
+	u32 t      : 1; /* test bit: status of arithmetic & test instruction*/
+	u32 rpc    :14; /* return program counter */
+	u32 unused0: 1;
+	u32 sf     : 1; /* source falut while loading data */
+	u32 spc    :14; /* loop start program counter */
+	u32 unused2: 1;
+	u32 df     : 1; /* destiantion falut while storing data */
+	u32 epc    :14; /* loop end program counter */
+	u32 lm     : 2; /* loop mode */
+};
+#endif
+
+struct sdma_context_data {
+	struct sdma_state_registers  channel_state; /* channel state bits */
+	u32  gReg[8]; /* general registers */
+	u32  mda; /* burst dma destination address register */
+	u32  msa; /* burst dma source address register */
+	u32  ms;  /* burst dma status  register */
+	u32  md;  /* burst dma data    register */
+	u32  pda; /* peripheral dma destination address register */
+	u32  psa; /* peripheral dma source address register */
+	u32  ps;  /* peripheral dma  status  register */
+	u32  pd;  /* peripheral dma  data    register */
+	u32  ca;  /* CRC polynomial  register */
+	u32  cs;  /* CRC accumulator register */
+	u32  dda; /* dedicated core destination address register */
+	u32  dsa; /* dedicated core source address register */
+	u32  ds;  /* dedicated core status  register */
+	u32  dd;  /* dedicated core data    register */
+	u32  scratch0;
+	u32  scratch1;
+	u32  scratch2;
+	u32  scratch3;
+	u32  scratch4;
+	u32  scratch5;
+	u32  scratch6;
+	u32  scratch7;
+};
+
+struct sdma_channel {
+	/* Channel number */
+	int channel;
+	/* Channel usage name */
+	int in_use;
+	/* Transfer type. Needed for setting SDMA script */
+	int dmamode;
+	/* Peripheral type. Needed for setting SDMA script */
+	sdma_peripheral_type peripheral_type;
+	/* Peripheral event id */
+	int event_id;
+	/* Peripheral event id2 (for channels that use 2 events) */
+	int event_id2;
+	/* Running status */
+	int running;
+	/* SDMA data access word size */
+	unsigned long word_size;
+
+	/* ID of the buffer that was processed */
+	unsigned int buf_tail;
+
+	void (*callback)(int channel, void *arg, int error);
+	void *callback_arg;
+
+	wait_queue_head_t waitq;	/* channel completion waitqeue */
+
+	int num_bd;
+
+	struct sdma_buffer_descriptor *bd;
+	dma_addr_t	bd_phys;
+
+	int pc_from_device, pc_to_device;
+
+	unsigned long flags;
+	dma_addr_t per_address;
+
+	uint32_t event_mask1, event_mask2;
+	uint32_t watermark_level;
+	uint32_t shp_addr, per_addr;
+};
+
+#define MAX_DMA_CHANNELS 32
+#define MXC_SDMA_DEFAULT_PRIORITY 1
+#define MXC_SDMA_MIN_PRIORITY 1
+#define MXC_SDMA_MAX_PRIORITY 7
+
+/*
+ * This enumerates transfer types
+ */
+typedef enum {
+	emi_2_per = 0,		/* EMI memory to peripheral */
+	emi_2_int,		/* EMI memory to internal RAM */
+	emi_2_emi,		/* EMI memory to EMI memory */
+	emi_2_dsp,		/* EMI memory to DSP memory */
+	per_2_int,		/* Peripheral to internal RAM */
+	per_2_emi,		/* Peripheral to internal EMI memory */
+	per_2_dsp,		/* Peripheral to DSP memory */
+	per_2_per,		/* Peripheral to Peripheral */
+	int_2_per,		/* Internal RAM to peripheral */
+	int_2_int,		/* Internal RAM to Internal RAM */
+	int_2_emi,		/* Internal RAM to EMI memory */
+	int_2_dsp,		/* Internal RAM to DSP memory */
+	dsp_2_per,		/* DSP memory to peripheral */
+	dsp_2_int,		/* DSP memory to internal RAM */
+	dsp_2_emi,		/* DSP memory to EMI memory */
+	dsp_2_dsp,		/* DSP memory to DSP memory */
+	emi_2_dsp_loop,		/* EMI memory to DSP memory loopback */
+	dsp_2_emi_loop,		/* DSP memory to EMI memory loopback */
+	dvfs_pll,		/* DVFS script with PLL change       */
+	dvfs_pdr		/* DVFS script without PLL change    */
+} sdma_transfer_type;
+
+/*
+ * Structure containing sdma request  parameters.
+ */
+struct sdma_script_start_addrs {
+	int ap_2_ap_addr;
+	int ap_2_bp_addr;
+	int ap_2_ap_fixed_addr;
+	int bp_2_ap_addr;
+	int loopback_on_dsp_side_addr;
+	int mcu_interrupt_only_addr;
+
+	int firi_2_per_addr;
+	int firi_2_mcu_addr;
+	int per_2_firi_addr;
+	int mcu_2_firi_addr;
+
+	int uart_2_per_addr;
+	int uart_2_mcu_addr;
+	int per_2_app_addr;
+	int mcu_2_app_addr;
+	int per_2_per_addr;
+
+	int uartsh_2_per_addr;
+	int uartsh_2_mcu_addr;
+	int per_2_shp_addr;
+	int mcu_2_shp_addr;
+
+	int ata_2_mcu_addr;
+	int mcu_2_ata_addr;
+
+	int app_2_per_addr;
+	int app_2_mcu_addr;
+	int shp_2_per_addr;
+	int shp_2_mcu_addr;
+
+	int mshc_2_mcu_addr;
+	int mcu_2_mshc_addr;
+
+	int spdif_2_mcu_addr;
+	int mcu_2_spdif_addr;
+
+	int asrc_2_mcu_addr;
+
+	int ext_mem_2_ipu_addr;
+
+	int descrambler_addr;
+
+	int dptc_dvfs_addr;
+
+	int utra_addr;
+
+	int ram_code_start_addr;
+};
+
+#define SDMA_FIRMWARE_MAGIC 0x414d4453
+
+struct sdma_firmware_header {
+	uint32_t	magic; /* "SDMA" */
+	uint32_t	version_major;	/* increased whenever layout of struct sdma_script_start_addrs changes */
+	uint32_t	version_minor;	/* firmware version */
+	uint32_t	script_addrs_start; /* offset of struct sdma_script_start_addrs in this image */
+	uint32_t	num_script_addrs; /* Number of script addresses in this image */
+	uint32_t	ram_code_start; /* offset of SDMA ram image in this firmware image */
+	uint32_t	ram_code_size; /* size of SDMA ram image */
+};
+
+static struct sdma_channel sdma_data[MAX_DMA_CHANNELS];
+static struct sdma_channel_control *channel_control;
+static void __iomem *sdma_base;
+static int sdma_version;
+static int sdma_num_events;
+static struct sdma_context_data *sdma_context;
+dma_addr_t sdma_context_phys;
+
+#define SDMA_H_CONFIG_DSPDMA	(1 << 12) /* indicates if the DSPDMA is used */
+#define SDMA_H_CONFIG_RTD_PINS	(1 << 11) /* indicates if Real-Time Debug pins are enabled */
+#define SDMA_H_CONFIG_ACR	(1 << 4)  /* indicates if AHB freq /core freq = 2 or 1 */
+#define SDMA_H_CONFIG_CSM	(3)       /* indicates which context switch mode is selected*/
+
+static int sdma_config_ownership(int channel, int event_override,
+		   int mcu_verride, int dsp_override)
+{
+	u32 evt, mcu, dsp;
+
+	if (event_override && mcu_verride && dsp_override)
+		return -EINVAL;
+
+	evt = readl(SDMA_H_EVTOVR);
+	mcu = readl(SDMA_H_HOSTOVR);
+	dsp = readl(SDMA_H_DSPOVR);
+
+	if (dsp_override)
+		dsp &= ~(1 << channel);
+	else
+		dsp |= (1 << channel);
+
+	if (event_override)
+		evt &= ~(1 << channel);
+	else
+		evt |= (1 << channel);
+
+	if (mcu_verride)
+		mcu &= ~(1 << channel);
+	else
+		mcu |= (1 << channel);
+
+	writel(evt, SDMA_H_EVTOVR);
+	writel(mcu, SDMA_H_HOSTOVR);
+	writel(dsp, SDMA_H_DSPOVR);
+
+	return 0;
+}
+
+/*
+ * sdma_run_channel - run a channel and wait till it's done
+ */
+static int sdma_run_channel(int channel)
+{
+	struct sdma_channel *sdma = &sdma_data[channel];
+	int ret;
+
+	writel(1 << channel, SDMA_H_START);
+
+	ret = wait_event_interruptible(sdma->waitq,
+			!(readl(SDMA_H_STATSTOP) & (1 << channel)));
+	return ret;
+}
+
+static int sdma_load_script(void *buf, int size, int address)
+{
+	struct sdma_buffer_descriptor *bd0 = sdma_data[0].bd;
+	void *buf_virt;
+	dma_addr_t buf_phys;
+	int ret;
+
+	buf_virt = dma_alloc_coherent(NULL,
+			size,
+			&buf_phys, GFP_KERNEL);
+	if (!buf_virt)
+		return -ENOMEM;
+
+	bd0->mode.command = C0_SETPM;
+	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
+	bd0->mode.count = size / 2;
+	bd0->buffer_addr = (void *)buf_phys;
+	bd0->ext_buffer_addr = (void *)address;
+
+	memcpy(buf_virt, buf, size);
+
+	ret = sdma_run_channel(0);
+
+	dma_free_coherent(NULL, size, buf_virt, buf_phys);
+
+	return ret;
+}
+
+static void sdma_event_enable(int channel, int event)
+{
+	u32 val;
+
+	val = readl(SDMA_CHNENBL_0 + event * 4);
+	val |= (1 << channel);
+	writel(val, SDMA_CHNENBL_0 + event * 4);
+}
+
+static void sdma_event_disable(int channel, int event)
+{
+	u32 val;
+
+	val = readl(SDMA_CHNENBL_0 + event * 4);
+	val &= ~(1 << channel);
+	writel(val, SDMA_CHNENBL_0 + event * 4);
+}
+
+static void mxc_sdma_handle_channel_loop(int channel)
+{
+	struct sdma_channel *sdma = &sdma_data[channel];
+	struct sdma_buffer_descriptor *bd;
+	int error = 0;
+
+	/*
+	 * loop mode. Iterate over descriptors, re-setup them and
+	 * call callback function.
+	 */
+	while (1) {
+		bd = &sdma->bd[sdma->buf_tail];
+
+		if (bd->mode.status & BD_DONE)
+			break;
+
+		if (bd->mode.status & BD_RROR)
+			error = -EIO;
+
+		bd->mode.status |= BD_DONE;
+		sdma->buf_tail++;
+		sdma->buf_tail %= sdma->num_bd;
+
+		if (sdma->callback)
+			sdma->callback(channel, sdma->callback_arg, error);
+	}
+}
+
+static void mxc_sdma_handle_channel_normal(int channel)
+{
+	struct sdma_channel *sdma = &sdma_data[channel];
+	struct sdma_buffer_descriptor *bd;
+	int i, error = 0;
+
+	/*
+	 * non loop mode. Iterate over all descriptors, collect
+	 * errors and call callback function
+	 */
+	for (i = 0; i < sdma->num_bd; i++) {
+		bd = &sdma->bd[i];
+
+		 if (bd->mode.status & (BD_DONE | BD_RROR))
+			error = -EIO;
+	}
+
+	if (sdma->callback)
+		sdma->callback(channel, sdma->callback_arg, error);
+}
+
+static void mxc_sdma_handle_channel(int channel)
+{
+	struct sdma_channel *sdma = &sdma_data[channel];
+
+	sdma->running = 0;
+
+	wake_up_interruptible(&sdma->waitq);
+
+	/* not interested in channel 0 interrupts */
+	if (!channel)
+		return;
+
+	if (sdma->flags & IMX_DMA_SG_LOOP)
+		mxc_sdma_handle_channel_loop(channel);
+	else
+		mxc_sdma_handle_channel_normal(channel);
+}
+
+static irqreturn_t sdma_int_handler(int irq, void *dev_id)
+{
+	u32 stat;
+
+	stat = readl(SDMA_H_INTR);
+	writel(stat, SDMA_H_INTR);
+
+	while (stat) {
+		int channel = fls(stat) - 1;
+
+		mxc_sdma_handle_channel(channel);
+
+		stat &= ~(1 << channel);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct clk *sdma_clk;
+
+/*
+ * Stores the start address of the SDMA scripts
+ */
+static struct sdma_script_start_addrs __sdma_script_addrs;
+static struct sdma_script_start_addrs *sdma_script_addrs = &__sdma_script_addrs;
+
+/*
+ * sets the pc of SDMA script according to the peripheral type
+ */
+static void sdma_get_pc(struct sdma_channel *sdma,
+		sdma_peripheral_type peripheral_type)
+{
+	int res = 0;
+	int per_2_emi = 0, emi_2_per = 0;
+	int per_2_int = 0, int_2_per = 0;
+	int per_2_per = 0, emi_2_emi = 0;
+
+	sdma->pc_from_device = 0;
+	sdma->pc_to_device = 0;
+
+	switch (peripheral_type) {
+	case IMX_DMATYPE_MEMORY:
+		emi_2_emi = sdma_script_addrs->ap_2_ap_addr;
+		break;
+	case IMX_DMATYPE_DSP:
+		emi_2_per = sdma_script_addrs->bp_2_ap_addr;
+		per_2_emi = sdma_script_addrs->ap_2_bp_addr;
+		break;
+	case IMX_DMATYPE_FIRI:
+		per_2_int = sdma_script_addrs->firi_2_per_addr;
+		per_2_emi = sdma_script_addrs->firi_2_mcu_addr;
+		int_2_per = sdma_script_addrs->per_2_firi_addr;
+		emi_2_per = sdma_script_addrs->mcu_2_firi_addr;
+		break;
+	case IMX_DMATYPE_UART:
+		per_2_int = sdma_script_addrs->uart_2_per_addr;
+		per_2_emi = sdma_script_addrs->uart_2_mcu_addr;
+		int_2_per = sdma_script_addrs->per_2_app_addr;
+		emi_2_per = sdma_script_addrs->mcu_2_app_addr;
+		break;
+	case IMX_DMATYPE_UART_SP:
+		per_2_int = sdma_script_addrs->uartsh_2_per_addr;
+		per_2_emi = sdma_script_addrs->uartsh_2_mcu_addr;
+		int_2_per = sdma_script_addrs->per_2_shp_addr;
+		emi_2_per = sdma_script_addrs->mcu_2_shp_addr;
+		break;
+	case IMX_DMATYPE_ATA:
+		per_2_emi = sdma_script_addrs->ata_2_mcu_addr;
+		emi_2_per = sdma_script_addrs->mcu_2_ata_addr;
+		break;
+	case IMX_DMATYPE_CSPI:
+	case IMX_DMATYPE_EXT:
+	case IMX_DMATYPE_SSI:
+		per_2_int = sdma_script_addrs->app_2_per_addr;
+		per_2_emi = sdma_script_addrs->app_2_mcu_addr;
+		int_2_per = sdma_script_addrs->per_2_app_addr;
+		emi_2_per = sdma_script_addrs->mcu_2_app_addr;
+		break;
+	case IMX_DMATYPE_SSI_SP:
+	case IMX_DMATYPE_MMC:
+	case IMX_DMATYPE_SDHC:
+	case IMX_DMATYPE_CSPI_SP:
+	case IMX_DMATYPE_ESAI:
+	case IMX_DMATYPE_MSHC_SP:
+		per_2_int = sdma_script_addrs->shp_2_per_addr;
+		per_2_emi = sdma_script_addrs->shp_2_mcu_addr;
+		int_2_per = sdma_script_addrs->per_2_shp_addr;
+		emi_2_per = sdma_script_addrs->mcu_2_shp_addr;
+		break;
+	case IMX_DMATYPE_ASRC:
+		per_2_emi = sdma_script_addrs->asrc_2_mcu_addr;
+		emi_2_per = sdma_script_addrs->asrc_2_mcu_addr;
+		per_2_per = sdma_script_addrs->per_2_per_addr;
+		break;
+	case IMX_DMATYPE_MSHC:
+		per_2_emi = sdma_script_addrs->mshc_2_mcu_addr;
+		emi_2_per = sdma_script_addrs->mcu_2_mshc_addr;
+		break;
+	case IMX_DMATYPE_CCM:
+		per_2_emi = sdma_script_addrs->dptc_dvfs_addr;
+		break;
+	case IMX_DMATYPE_FIFO_MEMORY:
+		res = sdma_script_addrs->ap_2_ap_fixed_addr;
+		break;
+	case IMX_DMATYPE_SPDIF:
+		per_2_emi = sdma_script_addrs->spdif_2_mcu_addr;
+		emi_2_per = sdma_script_addrs->mcu_2_spdif_addr;
+		break;
+	case IMX_DMATYPE_IPU_MEMORY:
+		emi_2_per = sdma_script_addrs->ext_mem_2_ipu_addr;
+		break;
+	default:
+		break;
+	}
+
+	sdma->pc_from_device = per_2_emi;
+	sdma->pc_to_device = emi_2_per;
+}
+
+static int sdma_load_context(int channel)
+{
+	struct sdma_channel *sdma = &sdma_data[channel];
+	int load_address;
+	struct sdma_buffer_descriptor *bd0 = sdma_data[0].bd;
+	int ret;
+
+	if (sdma->dmamode == DMA_MODE_READ)
+		load_address = sdma->pc_from_device;
+	else
+		load_address = sdma->pc_to_device;
+
+	if (load_address < 0)
+		return load_address;
+
+	pr_debug("%s: load_address = %d\n", __func__, load_address);
+	pr_debug("%s: wml = 0x%08x\n", __func__, sdma->watermark_level);
+	pr_debug("%s: shp_addr = 0x%08x\n", __func__, sdma->shp_addr);
+	pr_debug("%s: per_addr = 0x%08x\n", __func__, sdma->per_addr);
+	pr_debug("%s: event_mask1 = 0x%08x\n", __func__, sdma->event_mask1);
+	pr_debug("%s: event_mask2 = 0x%08x\n", __func__, sdma->event_mask2);
+
+	memset(sdma_context, 0, sizeof(*sdma_context));
+	sdma_context->channel_state.pc = load_address;
+
+	/* Send by context the event mask,base address for peripheral
+	 * and watermark level
+	 */
+	sdma_context->gReg[0] = sdma->event_mask2;
+	sdma_context->gReg[1] = sdma->event_mask1;
+	sdma_context->gReg[2] = sdma->per_addr;
+	sdma_context->gReg[6] = sdma->shp_addr;
+	sdma_context->gReg[7] = sdma->watermark_level;
+
+	bd0->mode.command = C0_SETDM;
+	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
+	bd0->mode.count = sizeof(*sdma_context) / 4;
+	bd0->buffer_addr = (void *)sdma_context_phys;
+	bd0->ext_buffer_addr = (void *) (2048 + (sizeof(*sdma_context) / 4) * channel);
+
+	ret = sdma_run_channel(0);
+
+	return ret;
+}
+
+static void sdma_disable_channel(int channel)
+{
+	writel(1 << channel, SDMA_H_STATSTOP);
+
+	sdma_data[channel].running = 0;
+}
+
+static int sdma_config_channel(int channel, struct imx_dma_config *cfg)
+{
+	struct sdma_channel *sdma = &sdma_data[channel];
+	int ret;
+
+	sdma_disable_channel(channel);
+
+	sdma->flags = cfg->flags;
+	sdma->per_address = cfg->dma_address;
+	sdma->word_size = cfg->word_size;
+	sdma->dmamode = DMA_MODE_READ;
+	sdma->peripheral_type = cfg->peripheral_type;
+	sdma->watermark_level = cfg->burstlen;
+	sdma->callback = cfg->completion_handler;
+	sdma->callback_arg = cfg->driver_data;
+
+	sdma->event_mask1 = 0;
+	sdma->event_mask2 = 0;
+	sdma->shp_addr = 0;
+	sdma->per_addr = 0;
+
+	if (cfg->dma_request)
+		sdma_event_enable(channel, cfg->dma_request);
+
+	sdma->event_id = cfg->dma_request;
+
+	switch (cfg->peripheral_type) {
+	case IMX_DMATYPE_DSP:
+		sdma_config_ownership(channel, 0, 1, 1);
+		break;
+	case IMX_DMATYPE_MEMORY:
+		sdma_config_ownership(channel, 0, 1, 0);
+		break;
+	default:
+		sdma_config_ownership(channel, 1, 1, 0);
+		break;
+	}
+
+	sdma_get_pc(sdma, sdma->peripheral_type);
+
+	if ((sdma->peripheral_type != IMX_DMATYPE_MEMORY) &&
+			(sdma->peripheral_type != IMX_DMATYPE_DSP)) {
+		/* Handle multiple event channels differently */
+		if (sdma->event_id2) {
+			sdma->event_mask2 = 1 << (sdma->event_id2 % 32);
+			if (sdma->event_id2 > 31)
+				sdma->watermark_level |= 1 << 31;
+			sdma->event_mask1 = 1 << (sdma->event_id % 32);
+			if (sdma->event_id > 31)
+				sdma->watermark_level |= 1 << 30;
+		} else {
+			sdma->event_mask1 = 1 << sdma->event_id;
+			sdma->event_mask2 = 1 << (sdma->event_id - 32);
+		}
+		/* Watermark Level */
+		sdma->watermark_level |= sdma->watermark_level;
+		/* Address */
+		sdma->shp_addr = sdma->per_address;
+	} else {
+		sdma->watermark_level = 0; /* FIXME: M3_BASE_ADDRESS */
+	}
+
+	ret = sdma_load_context(channel);
+
+	return ret;
+}
+
+static int sdma_set_channel_priority(unsigned int channel, unsigned int priority)
+{
+	if (priority < MXC_SDMA_MIN_PRIORITY
+	    || priority > MXC_SDMA_MAX_PRIORITY) {
+		return -EINVAL;
+	}
+
+	writel(priority, SDMA_CHNPRI_0 + 4 * channel);
+
+	return 0;
+}
+
+static int __sdma_request_channel(int channel)
+{
+	struct sdma_channel *sdma = &sdma_data[channel];
+	int ret = -EBUSY;
+
+	if (sdma->in_use)
+		goto out;
+
+	sdma->bd = dma_alloc_coherent(NULL, PAGE_SIZE, &sdma->bd_phys, GFP_KERNEL);
+	if (!sdma->bd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memset(sdma->bd, 0, PAGE_SIZE);
+
+	channel_control[channel].baseBDptr = (void *)sdma->bd_phys;
+	channel_control[channel].currentBDptr = (void *)sdma->bd_phys;
+
+	sdma_set_channel_priority(channel, MXC_SDMA_DEFAULT_PRIORITY);
+
+	init_waitqueue_head(&sdma->waitq);
+
+	sdma->in_use = 1;
+	sdma->buf_tail = 0;
+
+	ret = 0;
+out:
+
+	return ret;
+}
+
+static int sdma_request(enum imx_dma_prio __prio)
+{
+	int ret = 0, channel, prio;
+
+	clk_enable(sdma_clk);
+
+	switch (__prio) {
+	case DMA_PRIO_HIGH:
+		prio = 3;
+		break;
+	case DMA_PRIO_MEDIUM:
+		prio = 2;
+		break;
+	case DMA_PRIO_LOW:
+	default:
+		prio = 1;
+		break;
+	}
+
+	/* Get the first free channel */
+	for (channel = MAX_DMA_CHANNELS - 1; channel > 0; channel--) {
+		ret = __sdma_request_channel(channel);
+		if (!ret) {
+			sdma_set_channel_priority(channel, prio);
+			return channel;
+		}
+	}
+
+	clk_disable(sdma_clk);
+	return -EBUSY;
+}
+
+static void sdma_free(int channel)
+{
+	struct sdma_channel *sdma = &sdma_data[channel];
+
+	sdma_disable_channel(channel);
+
+	if (sdma->event_id)
+		sdma_event_disable(channel, sdma->event_id);
+	if (sdma->event_id2)
+		sdma_event_disable(channel, sdma->event_id2);
+
+	sdma->event_id = 0;
+	sdma->event_id2 = 0;
+
+	sdma_set_channel_priority(channel, 0);
+
+	dma_free_coherent(NULL, PAGE_SIZE, sdma->bd, sdma->bd_phys);
+
+	sdma_data[channel].in_use = 0;
+
+	clk_disable(sdma_clk);
+}
+
+#define NUM_BD (int)(PAGE_SIZE / sizeof(struct sdma_buffer_descriptor))
+
+static int sdma_setup_sg(int channel, struct scatterlist *sg, unsigned int sgcount,
+			unsigned int dma_length, unsigned int dmamode)
+{
+	struct sdma_channel *sdma = &sdma_data[channel];
+	int i, count, ret;
+
+	pr_debug("SDMA: setting up %d entries for channel %d. total length: %d\n",
+			sgcount, channel, dma_length);
+
+	sdma->dmamode = dmamode;
+	ret = sdma_load_context(channel);
+	if (ret)
+		return ret;
+
+	if (sgcount > NUM_BD) {
+		pr_err("SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
+				channel, sgcount, NUM_BD);
+	}
+
+	for (i = 0; i < sgcount; i++) {
+		struct sdma_buffer_descriptor *bd = &sdma->bd[i];
+		int param;
+
+		if (dmamode == DMA_MODE_READ)
+			bd->buffer_addr = (void *)sg->dma_address;
+		else
+			bd->buffer_addr = (void *)sg->dma_address;
+
+		count = sg->length < dma_length ? sg->length : dma_length;
+		dma_length -= count;
+
+		if (count > 0xffff) {
+			pr_err("SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
+					channel, count, 0xffff);
+			return -EINVAL;
+		}
+
+		bd->mode.count = count;
+
+		if (sdma->word_size > 4)
+			return -EINVAL;
+		if (sdma->word_size == 4)
+			bd->mode.command = 0;
+		else
+			bd->mode.command = sdma->word_size;
+
+		param = BD_DONE | BD_EXTD | BD_CONT;
+
+		if (sdma->flags & IMX_DMA_SG_LOOP) {
+			param |= BD_INTR;
+			if (i + 1 == sgcount)
+				param |= BD_WRAP;
+		}
+
+		if (i + 1 == sgcount)
+			param |= BD_INTR;
+
+		pr_debug("entry %d: count: %d dma: 0x%08x %s%s\n",
+				i, count, sg->dma_address,
+				param & BD_WRAP ? "wrap" : "",
+				param & BD_INTR ? " intr" : "");
+
+		bd->mode.status = param;
+
+		sg++;
+	}
+
+	sdma->num_bd = sgcount;
+	channel_control[channel].currentBDptr = (void *)sdma->bd_phys;
+
+	return 0;
+}
+
+static void sdma_enable_channel(int channel)
+{
+	if (sdma_data[channel].running == 0) {
+		sdma_data[channel].running = 1;
+		writel(1 << channel, SDMA_H_START);
+	}
+}
+
+static int sdma_setup_single(int channel, dma_addr_t mem, int dma_length,
+		unsigned int dmamode)
+{
+	return -ENOSYS;
+}
+
+static struct imx_dma_operations sdma_ops = {
+	.config_channel = sdma_config_channel,
+	.setup_single = sdma_setup_single,
+	.setup_sg = sdma_setup_sg,
+	.enable = sdma_enable_channel,
+	.disable = sdma_disable_channel,
+	.request = sdma_request,
+	.free = sdma_free,
+	.num_channels = MAX_DMA_CHANNELS,
+};
+
+static int __init sdma_init(unsigned long phys_base, int irq, int version,
+		void *ram_code,
+		int ram_code_size)
+{
+	int i, ret;
+	int channel;
+	dma_addr_t ccb_phys;
+
+	sdma_version = version;
+	switch (sdma_version) {
+	case 1:
+		sdma_num_events = 32;
+		break;
+	case 2:
+		sdma_num_events = 48;
+		break;
+	default:
+		pr_err("SDMA: Unknown version %d. aborting\n", sdma_version);
+		return -ENODEV;
+	}
+
+	clk_enable(sdma_clk);
+
+	sdma_base = ioremap(phys_base, 4096);
+	if (!sdma_base) {
+		ret = -ENOMEM;
+		goto err_ioremap;
+	}
+
+	/* Initialize SDMA private data */
+	memset(sdma_data, 0, sizeof(struct sdma_channel) * MAX_DMA_CHANNELS);
+
+	for (channel = 0; channel < MAX_DMA_CHANNELS; channel++)
+		sdma_data[channel].channel = channel;
+
+	ret = request_irq(irq, sdma_int_handler, 0, "sdma", NULL);
+	if (ret)
+		goto err_request_irq;
+
+	/* Be sure SDMA has not started yet */
+	writel(0, SDMA_H_C0PTR);
+
+	channel_control = dma_alloc_coherent(NULL,
+			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control) + 
+			sizeof(struct sdma_context_data),
+			&ccb_phys, GFP_KERNEL);
+
+	if (!channel_control) {
+		ret = -ENOMEM;
+		goto err_dma_alloc;
+	}
+
+	sdma_context = (void *)channel_control +
+		MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control);
+	sdma_context_phys = ccb_phys +
+		MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control);
+
+	/* Zero-out the CCB structures array just allocated */
+	memset(channel_control, 0,
+			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control));
+
+	/* disable all channels */
+	for (i = 0; i < sdma_num_events; i++)
+		writel(0, SDMA_CHNENBL_0 + i * 4);
+
+	/* All channels have priority 0 */
+	for (i = 0; i < MAX_DMA_CHANNELS; i++)
+		writel(0, SDMA_CHNPRI_0 + i * 4);
+
+	ret = __sdma_request_channel(0);
+	BUG_ON(ret);
+	sdma_config_ownership(0, 0, 1, 0);
+
+	/* Set Command Channel (Channel Zero) */
+	writel(0x4050, SDMA_CHN0ADDR);
+
+	/* Set bits of CONFIG register but with static context switching */
+	/* FIXME: Check whether to set ACR bit depending on clock ratios */
+	writel(0, SDMA_H_CONFIG);
+
+	writel(ccb_phys, SDMA_H_C0PTR);
+
+	/* download the RAM image for SDMA */
+	sdma_load_script(ram_code,
+			ram_code_size,
+			sdma_script_addrs->ram_code_start_addr);
+
+	/* Set bits of CONFIG register with given context switching mode */
+	writel(SDMA_H_CONFIG_CSM, SDMA_H_CONFIG);
+
+	/* Initializes channel's priorities */
+	sdma_set_channel_priority(0, 7);
+
+	clk_disable(sdma_clk);
+
+	imx_dma_ops_register(&sdma_ops);
+
+	return 0;
+
+err_dma_alloc:
+	free_irq(irq, NULL);
+err_request_irq:
+	iounmap(sdma_base);
+err_ioremap:
+	clk_disable(sdma_clk);
+	pr_err("%s failed with %d\n", __func__, ret);
+	return ret;
+}
+
+static int __devinit sdma_probe(struct platform_device *pdev)
+{
+	int ret;
+	const struct firmware *fw;
+	const struct sdma_firmware_header *header;
+	const struct sdma_script_start_addrs *addr;
+	int irq;
+	unsigned short *ram_code;
+	struct resource *iores;
+	struct sdma_platform_data *pdata = pdev->dev.platform_data;
+	int version;
+	char *cpustr, *fwname;
+
+	/* there can be only one */
+	BUG_ON(sdma_base);
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (!iores || irq < 0 || !pdata)
+		return -EINVAL;
+
+	sdma_clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sdma_clk)) {
+		ret = PTR_ERR(sdma_clk);
+		goto err_clk;
+	}
+
+	if (cpu_is_mx31()) {
+		cpustr = "imx31";
+		version = mx31_revision() >> 4;
+	} else if (cpu_is_mx35()) {
+		cpustr = "imx35";
+/* FIXME:	version = mx35_revision(); */
+		version = 2;
+	} else {
+		ret = -EINVAL;
+		goto err_cputype;
+	}
+
+	fwname = kasprintf(GFP_KERNEL, "sdma-%s-to%d.bin", cpustr, version);
+	if (!fwname) {
+		ret = -ENOMEM;
+		goto err_cputype;
+	}
+
+	ret = request_firmware(&fw, fwname, &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "request firmware \"%s\" failed with %d\n",
+				fwname, ret);
+		kfree(fwname);
+		goto err_cputype;
+	}
+	kfree(fwname);
+
+	if (fw->size < sizeof(*header))
+		goto err_firmware;
+
+	header = (struct sdma_firmware_header *)fw->data;
+
+	if (header->magic != SDMA_FIRMWARE_MAGIC)
+		goto err_firmware;
+	if (header->ram_code_start + header->ram_code_size > fw->size)
+		goto err_firmware;
+
+	addr = (void *)header + header->script_addrs_start;
+	ram_code = (void *)header + header->ram_code_start;
+	memcpy(&__sdma_script_addrs, addr, sizeof(*addr));
+
+	ret = sdma_init(iores->start, irq, pdata->sdma_version,
+			ram_code, header->ram_code_size);
+	if (ret)
+		goto err_firmware;
+
+	dev_info(&pdev->dev, "initialized (firmware %d.%d)\n",
+			header->version_major,
+			header->version_minor);
+
+	release_firmware(fw);
+
+	return 0;
+
+err_firmware:
+	release_firmware(fw);
+err_cputype:
+	clk_put(sdma_clk);
+err_clk:
+	return 0;
+}
+
+static int __devexit sdma_remove(struct platform_device *pdev)
+{
+	return -EBUSY;
+}
+
+static struct platform_driver sdma_driver = {
+	.driver		= {
+		.name	= "imx-sdma",
+	},
+	.probe		= sdma_probe,
+	.remove		= __devexit_p(sdma_remove),
+};
+
+static int __init sdma_module_init(void)
+{
+	return platform_driver_register(&sdma_driver);
+}
+module_init(sdma_module_init);
+
+MODULE_AUTHOR("Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>");
+MODULE_DESCRIPTION("i.MX SDMA driver");
+MODULE_LICENSE("GPL");
-- 
1.7.1
