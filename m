From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Tue, 13 Nov 2018 07:04:02 +0000
Subject: [PATCH RESEND v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
In-Reply-To: <fa66839a-6831-47d0-99f9-eef4f50ef8e3@kontron.de>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1540284888-32307-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <fa66839a-6831-47d0-99f9-eef4f50ef8e3@kontron.de>
Message-ID: <VI1PR04MB572694FCA68EC75B3BB79EE299C20@VI1PR04MB5726.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frieder,

Thanks for review.

> -----Original Message-----
> From: Schrempf Frieder [mailto:frieder.schrempf at kontron.De]
> Sent: Wednesday, November 7, 2018 9:52 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd at lists.infradead.org; boris.brezillon at bootlin.com; marek.vasut at gmail.com;
> broonie at kernel.org; linux-spi at vger.kernel.org; devicetree at vger.kernel.org
> Cc: robh at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org; linux-
> arm-kernel at lists.infradead.org; computersforpeace at gmail.com;
> frieder.schrempf at exceet.de; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH RESEND v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI
> controller
> 
> Hi Yogesh,
> 
> I didn't have time to look at all of the code, but nevertheless here are some
> comments.
> 
> On 23.10.18 10:56, Yogesh Narayan Gaur wrote:
> > - Add driver for NXP FlexSPI host controller
> >
> > (0) What is the FlexSPI controller?
> >   FlexSPI is a flexsible SPI host controller which supports two SPI
> >   channels and up to 4 external devices. Each channel supports
> >   Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional
> >   data lines) i.e. FlexSPI acts as an interface to external devices,
> >   maximum 4, each with up to 8 bidirectional data lines.
> >
> >   It uses new SPI memory interface of the SPI framework to issue
> >   flash memory operations to up to four connected flash
> >   devices (2 buses with 2 CS each).
> >
> > (1) Tested this driver with the mtd_debug and JFFS2 filesystem utility
> >   on NXP LX2160ARDB and LX2160AQDS targets.
> >   LX2160ARDB is having two NOR slave device connected on single bus A
> >   i.e. A0 and A1 (CS0 and CS1).
> >   LX2160AQDS is having two NOR slave device connected on separate buses
> >   one flash on A0 and second on B1 i.e. (CS0 and CS3).
> >   Verified this driver on following SPI NOR flashes:
> >      Micron, mt35xu512ab, [Read - 1 bit mode]
> >      Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> >
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> > Changes for v4:
> > - Incorporate Boris review comments
> >    * Use readl_poll_timeout() instead of busy looping.
> >    * Re-define register masking as per comment.
> >    * Drop fspi_devtype enum.
> > Changes for v3:
> > - Added endianness flag in platform specific structure instead of DTS.
> > - Modified nxp_fspi_read_ahb(), removed remapping code.
> > - Added Boris and Frieder as Author and provided reference of
> > spi-fsl-qspi.c Changes for v2:
> > - Incorporated Boris review comments.
> > - Remove dependency of driver over connected flash device size.
> > - Modified the logic to select requested CS.
> > - Remove SPI-Octal Macros.
> >
> >   drivers/spi/Kconfig        |   10 +
> >   drivers/spi/Makefile       |    1 +
> >   drivers/spi/spi-nxp-fspi.c | 1158
> ++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 1169 insertions(+)
> >   create mode 100644 drivers/spi/spi-nxp-fspi.c
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index
> > ad5d68e..68da874 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -251,6 +251,16 @@ config SPI_FSL_LPSPI
> >   	help
> >   	  This enables Freescale i.MX LPSPI controllers in master mode.
> >
> > +config SPI_NXP_FLEXSPI
> > +	tristate "NXP Flex SPI controller"
> > +	depends on ARCH_LAYERSCAPE || HAS_IOMEM
> > +	help
> > +	  This enables support for the Flex SPI controller in master mode.
> > +	  Up to four slave devices can be connected on two buses with two
> > +	  chipselects each.
> > +	  This controller does not support generic SPI messages and only
> > +	  supports the high-level SPI memory interface.
> > +
> >   config SPI_GPIO
> >   	tristate "GPIO-based bitbanging SPI Master"
> >   	depends on GPIOLIB || COMPILE_TEST
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile index
> > cb1f437..52c9f18 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -59,6 +59,7 @@ obj-$(CONFIG_SPI_MPC52xx)		+= spi-
> mpc52xx.o
> >   obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
> >   obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
> >   obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
> > +obj-$(CONFIG_SPI_NXP_FLEXSPI)		+= spi-nxp-fspi.o
> >   obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
> >   spi-octeon-objs				:= spi-cavium.o spi-cavium-
> octeon.o
> >   obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
> > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > new file mode 100644 index 0000000..e5188b2
> > --- /dev/null
> > +++ b/drivers/spi/spi-nxp-fspi.c
> > @@ -0,0 +1,1158 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/*
> > + * NXP FlexSPI(FSPI) controller driver.
> > + *
> > + * Copyright 2018 NXP.
> > + *
> > + * FlexSPI is a flexsible SPI host controller which supports two SPI
> > + * channels and up to 4 external devices. Each channel supports
> > + * Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional
> > + * data lines).
> > + *
> > + * FlexSPI controller is driven by the LUT(Look-up Table) registers
> > + * LUT registers are a look-up-table for sequences of instructions.
> > + * A valid sequence consists of four LUT registers.
> > + * Maximum 32 LUT sequences can be programmed simultaneously.
> > + *
> > + * LUTs are being created at run-time based on the commands passed
> > + * from the spi-mem framework, thus using single LUT index.
> > + *
> > + * Software triggered Flash read/write access by IP Bus.
> > + *
> > + * Memory mapped read access by AHB Bus.
> > + *
> > + * Based on SPI MEM interface and spi-fsl-qspi.c driver.
> > + *
> > + * Author:
> > + *     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > + *     Boris Brezillion <boris.brezillon@bootlin.com>
> > + *     Frieder Schrempf <frieder.schrempf@exceet.de>
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_qos.h>
> > +#include <linux/sizes.h>
> > +#include <linux/iopoll.h>
> 
> If you would move this below io.h, then all the includes would stay in
> alphabetical order ;)
> 
Ok, would change for next version.

> > +
> > +#include <linux/spi/spi.h>
> > +#include <linux/spi/spi-mem.h>
> > +
> > +/*
> > + * The driver only uses one single LUT entry, that is updated on
> > + * each call of exec_op(). Index 0 is preset at boot with a basic
> > + * read operation, so let's use the last entry (31).
> > + */
> > +#define	SEQID_LUT			31
> > +
> > +/* Registers used by the driver */
> > +#define FSPI_MCR0			0x00
> > +#define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
> > +#define FSPI_MCR0_IP_TIMEOUT(x)		((x) << 16)
> > +#define FSPI_MCR0_LEARN_EN		BIT(15)
> > +#define FSPI_MCR0_SCRFRUN_EN		BIT(14)
> > +#define FSPI_MCR0_OCTCOMB_EN		BIT(13)
> > +#define FSPI_MCR0_DOZE_EN		BIT(12)
> > +#define FSPI_MCR0_HSEN			BIT(11)
> > +#define FSPI_MCR0_SERCLKDIV		BIT(8)
> > +#define FSPI_MCR0_ATDF_EN		BIT(7)
> > +#define FSPI_MCR0_ARDF_EN		BIT(6)
> > +#define FSPI_MCR0_RXCLKSRC(x)		((x) << 4)
> > +#define FSPI_MCR0_END_CFG(x)		((x) << 2)
> > +#define FSPI_MCR0_MDIS			BIT(1)
> > +#define FSPI_MCR0_SWRST			BIT(0)
> > +
> > +#define FSPI_MCR1			0x04
> > +#define FSPI_MCR1_SEQ_TIMEOUT(x)	((x) << 16)
> > +#define FSPI_MCR1_AHB_TIMEOUT(x)	(x)
> > +
> > +#define FSPI_MCR2			0x08
> > +#define FSPI_MCR2_IDLE_WAIT(x)		((x) << 24)
> > +#define FSPI_MCR2_SAMEDEVICEEN		BIT(15)
> > +#define FSPI_MCR2_CLRLRPHS		BIT(14)
> > +#define FSPI_MCR2_ABRDATSZ		BIT(8)
> > +#define FSPI_MCR2_ABRLEARN		BIT(7)
> > +#define FSPI_MCR2_ABR_READ		BIT(6)
> > +#define FSPI_MCR2_ABRWRITE		BIT(5)
> > +#define FSPI_MCR2_ABRDUMMY		BIT(4)
> > +#define FSPI_MCR2_ABR_MODE		BIT(3)
> > +#define FSPI_MCR2_ABRCADDR		BIT(2)
> > +#define FSPI_MCR2_ABRRADDR		BIT(1)
> > +#define FSPI_MCR2_ABR_CMD		BIT(0)
> > +
> > +#define FSPI_AHBCR			0x0c
> > +#define FSPI_AHBCR_RDADDROPT		BIT(6)
> > +#define FSPI_AHBCR_PREF_EN		BIT(5)
> > +#define FSPI_AHBCR_BUFF_EN		BIT(4)
> > +#define FSPI_AHBCR_CACH_EN		BIT(3)
> > +#define FSPI_AHBCR_CLRTXBUF		BIT(2)
> > +#define FSPI_AHBCR_CLRRXBUF		BIT(1)
> > +#define FSPI_AHBCR_PAR_EN		BIT(0)
> > +
> > +#define FSPI_INTEN			0x10
> > +#define FSPI_INTEN_SCLKSBWR		BIT(9)
> > +#define FSPI_INTEN_SCLKSBRD		BIT(8)
> > +#define FSPI_INTEN_DATALRNFL		BIT(7)
> > +#define FSPI_INTEN_IPTXWE		BIT(6)
> > +#define FSPI_INTEN_IPRXWA		BIT(5)
> > +#define FSPI_INTEN_AHBCMDERR		BIT(4)
> > +#define FSPI_INTEN_IPCMDERR		BIT(3)
> > +#define FSPI_INTEN_AHBCMDGE		BIT(2)
> > +#define FSPI_INTEN_IPCMDGE		BIT(1)
> > +#define FSPI_INTEN_IPCMDDONE		BIT(0)
> > +
> > +#define FSPI_INTR			0x14
> > +#define FSPI_INTR_SCLKSBWR		BIT(9)
> > +#define FSPI_INTR_SCLKSBRD		BIT(8)
> > +#define FSPI_INTR_DATALRNFL		BIT(7)
> > +#define FSPI_INTR_IPTXWE		BIT(6)
> > +#define FSPI_INTR_IPRXWA		BIT(5)
> > +#define FSPI_INTR_AHBCMDERR		BIT(4)
> > +#define FSPI_INTR_IPCMDERR		BIT(3)
> > +#define FSPI_INTR_AHBCMDGE		BIT(2)
> > +#define FSPI_INTR_IPCMDGE		BIT(1)
> > +#define FSPI_INTR_IPCMDDONE		BIT(0)
> > +
> > +#define FSPI_LUTKEY			0x18
> > +#define FSPI_LUTKEY_VALUE		0x5AF05AF0
> > +
> > +#define FSPI_LCKCR			0x1C
> > +
> > +#define FSPI_LCKER_LOCK			0x1
> > +#define FSPI_LCKER_UNLOCK		0x2
> > +
> > +#define FSPI_BUFXCR_INVALID_MSTRID	0xE
> > +#define FSPI_AHBRX_BUF0CR0		0x20
> > +#define FSPI_AHBRX_BUF1CR0		0x24
> > +#define FSPI_AHBRX_BUF2CR0		0x28
> > +#define FSPI_AHBRX_BUF3CR0		0x2C
> > +#define FSPI_AHBRX_BUF4CR0		0x30
> > +#define FSPI_AHBRX_BUF5CR0		0x34
> > +#define FSPI_AHBRX_BUF6CR0		0x38
> > +#define FSPI_AHBRX_BUF7CR0		0x3C
> > +#define FSPI_AHBRXBUF0CR7_PREF		BIT(31)
> > +
> > +#define FSPI_AHBRX_BUF0CR1		0x40
> > +#define FSPI_AHBRX_BUF1CR1		0x44
> > +#define FSPI_AHBRX_BUF2CR1		0x48
> > +#define FSPI_AHBRX_BUF3CR1		0x4C
> > +#define FSPI_AHBRX_BUF4CR1		0x50
> > +#define FSPI_AHBRX_BUF5CR1		0x54
> > +#define FSPI_AHBRX_BUF6CR1		0x58
> > +#define FSPI_AHBRX_BUF7CR1		0x5C
> > +
> > +#define FSPI_FLSHA1CR0			0x60
> > +#define FSPI_FLSHA2CR0			0x64
> > +#define FSPI_FLSHB1CR0			0x68
> > +#define FSPI_FLSHB2CR0			0x6C
> > +#define FSPI_FLSHXCR0_SZ_KB		10
> > +#define FSPI_FLSHXCR0_SZ(x)		((x) >> FSPI_FLSHXCR0_SZ_KB)
> > +
> > +#define FSPI_FLSHA1CR1			0x70
> > +#define FSPI_FLSHA2CR1			0x74
> > +#define FSPI_FLSHB1CR1			0x78
> > +#define FSPI_FLSHB2CR1			0x7C
> > +#define FSPI_FLSHXCR1_CSINTR(x)		((x) << 16)
> > +#define FSPI_FLSHXCR1_CAS(x)		((x) << 11)
> > +#define FSPI_FLSHXCR1_WA		BIT(10)
> > +#define FSPI_FLSHXCR1_TCSH(x)		((x) << 5)
> > +#define FSPI_FLSHXCR1_TCSS(x)		(x)
> > +
> > +#define FSPI_FLSHA1CR2			0x80
> > +#define FSPI_FLSHA2CR2			0x84
> > +#define FSPI_FLSHB1CR2			0x88
> > +#define FSPI_FLSHB2CR2			0x8C
> > +#define FSPI_FLSHXCR2_CLRINSP		BIT(24)
> > +#define FSPI_FLSHXCR2_AWRWAIT		BIT(16)
> > +#define FSPI_FLSHXCR2_AWRSEQN_SHIFT	13
> > +#define FSPI_FLSHXCR2_AWRSEQI_SHIFT	8
> > +#define FSPI_FLSHXCR2_ARDSEQN_SHIFT	5
> > +#define FSPI_FLSHXCR2_ARDSEQI_SHIFT	0
> > +
> > +#define FSPI_IPCR0			0xA0
> > +
> > +#define FSPI_IPCR1			0xA4
> > +#define FSPI_IPCR1_IPAREN		BIT(31)
> > +#define FSPI_IPCR1_SEQNUM_SHIFT		24
> > +#define FSPI_IPCR1_SEQID_SHIFT		16
> > +#define FSPI_IPCR1_IDATSZ(x)		(x)
> > +
> > +#define FSPI_IPCMD			0xB0
> > +#define FSPI_IPCMD_TRG			BIT(0)
> > +
> > +#define FSPI_DLPR			0xB4
> > +
> > +#define FSPI_IPRXFCR			0xB8
> > +#define FSPI_IPRXFCR_CLR		BIT(0)
> > +#define FSPI_IPRXFCR_DMA_EN		BIT(1)
> > +#define FSPI_IPRXFCR_WMRK(x)		((x) << 2)
> > +
> > +#define FSPI_IPTXFCR			0xBC
> > +#define FSPI_IPTXFCR_CLR		BIT(0)
> > +#define FSPI_IPTXFCR_DMA_EN		BIT(1)
> > +#define FSPI_IPTXFCR_WMRK(x)		((x) << 2)
> > +
> > +#define FSPI_DLLACR			0xC0
> > +#define FSPI_DLLACR_OVRDEN		BIT(8)
> > +
> > +#define FSPI_DLLBCR			0xC4
> > +#define FSPI_DLLBCR_OVRDEN		BIT(8)
> > +
> > +#define FSPI_STS0			0xE0
> > +#define FSPI_STS0_DLPHB(x)		((x) << 8)
> > +#define FSPI_STS0_DLPHA(x)		((x) << 4)
> > +#define FSPI_STS0_CMD_SRC(x)		((x) << 2)
> > +#define FSPI_STS0_ARB_IDLE		BIT(1)
> > +#define FSPI_STS0_SEQ_IDLE		BIT(0)
> > +
> > +#define FSPI_STS1			0xE4
> > +#define FSPI_STS1_IP_ERRCD(x)		((x) << 24)
> > +#define FSPI_STS1_IP_ERRID(x)		((x) << 16)
> > +#define FSPI_STS1_AHB_ERRCD(x)		((x) << 8)
> > +#define FSPI_STS1_AHB_ERRID(x)		(x)
> > +
> > +#define FSPI_AHBSPNST			0xEC
> > +#define FSPI_AHBSPNST_DATLFT(x)		((x) << 16)
> > +#define FSPI_AHBSPNST_BUFID(x)		((x) << 1)
> > +#define FSPI_AHBSPNST_ACTIVE		BIT(0)
> > +
> > +#define FSPI_IPRXFSTS			0xF0
> > +#define FSPI_IPRXFSTS_RDCNTR(x)		((x) << 16)
> > +#define FSPI_IPRXFSTS_FILL(x)		(x)
> > +
> > +#define FSPI_IPTXFSTS			0xF4
> > +#define FSPI_IPTXFSTS_WRCNTR(x)		((x) << 16)
> > +#define FSPI_IPTXFSTS_FILL(x)		(x)
> > +
> > +#define FSPI_RFDR			0x100
> > +#define FSPI_TFDR			0x180
> > +
> > +#define FSPI_LUT_BASE			0x200
> > +#define FSPI_LUT_OFFSET			(SEQID_LUT * 4 * 4)
> > +#define FSPI_LUT_REG(idx) \
> > +	(FSPI_LUT_BASE + FSPI_LUT_OFFSET + (idx) * 4)
> > +
> > +/* register map end */
> > +
> > +/* Instruction set for the LUT register. */
> > +#define LUT_STOP			0x00
> > +#define LUT_CMD				0x01
> > +#define LUT_ADDR			0x02
> > +#define LUT_CADDR_SDR			0x03
> > +#define LUT_MODE			0x04
> > +#define LUT_MODE2			0x05
> > +#define LUT_MODE4			0x06
> > +#define LUT_MODE8			0x07
> > +#define LUT_NXP_WRITE			0x08
> > +#define LUT_NXP_READ			0x09
> > +#define LUT_LEARN_SDR			0x0A
> > +#define LUT_DATSZ_SDR			0x0B
> > +#define LUT_DUMMY			0x0C
> > +#define LUT_DUMMY_RWDS_SDR		0x0D
> > +#define LUT_JMP_ON_CS			0x1F
> > +#define LUT_CMD_DDR			0x21
> > +#define LUT_ADDR_DDR			0x22
> > +#define LUT_CADDR_DDR			0x23
> > +#define LUT_MODE_DDR			0x24
> > +#define LUT_MODE2_DDR			0x25
> > +#define LUT_MODE4_DDR			0x26
> > +#define LUT_MODE8_DDR			0x27
> > +#define LUT_WRITE_DDR			0x28
> > +#define LUT_READ_DDR			0x29
> > +#define LUT_LEARN_DDR			0x2A
> > +#define LUT_DATSZ_DDR			0x2B
> > +#define LUT_DUMMY_DDR			0x2C
> > +#define LUT_DUMMY_RWDS_DDR		0x2D
> > +
> > +/*
> > + * Calculate number of required PAD bits for LUT register.
> > + *
> > + * The pad stands for the number of IO lines [0:7].
> > + * For example, the octal read needs eight IO lines,
> > + * so you should use LUT_PAD(8). This macro
> > + * returns 3 i.e. use eight (2^3) IP lines for read.
> > + */
> > +#define LUT_PAD(x) (fls(x) - 1)
> > +
> > +/*
> > + * Macro for constructing the LUT entries with the following
> > + * register layout:
> > + *
> > + *  ---------------------------------------------------
> > + *  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
> > + *  ---------------------------------------------------
> > + */
> > +#define PAD_SHIFT		8
> > +#define INSTR_SHIFT		10
> > +#define OPRND_SHIFT		16
> > +
> > +/* Macros for constructing the LUT register. */
> > +#define LUT_DEF(idx, ins, pad, opr)			  \
> > +	((((ins) << INSTR_SHIFT) | ((pad) << PAD_SHIFT) | \
> > +	(opr)) << (((idx) % 2) * OPRND_SHIFT))
> > +
> > +/* Oprands for the LUT register. */
> 
> s/Oprands/Operands
Ok

> 
> > +#define ADDR8BIT		0x08
> > +#define ADDR16BIT		0x10
> > +#define ADDR24BIT		0x18
> > +#define ADDR32BIT		0x20
> > +
> > +#define POLL_TOUT_US		5000
> > +
> > +struct nxp_fspi_devtype_data {
> > +	unsigned int rxfifo;
> > +	unsigned int txfifo;
> > +	unsigned int ahb_buf_size;
> > +	unsigned int quirks;
> > +	bool little_endian;
> > +};
> > +
> > +static const struct nxp_fspi_devtype_data lx2160a_data = {
> > +	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
> > +	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
> > +	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
> > +	.quirks = 0,
> > +	.little_endian = 1,     /* little-endian    */
> 
> I'm not sure if this is really necessary, but for a boolean probably 'true' would be
> better than '1'.
Ok

> 
> > +};
> > +
> > +#define NXP_FSPI_MAX_CHIPSELECT		4
> > +
> > +struct nxp_fspi {
> > +	void __iomem *iobase;
> > +	void __iomem *ahb_addr;
> > +	u32 memmap_phy;
> > +	u32 memmap_phy_size;
> > +	struct clk *clk, *clk_en;
> > +	struct device *dev;
> > +	struct completion c;
> > +	const struct nxp_fspi_devtype_data *devtype_data;
> > +	struct mutex lock;
> > +	struct pm_qos_request pm_qos_req;
> > +	int selected;
> > +	void (*write)(u32 val, void __iomem *addr);
> > +	u32 (*read)(void __iomem *addr);
> > +};
> > +
> > +static void fspi_writel_be(u32 val, void __iomem *addr) {
> > +	iowrite32be(val, addr);
> > +}
> > +
> > +static void fspi_writel(u32 val, void __iomem *addr) {
> > +	iowrite32(val, addr);
> > +}
> > +
> > +static u32 fspi_readl_be(void __iomem *addr) {
> > +	return ioread32be(addr);
> > +}
> > +
> > +static u32 fspi_readl(void __iomem *addr) {
> > +	return ioread32(addr);
> > +}
> > +
> > +static irqreturn_t nxp_fspi_irq_handler(int irq, void *dev_id) {
> > +	struct nxp_fspi *f = dev_id;
> > +	u32 reg;
> > +
> > +	/* clear interrupt */
> > +	reg = f->read(f->iobase + FSPI_INTR);
> > +	f->write(FSPI_INTR_IPCMDDONE, f->iobase + FSPI_INTR);
> > +
> > +	if (reg & FSPI_INTR_IPCMDDONE)
> > +		complete(&f->c);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int nxp_fspi_check_buswidth(struct nxp_fspi *f, u8 width) {
> > +	switch (width) {
> > +	case 1:
> > +	case 2:
> > +	case 4:
> > +	case 8:
> > +		return 0;
> > +	}
> > +
> > +	return -ENOTSUPP;
> > +}
> > +
> > +static bool nxp_fspi_supports_op(struct spi_mem *mem,
> > +				 const struct spi_mem_op *op)
> > +{
> > +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> > +	int ret;
> > +
> > +	ret = nxp_fspi_check_buswidth(f, op->cmd.buswidth);
> > +
> > +	if (op->addr.nbytes)
> > +		ret |= nxp_fspi_check_buswidth(f, op->addr.buswidth);
> > +
> > +	if (op->dummy.nbytes)
> > +		ret |= nxp_fspi_check_buswidth(f, op->dummy.buswidth);
> > +
> > +	if (op->data.nbytes)
> > +		ret |= nxp_fspi_check_buswidth(f, op->data.buswidth);
> > +
> > +	if (ret)
> > +		return false;
> > +
> > +	/*
> > +	 * The number of instructions needed for the op, needs
> > +	 * to fit into a single LUT entry.
> > +	 */
> > +	if (op->addr.nbytes +
> > +	   (op->dummy.nbytes ? 1:0) +
> > +	   (op->data.nbytes ? 1:0) > 6)
> > +		return false;
> > +
> > +	/* Max 64 dummy clock cycles supported */
> > +	if (op->dummy.buswidth &&
> > +	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
> > +		return false;
> > +
> > +	/* Max data length, check controller limits and alignment */
> > +	if (op->data.dir == SPI_MEM_DATA_IN &&
> > +	    (op->data.nbytes > f->devtype_data->ahb_buf_size ||
> > +	     (op->data.nbytes > f->devtype_data->rxfifo - 4 &&
> > +	      !IS_ALIGNED(op->data.nbytes, 8))))
> > +		return false;
> > +
> > +	if (op->data.dir == SPI_MEM_DATA_OUT &&
> > +	    op->data.nbytes > f->devtype_data->txfifo)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +/* Instead of busy looping invoke readl_poll_timeout functionality.
> > +*/ static int fspi_readl_poll_tout(struct nxp_fspi *f, void __iomem *base, u32
> reg,
> > +				u32 mask, u32 delay_us, u32 timeout_us)
> 
> You do not need to pass 'reg' here, you can just use a local variable.
> 
Ok, let me verify by using local variable instead of passing status in reg variable.

> > +{
> > +	u32 l_mask;
> > +
> > +	if (f->devtype_data->little_endian)
> > +		l_mask = mask;
> > +	else
> > +		l_mask = (u32)cpu_to_be32(mask);
> 
> You could shorten this a bit by just reusing 'mask' and drop 'l_mask'.
> See my version of this function in v4 of the FSL QSPI driver.
Ok, would check your implementation.

> 
> > +
> > +	return readl_poll_timeout(base, reg, (reg & l_mask),
> > +				  delay_us, timeout_us);
> > +}
> > +
> > +/*
> > + * If the slave device content being changed by Write/Erase, need to
> > + * invalidate the AHB buffer. This can be achieved by doing the reset
> > + * of controller after setting MCR0[SWRESET] bit.
> > + */
> > +static inline void nxp_fspi_invalid(struct nxp_fspi *f) {
> > +	u32 reg;
> > +	int ret;
> > +	u32 l_mask;
> > +
> > +	reg = f->read(f->iobase + FSPI_MCR0);
> > +	f->write(reg | FSPI_MCR0_SWRST, f->iobase + FSPI_MCR0);
> > +
> > +	if (f->devtype_data->little_endian)
> > +		l_mask = FSPI_MCR0_SWRST;
> > +	else
> > +		l_mask = (u32)cpu_to_be32(FSPI_MCR0_SWRST);
> > +
> > +	/* w1c register, wait unit clear */
> > +	ret = readl_poll_timeout(f->iobase + FSPI_MCR0, reg,
> > +				 !(reg & l_mask), 0, POLL_TOUT_US);
> 
> It would be better to add a parameter to fspi_readl_poll_tout() for inverting the
> break condition and then reuse this function here.
> 
Ok

> > +	WARN_ON(ret);
> > +}
> > +
> > +static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
> > +				 const struct spi_mem_op *op)
> > +{
> > +	void __iomem *base = f->iobase;
> > +	u32 lutval[4] = {};
> > +	int lutidx = 1, i;
> > +
> > +	/* cmd */
> > +	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
> > +			     op->cmd.opcode);
> > +
> > +	/* addr bus width */
> > +	if (op->addr.nbytes) {
> > +		u32 addrlen = 0;
> > +
> > +		if (op->addr.nbytes == 3)
> > +			addrlen = ADDR24BIT;
> > +		else if (op->addr.nbytes == 4)
> > +			addrlen = ADDR32BIT;
> 
> I know we already had this  discussion with Boris on v2, but if you keep only
> supporting 3 and 4 byte adresses, then it should be documented somewhere to
> let people know that this driver can't be used to interface SPI NAND and other
> flash chips that use deviant address widths.
> 
> An even better solution would be to make this work somehow. I can't see why
> the approach from the QSPI driver using LUT_MODE shouldn't work, but who
> knows...
Working of LUT_MODE in place of LUT_ADDR in QSPI when passing information of address might be an QuadSPI controller issue.
I have tried using LUT_MODE for this controller and it didn't work.
Discussed with HW IP owner of FlexSPI controller and they said we need to pass LUT_ADDR when programming for address length.

> 
> It's a pity, that the designers of the new IP still did not really take SPI NAND into
> account.
> 
This controller works for the NAND flash as well. In SW, for now my driver has been validated only for the NOR flash devices and thus I have added support for 3 and 4 bytes in code.
Idea, was to modify the driver code when NAND device being verified using this driver.
Meanwhile, I can add switch case for address bytes of length 1, 2, 3 and 4 instead of just 3 and 4.

> > +
> > +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
> > +					      LUT_PAD(op->addr.buswidth),
> > +					      addrlen);
> > +		lutidx++;
> > +	}
> > +
> > +	/* dummy bytes, if needed */
> > +	if (op->dummy.nbytes) {
> > +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
> > +		/*
> > +		 * Due to FlexSPI controller limitation number of PAD for
> dummy
> > +		 * buswidth needs to be programmed as equal to data buswidth.
> > +		 */
> > +					      LUT_PAD(op->data.buswidth),
> 
> This seems like a hack for something that should be better handled by the spi
> mem layer. I think you should have a check for data.buswidth ==
> dummy.buswidth in nxp_fspi_supports_op() and if that fails the spi mem layer
> must find a working fallback. But I'm not sure, so we probably need to ask Boris.
> 
This is an issue with the controller and would be published in the documentation in upcoming revision.
In any of the 1-1-x mode, needs to be pass dummy information on single PAD but due to clock control issue, both controller and flash device start taking control of the data line and hence data gets corrupted.
This has been identified and been suggested to use PAD information for dummy same as Data PAD for case of 1-1-x protocols.
This would going to be updated in the next release document of the controller.

> > +					      op->dummy.nbytes * 8 /
> > +					      op->dummy.buswidth);
> > +		lutidx++;
> > +	}
> > +
> > +	/* read/write data bytes */
> > +	if (op->data.nbytes) {
> > +		lutval[lutidx / 2] |= LUT_DEF(lutidx,
> > +					      op->data.dir ==
> SPI_MEM_DATA_IN ?
Yes, data is coming from SPI memory i.e. read operation
@SPI_MEM_DATA_IN: data coming from the SPI memory

> > +					      LUT_NXP_READ : LUT_NXP_WRITE,
> > +					      LUT_PAD(op->data.buswidth),
> > +					      0);
> > +		lutidx++;
> > +	}
> > +
> > +	/* stop condition. */
> > +	lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_STOP, 0, 0);
> > +
> > +	/* unlock LUT */
> > +	f->write(FSPI_LUTKEY_VALUE, f->iobase + FSPI_LUTKEY);
> > +	f->write(FSPI_LCKER_UNLOCK, f->iobase + FSPI_LCKCR);
> > +
> > +	/* fill LUT */
> > +	for (i = 0; i < ARRAY_SIZE(lutval); i++)
> > +		f->write(lutval[i], base + FSPI_LUT_REG(i));
> > +
> > +	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x]\n",
> > +		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3]);
> > +
> > +	/* lock LUT */
> > +	f->write(FSPI_LUTKEY_VALUE, f->iobase + FSPI_LUTKEY);
> > +	f->write(FSPI_LCKER_LOCK, f->iobase + FSPI_LCKCR); }
> > +
> > +static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f) {
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(f->clk_en);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = clk_prepare_enable(f->clk);
> > +	if (ret) {
> > +		clk_disable_unprepare(f->clk_en);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f) {
> > +	clk_disable_unprepare(f->clk);
> > +	clk_disable_unprepare(f->clk_en);
> > +}
> > +
> > +/*
> > + * In FlexSPI controller, flash access is based on value of
> > +FSPI_FLSHXXCR0
> > + * register and start base address of the slave device.
> > + *
> > + *							    (Higher address)
> > + *				--------    <-- FLSHB2CR0
> > + *				|  B2  |
> > + *				|      |
> > + *	B2 start address -->	--------    <-- FLSHB1CR0
> > + *				|  B1  |
> > + *				|      |
> > + *	B1 start address -->	--------    <-- FLSHA2CR0
> > + *				|  A2  |
> > + *				|      |
> > + *	A2 start address -->	--------    <-- FLSHA1CR0
> > + *				|  A1  |
> > + *				|      |
> > + *	A1 start address -->	--------		    (Lower address)
> > + *
> > + *
> > + * Start base address defines the starting address range for given CS
> > +and
> > + * FSPI_FLSHXXCR0 defines the size of the slave device connected at given CS.
> > + *
> > + * But, different targets are having different combinations of number
> > +of CS,
> > + * some targets only have single CS or two CS covering controller's
> > +full
> > + * memory mapped space area.
> > + * Thus, implementation is being done as independent of the size and
> > +number
> > + * of the connected slave device.
> > + * Assign controller memory mapped space size as the size to the
> > +connected
> > + * slave device.
> > + * Mark FLSHxxCR0 as zero initially and then assign value only to the
> > +selected
> > + * chip-select Flash configuration register.
> > + *
> > + * For e.g. to access CS2 (B1), FLSHB1CR0 register would be equal to
> > +the
> > + * memory mapped size of the controller.
> > + * Value for rest of the CS FLSHxxCR0 register would be zero.
> > + *
> > + */
> > +static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device
> > +*spi) {
> > +	unsigned long rate = spi->max_speed_hz;
> > +	int ret;
> > +	uint64_t size_kb;
> > +
> > +	/*
> > +	 * Return, if previously selected slave device is same as current
> > +	 * requested slave device.
> > +	 */
> > +	if (f->selected == spi->chip_select)
> > +		return;
> > +
> > +	/* Reset FLSHxxCR0 registers */
> > +	f->write(0, f->iobase + FSPI_FLSHA1CR0);
> > +	f->write(0, f->iobase + FSPI_FLSHA2CR0);
> > +	f->write(0, f->iobase + FSPI_FLSHB1CR0);
> > +	f->write(0, f->iobase + FSPI_FLSHB2CR0);
> > +
> > +	/* Assign controller memory mapped space as size, KBytes, of flash. */
> > +	size_kb = FSPI_FLSHXCR0_SZ(f->memmap_phy_size);
> > +
> > +	switch (spi->chip_select) {
> > +	case 0:
> > +		f->write(size_kb, f->iobase + FSPI_FLSHA1CR0);
> > +		break;
> > +	case 1:
> > +		f->write(size_kb, f->iobase + FSPI_FLSHA2CR0);
> > +		break;
> > +	case 2:
> > +		f->write(size_kb, f->iobase + FSPI_FLSHB1CR0);
> > +		break;
> > +	case 3:
> > +		f->write(size_kb, f->iobase + FSPI_FLSHB2CR0);
> > +		break;
> > +	default:
> > +		dev_err(f->dev, "In-correct CS provided\n");
> > +		return;
> > +	}
> > +
> > +	dev_dbg(f->dev, "Slave device [CS:%x] selected\n",
> > +spi->chip_select);
> > +
> > +	nxp_fspi_clk_disable_unprep(f);
> > +
> > +	ret = clk_set_rate(f->clk, rate);
> > +	if (ret)
> > +		return;
> > +
> > +	ret = nxp_fspi_clk_prep_enable(f);
> > +	if (ret)
> > +		return;
> > +	f->selected = spi->chip_select;
> > +}
> > +
> > +static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct
> > +spi_mem_op *op) {
> > +	u32 len = op->data.nbytes;
> > +
> > +	/* Read out the data directly from the AHB buffer. */
> > +	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len); }
> > +
> > +static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
> > +				 const struct spi_mem_op *op)
> > +{
> > +	void __iomem *base = f->iobase;
> > +	int i, j, ret;
> > +	int size, tmp_size, wm_size;
> > +	u32 data = 0, reg;
> > +	u32 *txbuf = (u32 *) op->data.buf.out;
> > +
> > +	/* clear the TX FIFO. */
> > +	f->write(FSPI_IPTXFCR_CLR, base + FSPI_IPTXFCR);
> > +
> > +	/* Default value of water mark level is 8 bytes. */
> > +	wm_size = 8;
> > +	size = op->data.nbytes / wm_size;
> > +	for (i = 0; i < size; i++) {
> > +		/* Wait for TXFIFO empty */
> > +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR, reg,
> > +					   FSPI_INTR_IPTXWE, 0,
> POLL_TOUT_US);
> > +		WARN_ON(ret);
> > +
> > +		j = 0;
> > +		tmp_size = wm_size;
> > +		while (tmp_size > 0) {
> > +			data = 0;
> > +			memcpy(&data, txbuf, 4);
> > +			f->write(data, base + FSPI_TFDR + j * 4);
> > +			tmp_size -= 4;
> > +			j++;
> > +			txbuf += 1;
> > +		}
> > +		f->write(FSPI_INTR_IPTXWE, base + FSPI_INTR);
> > +	}
> > +
> > +	size = op->data.nbytes % wm_size;
> > +	if (size) {
> > +		/* Wait for TXFIFO empty */
> > +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR, reg,
> > +					   FSPI_INTR_IPTXWE, 0,
> POLL_TOUT_US);
> > +		WARN_ON(ret);
> > +
> > +		j = 0;
> > +		tmp_size = 0;
> > +		while (size > 0) {
> > +			data = 0;
> > +			tmp_size = (size < 4) ? size : 4;
> > +			memcpy(&data, txbuf, tmp_size);
> > +			f->write(data, base + FSPI_TFDR + j * 4);
> > +			size -= tmp_size;
> > +			j++;
> > +			txbuf += 1;
> > +		}
> > +		f->write(FSPI_INTR_IPTXWE, base + FSPI_INTR);
> > +	}
> > +}
> > +
> > +static void nxp_fspi_read_rxfifo(struct nxp_fspi *f,
> > +			  const struct spi_mem_op *op)
> > +{
> > +	void __iomem *base = f->iobase;
> > +	int i, j;
> > +	int size, tmp_size, wm_size, ret;
> > +	u32 tmp = 0, reg;
> > +	u8 *buf = op->data.buf.in;
> > +	u32 len = op->data.nbytes;
> > +
> > +	/* Default value of water mark level is 8 bytes. */
> > +	wm_size = 8;
> > +
> > +	while (len > 0) {
> > +		size = len / wm_size;
> > +
> > +		for (i = 0; i < size; i++) {
> > +			/* Wait for RXFIFO available */
> > +			ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> > +						   reg, FSPI_INTR_IPRXWA,
> > +						   0, POLL_TOUT_US);
> > +			WARN_ON(ret);
> > +
> > +			j = 0;
> > +			tmp_size = wm_size;
> > +			while (tmp_size > 0) {
> > +				tmp = 0;
> > +				tmp = f->read(base + FSPI_RFDR + j * 4);
> > +				memcpy(buf, &tmp, 4);
> > +				tmp_size -= 4;
> > +				j++;
> > +				buf += 4;
> > +			}
> > +			/* move the FIFO pointer */
> > +			f->write(FSPI_INTR_IPRXWA, base + FSPI_INTR);
> > +			len -= wm_size;
> > +		}
> > +
> > +		size = len % wm_size;
> > +
> > +		j = 0;
> > +		if (size) {
> > +			/* Wait for RXFIFO available */
> > +			ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> > +						   reg, FSPI_INTR_IPRXWA,
> > +						   0, POLL_TOUT_US);
> > +			WARN_ON(ret);
> > +
> > +			while (len > 0) {
> > +				tmp = 0;
> > +				size = (len < 4) ? len : 4;
> > +				tmp = f->read(base + FSPI_RFDR + j * 4);
> > +				memcpy(buf, &tmp, size);
> > +				len -= size;
> > +				j++;
> > +				buf += size;
> > +			}
> > +		}
> > +
> > +		/* invalid the RXFIFO */
> > +		f->write(FSPI_IPRXFCR_CLR, base + FSPI_IPRXFCR);
> > +		/* move the FIFO pointer */
> > +		f->write(FSPI_INTR_IPRXWA, base + FSPI_INTR);
> > +	}
> > +}
> > +
> > +static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op
> > +*op) {
> > +	void __iomem *base = f->iobase;
> > +	int seqnum = 0;
> > +	int err = 0;
> > +	u32 reg;
> > +
> > +	reg = f->read(base + FSPI_IPRXFCR);
> > +	/* invalid RXFIFO first */
> > +	reg &= ~FSPI_IPRXFCR_DMA_EN;
> > +	reg = reg | FSPI_IPRXFCR_CLR;
> > +	f->write(reg, base + FSPI_IPRXFCR);
> > +
> > +	init_completion(&f->c);
> > +
> > +	f->write(op->addr.val, base + FSPI_IPCR0);
> > +	/*
> > +	 * Always start the sequence at the same index since we update
> > +	 * the LUT at each exec_op() call. And also specify the DATA
> > +	 * length, since it's has not been specified in the LUT.
> > +	 */
> > +	f->write(op->data.nbytes |
> > +		 (SEQID_LUT << FSPI_IPCR1_SEQID_SHIFT) |
> > +		 (seqnum << FSPI_IPCR1_SEQNUM_SHIFT),
> > +		 base + FSPI_IPCR1);
> > +
> > +	/* Trigger the LUT now. */
> > +	f->write(FSPI_IPCMD_TRG, base + FSPI_IPCMD);
> > +
> > +	/* Wait for the interrupt. */
> > +	if (!wait_for_completion_timeout(&f->c, msecs_to_jiffies(1000)))
> > +		err = -ETIMEDOUT;
> > +
> > +	/* Invoke IP data read, if request is of data read. */
> > +	if (!err && op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
> > +		nxp_fspi_read_rxfifo(f, op);
> > +
> > +	return err;
> > +}
> > +
> > +static int nxp_fspi_exec_op(struct spi_mem *mem, const struct
> > +spi_mem_op *op) {
> > +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> > +	void __iomem *base = f->iobase;
> > +	int err = 0;
> > +	u32 status;
> > +
> > +	mutex_lock(&f->lock);
> > +
> > +	/* Wait for controller being ready. */
> > +	status = f->read(base + FSPI_STS0);
> > +	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0, status,
> > +				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT_US);
> > +	WARN_ON(err);
> > +
> > +	nxp_fspi_select_mem(f, mem->spi);
> > +
> > +	nxp_fspi_prepare_lut(f, op);
> > +	/*
> > +	 * If we have large chunks of data, we read them through the AHB bus
> > +	 * by accessing the mapped memory. In all other cases we use
> > +	 * IP commands to access the flash.
> > +	 */
> > +	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
> > +	    op->data.dir == SPI_MEM_DATA_IN) {
> > +		nxp_fspi_read_ahb(f, op);
> > +	} else {
> > +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> > +			nxp_fspi_fill_txfifo(f, op);
> > +
> > +		err = nxp_fspi_do_op(f, op);
> > +
> > +		/* Invalidate the data in the AHB buffer. */
> > +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> > +			nxp_fspi_invalid(f);
> > +	}
> > +
> > +	mutex_unlock(&f->lock);
> > +
> > +	return err;
> > +}
> > +
> > +static int nxp_fspi_adjust_op_size(struct spi_mem *mem, struct
> > +spi_mem_op *op) {
> > +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> > +
> > +	if (op->data.dir == SPI_MEM_DATA_OUT) {
> > +		if (op->data.nbytes > f->devtype_data->txfifo)
> > +			op->data.nbytes = f->devtype_data->txfifo;
> > +	} else {
> > +		if (op->data.nbytes > f->devtype_data->ahb_buf_size)
> > +			op->data.nbytes = f->devtype_data->ahb_buf_size;
> > +		else if (op->data.nbytes > (f->devtype_data->rxfifo - 4))
> > +			op->data.nbytes = ALIGN_DOWN(op->data.nbytes, 8);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int nxp_fspi_default_setup(struct nxp_fspi *f) {
> > +	void __iomem *base = f->iobase;
> > +	int ret, i;
> > +	u32 reg, l_mask;
> > +
> > +	/* disable and unprepare clock to avoid glitch pass to controller */
> > +	nxp_fspi_clk_disable_unprep(f);
> > +
> > +	/* the default frequency, we will change it later if necessary. */
> > +	ret = clk_set_rate(f->clk, 20000000);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nxp_fspi_clk_prep_enable(f);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Reset the module */
> > +	f->write(FSPI_MCR0_SWRST, base + FSPI_MCR0);
> > +
> > +	if (f->devtype_data->little_endian)
> > +		l_mask = FSPI_MCR0_SWRST;
> > +	else
> > +		l_mask = (u32)cpu_to_be32(FSPI_MCR0_SWRST);
> > +
> > +	/* w1c register, wait unit clear */
> > +	ret = readl_poll_timeout(f->iobase + FSPI_MCR0, reg,
> > +				 !(reg & l_mask), 0, POLL_TOUT_US);
> 
> See above. Reuse fspi_readl_poll_tout() here.
> 
Ok

> Regards,
> Frieder
> 
> > +	WARN_ON(ret);
> > +
> > +	/* Disable the module */
> > +	f->write(FSPI_MCR0_MDIS, base + FSPI_MCR0);
> > +
> > +	/* Reset the DLL register to default value */
> > +	f->write(FSPI_DLLACR_OVRDEN, base + FSPI_DLLACR);
> > +	f->write(FSPI_DLLBCR_OVRDEN, base + FSPI_DLLBCR);
> > +
> > +	/* enable module */
> > +	f->write(FSPI_MCR0_AHB_TIMEOUT(0xFF) |
> FSPI_MCR0_IP_TIMEOUT(0xFF),
> > +		 base + FSPI_MCR0);
> > +
> > +	/*
> > +	 * Disable same device enable bit and configure all slave devices
> > +	 * independently.
> > +	 */
> > +	reg = f->read(f->iobase + FSPI_MCR2);
> > +	reg = reg & ~(FSPI_MCR2_SAMEDEVICEEN);
> > +	f->write(reg, base + FSPI_MCR2);
> > +
> > +	/* AHB configuration for access buffer 0~7. */
> > +	for (i = 0; i < 7; i++)
> > +		f->write(0, base + FSPI_AHBRX_BUF0CR0 + 4 * i);
> > +
> > +	/*
> > +	 * Set ADATSZ with the maximum AHB buffer size to improve the read
> > +	 * performance.
> > +	 */
> > +	f->write((f->devtype_data->ahb_buf_size / 8 |
> > +		  FSPI_AHBRXBUF0CR7_PREF), base + FSPI_AHBRX_BUF7CR0);
> > +
> > +	/* prefetch and no start address alignment limitation */
> > +	f->write(FSPI_AHBCR_PREF_EN | FSPI_AHBCR_RDADDROPT,
> > +		 base + FSPI_AHBCR);
> > +
> > +	/* AHB Read - Set lut sequence ID for all CS. */
> > +	f->write(SEQID_LUT, base + FSPI_FLSHA1CR2);
> > +	f->write(SEQID_LUT, base + FSPI_FLSHA2CR2);
> > +	f->write(SEQID_LUT, base + FSPI_FLSHB1CR2);
> > +	f->write(SEQID_LUT, base + FSPI_FLSHB2CR2);
> > +
> > +	f->selected = -1;
> > +
> > +	/* enable the interrupt */
> > +	f->write(FSPI_INTEN_IPCMDDONE, base + FSPI_INTEN);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
> > +	.adjust_op_size = nxp_fspi_adjust_op_size,
> > +	.supports_op = nxp_fspi_supports_op,
> > +	.exec_op = nxp_fspi_exec_op,
> > +};
> > +
> > +static int nxp_fspi_probe(struct platform_device *pdev) {
> > +	struct spi_controller *ctlr;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *np = dev->of_node;
> > +	struct resource *res;
> > +	struct nxp_fspi *f;
> > +	int ret;
> > +
> > +	ctlr = spi_alloc_master(&pdev->dev, sizeof(*f));
> > +	if (!ctlr)
> > +		return -ENOMEM;
> > +
> > +	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
> > +			  SPI_TX_DUAL | SPI_TX_QUAD;
> > +
> > +	f = spi_controller_get_devdata(ctlr);
> > +	f->dev = dev;
> > +	f->devtype_data = of_device_get_match_data(dev);
> > +	if (!f->devtype_data) {
> > +		ret = -ENODEV;
> > +		goto err_put_ctrl;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, f);
> > +
> > +	/* find the resources - configuration register address space */
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "fspi_base");
> > +	f->iobase = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(f->iobase)) {
> > +		ret = PTR_ERR(f->iobase);
> > +		goto err_put_ctrl;
> > +	}
> > +
> > +	/* find the resources - controller memory mapped space */
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "fspi_mmap");
> > +	f->ahb_addr = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(f->ahb_addr)) {
> > +		ret = PTR_ERR(f->ahb_addr);
> > +		goto err_put_ctrl;
> > +	}
> > +
> > +	/* assign memory mapped starting address and mapped size. */
> > +	f->memmap_phy = res->start;
> > +	f->memmap_phy_size = resource_size(res);
> > +
> > +	/* find the clocks */
> > +	f->clk_en = devm_clk_get(dev, "fspi_en");
> > +	if (IS_ERR(f->clk_en)) {
> > +		ret = PTR_ERR(f->clk_en);
> > +		goto err_put_ctrl;
> > +	}
> > +
> > +	f->clk = devm_clk_get(dev, "fspi");
> > +	if (IS_ERR(f->clk)) {
> > +		ret = PTR_ERR(f->clk);
> > +		goto err_put_ctrl;
> > +	}
> > +
> > +	/*
> > +	 * R/W functions for big- or little-endian registers:
> > +	 * The FSPI controller's endianness is independent of
> > +	 * the CPU core's endianness. So far, although the CPU
> > +	 * core is little-endian the FSPI controller can use
> > +	 * big-endian or little-endian.
> > +	 */
> > +	if (f->devtype_data->little_endian) {
> > +		f->write = fspi_writel;
> > +		f->read = fspi_readl;
> > +	} else {
> > +		f->write = fspi_writel_be;
> > +		f->read = fspi_readl_be;
> > +	}
> > +
> > +	ret = nxp_fspi_clk_prep_enable(f);
> > +	if (ret) {
> > +		dev_err(dev, "can not enable the clock\n");
> > +		goto err_put_ctrl;
> > +	}
> > +
> > +	/* find the irq */
> > +	ret = platform_get_irq(pdev, 0);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get the irq: %d\n", ret);
> > +		goto err_disable_clk;
> > +	}
> > +
> > +	ret = devm_request_irq(dev, ret,
> > +			nxp_fspi_irq_handler, 0, pdev->name, f);
> > +	if (ret) {
> > +		dev_err(dev, "failed to request irq: %d\n", ret);
> > +		goto err_disable_clk;
> > +	}
> > +
> > +	mutex_init(&f->lock);
> > +
> > +	ctlr->bus_num = -1;
> > +	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
> > +	ctlr->mem_ops = &nxp_fspi_mem_ops;
> > +
> > +	nxp_fspi_default_setup(f);
> > +
> > +	ctlr->dev.of_node = np;
> > +
> > +	ret = spi_register_controller(ctlr);
> > +	if (ret)
> > +		goto err_destroy_mutex;
> > +
> > +	return 0;
> > +
> > +err_destroy_mutex:
> > +	mutex_destroy(&f->lock);
> > +
> > +err_disable_clk:
> > +	nxp_fspi_clk_disable_unprep(f);
> > +
> > +err_put_ctrl:
> > +	spi_controller_put(ctlr);
> > +
> > +	dev_err(dev, "NXP FSPI probe failed\n");
> > +	return ret;
> > +}
> > +
> > +static int nxp_fspi_remove(struct platform_device *pdev) {
> > +	struct nxp_fspi *f = platform_get_drvdata(pdev);
> > +
> > +	/* disable the hardware */
> > +	f->write(FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
> > +
> > +	nxp_fspi_clk_disable_unprep(f);
> > +
> > +	mutex_destroy(&f->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int nxp_fspi_suspend(struct device *dev) {
> > +	return 0;
> > +}
> > +
> > +static int nxp_fspi_resume(struct device *dev) {
> > +	struct nxp_fspi *f = dev_get_drvdata(dev);
> > +
> > +	nxp_fspi_default_setup(f);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id nxp_fspi_dt_ids[] = {
> > +	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
> > +
> > +static const struct dev_pm_ops nxp_fspi_pm_ops = {
> > +	.suspend	= nxp_fspi_suspend,
> > +	.resume		= nxp_fspi_resume,
> > +};
> > +
> > +static struct platform_driver nxp_fspi_driver = {
> > +	.driver = {
> > +		.name	= "nxp-fspi",
> > +		.of_match_table = nxp_fspi_dt_ids,
> > +		.pm =   &nxp_fspi_pm_ops,
> > +	},
> > +	.probe          = nxp_fspi_probe,
> > +	.remove		= nxp_fspi_remove,
> > +};
> > +module_platform_driver(nxp_fspi_driver);
> > +
> > +MODULE_DESCRIPTION("NXP FSPI Controller Driver");
> MODULE_AUTHOR("NXP
> > +Semiconductor"); MODULE_LICENSE("GPL v2");
> >
