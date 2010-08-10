From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 10 Aug 2010 21:08:54 +0200
Subject: [PATCH 4/8] ARM i.MX: add SDMA driver
In-Reply-To: <1281344743-2029-5-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20100810190854.GB9149@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 09, 2010 at 11:05:39AM +0200, Sascha Hauer wrote:
> This patch adds DMA support for i.MX25/31/35/51 based SoCs.
> The SDMA engine is a scatter/gather DMA engine which is implemented
> as a seperate coprocessor. SDMA needs its own firmware which is
> requested using the standard request_firmware mechanism. The firmware
> has different entry points for each peripheral type, so drivers
> have to pass the peripheral type to the DMA engine which in turn
> picks the correct firmware entry point from a table contained in
> the firmware image itself.
> The original Freescale code also supports support for transfering
> data to the internal SRAM which needs different entry points to
> the firmware. Support for this is currently not implemented. Also,
> support for the ASRC (asymmetric sample rate converter) is skipped.
> 
> This code has been tested with sound on i.MX31/35 and with SD/MMC on
> i.MX31. It should work on i.MX25/51, but this is currently untested.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/Kconfig             |    2 +
>  arch/arm/plat-mxc/Kconfig             |   10 +
>  arch/arm/plat-mxc/Makefile            |    1 +
>  arch/arm/plat-mxc/include/mach/sdma.h |    8 +
>  arch/arm/plat-mxc/sdma.c              | 1181 +++++++++++++++++++++++++++++++++
>  5 files changed, 1202 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/sdma.h
>  create mode 100644 arch/arm/plat-mxc/sdma.c
> 
> diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> index 85beece..301375c 100644
> --- a/arch/arm/mach-mx3/Kconfig
> +++ b/arch/arm/mach-mx3/Kconfig
> @@ -3,12 +3,14 @@ if ARCH_MX3
>  config ARCH_MX31
>  	select ARCH_HAS_RNGA
>  	select ARCH_MXC_AUDMUX_V2
> +	select IMX_HAVE_SDMA
>  	bool
>  
>  config ARCH_MX35
>  	bool
>  	select ARCH_MXC_IOMUX_V3
>  	select ARCH_MXC_AUDMUX_V2
> +	select IMX_HAVE_SDMA
>  
>  comment "MX3 platforms:"
>  
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index 0527e65..6741625 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -109,4 +109,14 @@ config ARCH_MXC_AUDMUX_V1
>  config ARCH_MXC_AUDMUX_V2
>  	bool
>  
> +config IMX_HAVE_SDMA
> +	bool
> +
> +config IMX_SDMA
> +	depends on IMX_HAVE_SDMA
> +	tristate "Enable SDMA support"
> +	help
> +	  Include support for the SDMA engine. The SDMA engine needs additional
> +	  firmware support. SDMA can be compiled as a module to support loading
> +	  the firmware when a rootfs is present.
>  endif
> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index ff9880c..378f8ca 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_MXC_ULPI) += ulpi.o
>  obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
>  obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
>  obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
> +obj-$(CONFIG_IMX_SDMA) += sdma.o
>  ifdef CONFIG_SND_IMX_SOC
>  obj-y += ssi-fiq.o
>  obj-y += ssi-fiq-ksym.o
> diff --git a/arch/arm/plat-mxc/include/mach/sdma.h b/arch/arm/plat-mxc/include/mach/sdma.h
> new file mode 100644
> index 0000000..5d542b8
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/sdma.h
> @@ -0,0 +1,8 @@
> +#ifndef __MACH_MXC_SDMA_H__
> +#define __MACH_MXC_SDMA_H__
__MACH_SDMA_H__ please

> +
> +struct sdma_platform_data {
> +	int sdma_version;
> +};
> +
> +#endif /* __MACH_MXC_SDMA_H__ */
> diff --git a/arch/arm/plat-mxc/sdma.c b/arch/arm/plat-mxc/sdma.c
> new file mode 100644
> index 0000000..3fbc8d8
> --- /dev/null
> +++ b/arch/arm/plat-mxc/sdma.c
> @@ -0,0 +1,1181 @@
> +/*
> + * arch/arm/plat-mxc/sdma.c
> + *
> + * This file contains a driver for the Freescale Smart DMA engine
> + *
> + * Copyright 2010 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> + *
> + * Based on code from Freescale:
> + *
> + * Copyright 2004-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/semaphore.h>
> +#include <linux/spinlock.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/firmware.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/irq.h>
> +#include <mach/sdma.h>
> +#include <mach/dma.h>
> +#include <mach/hardware.h>
> +
> +/* SDMA registers */
> +#define SDMA_H_C0PTR		(sdma_base + 0x000)
> +#define SDMA_H_INTR		(sdma_base + 0x004)
> +#define SDMA_H_STATSTOP		(sdma_base + 0x008)
> +#define SDMA_H_START		(sdma_base + 0x00c)
> +#define SDMA_H_EVTOVR		(sdma_base + 0x010)
> +#define SDMA_H_DSPOVR		(sdma_base + 0x014)
> +#define SDMA_H_HOSTOVR		(sdma_base + 0x018)
> +#define SDMA_H_EVTPEND		(sdma_base + 0x01c)
> +#define SDMA_H_DSPENBL		(sdma_base + 0x020)
> +#define SDMA_H_RESET		(sdma_base + 0x024)
> +#define SDMA_H_EVTERR		(sdma_base + 0x028)
> +#define SDMA_H_INTRMSK		(sdma_base + 0x02c)
> +#define SDMA_H_PSW		(sdma_base + 0x030)
> +#define SDMA_H_EVTERRDBG	(sdma_base + 0x034)
> +#define SDMA_H_CONFIG		(sdma_base + 0x038)
> +#define SDMA_ONCE_ENB		(sdma_base + 0x040)
> +#define SDMA_ONCE_DATA		(sdma_base + 0x044)
> +#define SDMA_ONCE_INSTR		(sdma_base + 0x048)
> +#define SDMA_ONCE_STAT		(sdma_base + 0x04c)
> +#define SDMA_ONCE_CMD		(sdma_base + 0x050)
> +#define SDMA_EVT_MIRROR		(sdma_base + 0x054)
> +#define SDMA_ILLINSTADDR	(sdma_base + 0x058)
> +#define SDMA_CHN0ADDR		(sdma_base + 0x05c)
> +#define SDMA_ONCE_RTB		(sdma_base + 0x060)
> +#define SDMA_XTRIG_CONF1	(sdma_base + 0x070)
> +#define SDMA_XTRIG_CONF2	(sdma_base + 0x074)
> +#define SDMA_CHNENBL_0		(sdma_base + (sdma_version == 2 ? 0x200 : 0x80))
> +#define SDMA_CHNPRI_0		(sdma_base + 0x100)
> +
> +/*
> + * Buffer descriptor status values.
> + */
> +#define BD_DONE  0x01
> +#define BD_WRAP  0x02
> +#define BD_CONT  0x04
> +#define BD_INTR  0x08
> +#define BD_RROR  0x10
> +#define BD_LAST  0x20
> +#define BD_EXTD  0x80
> +
> +/*
> + * Data Node descriptor status values.
> + */
> +#define DND_END_OF_FRAME  0x80
> +#define DND_END_OF_XFER   0x40
> +#define DND_DONE          0x20
> +#define DND_UNUSED        0x01
> +
> +/*
> + * IPCV2 descriptor status values.
> + */
> +#define BD_IPCV2_END_OF_FRAME  0x40
> +
> +#define IPCV2_MAX_NODES        50
> +/*
> + * Error bit set in the CCB status field by the SDMA,
> + * in setbd routine, in case of a transfer error
> + */
> +#define DATA_ERROR  0x10000000
> +
> +/*
> + * Buffer descriptor commands.
> + */
> +#define C0_ADDR             0x01
> +#define C0_LOAD             0x02
> +#define C0_DUMP             0x03
> +#define C0_SETCTX           0x07
> +#define C0_GETCTX           0x03
> +#define C0_SETDM            0x01
> +#define C0_SETPM            0x04
> +#define C0_GETDM            0x02
> +#define C0_GETPM            0x08
> +/*
> + * Change endianness indicator in the BD command field
> + */
> +#define CHANGE_ENDIANNESS   0x80
> +
> +/*
> + * Mode/Count of data node descriptors - IPCv2
> + */
> +#ifdef __BIG_ENDIAN
> +struct sdma_mode_count {
> +	u32 command :  8; /* command mostlky used for channel 0 */
> +	u32 status  :  8; /* E,R,I,C,W,D status bits stored here */
> +	u32 count   : 16; /* size of the buffer pointed by this BD */
> +};
> +#else
> +struct sdma_mode_count {
> +	u32 count   : 16; /* size of the buffer pointed by this BD */
> +	u32 status  :  8; /* E,R,I,C,W,D status bits stored here */
> +	u32 command :  8; /* command mostlky used for channel 0 */
> +};
> +#endif
> +
> +/*
> + * Buffer descriptor
> + */
> +struct sdma_buffer_descriptor {
> +	struct sdma_mode_count  mode;
> +	void *buffer_addr;    /* address of the buffer described */
> +	void *ext_buffer_addr; /* extended buffer address */
> +};
> +
> +/*
> + * Channel control Block
> + */
> +struct sdma_channel_control {
> +	struct sdma_buffer_descriptor *currentBDptr; /* current buffer descriptor processed */
> +	struct sdma_buffer_descriptor *baseBDptr;    /* first element of buffer descriptor array */
> +	void *unused;
> +	void *unused1;
> +};
> +
> +/**
> + * Context structure.
> + */
> +#ifdef __BIG_ENDIAN
> +struct sdma_state_registers {
> +	u32 sf     : 1; /* source falut while loading data */
> +	u32 unused0: 1;
> +	u32 rpc    :14; /* return program counter */
> +	u32 t      : 1; /* test bit:status of arithmetic & test instruction*/
> +	u32 unused1: 1;
> +	u32 pc     :14; /* program counter */
> +	u32 lm     : 2; /* loop mode */
> +	u32 epc    :14; /* loop end program counter */
> +	u32 df     : 1; /* destiantion falut while storing data */
> +	u32 unused2: 1;
> +	u32 spc    :14; /* loop start program counter */
> +};
> +#else
> +struct sdma_state_registers {
> +	u32 pc     :14; /* program counter */
> +	u32 unused1: 1;
> +	u32 t      : 1; /* test bit: status of arithmetic & test instruction*/
> +	u32 rpc    :14; /* return program counter */
> +	u32 unused0: 1;
> +	u32 sf     : 1; /* source falut while loading data */
> +	u32 spc    :14; /* loop start program counter */
> +	u32 unused2: 1;
> +	u32 df     : 1; /* destiantion falut while storing data */
> +	u32 epc    :14; /* loop end program counter */
> +	u32 lm     : 2; /* loop mode */
> +};
> +#endif
> +
> +struct sdma_context_data {
> +	struct sdma_state_registers  channel_state; /* channel state bits */
> +	u32  gReg[8]; /* general registers */
> +	u32  mda; /* burst dma destination address register */
> +	u32  msa; /* burst dma source address register */
> +	u32  ms;  /* burst dma status  register */
> +	u32  md;  /* burst dma data    register */
> +	u32  pda; /* peripheral dma destination address register */
> +	u32  psa; /* peripheral dma source address register */
> +	u32  ps;  /* peripheral dma  status  register */
> +	u32  pd;  /* peripheral dma  data    register */
> +	u32  ca;  /* CRC polynomial  register */
> +	u32  cs;  /* CRC accumulator register */
> +	u32  dda; /* dedicated core destination address register */
> +	u32  dsa; /* dedicated core source address register */
> +	u32  ds;  /* dedicated core status  register */
> +	u32  dd;  /* dedicated core data    register */
> +	u32  scratch0;
> +	u32  scratch1;
> +	u32  scratch2;
> +	u32  scratch3;
> +	u32  scratch4;
> +	u32  scratch5;
> +	u32  scratch6;
> +	u32  scratch7;
> +};
> +
> +struct sdma_channel {
> +	/* Channel number */
> +	int channel;
> +	/* Channel usage name */
> +	int in_use;
> +	/* Transfer type. Needed for setting SDMA script */
> +	int dmamode;
> +	/* Peripheral type. Needed for setting SDMA script */
> +	sdma_peripheral_type peripheral_type;
> +	/* Peripheral event id */
> +	int event_id;
> +	/* Peripheral event id2 (for channels that use 2 events) */
> +	int event_id2;
> +	/* Running status */
> +	int running;
> +	/* SDMA data access word size */
> +	unsigned long word_size;
> +
> +	/* ID of the buffer that was processed */
> +	unsigned int buf_tail;
> +
> +	void (*callback)(int channel, void *arg, int error);
> +	void *callback_arg;
> +
> +	wait_queue_head_t waitq;	/* channel completion waitqeue */
> +
> +	int num_bd;
> +
> +	struct sdma_buffer_descriptor *bd;
> +	dma_addr_t	bd_phys;
> +
> +	int pc_from_device, pc_to_device;
> +
> +	unsigned long flags;
> +	dma_addr_t per_address;
> +
> +	uint32_t event_mask1, event_mask2;
> +	uint32_t watermark_level;
> +	uint32_t shp_addr, per_addr;
> +};
> +
> +#define MAX_DMA_CHANNELS 32
> +#define MXC_SDMA_DEFAULT_PRIORITY 1
> +#define MXC_SDMA_MIN_PRIORITY 1
> +#define MXC_SDMA_MAX_PRIORITY 7
> +
> +/*
> + * This enumerates transfer types
> + */
> +typedef enum {
> +	emi_2_per = 0,		/* EMI memory to peripheral */
> +	emi_2_int,		/* EMI memory to internal RAM */
> +	emi_2_emi,		/* EMI memory to EMI memory */
> +	emi_2_dsp,		/* EMI memory to DSP memory */
> +	per_2_int,		/* Peripheral to internal RAM */
> +	per_2_emi,		/* Peripheral to internal EMI memory */
> +	per_2_dsp,		/* Peripheral to DSP memory */
> +	per_2_per,		/* Peripheral to Peripheral */
> +	int_2_per,		/* Internal RAM to peripheral */
> +	int_2_int,		/* Internal RAM to Internal RAM */
> +	int_2_emi,		/* Internal RAM to EMI memory */
> +	int_2_dsp,		/* Internal RAM to DSP memory */
> +	dsp_2_per,		/* DSP memory to peripheral */
> +	dsp_2_int,		/* DSP memory to internal RAM */
> +	dsp_2_emi,		/* DSP memory to EMI memory */
> +	dsp_2_dsp,		/* DSP memory to DSP memory */
> +	emi_2_dsp_loop,		/* EMI memory to DSP memory loopback */
> +	dsp_2_emi_loop,		/* DSP memory to EMI memory loopback */
> +	dvfs_pll,		/* DVFS script with PLL change       */
> +	dvfs_pdr		/* DVFS script without PLL change    */
> +} sdma_transfer_type;
> +
> +/*
> + * Structure containing sdma request  parameters.
s/  / /
> + */
> +struct sdma_script_start_addrs {
> +	int ap_2_ap_addr;
> +	int ap_2_bp_addr;
> +	int ap_2_ap_fixed_addr;
> +	int bp_2_ap_addr;
> +	int loopback_on_dsp_side_addr;
> +	int mcu_interrupt_only_addr;
> +
> +	int firi_2_per_addr;
> +	int firi_2_mcu_addr;
> +	int per_2_firi_addr;
> +	int mcu_2_firi_addr;
> +
> +	int uart_2_per_addr;
> +	int uart_2_mcu_addr;
> +	int per_2_app_addr;
> +	int mcu_2_app_addr;
> +	int per_2_per_addr;
> +
> +	int uartsh_2_per_addr;
> +	int uartsh_2_mcu_addr;
> +	int per_2_shp_addr;
> +	int mcu_2_shp_addr;
> +
> +	int ata_2_mcu_addr;
> +	int mcu_2_ata_addr;
> +
> +	int app_2_per_addr;
> +	int app_2_mcu_addr;
> +	int shp_2_per_addr;
> +	int shp_2_mcu_addr;
> +
> +	int mshc_2_mcu_addr;
> +	int mcu_2_mshc_addr;
> +
> +	int spdif_2_mcu_addr;
> +	int mcu_2_spdif_addr;
> +
> +	int asrc_2_mcu_addr;
> +
> +	int ext_mem_2_ipu_addr;
> +
> +	int descrambler_addr;
> +
> +	int dptc_dvfs_addr;
> +
> +	int utra_addr;
> +
> +	int ram_code_start_addr;
> +};
> +
> +#define SDMA_FIRMWARE_MAGIC 0x414d4453
> +
> +struct sdma_firmware_header {
> +	uint32_t	magic; /* "SDMA" */
> +	uint32_t	version_major;	/* increased whenever layout of struct sdma_script_start_addrs changes */
> +	uint32_t	version_minor;	/* firmware version */
> +	uint32_t	script_addrs_start; /* offset of struct sdma_script_start_addrs in this image */
> +	uint32_t	num_script_addrs; /* Number of script addresses in this image */
> +	uint32_t	ram_code_start; /* offset of SDMA ram image in this firmware image */
> +	uint32_t	ram_code_size; /* size of SDMA ram image */
> +};
I wonder if it's worth the effort to have symbolic names for the script
addresses.  i.e.

struct sdma_firmware_header {
	uint32_t magic;
	uint32_t version_major;
	uint32_t version_minor;
	uint32_t script_addrs_start; /* offset of struct scriptaddr[] in this image */
	uint32_t num_script_addrs; /* number of script addresses or
				alternatively just NULL-terminate the list? */
	....
};

struct scriptaddr {
	int startaddr;
	char name[0];
};

It's a bit more flexible and doesn't necessarily introduce the need for
bumping the version_major when a new address is added.  Maybe require
alphabetic ordering then to make lookup a bit faster?

> +
> +static struct sdma_channel sdma_data[MAX_DMA_CHANNELS];
> +static struct sdma_channel_control *channel_control;
> +static void __iomem *sdma_base;
> +static int sdma_version;
> +static int sdma_num_events;
> +static struct sdma_context_data *sdma_context;
> +dma_addr_t sdma_context_phys;
> +
> +#define SDMA_H_CONFIG_DSPDMA	(1 << 12) /* indicates if the DSPDMA is used */
> +#define SDMA_H_CONFIG_RTD_PINS	(1 << 11) /* indicates if Real-Time Debug pins are enabled */
> +#define SDMA_H_CONFIG_ACR	(1 << 4)  /* indicates if AHB freq /core freq = 2 or 1 */
> +#define SDMA_H_CONFIG_CSM	(3)       /* indicates which context switch mode is selected*/
> +
> +static int sdma_config_ownership(int channel, int event_override,
> +		   int mcu_verride, int dsp_override)
> +{
> +	u32 evt, mcu, dsp;
> +
> +	if (event_override && mcu_verride && dsp_override)
> +		return -EINVAL;
> +
> +	evt = readl(SDMA_H_EVTOVR);
> +	mcu = readl(SDMA_H_HOSTOVR);
> +	dsp = readl(SDMA_H_DSPOVR);
readl performs little endian access, so I suggest to either use
__raw_readl or run unifdef -U__BIG_ENDIAN on this patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
