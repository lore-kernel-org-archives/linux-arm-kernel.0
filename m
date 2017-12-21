From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 21 Dec 2017 11:14:28 +0100
Subject: [PATCH v2 2/5] mtd: nand: add reworked Marvell NAND controller
 driver
In-Reply-To: <20171219132942.27433-3-miquel.raynal@free-electrons.com>
References: <20171219132942.27433-1-miquel.raynal@free-electrons.com>
 <20171219132942.27433-3-miquel.raynal@free-electrons.com>
Message-ID: <20171221111428.0aa3e65e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

On Tue, 19 Dec 2017 14:29:39 +0100
Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Add marvell_nand driver which aims at replacing the existing pxa3xx_nand
> driver.
> 
> The new driver intends to be easier to understand and follows the brand
> new NAND framework rules by implementing hooks for every pattern the
> controller might support and referencing them inside a parser object
> that will be given to the core at each ->exec_op() call.
> 
> Raw accessors are implemented, useful to test/debug memory/filesystem
> corruptions. Userspace binaries contained in the mtd-utils package may
> now be used and their output trusted.
> 
> Timings may not be kept from the bootloader anymore, the timings used
> for instance in U-Boot were not optimal and it supposed to have NAND
> support (and initialized) in the bootloader.

Hm, AFAIR the old driver was able to dynamically adjust the timings
when the NAND was ONFI compliant.

> 
> Thanks to the improved timings, implementation of ONFI mode 5 support
> (with EDO managed by adding a delay on data sampling), merging the
> commands together and optimizing writes in the command registers, the
> new driver may achieve faster throughputs in both directions.
> Measurements show an improvement of about +23% read throughput and +24%
> write throughput. These measurements have been done with an
> Armada-385-DB-AP (4kiB NAND pages forced in 4-bit strength BCH ECC
> correction) using the userspace tool 'flash_speed' from the MTD test
> suite.
> 
> Besides these important topics, the new driver addresses several
> unsolved known issues in the old driver which:
> - did not work with ECC soft neither with ECC none ;
> - relied on naked read/write (which is unchanged) while the NFCv1
>   embedded in the pxa3xx platforms do not implement it, so several
>   NAND commands did not actually ever work without any notice (like
>   reading the ONFI PARAM_PAGE or SET/GET_FEATURES) ;
> - wrote the OOB data correctly, but was not able to read it correctly
>   past the first OOB data chunk ;
> - did not displayed ECC bytes ;

	    ^display

and I'm not even sure display is the right term here. How about
'retrieve'.

> - used device tree bindings that did not allow more than one NAND chip,
>   and did not allow to choose the correct chip select if not
>   incrementing from 0. Plus, the Ready/Busy line used had to be 0.
> 
> Old device tree bindings are still supported but deprecated. A more
> hierarchical view has to be used to keep the controller and the NAND
> chip structures clearly separated both inside the device tree and also
> in the driver code.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> Tested-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Tested-by: Willy Tarreau <w@1wt.eu>
> ---
>  drivers/mtd/nand/Kconfig        |   12 +
>  drivers/mtd/nand/Makefile       |    1 +
>  drivers/mtd/nand/marvell_nand.c | 2942 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2955 insertions(+)
>  create mode 100644 drivers/mtd/nand/marvell_nand.c
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 859eb7790c46..9e141e03f5c2 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -323,6 +323,18 @@ config MTD_NAND_PXA3xx
>  	  platforms (XP, 370, 375, 38x, 39x) and 64-bit Armada
>  	  platforms (7K, 8K) (NFCv2).
>  
> +config MTD_NAND_MARVELL
> +	tristate "NAND controller support on Marvell boards"
> +	depends on PXA3xx || ARCH_MMP || PLAT_ORION || ARCH_MVEBU || \
> +		   COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This enables the NAND flash controller driver for Marvell boards,
> +	  including:
> +	  - PXA3xx processors (NFCv1)
> +	  - 32-bit Armada platforms (XP, 37x, 38x, 39x) (NFCv2)
> +	  - 64-bit Aramda platforms (7k, 8k) (NFCv2)
> +
>  config MTD_NAND_SLC_LPC32XX
>  	tristate "NXP LPC32xx SLC Controller"
>  	depends on ARCH_LPC32XX
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 118a1349aad3..921634ba400c 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
>  obj-$(CONFIG_MTD_NAND_OMAP_BCH_BUILD)	+= omap_elm.o
>  obj-$(CONFIG_MTD_NAND_CM_X270)		+= cmx270_nand.o
>  obj-$(CONFIG_MTD_NAND_PXA3xx)		+= pxa3xx_nand.o
> +obj-$(CONFIG_MTD_NAND_MARVELL)		+= marvell_nand.o
>  obj-$(CONFIG_MTD_NAND_TMIO)		+= tmio_nand.o
>  obj-$(CONFIG_MTD_NAND_PLATFORM)		+= plat_nand.o
>  obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
> diff --git a/drivers/mtd/nand/marvell_nand.c b/drivers/mtd/nand/marvell_nand.c
> new file mode 100644
> index 000000000000..0a5432bcda6a
> --- /dev/null
> +++ b/drivers/mtd/nand/marvell_nand.c
> @@ -0,0 +1,2942 @@
> +/*
> + * Marvell NAND flash controller driver
> + *
> + * Copyright (C) 2017 Marvell
> + * Author: Miquel RAYNAL <miquel.raynal@free-electrons.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0

AFAIU (maybe I'm wrong), this should be a single line comment
(C++-style) on the first line of the file:

// SPDX-License-Identifier: GPL-2.0
/*
 * Marvell NAND flash controller driver
 *
 * Copyright (C) 2017 Marvell
 * Author: Miquel RAYNAL <miquel.raynal@free-electrons.com>
 */

> + */
> +
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/of_platform.h>
> +#include <linux/iopoll.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <asm/unaligned.h>
> +
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma/pxa-dma.h>
> +#include <linux/platform_data/mtd-nand-pxa3xx.h>
> +
> +/* Data FIFO granularity, FIFO reads/writes must be a multiple of this length */
> +#define FIFO_DEPTH		8
> +#define FIFO_REP(x)		(x / sizeof(u32))
> +#define BCH_SEQ_READS		(32 / FIFO_DEPTH)
> +/* NFC does not support transfers of larger chunks at a time */
> +#define MAX_CHUNK_SIZE		2112
> +/* NFCv1 cannot read more that 7 bytes of ID */
> +#define NFCV1_READID_LEN	7
> +/* Polling is done at a pace of POLL_PERIOD us until POLL_TIMEOUT is reached */
> +#define POLL_PERIOD		0
> +#define POLL_TIMEOUT		100000
> +/* Interrupt maximum wait period in ms */
> +#define IRQ_TIMEOUT		1000
> +/* Latency in clock cycles between SoC pins and NFC logic */
> +#define MIN_RD_DEL_CNT		3
> +/* Maximum number of contiguous address cycles */
> +#define MAX_ADDRESS_CYC_NFCV1	5
> +#define MAX_ADDRESS_CYC_NFCV2	7
> +/* System control registers/bits to enable the NAND controller on some SoCs */
> +#define GENCONF_SOC_DEVICE_MUX	0x208
> +#define GENCONF_SOC_DEVICE_MUX_NFC_EN BIT(0)
> +#define GENCONF_SOC_DEVICE_MUX_ECC_CLK_RST BIT(20)
> +#define GENCONF_SOC_DEVICE_MUX_ECC_CORE_RST BIT(21)
> +#define GENCONF_SOC_DEVICE_MUX_NFC_INT_EN BIT(25)
> +#define GENCONF_CLK_GATING_CTRL	0x220
> +#define GENCONF_CLK_GATING_CTRL_ND_GATE BIT(2)
> +#define GENCONF_ND_CLK_CTRL	0x700
> +#define GENCONF_ND_CLK_CTRL_EN	BIT(0)
> +
> +/* NAND controller data flash control register */
> +#define NDCR			0x00
> +/* NAND interface timing parameter 0 register */
> +#define NDTR0			0x04
> +/* NAND interface timing parameter 1 register */
> +#define NDTR1			0x0C
> +/* NAND controller status register */
> +#define NDSR			0x14
> +/* NAND ECC control register */
> +#define NDECCCTRL		0x28
> +/* NAND controller data buffer register */
> +#define NDDB			0x40
> +/* NAND controller command buffer 0 register */
> +#define NDCB0			0x48
> +/* NAND controller command buffer 1 register */
> +#define NDCB1			0x4C
> +/* NAND controller command buffer 2 register */
> +#define NDCB2			0x50
> +/* NAND controller command buffer 3 register */
> +#define NDCB3			0x54

Just nitpicking, but I find it clearer when register offsets and
register fields are defined next to each other:

#define MY_REG		0xYYYY
#define MY_REG_FIELDX	BIT(X)
...

> +
> +/* Data flash control register bitfields */
> +#define NDCR_ALL_INT		GENMASK(11, 0)
> +#define NDCR_CS1_CMDDM		BIT(7)
> +#define NDCR_CS0_CMDDM		BIT(8)
> +#define NDCR_RDYM		BIT(11)
> +#define NDCR_ND_ARB_EN		BIT(12)
> +#define NDCR_RA_START		BIT(15)
> +#define NDCR_RD_ID_CNT(x)	(min_t(unsigned int, x, 0x7) << 16)
> +#define NDCR_PAGE_SZ(x)		(x >= 2048 ? BIT(24) : 0)
> +#define NDCR_DWIDTH_M		BIT(26)
> +#define NDCR_DWIDTH_C		BIT(27)
> +#define NDCR_ND_RUN		BIT(28)
> +#define NDCR_DMA_EN		BIT(29)
> +#define NDCR_ECC_EN		BIT(30)
> +#define NDCR_SPARE_EN		BIT(31)
> +

[...]

> +
> +/*

You seem to use the kerneldoc format, so you should probably start all
your comments with:

/**

> + * Marvell ECC engine works differently than the others, in order to limit the
> + * size of the IP, hardware engineers choose to set a fixed strength at 16 bits

					 ^chose

> + * per subpage, and depending on a the desired strength needed by the NAND chip,
> + * a particular layout mixing data/spare/ecc is defined, with a possible last
> + * chunk smaller that the others.
> + *
> + * @writesize:		Full page size on which the layout applies
> + * @chunk:		Desired ECC chunk size on which the layout applies
> + * @strength:		Desired ECC strength (per chunk size bytes) on which the
> + *			layout applies
> + * @full_chunk_cnt:	Number of full-sized chunks, which is the number of
> + *			repetitions of the pattern:
> + *			(data_bytes + spare_bytes + ecc_bytes).
> + * @data_bytes:		Number of data bytes per chunk
> + * @spare_bytes:	Number of spare bytes per chunk
> + * @ecc_bytes:		Number of ecc bytes per chunk
> + * @last_chunk_cnt:	If there is a last chunk with a different size than
> + *			the first ones, the next fields may not be empty

A boolean named has_last_chunk would be more appropriate since you can
only have one last chunk.

> + * @last_data_bytes:	Number of data bytes in the last chunk
> + * @last_spare_bytes:	Number of spare bytes in the last chunk
> + * @last_ecc_bytes:	Number of ecc bytes in the last chunk
> + */
> +struct marvell_hw_ecc_layout {
> +	/* Constraints */
> +	int writesize;
> +	int chunk;
> +	int strength;
> +	/* Corresponding layout */
> +	int full_chunk_cnt;
> +	int data_bytes;
> +	int spare_bytes;
> +	int ecc_bytes;
> +	int last_chunk_cnt;
> +	int last_data_bytes;
> +	int last_spare_bytes;
> +	int last_ecc_bytes;
> +};
> +

[...]

> +/*
> + * NAND controller structure: stores Marvell NAND controller information
> + *
> + * @controller:		Base controller structure
> + * @dev:		Parent device (used to print error messages)
> + * @regs:		NAND controller registers
> + * @ecc_clk:		ECC block clock, two times the NAND controller clock
> + * @complete:		Completion object to wait for NAND controller events
> + * @assigned_cs:	Bitmask describing already assigned CS lines
> + * @chips:		List containing all the NAND chips attached to
> + *			this NAND controller
> + * @caps:		NAND controller capabilities for each compatible string
> + * @buf:		Controller local buffer to store a part of the read
> + *			buffer when the read operation was not 8 bytes aligned
> + *			as is the FIFO.
> + * @buf_pos:		Position in the 'buf' buffer
> + * @dma_chan:		DMA channel (NFCv1 only)
> + * @dma_buf:		32-bit aligned buffer for DMA transfers (NFCv1 only)
> + */
> +struct marvell_nfc {
> +	struct nand_hw_control controller;
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct clk *ecc_clk;
> +	struct completion complete;
> +	unsigned long assigned_cs;
> +	struct list_head chips;
> +	struct nand_chip *selected_chip;
> +	const struct marvell_nfc_caps *caps;
> +
> +	/*
> +	 * Buffer handling: @buf will be accessed byte-per-byter but also
> +	 * int-per-int when exchanging data with the NAND controller FIFO,
> +	 * 32-bit alignment is then required.
> +	 */
> +	u8 buf[FIFO_DEPTH] __aligned(sizeof(u32));
> +	int buf_pos;

I'm almost sure you don't need this temporary buffer. Every time it's
used locally, so just allocate an u32 buf[2] on the stack where you
need it and you should be good.

> +
> +	/* DMA (NFCv1 only) */
> +	bool use_dma;
> +	struct dma_chan *dma_chan;
> +	u8 *dma_buf;
> +};
> +

[...]

> +/*
> + * Derives a duration in numbers of clock cycles.
> + *
> + * @ps: Duration in pico-seconds
> + * @period_ns:  Clock period in nano-seconds
> + *
> + * Convert the duration in nano-seconds, then divide by the period and
> + * return the number of clock periods.
> + */
> +#define TO_CYCLES(ps, period_ns) (DIV_ROUND_UP(ps / 1000, period_ns))
> +
> +/*
> + * NAND driver structure filled during the parsing of the ->exec_op() subop
> + * subset of instructions.
> + *
> + * @ndcb:		Array for the values of the NDCBx registers

			Array of values written to NDCBx registers

> + * @cle_ale_delay_ns:	Optional delay after the last CMD or ADDR cycle
> + * @rdy_timeout_ms:	Timeout for waits on Ready/Busy pin
> + * @rdy_delay_ns:	Optional delay after waiting for the RB pin
> + * @data_delay_ns:	Optional delay after the data xfer
> + * @data_instr_idx:	Index of the data instruction in the subop
> + * @data_instr:		Pointer to the data instruction in the subop
> + */
> +struct marvell_nfc_op {
> +	u32 ndcb[4];
> +	unsigned int cle_ale_delay_ns;
> +	unsigned int rdy_timeout_ms;
> +	unsigned int rdy_delay_ns;
> +	unsigned int data_delay_ns;
> +	unsigned int data_instr_idx;
> +	const struct nand_op_instr *data_instr;
> +};

[...]

> +
> +/*
> + * The core may ask the controller to use only 8-bit accesses while usually
> + * using 16-bit accesses. Later function may blindly call this one with a

			     ^Later, callers of this function may ...

> + * boolean to indicate if 8-bit accesses must be enabled of disabled without

							    ^or

> + * knowing if 16-bit accesses are actually in use.
> + */

I'd move this comment in the code...

> +static void marvell_nfc_force_byte_access(struct nand_chip *chip,
> +					  bool force_8bit)
> +{
> +	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
> +	u32 ndcr;
> +

... like here:

	/*
	 * Callers of this function do not verify if the NAND is
	 * using a 16-bit or an 8-bit bus for normal operations, so we
	 * need to take care of that here by leaving the configuration
	 * unchanged if the NAND does not have the NAND_BUSWIDTH_16
	 * flag set.
	 */

> +	if (!(chip->options & NAND_BUSWIDTH_16))
> +		return;
> +
> +	ndcr = readl_relaxed(nfc->regs + NDCR);
> +
> +	if (force_8bit)
> +		ndcr &= ~(NDCR_DWIDTH_M | NDCR_DWIDTH_C);
> +	else
> +		ndcr |= NDCR_DWIDTH_M | NDCR_DWIDTH_C;
> +
> +	writel_relaxed(ndcr, nfc->regs + NDCR);
> +}

[...]

> +
> +/*
> + * Any time a command has to be sent to the controller, the following sequence
> + * has to be followed:
> + * - call marvell_nfc_prepare_cmd()
> + *      -> activate the ND_RUN bit that will kind of 'start a job'
> + *      -> wait the signal indicating the NFC is waiting for a command
> + * - send the command (cmd and address cycles)
> + * - enventually send or receive the data
> + * - call marvell_nfc_end_cmd() with the corresponding flag
> + *      -> wait the flag to be triggered or cancel the job with a timeout
> + *
> + * The following functions are helpers to do this job and keep in the
> + * specialized functions the code that really does the operations.

I would rephrase it like that:
"
The following helpers are here to factorize the code a bit so that
specialized functions responsible for executing the actual NAND
operations do not have to replicate the same code blocks.
"

> + */
> +static int marvell_nfc_prepare_cmd(struct nand_chip *chip)
> +{
> +	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
> +	u32 ndcr, val;
> +	int ret;
> +
> +	/* Poll ND_RUN and clear NDSR before issuing any command */
> +	ret = marvell_nfc_wait_ndrun(chip);
> +	if (ret) {
> +		dev_err(nfc->dev, "Last operation did not suceed\n");
> +		return ret;
> +	}
> +
> +	ndcr = readl_relaxed(nfc->regs + NDCR);
> +	writel_relaxed(readl_relaxed(nfc->regs + NDSR), nfc->regs + NDSR);
> +
> +	/* Assert ND_RUN bit and wait the NFC to be ready */
> +	writel_relaxed(ndcr | NDCR_ND_RUN, nfc->regs + NDCR);
> +	ret = readl_relaxed_poll_timeout(nfc->regs + NDSR, val,
> +					 val & NDSR_WRCMDREQ,
> +					 POLL_PERIOD, POLL_TIMEOUT);
> +	if (ret) {
> +		dev_err(nfc->dev, "Timeout on WRCMDRE\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* Command may be written, clear WRCMDREQ status bit */
> +	writel_relaxed(NDSR_WRCMDREQ, nfc->regs + NDSR);
> +
> +	return 0;
> +}


[...]

> +
> +static void marvell_nfc_select_chip(struct mtd_info *mtd, int die_nr)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct marvell_nand_chip *marvell_nand = to_marvell_nand(chip);
> +	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
> +	u32 ndcr;
> +
> +	if (chip == nfc->selected_chip && die_nr == marvell_nand->selected_die)
> +		return;
> +
> +	if (die_nr < 0 || die_nr >= marvell_nand->nsels) {
> +		nfc->selected_chip = NULL;
> +		marvell_nand->selected_die = -1;
> +		return;
> +	}
> +
> +	/*
> +	 * Do not change the timing registers when using the DT property
> +	 * marvell,nand-keep-config; in that case ->ndtr0 and ->ndtr1 from the
> +	 * marvell_nand structure are supposedly empty.
> +	 */
> +	if (marvell_nand->ndtr0 && marvell_nand->ndtr1) {
> +		writel_relaxed(marvell_nand->ndtr0, nfc->regs + NDTR0);
> +		writel_relaxed(marvell_nand->ndtr1, nfc->regs + NDTR1);
> +	}
> +
> +	ndcr = readl_relaxed(nfc->regs + NDCR);
> +
> +	/* Ensure controller is not blocked; also clear some fields */
> +	ndcr &= ~(NDCR_ND_RUN | NDCR_DWIDTH_M | NDCR_DWIDTH_C |
> +		  NDCR_PAGE_SZ(2048));
> +
> +	/* Adapt bus width */
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		ndcr |= NDCR_DWIDTH_M | NDCR_DWIDTH_C;
> +
> +	/* Page size as seen by the controller, either 512B or 2kiB */
> +	ndcr |= NDCR_PAGE_SZ(mtd->writesize);

I wonder if we couldn't prepare the value of ->ndcr at probe time
(just like we prepare ->ndtrX) so that the only thing you'd have to do
here is a

	writel_relaxed(ndcr, nfc->regs + NDCR);

> +
> +	/* Update the control register */
> +	writel_relaxed(ndcr,  nfc->regs + NDCR);
> +
> +	/* Also reset the interrupt status register */
> +	marvell_nfc_clear_int(nfc, NDCR_ALL_INT);
> +
> +	nfc->selected_chip = chip;
> +	marvell_nand->selected_die = die_nr;
> +}
> +

[...]


> +
> +/* Read/write PIO/DMA accessors */
> +static int marvell_nfc_xfer_data_dma(struct marvell_nfc *nfc,
> +				     enum dma_data_direction direction,
> +				     unsigned int len)
> +{
> +	unsigned int dma_len = min_t(int, ALIGN(len, 32), MAX_CHUNK_SIZE);
> +	struct dma_async_tx_descriptor *tx;
> +	struct scatterlist sg;
> +	dma_cookie_t cookie;
> +	int ret;
> +
> +	marvell_nfc_enable_dma(nfc);
> +	/* Prepare the DMA transfer */
> +	sg_init_one(&sg, nfc->dma_buf, dma_len);
> +	dma_map_sg(nfc->dma_chan->device->dev, &sg, 1, direction);
> +	tx = dmaengine_prep_slave_sg(nfc->dma_chan, &sg, 1,
> +				     direction == DMA_FROM_DEVICE ?
> +				     DMA_DEV_TO_MEM : DMA_MEM_TO_DEV,
> +				     DMA_PREP_INTERRUPT);
> +	if (!tx) {
> +		dev_err(nfc->dev, "Could not prepare DMA S/G list\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Do the task and wait for it to finish */
> +	cookie = dmaengine_submit(tx);
> +	ret = dma_submit_error(cookie);
> +	if (ret)
> +		return -EIO;
> +
> +	dma_async_issue_pending(nfc->dma_chan);
> +	ret = marvell_nfc_wait_cmdd(nfc->selected_chip);
> +	dma_unmap_sg(nfc->dma_chan->device->dev, &sg, 1, direction);
> +	marvell_nfc_disable_dma(nfc);
> +	if (ret) {
> +		dev_err(nfc->dev, "Timeout waiting for DMA (status: %d)\n",
> +			dmaengine_tx_status(nfc->dma_chan, cookie, NULL));
> +		dmaengine_terminate_all(nfc->dma_chan);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int marvell_nfc_xfer_data_in_pio(struct marvell_nfc *nfc, u8 *in,
> +					unsigned int len)
> +{
> +	unsigned int last_len = len % FIFO_DEPTH;
> +	unsigned int last_full_offset = round_down(len, FIFO_DEPTH);
> +	int i;
> +
> +	for (i = 0; i < last_full_offset; i += FIFO_DEPTH)
> +		ioread32_rep(nfc->regs + NDDB, in + i, FIFO_REP(FIFO_DEPTH));
> +
> +	if (last_len) {
> +		ioread32_rep(nfc->regs + NDDB, nfc->buf, FIFO_REP(FIFO_DEPTH));
> +		memcpy(in + last_full_offset, nfc->buf, last_len);

This is where you should declare your temporary buffer:

		u32 tmpbuf[FIFO_REP(FIFO_DEPTH)];
		ioread32_rep(nfc->regs + NDDB, tmpbuf, sizeof(tmpbuf));
		memcpy(in + last_full_offset, tmpbuf, last_len);
> +	}
> +
> +	return 0;
> +}
> +

[...]


> +
> +/*
> + * Check a chunk is correct or not according to hardware ECC engine.
> + * mtd->ecc_stats.corrected is updated, as well as max_bitflips, however
> + * mtd->ecc_stats.failure is not, the function will instead return a non-zero
> + * value indicating that a check on the emptyness of the subpage must be
> + * performed before declaring the subpage corrupted.
> + */
> +static int marvell_nfc_hw_ecc_correct(struct nand_chip *chip,
> +				      unsigned int *max_bitflips)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
> +	int bf = 0;
> +	u32 ndsr;
> +
> +	ndsr = readl_relaxed(nfc->regs + NDSR);
> +
> +	/* Check uncorrectable error flag */
> +	if (ndsr & NDSR_UNCERR) {
> +		writel_relaxed(ndsr, nfc->regs + NDSR);
> +
> +		/*
> +		 * Do not increment ->ecc_stats.failed now, instead, return a
> +		 * non-zero value to indicate that this chunk was apparently
> +		 * bad, and it should be check to see if it empty or not. If
> +		 * the chunk (with ECC bytes) is not declared empty, the calling
> +		 * function must increment the failure count.
> +		 */
> +		return -EIO;

-EBADMSG would be better, just to be consistent with the error code
returned in case of ECC errors elsewhere.

> +	}
> +
> +	/* Check correctable error flag */
> +	if (ndsr & NDSR_CORERR) {
> +		writel_relaxed(ndsr, nfc->regs + NDSR);
> +
> +		if (chip->ecc.algo == NAND_ECC_BCH)
> +			bf = NDSR_ERRCNT(ndsr);
> +		else
> +			bf = 1;
> +	}
> +
> +	/* Update the stats and max_bitflips */
> +	mtd->ecc_stats.corrected += bf;
> +	*max_bitflips = max_t(unsigned int, *max_bitflips, bf);
> +
> +	return 0;
> +}
> +
> +/* Hamming read helpers */
> +static int marvell_nfc_hw_ecc_hmg_do_read_page(struct nand_chip *chip, u8 *buf,
> +					       bool oob_required, bool raw,
> +					       int page)
> +{
> +	struct marvell_nand_chip *marvell_nand = to_marvell_nand(chip);
> +	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
> +	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
> +	struct marvell_nfc_op nfc_op = {
> +		.ndcb[0] = NDCB0_CMD_TYPE(TYPE_READ) |
> +			   NDCB0_ADDR_CYC(marvell_nand->addr_cyc) |
> +			   NDCB0_DBC |
> +			   NDCB0_CMD1(NAND_CMD_READ0) |
> +			   NDCB0_CMD2(NAND_CMD_READSTART),
> +		.ndcb[1] = NDCB1_ADDRS_PAGE(page),
> +		.ndcb[2] = NDCB2_ADDR5_PAGE(page),
> +	};
> +	unsigned int oob_bytes = 0;
> +	int ret;
> +
> +	/* NFCv2 needs more information about the operation being executed */
> +	if (nfc->caps->is_nfcv2)
> +		nfc_op.ndcb[0] |= NDCB0_CMD_XTYPE(XTYPE_MONOLITHIC_RW);
> +
> +	ret = marvell_nfc_prepare_cmd(chip);
> +	if (ret)
> +		return ret;
> +
> +	if (oob_required) {
> +		oob_bytes = lt->spare_bytes;

AFAIR, you have to read the spare bytes when raw is false, so this
should be something like:

	if (oob_required || !raw)

This being said, we don't really care about performances when reading
in raw mode, so you could just drop the oob_required argument and always
read the OOB bytes.

> +		if (raw)
> +			oob_bytes += lt->ecc_bytes;
> +	}
> +
> +	marvell_nfc_send_cmd(chip, &nfc_op);
> +	ret = marvell_nfc_end_cmd(chip, NDSR_RDDREQ,
> +				  "RDDREQ while draining FIFO (data/oob)");
> +	if (ret)
> +		return ret;
> +
> +	/* Read the page then the OOB area */
> +	if (nfc->use_dma) {
> +		marvell_nfc_xfer_data_dma(nfc, DMA_FROM_DEVICE,
> +					  lt->data_bytes + oob_bytes);
> +		memcpy(buf, nfc->dma_buf, lt->data_bytes);
> +		memcpy(chip->oob_poi + (raw ? 0 : lt->ecc_bytes),
> +		       nfc->dma_buf + lt->data_bytes, oob_bytes);
> +	} else {
> +		marvell_nfc_xfer_data_in_pio(nfc, buf, lt->data_bytes);
> +		marvell_nfc_xfer_data_in_pio(nfc, chip->oob_poi, oob_bytes);
> +	}
> +
> +	ret = marvell_nfc_wait_cmdd(chip);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +

[...]

> +
> +static int marvell_nfc_hw_ecc_hmg_read_page(struct mtd_info *mtd,
> +					    struct nand_chip *chip,
> +					    u8 *buf, int oob_required,
> +					    int page)
> +{
> +	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
> +	int max_bitflips = 0, ret;
> +
> +	/*
> +	 * Reading/Writing a given page must always be performed with the same
> +	 * configuration regarding the state of the SPARE_EN bit or ECC bytes
> +	 * will not be present at the same location (writing only data, without
> +	 * SPARE_EN will put the ECC bytes at the beginning of the OOB area,
> +	 * while writing with the SPARE_EN bit (hence, also writing free OOB
> +	 * bytes) will put first the spare bytes then, at the end of the OOB
> +	 * area, the ECC bytes. Choices has been made to always read/write OOB
> +	 * area (padding with 0xFF is handled by the core for writes).

IMHO, this comment should go next to the place where you actually set
the SPARE_EN bit. This way you don't have to duplicate the same comment
block in various places.

> +	 */
> +

Drop this empty line.

> +	marvell_nfc_enable_hw_ecc(chip);
> +	marvell_nfc_hw_ecc_hmg_do_read_page(chip, buf, true, false, page);
> +	ret = marvell_nfc_hw_ecc_correct(chip, &max_bitflips);
> +	marvell_nfc_disable_hw_ecc(chip);
> +
> +	if (!ret)
> +		return max_bitflips;
> +
> +	/*
> +	 * Re-read the OOB area in raw mode if ECC failures have been detected
> +	 * to check for empty pages.
> +	 */
> +	nand_change_read_column_op(chip, lt->data_bytes + lt->spare_bytes,
> +				   chip->oob_poi + lt->spare_bytes,
> +				   lt->ecc_bytes, false);
> +	marvell_nfc_check_empty_chunk(chip, buf, lt->data_bytes, chip->oob_poi,
> +				      lt->spare_bytes, chip->oob_poi +
> +				      lt->spare_bytes, lt->ecc_bytes,
> +				      &max_bitflips);
> +
> +	return max_bitflips;
> +}
> +

[...]

> +
> +/* Hamming write helpers */
> +static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
> +						const u8 *buf,
> +						bool oob_required, bool raw,
> +						int page)
> +{
> +	struct marvell_nand_chip *marvell_nand = to_marvell_nand(chip);
> +	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
> +	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
> +	struct marvell_nfc_op nfc_op = {
> +		.ndcb[0] = NDCB0_CMD_TYPE(TYPE_WRITE) |
> +			   NDCB0_ADDR_CYC(marvell_nand->addr_cyc) |
> +			   NDCB0_CMD1(NAND_CMD_SEQIN) |
> +			   NDCB0_CMD2(NAND_CMD_PAGEPROG) |
> +			   NDCB0_DBC,
> +		.ndcb[1] = NDCB1_ADDRS_PAGE(page),
> +		.ndcb[2] = NDCB2_ADDR5_PAGE(page),
> +	};
> +	int oob_bytes = 0;
> +	int ret;
> +
> +	/* NFCv2 needs more information about the operation being executed */
> +	if (nfc->caps->is_nfcv2)
> +		nfc_op.ndcb[0] |= NDCB0_CMD_XTYPE(XTYPE_MONOLITHIC_RW);
> +
> +	ret = marvell_nfc_prepare_cmd(chip);
> +	if (ret)
> +		return ret;
> +
> +	if (oob_required) {

Same comment as for the marvell_nfc_hw_ecc_hmg_read_page() function:
just drop the oob_required argument to simplify the logic.

> +		oob_bytes = lt->spare_bytes;
> +		if (raw)
> +			oob_bytes += lt->ecc_bytes;
> +	}
> +
> +	marvell_nfc_send_cmd(chip, &nfc_op);
> +	ret = marvell_nfc_end_cmd(chip, NDSR_WRDREQ,
> +				  "WRDREQ while loading FIFO (data)");
> +	if (ret)
> +		return ret;
> +
> +	/* Write the page then the OOB area */
> +	if (nfc->use_dma) {
> +		memcpy(nfc->dma_buf, buf, lt->data_bytes);
> +		if (oob_required)
> +			memcpy(nfc->dma_buf + lt->data_bytes, chip->oob_poi,
> +			       oob_bytes);
> +		marvell_nfc_xfer_data_dma(nfc, DMA_TO_DEVICE, lt->data_bytes +
> +					  lt->ecc_bytes + lt->spare_bytes);
> +	} else {
> +		marvell_nfc_xfer_data_out_pio(nfc, buf, lt->data_bytes);
> +		if (oob_required)
> +			marvell_nfc_xfer_data_out_pio(nfc, chip->oob_poi,
> +						      oob_bytes);
> +	}
> +
> +	ret = marvell_nfc_wait_cmdd(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret = marvell_nfc_wait_op(chip,
> +				  chip->data_interface.timings.sdr.tPROG_max);
> +	return ret;
> +}
> +

[...]

> +static int marvell_nfc_hw_ecc_hmg_write_page(struct mtd_info *mtd,
> +					     struct nand_chip *chip,
> +					     const u8 *buf,
> +					     int oob_required, int page)
> +{
> +	int ret;
> +
> +	/*
> +	 * Reading/Writing a given page must always be performed with the same
> +	 * configuration regarding the state of the SPARE_EN bit or ECC bytes
> +	 * will not be present at the same location (writing only data, without
> +	 * SPARE_EN will put the ECC bytes at the beginning of the OOB area,
> +	 * while writing with the SPARE_EN bit (hence, also writing free OOB
> +	 * bytes) will put first the spare bytes then, at the end of the OOB
> +	 * area, the ECC bytes. Choices has been made to always read/write OOB
> +	 * area (padding with 0xFF is handled by the core for writes).
> +	 */

Same as above: drop the comment.

> +
> +	marvell_nfc_enable_hw_ecc(chip);
> +	ret = marvell_nfc_hw_ecc_hmg_do_write_page(chip, buf, true, false,
> +						   page);
> +	marvell_nfc_disable_hw_ecc(chip);
> +
> +	return ret;
> +}
> +

[...]

> +
> +static void marvell_nfc_hw_ecc_bch_read_chunk(struct nand_chip *chip, int chunk,
> +					      u8 *data, unsigned int data_len,
> +					      u8 *spare, unsigned int spare_len,
> +					      int page)
> +{
> +	struct marvell_nand_chip *marvell_nand = to_marvell_nand(chip);
> +	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
> +	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
> +	int nchunks = lt->full_chunk_cnt + lt->last_chunk_cnt;
> +	int i, ret;
> +	struct marvell_nfc_op nfc_op = {
> +		.ndcb[0] = NDCB0_CMD_TYPE(TYPE_READ) |
> +			   NDCB0_ADDR_CYC(marvell_nand->addr_cyc) |
> +			   NDCB0_LEN_OVRD,
> +		.ndcb[1] = NDCB1_ADDRS_PAGE(page),
> +		.ndcb[2] = NDCB2_ADDR5_PAGE(page),
> +		.ndcb[3] = data_len + spare_len,
> +	};
> +
> +	ret = marvell_nfc_prepare_cmd(chip);
> +	if (ret)
> +		return;
> +
> +	if (chunk == 0)
> +		nfc_op.ndcb[0] |= NDCB0_DBC |
> +				  NDCB0_CMD1(NAND_CMD_READ0) |
> +				  NDCB0_CMD2(NAND_CMD_READSTART);
> +
> +	/*
> +	 * Trigger the naked read operation only on the last chunk.
> +	 * Otherwise, use monolithic read.
> +	 */
> +	if (nchunks == 1 || (chunk < nchunks - 1))
> +		nfc_op.ndcb[0] |= NDCB0_CMD_XTYPE(XTYPE_MONOLITHIC_RW);
> +	else
> +		nfc_op.ndcb[0] |= NDCB0_CMD_XTYPE(XTYPE_LAST_NAKED_RW);
> +
> +	marvell_nfc_send_cmd(chip, &nfc_op);
> +
> +	/*
> +	 * According to the datasheet, when reading from NDDB
> +	 * with BCH enabled, after each 32 bytes reads, we
> +	 * have to make sure that the NDSR.RDDREQ bit is set.
> +	 *
> +	 * Drain the FIFO, 8 32-bit reads at a time, and skip
> +	 * the polling on the last read.
> +	 *
> +	 * Length is a multiple of 32 bytes, hence it is a multiple of 8 too.
> +	 */
> +

Drop the empty line.

> +	for (i = 0; i < data_len; i += FIFO_DEPTH * BCH_SEQ_READS) {
> +		marvell_nfc_end_cmd(chip, NDSR_RDDREQ,
> +				    "RDDREQ while draining FIFO (data)");
> +		marvell_nfc_xfer_data_in_pio(nfc, data,
> +					     FIFO_DEPTH * BCH_SEQ_READS);
> +		data += FIFO_DEPTH * BCH_SEQ_READS;
> +	}
> +
> +	for (i = 0; i < spare_len; i += FIFO_DEPTH * BCH_SEQ_READS) {
> +		marvell_nfc_end_cmd(chip, NDSR_RDDREQ,
> +				    "RDDREQ while draining FIFO (OOB)");
> +		marvell_nfc_xfer_data_in_pio(nfc, spare,
> +					     FIFO_DEPTH * BCH_SEQ_READS);
> +		spare += FIFO_DEPTH * BCH_SEQ_READS;
> +	}
> +}
> +
> +static int marvell_nfc_hw_ecc_bch_read_page(struct mtd_info *mtd,
> +					    struct nand_chip *chip,
> +					    u8 *buf, int oob_required,
> +					    int page)
> +{
> +	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
> +	int nchunks = lt->full_chunk_cnt + lt->last_chunk_cnt;
> +	int data_len = lt->data_bytes, spare_len = lt->spare_bytes, ecc_len;
> +	u8 *data = buf, *spare = chip->oob_poi, *ecc;
> +	int max_bitflips = 0;
> +	u32 failure_mask = 0;
> +	int chunk, ecc_offset_in_page, ret;
> +
> +	/*
> +	 * With BCH, OOB is not fully used (and thus not read entirely), not
> +	 * expected bytes could show up at the end of the OOB buffer if not
> +	 * explicitly erased.
> +	 */
> +	if (oob_required)
> +		memset(chip->oob_poi, 0xFF, mtd->oobsize);
> +
> +	marvell_nfc_enable_hw_ecc(chip);
> +
> +	for (chunk = 0; chunk < nchunks; chunk++) {
> +		/* Update length for the last chunk */
> +		if (chunk >= lt->full_chunk_cnt) {
> +			data_len = lt->last_data_bytes;
> +			spare_len = lt->last_spare_bytes;
> +		}
> +
> +		/* Read the chunk and detect number of bitflips */
> +		marvell_nfc_hw_ecc_bch_read_chunk(chip, chunk, data, data_len,
> +						  spare, spare_len, page);
> +		ret = marvell_nfc_hw_ecc_correct(chip, &max_bitflips);
> +		if (ret)
> +			failure_mask |= BIT(chunk);
> +
> +		data += data_len;
> +		spare += spare_len;
> +	}
> +
> +	marvell_nfc_disable_hw_ecc(chip);
> +
> +	if (!failure_mask)
> +		return max_bitflips;
> +
> +	/*
> +	 * Please note that dumping the ECC bytes during a normal read with OOB
> +	 * area would add a significant overhead as ECC bytes are "consumed" by
> +	 * the controller in normal mode and must be re-read in raw mode. To
> +	 * avoid dropping the performances, we prefer not to include them. The
> +	 * user should re-read the page in raw mode if ECC bytes are required.
> +	 *
> +	 * However, for any subpage read error reported by ->correct(), the ECC
> +	 * bytes must be read in raw mode and the full subpage must be checked
> +	 * to see if it is entirely empty of if there was an actual error.

Nice explanation!

> +	 */
> +

Extra empty

> +	for (chunk = 0; chunk < nchunks; chunk++) {
> +		/* No failure reported for this chunk, move to the next one */
> +		if (!(failure_mask & BIT(chunk)))
> +			continue;
> +
> +		/* Derive ECC bytes positions (in page/buffer) and length */
> +		ecc = chip->oob_poi +
> +			(lt->full_chunk_cnt * lt->spare_bytes) +
> +			(lt->last_chunk_cnt * lt->last_spare_bytes) +
> +			(chunk * ALIGN(lt->ecc_bytes, 32));
> +		ecc_offset_in_page =
> +			(chunk * (lt->data_bytes + lt->spare_bytes +
> +				  lt->ecc_bytes)) +
> +			(chunk < lt->full_chunk_cnt ?
> +			 lt->data_bytes + lt->spare_bytes :
> +			 lt->last_data_bytes + lt->last_spare_bytes);
> +		ecc_len = chunk < lt->full_chunk_cnt ?
> +			lt->ecc_bytes : lt->last_ecc_bytes;
> +
> +		/* Do the actual raw read of the ECC bytes */
> +		nand_change_read_column_op(chip, ecc_offset_in_page,
> +					   ecc, ecc_len, false);
> +
> +		/* Derive data/spare bytes positions (in buffer) and length */
> +		data = buf + (chunk * lt->data_bytes);
> +		data_len = chunk < lt->full_chunk_cnt ?
> +			lt->data_bytes : lt->last_data_bytes;
> +		spare = chip->oob_poi + (chunk * (lt->spare_bytes +
> +						  lt->ecc_bytes));
> +		spare_len = chunk < lt->full_chunk_cnt ?
> +			lt->spare_bytes : lt->last_spare_bytes;
> +
> +		/* Check the entire chunk (data + spare + ecc) for emptyness */
> +		marvell_nfc_check_empty_chunk(chip, data, data_len, spare,
> +					      spare_len, ecc, ecc_len,
> +					      &max_bitflips);
> +	}
> +
> +	return max_bitflips;
> +}
> +

[...]

> +
> +/*
> + * HW ECC layouts, identical to old pxa3xx_nand driver,
> + * to be fully backward compatible.
> + */
> +static int marvell_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
> +	int nchunks = lt->full_chunk_cnt;
> +
> +	if (section >= nchunks)
> +		return -ERANGE;
> +
> +	oobregion->offset = ((lt->spare_bytes + lt->ecc_bytes) * section) +
> +		lt->spare_bytes;
> +	oobregion->length = lt->ecc_bytes;

We discussed about fixing the layouts to expose all free bytes at
the beginning of the OOB area and all ECC bytes at the end. It doesn't
seem to be the case here.

> +
> +	return 0;
> +}
> +
> +static int marvell_nand_ooblayout_free(struct mtd_info *mtd, int section,
> +				       struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
> +	int nchunks = lt->full_chunk_cnt;
> +
> +	if (section >= nchunks)
> +		return -ERANGE;
> +
> +	if (!lt->spare_bytes)
> +		return 0;
> +
> +	oobregion->offset = section * (lt->spare_bytes + lt->ecc_bytes);
> +	oobregion->length = lt->spare_bytes;
> +	if (!section) {
> +		/*
> +		 * Bootrom looks in bytes 0 & 5 for bad blocks for the
> +		 * 4KB page / 4bit BCH combination.
> +		 */
> +		if (mtd->writesize == SZ_4K && lt->data_bytes == SZ_2K) {
> +			oobregion->offset += 6;
> +			oobregion->length -= 6;
> +		} else {
> +			oobregion->offset += 2;
> +			oobregion->length -= 2;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops marvell_nand_ooblayout_ops = {
> +	.ecc = marvell_nand_ooblayout_ecc,
> +	.free = marvell_nand_ooblayout_free,
> +};
> +

[...]

> +
> +static int marvell_nand_ecc_init(struct mtd_info *mtd,
> +				 struct nand_ecc_ctrl *ecc)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
> +	int ret;
> +
> +	if ((ecc->mode != NAND_ECC_NONE) && (!ecc->size || !ecc->strength)) {
> +		if (chip->ecc_step_ds && chip->ecc_strength_ds) {
> +			ecc->size = chip->ecc_step_ds;
> +			ecc->strength = chip->ecc_strength_ds;
> +		} else {
> +			dev_info(nfc->dev,
> +				 "No minimum ECC strength, using 1b/512B\n");
> +			ecc->size = 512;
> +			ecc->strength = 1;
> +		}
> +	}
> +
> +	switch (ecc->mode) {
> +	case NAND_ECC_HW:
> +		ret = marvell_nand_hw_ecc_ctrl_init(mtd, ecc);
> +		if (ret)
> +			return ret;
> +		break;
> +	case NAND_ECC_NONE:
> +		chip->ecc.algo = 0;

No need to set ecc->algo to 0 here.

> +	case NAND_ECC_SOFT:

You should probably do a check on ->writesize, especially for NFCv1
when used in ECC_NONE of ECC_SOFT, since you can't write/read arbitrary
size.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +

[...]

> +static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
> +				  struct device_node *np)
> +{
> +	struct pxa3xx_nand_platform_data *pdata = dev_get_platdata(dev);
> +	struct marvell_nand_chip *marvell_nand;
> +	struct mtd_info *mtd;
> +	struct nand_chip *chip;
> +	int nsels, ret, i;
> +	u32 cs, rb;
> +
> +	/*
> +	 * The legacy "num-cs" property indicates the number of CS on the only
> +	 * chip connected to the controller (legacy bindings does not support
> +	 * more than one chip). CS are only incremented one by one while the RB
> +	 * pin is always the #0.
> +	 *
> +	 * When not using legacy bindings, a couple of "reg" and "marvell,rb"
> +	 * properties must be filled. For each chip, expressed as a subnode,
> +	 * "reg" points to the CS lines and "marvell,rb" to the RB line.
> +	 */
> +	if (pdata) {
> +		nsels = 1;
> +	} else if (nfc->caps->legacy_of_bindings) {
> +		if (!of_get_property(np, "num-cs", &nsels)) {
> +			dev_err(dev, "missing num-cs property\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		if (!of_get_property(np, "reg", &nsels)) {
> +			dev_err(dev, "missing reg property\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!pdata)
> +		nsels /= sizeof(u32);
> +	if (!nsels) {
> +		dev_err(dev, "invalid reg property size\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Alloc the nand chip structure */
> +	marvell_nand = devm_kzalloc(dev, sizeof(*marvell_nand) +
> +				    (nsels *
> +				     sizeof(struct marvell_nand_chip_sel)),
> +				    GFP_KERNEL);
> +	if (!marvell_nand) {
> +		dev_err(dev, "could not allocate chip structure\n");
> +		return -ENOMEM;
> +	}
> +
> +	marvell_nand->nsels = nsels;
> +	marvell_nand->selected_die = -1;
> +
> +	for (i = 0; i < nsels; i++) {
> +		if (pdata || nfc->caps->legacy_of_bindings) {
> +			/*
> +			 * Legacy bindings use the CS lines in natural
> +			 * order (0, 1, ...)
> +			 */
> +			cs = i;
> +		} else {
> +			/* Retrieve CS id */
> +			ret = of_property_read_u32_index(np, "reg", i, &cs);
> +			if (ret) {
> +				dev_err(dev, "could not retrieve reg property: %d\n",
> +					ret);
> +				return ret;
> +			}
> +		}
> +
> +		if (cs >= nfc->caps->max_cs_nb) {
> +			dev_err(dev, "invalid reg value: %u (max CS = %d)\n",
> +				cs, nfc->caps->max_cs_nb);
> +			return -EINVAL;
> +		}
> +
> +		if (test_and_set_bit(cs, &nfc->assigned_cs)) {
> +			dev_err(dev, "CS %d already assigned\n", cs);
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * The cs variable represents the chip select id, which must be
> +		 * converted in bit fields for NDCB0 and NDCB2 to select the
> +		 * right chip. Unfortunately, due to a lack of information on
> +		 * the subject and incoherent documentation, the user should not
> +		 * use CS1 and CS3 at all as asserting them is not supported in
> +		 * a reliable way (due to multiplexing inside ADDR5 field).
> +		 */
> +		marvell_nand->sels[i].cs = cs;
> +		switch (cs) {
> +		case 0:
> +		case 2:
> +			marvell_nand->sels[i].ndcb0_csel = 0;
> +			break;
> +		case 1:
> +		case 3:
> +			marvell_nand->sels[i].ndcb0_csel = NDCB0_CSEL;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		/* Retrieve RB id */
> +		if (pdata || nfc->caps->legacy_of_bindings) {
> +			/* Legacy bindings always use RB #0 */
> +			rb = 0;
> +		} else {
> +			ret = of_property_read_u32_index(np, "marvell,rb", i,
> +							 &rb);
> +			if (ret) {
> +				dev_err(dev,
> +					"could not retrieve RB property: %d\n",
> +					ret);
> +				return ret;
> +			}
> +		}
> +
> +		if (rb >= nfc->caps->max_rb_nb) {
> +			dev_err(dev, "invalid reg value: %u (max RB = %d)\n",
> +				rb, nfc->caps->max_rb_nb);
> +			return -EINVAL;
> +		}
> +
> +		marvell_nand->sels[i].rb = rb;
> +	}
> +
> +	chip = &marvell_nand->chip;
> +	chip->controller = &nfc->controller;
> +	nand_set_flash_node(chip, np);
> +
> +	chip->exec_op = marvell_nfc_exec_op;
> +	chip->select_chip = marvell_nfc_select_chip;
> +	if (nfc->caps->is_nfcv2 &&
> +	    !of_property_read_bool(np, "marvell,nand-keep-config"))
> +		chip->setup_data_interface = marvell_nfc_setup_data_interface;
> +
> +	mtd = nand_to_mtd(chip);
> +	mtd->dev.parent = dev;
> +
> +	/*
> +	 * Default to HW ECC engine mode. If the nand-ecc-mode property is given
> +	 * in the DT node, this entry will be overwritten in nand_scan_ident().
> +	 */
> +	chip->ecc.mode = NAND_ECC_HW;
> +
> +	ret = nand_scan_ident(mtd, marvell_nand->nsels, NULL);
> +	if (ret) {
> +		dev_err(dev, "could not identify the nand chip\n");
> +		return ret;
> +	}
> +
> +	if (pdata && pdata->flash_bbt)
> +		chip->bbt_options |= NAND_BBT_USE_FLASH;
> +
> +	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
> +		/*
> +		 * We'll use a bad block table stored in-flash and don't
> +		 * allow writing the bad block marker to the flash.
> +		 */
> +		chip->bbt_options |= NAND_BBT_NO_OOB_BBM;
> +		chip->bbt_td = &bbt_main_descr;
> +		chip->bbt_md = &bbt_mirror_descr;
> +	}
> +
> +	/*
> +	 * With RA_START bit set in NDCR, columns takes two address cycles. This
> +	 * means addressing a chip with more than 256 pages needs a fifth
> +	 * address cycle. Addressing a chip using CS 2 or 3 should also needs
> +	 * this additional cycle but due to insistance in the documentation and
> +	 * lack of hardware to test this situation, this case has been dropped
> +	 * and is not supported by this driver.
> +	 */
> +	marvell_nand->addr_cyc = 4;
> +	if (chip->options & NAND_ROW_ADDR_3)
> +		marvell_nand->addr_cyc = 5;
> +
> +	if (pdata) {
> +		chip->ecc.size = pdata->ecc_step_size;
> +		chip->ecc.strength = pdata->ecc_strength;
> +	}
> +
> +	ret = marvell_nand_ecc_init(mtd, &chip->ecc);
> +	if (ret) {
> +		dev_err(dev, "ECC init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (chip->ecc.mode == NAND_ECC_HW) {
> +		/*
> +		 * Subpage write not available with hardware ECC, prohibit also
> +		 * subpage read as in userspace subpage acces would still be

							^ access

> +		 * allowed and subpage write, if used, would lead to numerous
> +		 * uncorrectable ECC errors.
> +		 */
> +		chip->options |= NAND_NO_SUBPAGE_WRITE;
> +	}
> +
> +	if (pdata || nfc->caps->legacy_of_bindings) {
> +		/*
> +		 * We keep the MTD name unchanged to avoid breaking platforms
> +		 * where the MTD cmdline parser is used and the bootloader
> +		 * has not been updated to use the new naming scheme.
> +		 */
> +		mtd->name = "pxa3xx_nand-0";
> +	} else if (!mtd->name) {
> +		/*
> +		 * If the new bindings are used and the bootloader has not been
> +		 * updated to pass a new mtdparts parameter on the cmdline, you
> +		 * should define the following property in your NAND node, ie:
> +		 *
> +		 *	label = "main-storage";
> +		 *
> +		 * This way, mtd->name will be set by the core when
> +		 * nand_set_flash_node() is called.
> +		 */
> +		mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
> +					   "%s:nand.%d", dev_name(nfc->dev),
> +					   marvell_nand->sels[0].cs);
> +		if (!mtd->name) {
> +			dev_err(nfc->dev, "Failed to allocate mtd->name\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	ret = nand_scan_tail(mtd);
> +	if (ret) {
> +		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (pdata)
> +		/* Legacy bindings support only one chip */
> +		ret = mtd_device_register(mtd, pdata->parts[0],
> +					  pdata->nr_parts[0]);
> +	else
> +		ret = mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_err(dev, "failed to register mtd device: %d\n", ret);
> +		nand_release(mtd);
> +		return ret;
> +	}
> +
> +	list_add_tail(&marvell_nand->node, &nfc->chips);
> +
> +	return 0;
> +}
> +
> +static int marvell_nand_chips_init(struct device *dev, struct marvell_nfc *nfc)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct device_node *nand_np;
> +	int max_cs = nfc->caps->max_cs_nb;
> +	int nchips;
> +	int ret;
> +
> +	if (!np)
> +		nchips = 1;
> +	else
> +		nchips = of_get_child_count(np);
> +
> +	if (nchips > max_cs) {
> +		dev_err(dev, "too many NAND chips: %d (max = %d CS)\n", nchips,
> +			max_cs);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Legacy bindings do not use child nodes to exhibit NAND chip
> +	 * properties and layout. Instead, NAND properties are mixed with the
> +	 * controller's and a single subnode presents the memory layout.

"
	   controller ones, and partitions are defined as direct
	   subnodes of the NAND controller node.
"

> +	 */
> +	if (nfc->caps->legacy_of_bindings) {
> +		ret = marvell_nand_chip_init(dev, nfc, np);
> +		return ret;
> +	}
> +
> +	for_each_child_of_node(np, nand_np) {
> +		ret = marvell_nand_chip_init(dev, nfc, nand_np);
> +		if (ret) {
> +			of_node_put(nand_np);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

That's all I see for now.

Really nice rework you've done here.

Thanks,

Boris
