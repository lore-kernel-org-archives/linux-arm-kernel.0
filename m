From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 22 Aug 2013 12:21:58 -0700
Subject: [PATCH V1 4/5] spi: Add Freescale QuadSpi driver
In-Reply-To: <1376885403-12156-5-git-send-email-b32955@freescale.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-5-git-send-email-b32955@freescale.com>
Message-ID: <20130822192158.GA10038@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding devicetree at vger.kernel.org

You might want to split out the devicetree binding documentation as a
separate patch from the driver submission, so that DT binding reviewers
will have an easier time.

On Mon, Aug 19, 2013 at 12:10:02PM +0800, Huang Shijie wrote:
> (0) What is the Quadspi controller?
> 
>     The Quadspi(Quad Serial Peripheral Interface) acts as an interface to
>     one single or two external serial flash devices, each with up to 4
>     bidirectional data lines.
> 
> (1) The Quadspi controller is driven by the LUT(Look-up Table) registers.
>     The LUT registers are a look-up-table for sequences of instructions.
>     A valid sequence consists of four LUT registers.
> 
> (2) The definition of the LUT register shows below:
> 
>     ---------------------------------------------------
>     | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
>     ---------------------------------------------------
> 
>     There are several types of INSTRx, such as:
>     	CMD	: the SPI NOR command.
> 	ADDR	: the address for the SPI NOR command.
> 	DUMMY	: the dummy cycles needed by the SPI NOR command.
> 	....
> 
> (3) We connect the NOR the QuadSPI now. I am not sure, but i think the
>     QuadSPI will be only used for the NOR. We may connect other devices
>     to it. But, for the reason of (2), we have to parse out the SPI NOR
>     command for the QuadSPI.
> 
> (4) Test this driver with the JFFS2 and UBIFS:
> 
>     For jffs2:
>          #flash_eraseall /dev/mtd0
>          #mount -t jffs2 /dev/mtdblock0 tmp
>          #bonnie++ -d tmp -u 0 -s 10 -r 5
> 
>     For ubifs:
>          #flash_eraseall /dev/mtd0
>     	 #ubiattach /dev/ubi_ctrl -m 0
>     	 #ubimkvol /dev/ubi0 -N test -m
>          #mount -t ubifs ubi0:test tmp
>          #bonnie++ -d tmp -u 0 -s 10 -r 5
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  .../devicetree/bindings/spi/fsl-quadspi.txt        |   27 +
>  drivers/spi/Kconfig                                |    7 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-fsl-quadspi.c                      |  930 ++++++++++++++++++++
>  4 files changed, 965 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/fsl-quadspi.txt
>  create mode 100644 drivers/spi/spi-fsl-quadspi.c
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl-quadspi.txt b/Documentation/devicetree/bindings/spi/fsl-quadspi.txt
> new file mode 100644
> index 0000000..e5bfa82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl-quadspi.txt
> @@ -0,0 +1,27 @@
> +* Freescale Quad Serial Peripheral Interface(QuadSPI)
> +
> +Required properties:
> +- compatible : Should be "fsl,vf610-qspi"
> +- reg : Offset and length of the register set for the device
> +- interrupts : Should contain the interrupt for the device
> +- fsl,spi-num-chipselects : Contains the number of the chipselect

Can this controller support more than one chip? If so, then the nor-size
property makes even less sense. See below.

> +- clocks : The clocks needed by the QuadSPI controller
> +- clock-names : the name of the clocks
> +
> +Optional properties:
> +- fsl,nor-size : The NOR size used by the QuadSPI mapping.

Why does the size of the NOR flash need to be in the controller's device
node? Shouldn't this be detected at run-time if possible? Or at least
included as a property of m25p80, if absolutely required?

> +
> +Example:
> +
> +qspi0: quadspi at 40044000 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "fsl,vf610-qspi";
> +	reg = <0x40044000 0x1000>;
> +	interrupts = <0 24 0x04>;
> +	clocks = <&clks VF610_CLK_QSPI0_EN>,
> +		<&clks VF610_CLK_QSPI0>;
> +	clock-names = "qspi_en", "qspi";
> +	fsl,nor-size = <0x1000000>;
> +	status = "disabled";
> +};
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 92b2373..dc38063 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -187,6 +187,13 @@ config SPI_FALCON
>  	  has only been tested with m25p80 type chips. The hardware has no
>  	  support for other types of SPI peripherals.
>  
> +config SPI_FSL_QUADSPI
> +	tristate "Freescale Quad SPI controller"
> +	depends on ARCH_MXC
> +	help
> +	  This enables support for the Quad SPI controller in master mode.
> +	  We only connect the NOR to this controller now.
> +
>  config SPI_GPIO
>  	tristate "GPIO-based bitbanging SPI Master"
>  	depends on GPIOLIB
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index b25f385..7fe505c 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_SPI_FSL_ESPI)		+= spi-fsl-espi.o
>  obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
>  obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
>  obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
> +obj-$(CONFIG_SPI_FSL_QUADSPI)           += spi-fsl-quadspi.o
>  obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
>  obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
>  obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
> diff --git a/drivers/spi/spi-fsl-quadspi.c b/drivers/spi/spi-fsl-quadspi.c
> new file mode 100644
> index 0000000..de71a4e
> --- /dev/null
> +++ b/drivers/spi/spi-fsl-quadspi.c
> @@ -0,0 +1,930 @@
> +/*
> + * Freescale Quad SPI driver.
> + *
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/errno.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/timer.h>
> +#include <linux/jiffies.h>
> +#include <linux/completion.h>
> +#include <linux/mtd/spi-nor.h>
> +
> +/* The registers */
> +#define QUADSPI_MCR			0x00
> +#define QUADSPI_MCR_MDIS_SHIFT		14
> +#define QUADSPI_MCR_MDIS_MASK		(1 << QUADSPI_MCR_MDIS_SHIFT)
> +#define QUADSPI_MCR_CLR_TXF_SHIFT	11
> +#define QUADSPI_MCR_CLR_TXF_MASK	(1 << QUADSPI_MCR_CLR_TXF_SHIFT)
> +#define QUADSPI_MCR_CLR_RXF_SHIFT	10
> +#define QUADSPI_MCR_CLR_RXF_MASK	(1 << QUADSPI_MCR_CLR_RXF_SHIFT)
> +#define QUADSPI_MCR_DDR_EN_SHIFT	7
> +#define QUADSPI_MCR_DDR_EN_MASK		(1 << QUADSPI_MCR_DDR_EN_SHIFT)
> +#define QUADSPI_MCR_RESERVED_SHIFT	16
> +#define QUADSPI_MCR_RESERVED_MASK	(0xF << QUADSPI_MCR_RESERVED_SHIFT)
> +#define QUADSPI_MCR_SWRSTHD_SHIFT	1
> +#define QUADSPI_MCR_SWRSTHD_MASK	(1 << QUADSPI_MCR_SWRSTHD_SHIFT)
> +#define QUADSPI_MCR_SWRSTSD_SHIFT	0
> +#define QUADSPI_MCR_SWRSTSD_MASK	(1 << QUADSPI_MCR_SWRSTSD_SHIFT)
> +
> +#define QUADSPI_IPCR			0x08
> +#define QUADSPI_IPCR_SEQID_SHIFT	24
> +#define QUADSPI_IPCR_SEQID_MASK		(0xF << QUADSPI_IPCR_SEQID_SHIFT)
> +
> +#define QUADSPI_BUF0CR			0x10
> +#define QUADSPI_BUF1CR			0x14
> +#define QUADSPI_BUF2CR			0x18
> +#define QUADSPI_BUFXCR_INVALID_MSTRID	0xe
> +
> +#define QUADSPI_BUF3CR			0x1c
> +#define QUADSPI_BUF3CR_ALLMST_SHIFT	31
> +#define QUADSPI_BUF3CR_ALLMST		(1 << QUADSPI_BUF3CR_ALLMST_SHIFT)
> +
> +#define QUADSPI_BFGENCR			0x20
> +#define QUADSPI_BFGENCR_PAR_EN_SHIFT	16
> +#define QUADSPI_BFGENCR_PAR_EN_MASK	(1 << (QUADSPI_BFGENCR_PAR_EN_SHIFT))
> +#define QUADSPI_BFGENCR_SEQID_SHIFT	12
> +#define QUADSPI_BFGENCR_SEQID_MASK	(0xF << QUADSPI_BFGENCR_SEQID_SHIFT)
> +
> +#define QUADSPI_BUF0IND			0x30
> +#define QUADSPI_BUF1IND			0x34
> +#define QUADSPI_BUF2IND			0x38
> +#define QUADSPI_SFAR			0x100
> +
> +#define QUADSPI_SMPR			0x108
> +#define QUADSPI_SMPR_DDRSMP_SHIFT	16
> +#define QUADSPI_SMPR_DDRSMP_MASK	(7 << QUADSPI_SMPR_DDRSMP_SHIFT)
> +#define QUADSPI_SMPR_FSDLY_SHIFT	6
> +#define QUADSPI_SMPR_FSDLY_MASK		(1 << QUADSPI_SMPR_FSDLY_SHIFT)
> +#define QUADSPI_SMPR_FSPHS_SHIFT	5
> +#define QUADSPI_SMPR_FSPHS_MASK		(1 << QUADSPI_SMPR_FSPHS_SHIFT)
> +#define QUADSPI_SMPR_HSENA_SHIFT	0
> +#define QUADSPI_SMPR_HSENA_MASK		(1 << QUADSPI_SMPR_HSENA_SHIFT)
> +
> +#define QUADSPI_RBSR			0x10c
> +#define QUADSPI_RBSR_RDBFL_SHIFT	8
> +#define QUADSPI_RBSR_RDBFL_MASK		(0x3F << QUADSPI_RBSR_RDBFL_SHIFT)
> +
> +#define QUADSPI_RBCT			0x110
> +#define QUADSPI_RBCT_WMRK_MASK		0x1F
> +#define QUADSPI_RBCT_RXBRD_SHIFT	8
> +#define QUADSPI_RBCT_RXBRD_USEIPS	(0x1 << QUADSPI_RBCT_RXBRD_SHIFT)
> +
> +#define QUADSPI_TBSR			0x150
> +#define QUADSPI_TBDR			0x154
> +
> +#define QUADSPI_SR			0x15c
> +#define QUADSPI_SR_TXFULL_SHIFT		27
> +#define QUADSPI_SR_TXFULL_MASK		(1 << QUADSPI_SR_TXFULL_SHIFT)
> +#define QUADSPI_SR_AHBTRN_SHIFT		6
> +#define QUADSPI_SR_AHBTRN_MASK		(1 << QUADSPI_SR_AHBTRN_SHIFT)
> +#define QUADSPI_SR_AHB_ACC_SHIFT	2
> +#define QUADSPI_SR_AHB_ACC_MASK		(1 << QUADSPI_SR_AHB_ACC_SHIFT)
> +#define QUADSPI_SR_IP_ACC_SHIFT		1
> +#define QUADSPI_SR_IP_ACC_MASK		(1 << QUADSPI_SR_IP_ACC_SHIFT)
> +#define QUADSPI_SR_BUSY_SHIFT		0
> +#define QUADSPI_SR_BUSY_MASK		(1 << QUADSPI_SR_BUSY_SHIFT)
> +
> +#define QUADSPI_FR			0x160
> +#define QUADSPI_FR_TFF_MASK		0x1
> +
> +#define QUADSPI_SFA1AD			0x180
> +#define QUADSPI_SFA2AD			0x184
> +#define QUADSPI_SFB1AD			0x188
> +#define QUADSPI_SFB2AD			0x18c
> +#define QUADSPI_RBDR			0x200
> +
> +#define QUADSPI_LUTKEY			0x300
> +#define QUADSPI_LUTKEY_VALUE		0x5AF05AF0
> +
> +#define QUADSPI_LCKCR			0x304
> +#define QUADSPI_LCKER_LOCK		0x1
> +#define QUADSPI_LCKER_UNLOCK		0x2
> +
> +#define QUADSPI_RSER			0x164
> +#define QUADSPI_RSER_TFIE       	(0x1 << 0)
> +
> +#define QUADSPI_LUT_BASE		0x310
> +
> +/* Field definitions for LUT register. */
> +#define OPRND0_SHIFT		0
> +#define PAD0_SHIFT		8
> +#define INSTR0_SHIFT		10
> +#define OPRND1_SHIFT		16
> +
> +/* Instruction set for the LUT register. */
> +#define CMD			1
> +#define ADDR			2
> +#define DUMMY			3
> +#define MODE			4
> +#define MODE2			5
> +#define MODE4			6
> +#define READ			7
> +#define WRITE			8
> +#define JMP_ON_CS		9
> +#define ADDR_DDR		10
> +#define MODE_DDR		11
> +#define MODE2_DDR		12
> +#define MODE4_DDR		13
> +
> +/*
> + * The PAD definitions for LUT register.
> + *
> + * The pad stands for the lines number of IO[0:3].
> + * For example, the Quad read need four IO lines, so you should
> + * set PAD4 which means we use four IO lines.
> + */
> +#define PAD1			0
> +#define PAD2			1
> +#define PAD4			2
> +
> +/* Oprands for the LUT register. */
> +#define ADDR24BIT		0x18
> +
> +/* Macros for constructing the LUT register. */
> +#define QUADSPI_LUT0(ins, pad, opr)					\
> +		(((opr) << OPRND0_SHIFT) | ((pad) << PAD0_SHIFT) |	\
> +		((ins) << INSTR0_SHIFT))
> +
> +#define QUADSPI_LUT1(ins, pad, opr) \
> +		(QUADSPI_LUT0((ins), (pad), (opr)) << OPRND1_SHIFT)
> +
> +/* other macros for LUT register. */
> +#define QUADSPI_LUT(x)          (QUADSPI_LUT_BASE + (x) * 4)
> +#define QUADSPI_LUT_NUM		64
> +
> +/* SEQID */
> +#define SEQID_QUAD_READ		0
> +#define SEQID_WREN		1
> +#define SEQID_FAST_READ 	2
> +#define SEQID_RDSR		3
> +#define SEQID_SE		4
> +#define SEQID_CHIP_ERASE	5
> +#define SEQID_PP		6
> +#define SEQID_RDID		7
> +#define SEQID_WRSR		8
> +#define SEQID_RDCR		9
> +
> +struct fsl_qspi_handler {
> +	int (*setup)(struct spi_device *);
> +	int (*do_one_msg)(struct spi_master *, struct spi_message *);
> +};
> +
> +enum fsl_qspi_devtype {
> +	FSL_QUADSPI_VYBRID,
> +	FSL_QUADSPI_IMX6SLX
> +};
> +
> +struct fsl_qspi_devtype_data {
> +	enum fsl_qspi_devtype devtype;
> +	u32 memmap_base;
> +	int rxfifo;
> +	int txfifo;
> +};
> +
> +static struct fsl_qspi_devtype_data vybrid_data = {
> +	.devtype = FSL_QUADSPI_VYBRID,
> +	.memmap_base = 0x20000000,
> +	.rxfifo = 128,
> +	.txfifo = 64
> +};
> +
> +struct fsl_qspi {
> +	void __iomem *iobase;
> +	struct clk *clk, *clk_en;
> +	struct device *dev;
> +	struct fsl_qspi_handler *h;
> +	struct completion c;
> +	struct fsl_qspi_devtype_data *devtype_data;
> +	void __iomem *ahb_base; /* Used when read from AHB bus */
> +	unsigned int addr;
> +	u32 nor_size; /* for mapping */
> +	u8 cmd;
> +	unsigned int quad_read_enabled:1;
> +};
> +
> +static inline int is_vybrid_qspi(struct fsl_qspi *q)
> +{
> +	return q->devtype_data->devtype == FSL_QUADSPI_VYBRID;
> +}
> +
> +/*
> + * An IC bug makes us to re-arrange the 32-bit data.
> + * The following chips, such as IMX6SLX, have fixed this bug.
> + */
> +static inline u32 fsl_qspi_endian_xchg(struct fsl_qspi *q, u32 a)
> +{
> +	return is_vybrid_qspi(q) ? __swab32(a) : a;
> +}
> +
> +static inline void qspi_unlock_lut(struct fsl_qspi *q)
> +{
> +	writel(QUADSPI_LUTKEY_VALUE, q->iobase + QUADSPI_LUTKEY);
> +	writel(QUADSPI_LCKER_UNLOCK, q->iobase + QUADSPI_LCKCR);
> +}
> +
> +static inline void qspi_lock_lut(struct fsl_qspi *q)
> +{
> +	writel(QUADSPI_LUTKEY_VALUE, q->iobase + QUADSPI_LUTKEY);
> +	writel(QUADSPI_LCKER_LOCK, q->iobase + QUADSPI_LCKCR);
> +}
> +
> +static irqreturn_t fsl_qspi_irq_handler(int irq, void *dev_id)
> +{
> +	struct fsl_qspi *q = dev_id;
> +	u32 reg;
> +
> +	/* clear interrupt */
> +	reg = readl(q->iobase + QUADSPI_FR);
> +	writel(reg, q->iobase + QUADSPI_FR);
> +
> +	if (reg & QUADSPI_FR_TFF_MASK)
> +		complete(&q->c);
> +
> +	dev_dbg(q->dev, "QUADSPI_FR : 0x%.8x\n", reg);
> +	return IRQ_HANDLED;
> +}
> +
> +/* Init the LUT table. */
> +static void fsl_qspi_init_lut(struct fsl_qspi *q)
> +{
> +	void *__iomem base = q->iobase;
> +	int rxfifo = q->devtype_data->rxfifo;
> +	u32 lut_base;
> +	int i;
> +
> +	qspi_unlock_lut(q);
> +
> +	/* Clear all the LUT table */
> +	for (i = 0; i < QUADSPI_LUT_NUM; i++)
> +		writel(0, base + QUADSPI_LUT_BASE + i * 4);
> +
> +	/* Quad Read */
> +	lut_base = SEQID_QUAD_READ * 4;
> +	writel(QUADSPI_LUT0(CMD, PAD1, OPCODE_QIOR)
> +			| QUADSPI_LUT1(ADDR, PAD4, ADDR24BIT),
> +			base + QUADSPI_LUT(lut_base));
> +	writel(QUADSPI_LUT0(MODE, PAD4, 0xff) | QUADSPI_LUT1(DUMMY, PAD4, 4),
> +			base + QUADSPI_LUT(lut_base + 1));
> +	writel(QUADSPI_LUT0(READ, PAD4, rxfifo),
> +			base + QUADSPI_LUT(lut_base + 2));
> +
> +	/* Write enable */
> +	lut_base = SEQID_WREN * 4;
> +	writel(QUADSPI_LUT0(CMD, PAD1, OPCODE_WREN),
> +			base + QUADSPI_LUT(lut_base));
> +
> +	/* Fast Read */
> +	lut_base = SEQID_FAST_READ * 4;
> +	writel(QUADSPI_LUT0(CMD, PAD1, OPCODE_FAST_READ)
> +			| QUADSPI_LUT1(ADDR, PAD1, ADDR24BIT),
> +			base + QUADSPI_LUT(lut_base));
> +	writel(QUADSPI_LUT0(DUMMY, PAD1, 8) | QUADSPI_LUT1(READ, PAD1, rxfifo),
> +			base + QUADSPI_LUT(lut_base + 1));
> +
> +	/* Page Program */
> +	lut_base = SEQID_PP * 4;
> +	writel(QUADSPI_LUT0(CMD, PAD1, OPCODE_PP)
> +			| QUADSPI_LUT1(ADDR, PAD1, ADDR24BIT),
> +			base + QUADSPI_LUT(lut_base));
> +	writel(QUADSPI_LUT0(WRITE, PAD1, 0),
> +			base + QUADSPI_LUT(lut_base + 1));
> +
> +	/* Read Status */
> +	lut_base = SEQID_RDSR * 4;
> +	writel(QUADSPI_LUT0(CMD, PAD1, OPCODE_RDSR)
> +			| QUADSPI_LUT1(READ, PAD1, 0x1),
> +			base + QUADSPI_LUT(lut_base));
> +
> +	/* Erase a sector */
> +	lut_base = SEQID_SE * 4;
> +	writel(QUADSPI_LUT0(CMD, PAD1, OPCODE_SE)
> +			| QUADSPI_LUT1(ADDR, PAD1, ADDR24BIT),
> +			base + QUADSPI_LUT(lut_base));
> +
> +	/* Erase the whole chip */
> +	lut_base = SEQID_CHIP_ERASE * 4;
> +	writel(QUADSPI_LUT0(CMD, PAD1, OPCODE_CHIP_ERASE),
> +			base + QUADSPI_LUT(lut_base));
> +
> +	/* READ ID */
> +	lut_base = SEQID_RDID * 4;
> +	writel(QUADSPI_LUT0(CMD, PAD1, OPCODE_RDID)
> +			| QUADSPI_LUT1(READ, PAD1, 0x8),
> +			base + QUADSPI_LUT(lut_base));
> +
> +	/* Write Register */
> +	lut_base = SEQID_WRSR * 4;
> +	writel(QUADSPI_LUT0(CMD, PAD1, OPCODE_WRSR)
> +			| QUADSPI_LUT1(WRITE, PAD1, 0x2),
> +			base + QUADSPI_LUT(lut_base));
> +
> +	/* Read Configuration Register */
> +	lut_base = SEQID_RDCR * 4;
> +	writel(QUADSPI_LUT0(CMD, PAD1, OPCODE_RDCR)
> +			| QUADSPI_LUT1(READ, PAD1, 0x1),
> +			base + QUADSPI_LUT(lut_base));
> +	qspi_lock_lut(q);
> +}
> +
> +/* Get the SEQID for the command */
> +static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
> +{
> +	switch (cmd) {
> +	case OPCODE_WREN:
> +		return SEQID_WREN;
> +	case OPCODE_RDSR:
> +		return SEQID_RDSR;
> +	case OPCODE_SE:
> +		return SEQID_SE;
> +	case OPCODE_CHIP_ERASE:
> +		return SEQID_CHIP_ERASE;
> +	case OPCODE_PP:
> +		return SEQID_PP;
> +	case OPCODE_RDID:
> +		return SEQID_RDID;
> +	case OPCODE_WRSR:
> +		return SEQID_WRSR;
> +	case OPCODE_RDCR:
> +		return SEQID_RDCR;
> +	default:
> +		dev_err(q->dev, "Unsupported cmd 0x%.2x\n", cmd);
> +		break;
> +	}
> +	return -1;
> +}
> +
> +static int
> +fsl_qspi_runcmd(struct fsl_qspi *q, u8 cmd, unsigned int addr, int len)
> +{
> +	int seqid;
> +	u32 reg;
> +	int err;
> +
> +	init_completion(&q->c);
> +	dev_dbg(q->dev, "to @%.8x, len:%d, cmd:%.2x\n", addr, len, cmd);
> +
> +	/* save the reg */
> +	reg = readl(q->iobase + QUADSPI_MCR);
> +
> +	writel(q->devtype_data->memmap_base + addr, q->iobase + QUADSPI_SFAR);
> +	writel(QUADSPI_RBCT_WMRK_MASK | QUADSPI_RBCT_RXBRD_USEIPS,
> +			q->iobase + QUADSPI_RBCT);
> +	writel(QUADSPI_MCR_CLR_RXF_MASK | QUADSPI_MCR_RESERVED_MASK,
> +			q->iobase + QUADSPI_MCR);
> +
> +	/* trigger the LUT now */
> +	seqid = fsl_qspi_get_seqid(q, cmd);
> +	writel((seqid << QUADSPI_IPCR_SEQID_SHIFT) | len,
> +		q->iobase + QUADSPI_IPCR);
> +
> +	/* Wait for the interrupt. */
> +	err = wait_for_completion_timeout(&q->c, msecs_to_jiffies(1000));
> +	if (!err) {
> +		dev_err(q->dev,
> +			"cmd 0x%.2x timeout, addr@%.8x, FR:0x%.8x, SR:0x%.8x\n",
> +			cmd, addr, readl(q->iobase + QUADSPI_FR),
> +			readl(q->iobase + QUADSPI_SR));
> +		err = -ETIMEDOUT;
> +	} else {
> +		err = 0;
> +	}
> +
> +	/* restore the MCR */
> +	writel(reg, q->iobase + QUADSPI_MCR);
> +
> +	return err;
> +}
> +
> +/* Get the address from the tx buffer. */
> +static unsigned int
> +fsl_qspi_get_addr(struct fsl_qspi *q, struct spi_transfer *t)
> +{
> +	unsigned int addr;
> +	u8 *buf = (u8 *)t->tx_buf;
> +
> +	/* 3-byte address */
> +	if (q->nor_size <= SZ_16M)
> +		addr = (buf[1] << 16) | (buf[2] << 8) |  buf[3];
> +	return addr;
> +}
> +
> +/* Read out the data from the buffer registers. */
> +static void fsl_qspi_read_data(struct fsl_qspi *q, int len, u32 *rxbuf)
> +{
> +	u32 tmp;
> +	int i = 0;
> +
> +	while (len > 0) {
> +		tmp = readl(q->iobase + QUADSPI_RBDR + i * 4);
> +		*rxbuf = fsl_qspi_endian_xchg(q, tmp);
> +		dev_dbg(q->dev, "rcv: 0x%.8x, tmp : 0x%.8x\n", *rxbuf, tmp);
> +
> +		rxbuf++;
> +		len -= 4;
> +		i++;
> +	}
> +}
> +
> +/* Read out the data directly from the AHB buffer.*/
> +static int fsl_qspi_read_data_ahb(struct fsl_qspi *q, struct spi_transfer *t)
> +{
> +	dev_dbg(q->dev, "cmd [%x],read from 0x%.8x,len:%d\n",
> +		q->cmd, q->addr, t->len);
> +	memcpy(t->rx_buf, q->ahb_base + q->addr, t->len);
> +	return 0;
> +}
> +
> +static u32 fsl_qspi_read_sr(struct fsl_qspi *q)
> +{
> +	u32 val = -EINVAL;
> +	int ret;
> +
> +	ret = fsl_qspi_runcmd(q, OPCODE_RDSR, 0, 1);
> +	if (!ret)
> +		fsl_qspi_read_data(q, 1, &val);
> +	return val;
> +}
> +
> +static int fsl_qspi_wait_till_ready(struct fsl_qspi *q)
> +{
> +	unsigned long deadline;
> +	u32 sr;
> +
> +	deadline = jiffies + msecs_to_jiffies(40000);
> +
> +	do {
> +		if ((sr = fsl_qspi_read_sr(q)) < 0)
> +			break;
> +		else if (!(sr & SR_WIP))
> +			return 0;
> +
> +		cond_resched();
> +
> +	} while (!time_after_eq(jiffies, deadline));
> +
> +	return 1;
> +}
> +
> +/*
> + * If we have changed the content of the flash by writing or erasing,
> + * we need to invalidate the AHB buffer. If we do not do so, we may read out
> + * the wrong data. The spec tells us reset the AHB domain and Serial Flash
> + * domain at the same time.
> + */
> +static inline void fsl_qspi_invalid(struct fsl_qspi *q)
> +{
> +	u32 reg;
> +
> +	reg = readl(q->iobase + QUADSPI_MCR);
> +	reg |= QUADSPI_MCR_SWRSTHD_MASK | QUADSPI_MCR_SWRSTSD_MASK;
> +	writel(reg, q->iobase + QUADSPI_MCR);
> +
> +	/*
> +	 * The minimum delay : 1 AHB + 2 SFCK clocks.
> +	 * Delay 1 us is enough.
> +	 */
> +	udelay(1);
> +
> +	reg &= ~(QUADSPI_MCR_SWRSTHD_MASK | QUADSPI_MCR_SWRSTSD_MASK);
> +	writel(reg, q->iobase + QUADSPI_MCR);
> +}
> +
> +static int fsl_qspi_nor_write(struct fsl_qspi *q, u32 *txbuf, unsigned count)
> +{
> +	unsigned int addr = q->addr;
> +	int txfifo_size = q->devtype_data->txfifo;
> +	int ret = 0;
> +	int tx_size;
> +	u32 tmp;
> +	int i, j;
> +	u8 cmd = q->cmd;
> +
> +	q->cmd = -1; /* clear the cmd */
> +	dev_dbg(q->dev, "to @%.8x, len : %d\n", addr, count);
> +
> +	while (count > 0) {
> +		tx_size = (count > txfifo_size) ? txfifo_size : count;
> +
> +		/* clear the TX FIFO. */
> +		tmp = readl(q->iobase + QUADSPI_MCR);
> +		writel(tmp | QUADSPI_MCR_CLR_RXF_MASK, q->iobase + QUADSPI_MCR);
> +
> +		/* fill the TX data to the FIFO */
> +		for (j = 0, i = ((tx_size + 3) / 4); j < i; j++) {
> +			tmp = fsl_qspi_endian_xchg(q, *txbuf);
> +			writel(tmp, q->iobase + QUADSPI_TBDR);
> +			txbuf++;
> +		}
> +
> +		/* Trigger it */
> +		ret = fsl_qspi_runcmd(q, cmd, addr, tx_size);
> +
> +		addr += tx_size;
> +		count -= tx_size;
> +
> +		/*
> +		 * If the TX FIFO is smaller then the size of Page Program,
> +		 * we have to wait until this Write is finished.
> +		 * For example, the TX FIFO is 64 bytes in the Vybrid,
> +		 * but the Page Program may writes 265 bytes per time.
> +		 * We are lucky that some chip(IMX6SLX) has increase the TX FIFO
> +		 * to 512 bytes.
> +		 *
> +		 * If we can change the @m25p->page_size, we can remove the
> +		 * following code.
> +		 */
> +		if (count > 0) {
> +			ret = fsl_qspi_wait_till_ready(q);
> +			if (ret) {
> +				dev_err(q->dev, "Reading SR, err:%d\n", ret);
> +				break;
> +			}
> +
> +			/* Write Enable again. */
> +			ret = fsl_qspi_runcmd(q, OPCODE_WREN, 0, 0);
> +			if (ret) {
> +				dev_err(q->dev, "Write Enable, err:%d\n", ret);
> +				break;
> +			}
> +		}
> +	}
> +	return ret;
> +}
> +
> +/* Switch to Quad read now. */
> +static inline void fsl_qspi_enable_quad_read(struct fsl_qspi *q)
> +{
> +	writel(SEQID_QUAD_READ << QUADSPI_BFGENCR_SEQID_SHIFT,
> +		q->iobase + QUADSPI_BFGENCR);
> +	q->quad_read_enabled = 1;
> +}
> +
> +static int fsl_qspi_nor_tx(struct fsl_qspi *q, struct spi_transfer *t)
> +{
> +	unsigned int addr = 0;
> +	bool need_invalid = false;
> +	int ret = 0;
> +	u32 val;
> +	u8 cmd;
> +
> +	/* This is the second spi_transfer for Page Program. */
> +	if (q->cmd == OPCODE_PP) {
> +		ret = fsl_qspi_nor_write(q, (u32 *)t->tx_buf, t->len);
> +		need_invalid = true;
> +		goto qspi_tx_out;
> +	}
> +
> +	cmd = *(u8 *)t->tx_buf;
> +	dev_dbg(q->dev, "NOR cmd is [0x%.2x], len : %d.\n", cmd, t->len);
> +
> +	switch (cmd) {
> +	case OPCODE_SE:
> +		addr = fsl_qspi_get_addr(q, t);
> +		/* fall through */
> +	case OPCODE_CHIP_ERASE:
> +		need_invalid = true;
> +	case OPCODE_WREN:
> +		ret = fsl_qspi_runcmd(q, cmd, addr, 0);
> +		q->cmd = -1;
> +		break;
> +
> +	case OPCODE_QIOR:
> +		if (!q->quad_read_enabled)
> +			fsl_qspi_enable_quad_read(q);
> +		/* fall through */
> +	case OPCODE_FAST_READ:
> +	case OPCODE_PP:
> +		q->cmd = cmd;
> +		q->addr = fsl_qspi_get_addr(q, t);
> +		break;
> +
> +	case OPCODE_WRSR:
> +		q->addr = 0;
> +		q->cmd = cmd;
> +		/* skip the cmd */
> +		memcpy((void *) &val, ((u8 *)t->tx_buf) + 1, t->len -1);
> +		ret = fsl_qspi_nor_write(q, &val, t->len - 1);
> +		break;
> +
> +	default:
> +		q->cmd = cmd;
> +		break;
> +	}
> +
> +qspi_tx_out:
> +	if (need_invalid)
> +		fsl_qspi_invalid(q);
> +	return ret;
> +}
> +
> +static int fsl_qspi_nor_rx(struct fsl_qspi *q, struct spi_transfer *t)
> +{
> +	int ret = 0;
> +
> +	switch (q->cmd) {
> +	case OPCODE_RDSR:
> +	case OPCODE_RDCR:
> +	case OPCODE_RDID:
> +		ret = fsl_qspi_runcmd(q, q->cmd, 0, t->len);
> +		if (!ret)
> +			fsl_qspi_read_data(q, t->len, t->rx_buf);
> +		break;
> +
> +	case OPCODE_QIOR:
> +	case OPCODE_FAST_READ:
> +		ret = fsl_qspi_read_data_ahb(q, t);
> +		break;
> +	default:
> +		dev_err(q->dev, "Unsupported cmd : %x\n", q->cmd);
> +		return -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static int fsl_qspi_nor_do_one_msg(struct spi_master *master,
> +		struct spi_message *m)
> +{
> +	struct fsl_qspi *q = spi_master_get_devdata(master);
> +	struct spi_transfer *t;
> +	int ret = 0;
> +
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		if (t->rx_buf && t->tx_buf) {
> +			dev_err(q->dev,
> +				"Can't send and receive simultaneously\n");
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (t->tx_buf) {
> +			ret = fsl_qspi_nor_tx(q, t);
> +			if (!ret)
> +				m->actual_length += t->len;
> +			continue;
> +		}
> +
> +		if (t->rx_buf) {
> +			ret = fsl_qspi_nor_rx(q, t);
> +			if (!ret)
> +				m->actual_length += t->len;
> +		}
> +	}
> +
> +	m->status = ret;
> +	spi_finalize_current_message(master);
> +	return ret;
> +}
> +
> +/*
> + * There are two different ways to read out the data from the flash:
> + *  the "IP Command Read" and the "AHB Command Read".
> + *
> + * The IC guy suggests we use the "AHB Command Read" which is faster
> + * then the "IP Command Read". (What's more is that there is a bug in
> + * the "IP Command Read" in the Vybrid.)
> + *
> + * After we set up the registers for the "AHB Command Read", we can use
> + * the memcpy to read the data directly. A "missed" access to the buffer
> + * causes the controller to clear the buffer, and use the sequence pointed
> + * by the QUADSPI_BFGENCR[SEQID] to initiate a read from the flash.
> + */
> +static int fsl_qspi_init_abh_read(struct fsl_qspi *q)
> +{
> +	void __iomem *base = q->iobase;
> +	u32 memmap_base = q->devtype_data->memmap_base;
> +	int nor_size = q->nor_size;
> +
> +	/* Map the SPI NOR to accessiable address */
> +	writel(nor_size | memmap_base, base + QUADSPI_SFA1AD);
> +	writel(nor_size | memmap_base, base + QUADSPI_SFA2AD);
> +	writel((nor_size * 2) | memmap_base, base + QUADSPI_SFB1AD);
> +	writel((nor_size * 2) | memmap_base, base + QUADSPI_SFB2AD);
> +
> +	/* AHB configuration for access buffer 0/1/2 .*/
> +	writel(QUADSPI_BUFXCR_INVALID_MSTRID, base + QUADSPI_BUF0CR);
> +	writel(QUADSPI_BUFXCR_INVALID_MSTRID, base + QUADSPI_BUF1CR);
> +	writel(QUADSPI_BUFXCR_INVALID_MSTRID, base + QUADSPI_BUF2CR);
> +	writel(QUADSPI_BUF3CR_ALLMST, base + QUADSPI_BUF3CR);
> +
> +	/* We only use the buffer3 */
> +	writel(0, base + QUADSPI_BUF0IND);
> +	writel(0, base + QUADSPI_BUF1IND);
> +	writel(0, base + QUADSPI_BUF2IND);
> +
> +	/* Set the default lut sequence for AHB Read. */
> +	writel(SEQID_FAST_READ << QUADSPI_BFGENCR_SEQID_SHIFT,
> +		base + QUADSPI_BFGENCR);
> +
> +	/* Map the AHB address for read. */
> +	q->ahb_base = ioremap(memmap_base, nor_size);
> +	if (!q->ahb_base)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static int fsl_qspi_nor_setup(struct spi_device *spi)
> +{
> +	struct fsl_qspi *q = spi_master_get_devdata(spi->master);
> +	void __iomem *base = q->iobase;
> +	u32 reg_val, smpr_val;
> +	int ret;
> +
> +	writel(QUADSPI_MCR_RESERVED_MASK | QUADSPI_MCR_MDIS_MASK,
> +		base + QUADSPI_MCR);
> +
> +	reg_val = readl(base + QUADSPI_SMPR);
> +	writel(reg_val & ~(QUADSPI_SMPR_FSDLY_MASK
> +			| QUADSPI_SMPR_FSPHS_MASK
> +			| QUADSPI_SMPR_HSENA_MASK), base + QUADSPI_SMPR);
> +
> +	writel(QUADSPI_MCR_RESERVED_MASK, base + QUADSPI_MCR);
> +
> +	fsl_qspi_init_lut(q);
> +	ret = fsl_qspi_init_abh_read(q);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg_val = 0;
> +	reg_val |= QUADSPI_MCR_RESERVED_MASK;
> +	smpr_val = readl(base + QUADSPI_SMPR);
> +	smpr_val &= ~QUADSPI_SMPR_DDRSMP_MASK;
> +	writel(smpr_val, base + QUADSPI_SMPR);
> +	reg_val &= ~QUADSPI_MCR_DDR_EN_MASK;
> +	writel(reg_val, base + QUADSPI_MCR);
> +
> +	/* enable the interrupt */
> +	writel(QUADSPI_RSER_TFIE, q->iobase + QUADSPI_RSER);
> +	return 0;
> +}
> +
> +/* We only support the NOR now. */
> +static struct fsl_qspi_handler fsl_qspi_nor_handler = {
> +	.setup = fsl_qspi_nor_setup,
> +	.do_one_msg = fsl_qspi_nor_do_one_msg,
> +};
> +
> +static int fsl_qspi_setup(struct spi_device *spi)
> +{
> +	struct fsl_qspi *q = spi_master_get_devdata(spi->master);
> +
> +	return q->h->setup(spi);
> +}
> +
> +static int fsl_qspi_do_one_msg(struct spi_master *master,
> +		struct spi_message *m)
> +{
> +	struct fsl_qspi *q = spi_master_get_devdata(master);
> +
> +	return q->h->do_one_msg(master, m);
> +}
> +
> +static struct of_device_id fsl_qspi_dt_ids[] = {
> +	{ .compatible = "fsl,vf610-qspi", .data = (void*)&vybrid_data, },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
> +
> +static int fsl_qspi_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct spi_master *master;
> +	struct fsl_qspi *q;
> +	struct resource *res;
> +	int num_cs, ret = 0;
> +	const struct of_device_id *of_id =
> +			of_match_device(fsl_qspi_dt_ids, &pdev->dev);
> +
> +	ret = of_property_read_u32(np, "fsl,spi-num-chipselects", &num_cs);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "can't get the spi-mum-chipselects\n");
> +		return ret;
> +	}
> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(*q));
> +	if (!master)
> +		return -ENOMEM;
> +	q = spi_master_get_devdata(master);
> +
> +	ret = of_property_read_u32(np, "fsl,nor-size", &q->nor_size);
> +	if (ret < 0)
> +		dev_dbg(&pdev->dev, "can't get the nor size.\n");
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	q->iobase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(q->iobase)) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		ret = PTR_ERR(q->iobase);
> +		goto map_failed;
> +	}
> +
> +	q->clk_en = devm_clk_get(&pdev->dev, "qspi_en");
> +	q->clk = devm_clk_get(&pdev->dev, "qspi");
> +	if (IS_ERR(q->clk_en) || IS_ERR(q->clk)) {
> +		dev_err(&pdev->dev, "failed to get clocks\n");
> +		ret = -ENOENT;
> +		goto map_failed;
> +	}
> +
> +	ret = clk_prepare_enable(q->clk_en);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can not enable the qspi_en clock\n");
> +		goto map_failed;
> +	}
> +
> +	ret = clk_prepare_enable(q->clk);
> +	if (ret) {
> +		clk_disable_unprepare(q->clk_en);
> +		dev_err(&pdev->dev, "can not enable the qspi clock\n");
> +		goto map_failed;
> +	}
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get the irq\n");
> +		goto irq_failed;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, ret,
> +			fsl_qspi_irq_handler, 0, pdev->name, q);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request irq.\n");
> +		goto irq_failed;
> +	}
> +
> +	q->dev = &pdev->dev;
> +	q->devtype_data = (struct fsl_qspi_devtype_data *)of_id->data;
> +
> +	/* The default handler is for NOR. */
> +	q->h = &fsl_qspi_nor_handler;
> +
> +	master->bus_num = pdev->id;
> +	master->num_chipselect = num_cs;
> +	master->dev.of_node = pdev->dev.of_node;
> +
> +	master->setup = fsl_qspi_setup;
> +	master->transfer_one_message = fsl_qspi_do_one_msg;
> +	platform_set_drvdata(pdev, master);
> +
> +	ret = spi_register_master(master);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register the spi master.\n");
> +		goto irq_failed;
> +	}
> +	dev_info(&pdev->dev, "QuadSPI bus driver\n");
> +	return 0;
> +
> +irq_failed:
> +	clk_disable_unprepare(q->clk);
> +	clk_disable_unprepare(q->clk_en);
> +map_failed:
> +	spi_master_put(master);
> +
> +	dev_err(&pdev->dev, "Freescale QuadSPI probe failed\n");
> +	return ret;
> +}
> +
> +static int fsl_qspi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct fsl_qspi *q = spi_master_get_devdata(master);
> +
> +	/* disable the hardware */
> +	writel(0x0, q->iobase + QUADSPI_MCR);
> +	writel(0x0, q->iobase + QUADSPI_RSER);
> +
> +	clk_disable_unprepare(q->clk);
> +	clk_disable_unprepare(q->clk_en);
> +	spi_master_put(master);
> +	return 0;
> +}
> +
> +static struct platform_driver fsl_qspi_driver = {
> +	.driver = {
> +		.name	= "fsl-quadspi",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = fsl_qspi_dt_ids,
> +	},
> +	.probe          = fsl_qspi_probe,
> +	.remove		= fsl_qspi_remove,
> +};
> +module_platform_driver(fsl_qspi_driver);
> +
> +MODULE_DESCRIPTION("Freescale QuadSPI Controller Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.1
> 
> 

Brian
