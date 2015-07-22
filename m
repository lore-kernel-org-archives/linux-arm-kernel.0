From: marex@denx.de (Marek Vasut)
Date: Wed, 22 Jul 2015 15:50:14 +0200
Subject: [PATCH v2 5/5] mtd: atmel-quadspi: add driver for Atmel QSPI
 controller
In-Reply-To: <3a43a1195054dbbdef5f5aabeae5f6377074d929.1437569902.git.cyrille.pitchen@atmel.com>
References: <cover.1437569902.git.cyrille.pitchen@atmel.com>
 <3a43a1195054dbbdef5f5aabeae5f6377074d929.1437569902.git.cyrille.pitchen@atmel.com>
Message-ID: <201507221550.14947.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 22, 2015 at 03:17:10 PM, Cyrille Pitchen wrote:
> This driver add support to the new Atmel QSPI controller embedded into
> sama5d2x SoCs. It expects a NOR memory to be connected to the QSPI
> controller.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
[...]

> +/* QSPI register offsets */
> +#define QSPI_CR		0x0000	/* Control Register */
> +#define QSPI_MR		0x0004	/* Mode Register */
> +#define QSPI_RD		0x0008	/* Receive Data Register */
> +#define QSPI_TD		0x000c	/* Transmit Data Register */
> +#define QSPI_SR		0x0010	/* Status Register */
> +#define QSPI_IER	0x0014	/* Interrupt Enable Register */
> +#define QSPI_IDR	0x0018	/* Interrupt Disable Register */
> +#define QSPI_IMR	0x001c	/* Interrupt Mask Register */
> +#define QSPI_SCR	0x0020	/* Serial Clock Register */
> +
> +#define QSPI_IAR	0x0030	/* Instruction Address Register */
> +#define QSPI_ICR	0x0034	/* Instruction Code Register */
> +#define QSPI_IFR	0x0038	/* Instruction Frame Register */
> +
> +#define QSPI_SMR	0x0040	/* Scrambling Mode Register */
> +#define QSPI_SKR	0x0044	/* Scrambling Key Register */
> +
> +#define QSPI_WPMR	0x00E4	/* Write Protection Mode Register */
> +#define QSPI_WPSR	0x00E8	/* Write Protection Status Register */
> +
> +#define QSPI_VERSION	0x00FC	/* Version Register */
> +
> +/* Bitfields in QSPI_CR (Control Register) */
> +#define QSPI_CR_QSPIEN_OFFSET		0
> +#define QSPI_CR_QSPIEN_SIZE		1
> +#define QSPI_CR_QSPIDIS_OFFSET		1
> +#define QSPI_CR_QSPIDIS_SIZE		1
> +#define QSPI_CR_SWRST_OFFSET		7
> +#define QSPI_CR_SWRST_SIZE		1
> +#define QSPI_CR_LASTXFER_OFFSET		24
> +#define QSPI_CR_LASTXFER_SIZE		1
> +
> +/* Bitfields in QSPI_MR (Mode Register) */
> +#define QSPI_MR_SSM_OFFSET		0
> +#define QSPI_MR_SSM_SIZE		1
> +#define QSPI_MR_LLB_OFFSET		1
> +#define QSPI_MR_LLB_SIZE		1
> +#define QSPI_MR_WDRBT_OFFSET		2
> +#define QSPI_MR_WDRBT_SIZE		1
> +#define QPSI_MR_SMRM_OFFSET		3
> +#define QSPI_MR_SMRM_SIZE		1
> +#define QSPI_MR_CSMODE_OFFSET		4
> +#define QSPI_MR_CSMODE_SIZE		2
> +#define QSPI_MR_NBBITS_OFFSET		8
> +#define QSPI_MR_NBBITS_SIZE		4
> +#define		QSPI_MR_NBBITS_8_BIT		0
> +#define		QSPI_MR_NBBITS_9_BIT		1
> +#define		QSPI_MR_NBBITS_10_BIT		2
> +#define		QSPI_MR_NBBITS_11_BIT		3
> +#define		QSPI_MR_NBBITS_12_BIT		4
> +#define		QSPI_MR_NBBITS_13_BIT		5
> +#define		QSPI_MR_NBBITS_14_BIT		6
> +#define		QSPI_MR_NBBITS_15_BIT		7
> +#define		QSPI_MR_NBBITS_16_BIT		8

You might want to turn this into something like:

#define QSPI_NR_NBBITS(n) ((n) - 8)

> +#define QSPI_MR_DLYBCT_OFFSET		16
> +#define QSPI_MR_DLYBCT_SIZE		8
> +#define QSPI_MR_DLYCS_OFFSET		24
> +#define QSPI_MR_DLYCS_SIZE		8

[...]

> +/* Bitfields in QSPI_IFR (Instruction Frame Register) */
> +#define QSPI_IFR_WIDTH_OFFSET		0
> +#define QSPI_IFR_WIDTH_SIZE		3
> +#define		QSPI_IFR_WIDTH_SINGLE_BIT_SPI		0
> +#define		QSPI_IFR_WIDTH_DUAL_OUTPUT		1
> +#define		QSPI_IFR_WIDTH_QUAD_OUTPUT		2
> +#define		QSPI_IFR_WIDTH_DUAL_IO			3
> +#define		QSPI_IFR_WIDTH_QUAD_IO			4
> +#define		QSPI_IFR_WIDTH_DUAL_CMD			5
> +#define		QSPI_IFR_WIDTH_QUAD_CMD			6

Please use #define[SPACE] instead of inconsistent #define[TAB]

[...]

> +/* Bit manipulation macros */
> +#define QSPI_BIT(name) \
> +	(1 << QSPI_##name##_OFFSET)
> +#define QSPI_BF(name, value) \
> +	(((value) & ((1 << QSPI_##name##_SIZE) - 1)) << QSPI_##name##_OFFSET)
> +#define QSPI_BFEXT(name, value) \
> +	(((value) >> QSPI_##name##_OFFSET) & ((1 << QSPI_##name##_SIZE) - 1))
> +#define QSPI_BFINS(name, value, old) \
> +	(((old) & ~(((1 << QSPI_##name##_SIZE) - 1) << QSPI_##name##_OFFSET)) \
> +	 | QSPI_BF(name, value))
> +
> +/* Register access macros */
> +#define qspi_readl(port, reg) \
> +	readl_relaxed((port)->regs + QSPI_##reg)
> +#define qspi_writel(port, reg, value) \
> +	writel_relaxed((value), (port)->regs + QSPI_##reg)
> +
> +#define qspi_readw(port, reg) \
> +	readw_relaxed((port)->regs + QSPI_##reg)
> +#define qspi_writew(port, reg, value) \
> +	writew_relaxed((value), (port)->regs + QSPI_##reg)
> +
> +#define qspi_readb(port, reg) \
> +	readb_relaxed((port)->regs + QSPI_##reg)
> +#define qspi_writeb(port, reg, value) \
> +	writeb_relaxed((value), (port)->regs + QSPI_##reg)

I cannot say I'd be very fond of those preprocessor concatenations. Can't
you do something about them? It's really hard to look for symbols which are
in fact result of this horrible macro voodoo .

> +struct atmel_qspi {
> +	void __iomem		*regs;
> +	void __iomem		*mem;
> +	dma_addr_t		phys_addr;
> +	struct dma_chan		*chan;
> +	struct clk		*clk;
> +	struct platform_device	*pdev;
> +	u32			ifr_width;
> +	u32			pending;
> +
> +	struct mtd_info		mtd;
> +	struct spi_nor		nor;
> +	u32			clk_rate;
> +	struct completion	completion;
> +
> +#ifdef DEBUG
> +	u8			last_instruction;
> +#endif
> +};

[...]

> +#ifdef DEBUG
> +static void atmel_qspi_debug_command(struct atmel_qspi *aq,
> +				     const struct atmel_qspi_command *cmd)
> +{
> +	u8 cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> +	size_t len = 0;
> +	int i;
> +
> +	if (cmd->enable.bits.instruction) {
> +		if (aq->last_instruction == cmd->instruction)
> +			return;
> +		aq->last_instruction = cmd->instruction;
> +	}
> +
> +	if (cmd->enable.bits.instruction)
> +		cmd_buf[len++] = cmd->instruction;
> +
> +	for (i = cmd->enable.bits.address-1; i >= 0; --i)
> +		cmd_buf[len++] = (cmd->address >> (i << 3)) & 0xff;
> +
> +	if (cmd->enable.bits.mode)
> +		cmd_buf[len++] = cmd->mode;
> +
> +	if (cmd->enable.bits.dummy) {
> +		int num = cmd->num_dummy_cycles;
> +
> +		switch (aq->ifr_width) {
> +		case QSPI_IFR_WIDTH_SINGLE_BIT_SPI:
> +		case QSPI_IFR_WIDTH_DUAL_OUTPUT:
> +		case QSPI_IFR_WIDTH_QUAD_OUTPUT:
> +			num >>= 3;
> +			break;
> +		case QSPI_IFR_WIDTH_DUAL_IO:
> +		case QSPI_IFR_WIDTH_DUAL_CMD:
> +			num >>= 2;
> +			break;
> +		case QSPI_IFR_WIDTH_QUAD_IO:
> +		case QSPI_IFR_WIDTH_QUAD_CMD:
> +			num >>= 1;
> +			break;
> +		default:
> +			return;
> +		}
> +
> +		for (i = 0; i < num; ++i)
> +			cmd_buf[len++] = 0;
> +	}
> +
> +	print_hex_dump(KERN_DEBUG, "qspi cmd: ", DUMP_PREFIX_NONE,
> +		       32, 1, cmd_buf, len, false);
> +
> +#ifdef VERBOSE_DEBUG

The print_hex_dump() is already KERN_DEBUG, so I don't think there's any
need to introduce yet another preprocessor check here.

> +	if (cmd->enable.bits.data && cmd->tx_buf)
> +		print_hex_dump(KERN_DEBUG, "qspi tx : ", DUMP_PREFIX_NONE,
> +			       32, 1, cmd->tx_buf, cmd->buf_len, false);
> +#endif
> +}
> +#else
> +#define atmel_qspi_debug_command(aq, cmd)
> +#endif

[...]
