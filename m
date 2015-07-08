From: leilk.liu@mediatek.com (leilk liu)
Date: Wed, 8 Jul 2015 19:32:33 +0800
Subject: [PATCH v2 3/4] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <CAGS+omD3anZyJST90QVoJ5N-OPsdYYj3_Fq0rJSXADt84EL6yg@mail.gmail.com>
References: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
 <1435583070-9600-4-git-send-email-leilk.liu@mediatek.com>
 <CAGS+omD3anZyJST90QVoJ5N-OPsdYYj3_Fq0rJSXADt84EL6yg@mail.gmail.com>
Message-ID: <1436355153.30071.52.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

On Wed, 2015-07-01 at 12:06 +0800, Daniel Kurtz wrote:
> Hi Leilk,
> 
> Please see comments inline...
> 
> On Mon, Jun 29, 2015 at 9:04 PM, Leilk Liu <leilk.liu@mediatek.com> wrote:
> > This patch adds basic spi bus for MT8173.
> >
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  drivers/spi/Kconfig      |   9 +
> >  drivers/spi/Makefile     |   1 +
> >  drivers/spi/spi-mt65xx.c | 656 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 666 insertions(+)
> >  create mode 100644 drivers/spi/spi-mt65xx.c
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index 198f96b..06f9514 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -324,6 +324,15 @@ config SPI_MESON_SPIFC
> >           This enables master mode support for the SPIFC (SPI flash
> >           controller) available in Amlogic Meson SoCs.
> >
> > +config SPI_MT65XX
> > +       tristate "MediaTek SPI controller"
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +       help
> > +         This selects the MediaTek(R) SPI bus driver.
> > +         If you want to use MediaTek(R) SPI interface,
> > +         say Y or M here.If you are not sure, say N.
> > +         SPI drivers for Mediatek mt65XX series ARM SoCs.
> > +
> >  config SPI_OC_TINY
> >         tristate "OpenCores tiny SPI"
> >         depends on GPIOLIB
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > index d8cbf65..ab332ef 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_SPI_MESON_SPIFC)         += spi-meson-spifc.o
> >  obj-$(CONFIG_SPI_MPC512x_PSC)          += spi-mpc512x-psc.o
> >  obj-$(CONFIG_SPI_MPC52xx_PSC)          += spi-mpc52xx-psc.o
> >  obj-$(CONFIG_SPI_MPC52xx)              += spi-mpc52xx.o
> > +obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
> >  obj-$(CONFIG_SPI_MXS)                  += spi-mxs.o
> >  obj-$(CONFIG_SPI_NUC900)               += spi-nuc900.o
> >  obj-$(CONFIG_SPI_OC_TINY)              += spi-oc-tiny.o
> > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> > new file mode 100644
> > index 0000000..6cb54587
> > --- /dev/null
> > +++ b/drivers/spi/spi-mt65xx.c
> > @@ -0,0 +1,656 @@
> > +/*
> > + * Copyright (c) 2015 MediaTek Inc.
> > + * Author: Leilk Liu <leilk.liu@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/ioport.h>
> > +#include <linux/errno.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/types.h>
> > +#include <linux/delay.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/sched.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/kernel.h>
> > +#include <linux/gpio.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> 
> It would be nicer if you can alphabetize these headers.
> 

OK, I'll fix it.

> > +
> > +#define SPI_CFG0_REG                      0x0000
> > +#define SPI_CFG1_REG                      0x0004
> > +#define SPI_TX_SRC_REG                    0x0008
> > +#define SPI_RX_DST_REG                    0x000c
> > +#define SPI_CMD_REG                       0x0018
> > +#define SPI_STATUS0_REG                   0x001c
> > +#define SPI_PAD_SEL_REG                   0x0024
> > +
> > +#define SPI_CFG0_SCK_HIGH_OFFSET          0
> > +#define SPI_CFG0_SCK_LOW_OFFSET           8
> > +#define SPI_CFG0_CS_HOLD_OFFSET           16
> > +#define SPI_CFG0_CS_SETUP_OFFSET          24
> > +
> > +#define SPI_CFG0_SCK_HIGH_MASK            0xff
> > +#define SPI_CFG0_SCK_LOW_MASK             0xff00
> > +#define SPI_CFG0_CS_HOLD_MASK             0xff0000
> > +#define SPI_CFG0_CS_SETUP_MASK            0xff000000
> > +
> > +#define SPI_CFG1_CS_IDLE_OFFSET           0
> > +#define SPI_CFG1_PACKET_LOOP_OFFSET       8
> > +#define SPI_CFG1_PACKET_LENGTH_OFFSET     16
> > +#define SPI_CFG1_GET_TICK_DLY_OFFSET      30
> > +
> > +#define SPI_CFG1_CS_IDLE_MASK             0xff
> > +#define SPI_CFG1_PACKET_LOOP_MASK         0xff00
> > +#define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
> > +#define SPI_CFG1_GET_TICK_DLY_MASK        0xc0000000
> > +
> > +#define SPI_CMD_ACT_OFFSET                0
> > +#define SPI_CMD_RESUME_OFFSET             1
> > +#define SPI_CMD_RST_OFFSET                2
> > +#define SPI_CMD_PAUSE_EN_OFFSET           4
> > +#define SPI_CMD_DEASSERT_OFFSET           5
> > +#define SPI_CMD_CPHA_OFFSET               8
> > +#define SPI_CMD_CPOL_OFFSET               9
> > +#define SPI_CMD_RX_DMA_OFFSET             10
> > +#define SPI_CMD_TX_DMA_OFFSET             11
> > +#define SPI_CMD_TXMSBF_OFFSET             12
> > +#define SPI_CMD_RXMSBF_OFFSET             13
> > +#define SPI_CMD_RX_ENDIAN_OFFSET          14
> > +#define SPI_CMD_TX_ENDIAN_OFFSET          15
> > +#define SPI_CMD_FINISH_IE_OFFSET          16
> > +#define SPI_CMD_PAUSE_IE_OFFSET           17
> > +
> > +#define SPI_CMD_RST_MASK                  0x4
> > +#define SPI_CMD_PAUSE_EN_MASK             0x10
> > +#define SPI_CMD_DEASSERT_MASK             0x20
> > +#define SPI_CMD_CPHA_MASK                 0x100
> > +#define SPI_CMD_CPOL_MASK                 0x200
> > +#define SPI_CMD_RX_DMA_MASK               0x400
> > +#define SPI_CMD_TX_DMA_MASK               0x800
> > +#define SPI_CMD_TXMSBF_MASK               0x1000
> > +#define SPI_CMD_RXMSBF_MASK               0x2000
> > +#define SPI_CMD_RX_ENDIAN_MASK            0x4000
> > +#define SPI_CMD_TX_ENDIAN_MASK            0x8000
> > +#define SPI_CMD_FINISH_IE_MASK            0x10000
> 
> Use the BIT() macro do define these bit masks.
> In fact, for these 1-bit fields, just use the MASK rather than "(1 <<
> *_OFFSET)" when setting/clearing the bits in code.
> 

OK, I'll use BIT() for these masks.

> > +
> > +#define COMPAT_MT6589                  (0x1 << 0)
> > +#define COMPAT_MT8135                  (0x1 << 1)
> > +#define COMPAT_MT8173                  (0x1 << 2)
> 
> Rather than define per-platform "COMPAT" flags, I think it would be
> better to define these as a set of quirks.
> Individual platforms would then specify a mask indicating which quirks
> they support.
> In this case, there are only two, and both are present on mt8173, but
> not on the other 2 listed parts:
>   MTK_SPI_QUIRK_PAD_SELECT
>   MTK_SPI_QUIRK_MUST_TX  /* Must explicitly send dummy Tx bytes to do
> Rx only transfer */
> 
> For MTK_SPI_QUIRK_MUST_TX, I think it just means that we must set the
> SPI_MASTER_MUST_TX flag when registering the spi_master?
> 

OK, I'll define a set of quirks and use SPI_MASTER_MUST_TX.


> > +
> > +#define MT8173_MAX_PAD_SEL 3
> 
> I'm not exactly sure how to deal with PAD_SEL either:
> 
> The MT8173 SPI device supports four SPI ports.
> Each port has the full complement of 4 signals (nSS, CLK, MISO, MOSI).
> However, only one can be selected at a time via the "PAD_SEL" register.
> In addition, the SPI function for the SPI port pins must be enabled
> for the corresponding GPIOs via pinctl.
> If the nSS pin has its SPI function selected, it will be controlled
> automatically by SPI hardware.
> 
> Relying on hardware control of the SPI nSS pin seems quite limiting -
> it means each SPI port can only control a single slave device.
> I would think that allowing any GPIO to act as nSS would be much more
> flexible, since then each SPI port could truly be a multi-slave bus.
> I also believe the standard linux SPI infrastructure has support for
> using GPIOs in this way.
> How is this handled for other platforms (using built-in nSS versus
> using GPIOs as nSS)?
> 

Please see Sascha Hauer's comment.

> > +
> > +#define MTK_SPI_IDLE 0
> > +#define MTK_SPI_INPROGRESS 1
> > +#define MTK_SPI_PAUSED 2
> > +
> > +#define MTK_SPI_PACKET_SIZE 1024
> > +#define MTK_SPI_MAX_PACKET_LOOP 256
> > +
> > +struct mtk_chip_config {
> > +       u32 setuptime;
> > +       u32 holdtime;
> > +       u32 high_time;
> > +       u32 low_time;
> > +       u32 cs_idletime;
> > +       u32 tx_mlsb;
> > +       u32 rx_mlsb;
> > +       u32 tx_endian;
> > +       u32 rx_endian;
> > +       u32 pause;
> > +       u32 finish_intr;
> > +       u32 deassert;
> > +       u32 tckdly;
> > +};
> > +
> > +struct mtk_spi_ddata {
> 
> nit: you can probably shorten this to just "struct mtk_spi".

Ok, I'll fix it.

> 
> > +       struct device *dev;
> > +       struct spi_master *master;
> > +       void __iomem *base;
> > +       u32 irq;
> > +       u32 state;
> > +       u32 platform_compat;
> > +       u32 pad_sel;
> > +       struct clk *clk;
> > +
> > +       const u8 *tx_buf;
> > +       u8 *rx_buf;
> > +       u32 tx_len, rx_len;
> > +       struct completion done;
> > +};
> > +
> > +/*
> > + * A piece of default chip info unless the platform
> > + * supplies it.
> 
> How can platform supply this when the struct is defined in this .c file?
> 
> > + */
> > +static const struct mtk_chip_config mtk_default_chip_info = {
> > +       .setuptime = 6,
> > +       .holdtime = 6,
> > +       .high_time = 3,
> > +       .low_time = 3,
> 
> Individual spi devices should be able to set their min/max transfer
> rate, and that rate can even be modified per-transaction.
> The high & low time should be computed from the SPI block main clock,
> and the requested SPI transfer rate.
> I can't find where this computation is done.
> 

OK, I will implement it.

> > +       .cs_idletime = 6,
> > +       .rx_mlsb = 1,
> > +       .tx_mlsb = 1,
> > +       .tx_endian = 0,
> > +       .rx_endian = 0,
> 
> I think there are standard linux flags for data endianness and bit order.
> 

tx_mlsb and rx_mlsb are define data is MSB first or not in byte;
tx_endian and rx_endian are define whether to reverse the endian order
of an unsigned int data.
I can't find standard linux flags for these, please tell me.

> > +       .pause = 0,
> > +       .finish_intr = 1,
> > +       .deassert = 0,
> > +       .tckdly = 0,
> 
> What is tckdly, and how should it be set for a spi_device?
> 

I will delete it, spi_device doesn't need it.

> > +};
> > +
> > +static const struct of_device_id mtk_spi_of_match[] = {
> > +       { .compatible = "mediatek,mt6589-spi", .data = (void *)COMPAT_MT6589},
> 
> add a space here before '}'

OK, I'll fix it.

> 
> > +       { .compatible = "mediatek,mt8135-spi", .data = (void *)COMPAT_MT8135},
> > +       { .compatible = "mediatek,mt8173-spi", .data = (void *)COMPAT_MT8173},
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
> > +
> > +static void mtk_spi_reset(struct mtk_spi_ddata *mdata)
> > +{
> > +       u32 reg_val;
> > +
> > +       /* set the software reset bit in SPI_CMD_REG. */
> > +       reg_val = readl(mdata->base + SPI_CMD_REG);
> > +       reg_val &= ~SPI_CMD_RST_MASK;
> > +       reg_val |= 1 << SPI_CMD_RST_OFFSET;
> > +       writel(reg_val, mdata->base + SPI_CMD_REG);
> > +       reg_val = readl(mdata->base + SPI_CMD_REG);
> 
> The read here is probably redundant.
> Also, are you sure you do not need a pause between asserting and
> releasing reset?
> Sometimes hardware blocks have a minimum "reset hold" time.

The CMD_RST bit is just soft reset, it resets the spi internel state
machine, so other bits of cmd register should not be changed.
According to designer, the time between asserting and releasing reset is
enough, it doesn't need an extra pause.
> 
> > +       reg_val &= ~SPI_CMD_RST_MASK;
> > +       writel(reg_val, mdata->base + SPI_CMD_REG
> > +}
> > +
> > +static int mtk_spi_config(struct mtk_spi_ddata *mdata,
> > +                         struct mtk_chip_config *chip_config)
> > +{
> > +       u32 reg_val;
> > +
> > +       /* set the timing */
> > +       reg_val = readl(mdata->base + SPI_CFG0_REG);
> > +       reg_val &= ~(SPI_CFG0_SCK_HIGH_MASK | SPI_CFG0_SCK_LOW_MASK);
> > +       reg_val &= ~(SPI_CFG0_CS_HOLD_MASK | SPI_CFG0_CS_SETUP_MASK);
> 
> For CFG0 & CFG1, you are writing the whole 32-bit register, so no need
> to read and mask the old value.
> 

OK, I'll fix CFG0 register here.
CFG1 register is not writing the whole 32-bit here, so I still need to
read and mask.

> > +       reg_val |= ((chip_config->high_time - 1) << SPI_CFG0_SCK_HIGH_OFFSET);
> > +       reg_val |= ((chip_config->low_time - 1) << SPI_CFG0_SCK_LOW_OFFSET);
> > +       reg_val |= ((chip_config->holdtime - 1) << SPI_CFG0_CS_HOLD_OFFSET);
> > +       reg_val |= ((chip_config->setuptime - 1) << SPI_CFG0_CS_SETUP_OFFSET);
> 
> However, the (chip_config->X -1) values here should be masked, to
> ensure they do not overwrite the wrong bits.
> 

ok, I'll fix it.

> > +       writel(reg_val, mdata->base + SPI_CFG0_REG);
> > +
> > +       reg_val = readl(mdata->base + SPI_CFG1_REG);
> > +       reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
> > +       reg_val |= ((chip_config->cs_idletime - 1) << SPI_CFG1_CS_IDLE_OFFSET);
> > +       reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
> > +       reg_val |= ((chip_config->tckdly) << SPI_CFG1_GET_TICK_DLY_OFFSET);
> > +       writel(reg_val, mdata->base + SPI_CFG1_REG);
> > +
> > +       /* set the mlsbx and mlsbtx */
> > +       reg_val = readl(mdata->base + SPI_CMD_REG);
> > +       reg_val &= ~(SPI_CMD_TX_ENDIAN_MASK | SPI_CMD_RX_ENDIAN_MASK);
> > +       reg_val &= ~(SPI_CMD_TXMSBF_MASK | SPI_CMD_RXMSBF_MASK);
> > +       reg_val |= (chip_config->tx_mlsb << SPI_CMD_TXMSBF_OFFSET);
> > +       reg_val |= (chip_config->rx_mlsb << SPI_CMD_RXMSBF_OFFSET);
> > +       reg_val |= (chip_config->tx_endian << SPI_CMD_TX_ENDIAN_OFFSET);
> > +       reg_val |= (chip_config->rx_endian << SPI_CMD_RX_ENDIAN_OFFSET);
> > +       writel(reg_val, mdata->base + SPI_CMD_REG);
> > +
> > +       /* set finish and pause interrupt always enable */
> > +       reg_val = readl(mdata->base + SPI_CMD_REG);
> 
> I don't think we need to keep writing and re-reading this register.
> Just generate the subfields directly into reg_val first, and then
> write it once to SPI_CMD_REG.
> 

ok, I'll fix it.

> > +       reg_val &= ~SPI_CMD_FINISH_IE_MASK;
> > +       reg_val |= (chip_config->finish_intr << SPI_CMD_FINISH_IE_OFFSET);
> > +       writel(reg_val, mdata->base + SPI_CMD_REG);
> > +
> > +       reg_val = readl(mdata->base + SPI_CMD_REG);
> > +       reg_val |= 1 << SPI_CMD_TX_DMA_OFFSET;
> > +       reg_val |= 1 << SPI_CMD_RX_DMA_OFFSET;
> > +       writel(reg_val, mdata->base + SPI_CMD_REG);
> 
> This could use a comment saying that the driver is hard-coding support
> for only DMA mode (not FIFO mode).
> Are there times (short transactions?) where using FIFO mode may be
> preferred to DMA?
> 

ok, I'll fix it.

> > +
> > +       /* set deassert mode */
> > +       reg_val = readl(mdata->base + SPI_CMD_REG);
> > +       reg_val &= ~SPI_CMD_DEASSERT_MASK;
> > +       reg_val |= (chip_config->deassert << SPI_CMD_DEASSERT_OFFSET);
> > +       writel(reg_val, mdata->base + SPI_CMD_REG);
> > +
> > +       /* pad select */
> > +       if (mdata->platform_compat & COMPAT_MT8173)
> > +               writel(mdata->pad_sel, mdata->base + SPI_PAD_SEL_REG);
> > +
> > +       return 0;
> > +}
> > +
> > +static int mtk_spi_prepare_message(struct spi_master *master,
> > +                                  struct spi_message *msg)
> > +{
> > +       u32 reg_val;
> > +       u8 cpha, cpol;
> > +       struct spi_transfer *trans;
> > +       struct mtk_chip_config *chip_config;
> > +       struct spi_device *spi = msg->spi;
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       if (spi->mode & SPI_CPHA)
> > +               cpha = 1;
> > +       else
> > +               cpha = 0;
> 
> style nit: I prefer the tertiary operator for setting values like
> this, but others may not:
> 

ok, I'll use tertiary operator instead.

>   cpha = (spi->mode & SPI_CPHA) ? 1 : 0;
>   cpol = (spi->mode & SPI_CPOL) ? 1 : 0;
> 
> > +
> > +       if (spi->mode & SPI_CPOL)
> > +               cpol = 1;
> > +       else
> > +               cpol = 0;
> > +
> > +       reg_val = readl(mdata->base + SPI_CMD_REG);
> > +       reg_val &= ~(SPI_CMD_CPHA_MASK | SPI_CMD_CPOL_MASK);
> > +       reg_val |= (cpha << SPI_CMD_CPHA_OFFSET);
> > +       reg_val |= (cpol << SPI_CMD_CPOL_OFFSET);
> > +       writel(reg_val, mdata->base + SPI_CMD_REG);
> > +
> > +       chip_config = (struct mtk_chip_config *)spi->controller_data;
> 
> The cast here is not necessary (you shouldn't need to cast to/from (void *))
> 

ok, I'll fix it.

> > +       if (!chip_config) {
> > +               chip_config = (void *)&mtk_default_chip_info;
> > +               spi->controller_data = chip_config;
> > +       }
> > +
> > +       trans = list_first_entry(&msg->transfers, struct spi_transfer,
> > +                                transfer_list);
> 
> This looks inherently racy, and should be unnecessary.
> I believe what you want here is to implement a
> prepare_transfer_hardware() callback.
> 

ok, I'll implement prepare_hardware().

> > +       if (trans->cs_change == 0) {
> > +               mdata->state = MTK_SPI_IDLE;
> > +               mtk_spi_reset(mdata);
> > +       }
> > +
> > +       mtk_spi_config(mdata, chip_config);
> > +
> > +       return 0;
> > +}
> > +
> > +static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
> > +{
> > +       u32 reg_val;
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(spi->master);
> > +
> > +       reg_val = readl(mdata->base + SPI_CMD_REG);
> > +       if (!enable)
> > +               reg_val |= 1 << SPI_CMD_PAUSE_EN_OFFSET;
> > +       else
> > +               reg_val &= ~SPI_CMD_PAUSE_EN_MASK;
> > +       writel(reg_val, mdata->base + SPI_CMD_REG);
> > +}
> > +
> > +static int mtk_spi_setup_packet(struct mtk_spi_ddata *mdata,
> > +                               struct spi_transfer *xfer)
> > +{
> > +       u32 packet_size, packet_loop, reg_val;
> > +
> > +       packet_size = min_t(unsigned, xfer->len, MTK_SPI_PACKET_SIZE);
> > +
> > +       /* mtk hw has the restriction that xfer len must be a multiple of 1024,
> > +        * when it is greater than 1024bytes.
> > +        */
> 
> Is this really true?
> It looks like the length of a single mtk_spi transaction is
> PACKET_LENGTH * PACKET_LOOP.
> So, it should be possible to support any non-prime length.
> 
> In addition, using the "PAUSE" mode, it should be possible to
> represent any length as a sequence of smaller transactions,
> potentially of different sizes.
> I think the only real limitiation is that without an IOMMU, the SPI
> hardware can only access a physically contiguous memory buffer.
> 

OK, I will support any non-prime length on next version.

> > +       if (xfer->len % packet_size) {
> > +               dev_err(mdata->dev, "ERROR!The lens must be a multiple of %d, your len %d\n",
> > +                       MTK_SPI_PACKET_SIZE, xfer->len);
> > +               return -EINVAL;
> > +       }
> > +
> > +       packet_loop = xfer->len / packet_size;
> > +       if (packet_loop > MTK_SPI_MAX_PACKET_LOOP) {
> > +               dev_err(mdata->dev, "packet_loop(%d) error\n", packet_loop);
> > +               return -EINVAL;
> > +       }
> > +
> > +       reg_val = readl(mdata->base + SPI_CFG1_REG);
> > +       reg_val &= ~(SPI_CFG1_PACKET_LENGTH_MASK + SPI_CFG1_PACKET_LOOP_MASK);
> > +       reg_val |= (packet_size - 1) << SPI_CFG1_PACKET_LENGTH_OFFSET;
> > +       reg_val |= (packet_loop - 1) << SPI_CFG1_PACKET_LOOP_OFFSET;
> > +       writel(reg_val, mdata->base + SPI_CFG1_REG);
> > +
> > +       return 0;
> > +}
> > +
> > +static int mtk_spi_transfer_one(struct spi_master *master,
> > +                               struct spi_device *spi,
> > +                               struct spi_transfer *xfer)
> > +{
> > +       int cmd = 0, ret = 0;
> 
> There is no need to 0 initialize these two variables.

ok, I will fix it.

> 
> > +       unsigned int tx_sgl_len = 0, rx_sgl_len = 0;
> > +       struct scatterlist *tx_sgl = NULL, *rx_sgl = NULL;
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       /* Here is mt8173 HW issue: RX must enable TX, then TX transfer
> > +        * dummy data; TX don't need to enable RX. so enable TX dma for
> > +        * RX to workaround.
> > +        */
> > +       cmd = readl(mdata->base + SPI_CMD_REG);
> > +       if (xfer->tx_buf || (mdata->platform_compat & COMPAT_MT8173))
> > +               cmd |= 1 << SPI_CMD_TX_DMA_OFFSET;
> > +       if (xfer->rx_buf)
> > +               cmd |= 1 << SPI_CMD_RX_DMA_OFFSET;
> > +       writel(cmd, mdata->base + SPI_CMD_REG);
> > +
> > +       if (xfer->tx_buf)
> > +               tx_sgl = xfer->tx_sg.sgl;
> > +       if (xfer->rx_buf)
> > +               rx_sgl = xfer->rx_sg.sgl;
> > +
> > +       while (rx_sgl || tx_sgl) {
> > +               if (tx_sgl && (tx_sgl_len == 0)) {
> > +                       xfer->tx_dma = sg_dma_address(tx_sgl);
> > +                       tx_sgl_len = sg_dma_len(tx_sgl);
> > +               }
> > +               if (rx_sgl && (rx_sgl_len == 0)) {
> > +                       xfer->rx_dma = sg_dma_address(rx_sgl);
> > +                       rx_sgl_len = sg_dma_len(rx_sgl);
> > +               }
> > +
> > +               if (tx_sgl && rx_sgl)
> > +                       xfer->len = min_t(unsigned int, tx_sgl_len, rx_sgl_len);
> > +               else
> > +                       xfer->len = max_t(unsigned int, tx_sgl_len, rx_sgl_len);
> > +
> > +               ret = mtk_spi_setup_packet(mdata, xfer);
> > +               if (ret != 0)
> > +                       return ret;
> > +
> > +               /* set up the DMA bus address */
> > +               writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
> > +               writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
> > +
> > +               /* trigger to transfer */
> > +               if (mdata->state == MTK_SPI_IDLE) {
> > +                       cmd = readl(mdata->base + SPI_CMD_REG);
> > +                       cmd |= 1 << SPI_CMD_ACT_OFFSET;
> > +                       writel(cmd, mdata->base + SPI_CMD_REG);
> > +               } else if (mdata->state == MTK_SPI_PAUSED) {
> > +                       cmd = readl(mdata->base + SPI_CMD_REG);
> > +                       cmd |= 1 << SPI_CMD_RESUME_OFFSET;
> > +                       writel(cmd, mdata->base + SPI_CMD_REG);
> > +               } else {
> > +                       mdata->state = MTK_SPI_INPROGRESS;
> > +               }
> > +
> > +               wait_for_completion(&mdata->done);
> > +
> > +               if (tx_sgl && rx_sgl) {
> > +                       if (tx_sgl_len > rx_sgl_len) {
> > +                               xfer->tx_dma += rx_sgl_len;
> > +                               tx_sgl_len -= rx_sgl_len;
> > +                               rx_sgl_len = 0;
> > +                               rx_sgl = sg_next(rx_sgl);
> > +                               continue;
> > +                       } else if (tx_sgl_len < rx_sgl_len) {
> > +                               xfer->rx_dma += tx_sgl_len;
> > +                               rx_sgl_len -= tx_sgl_len;
> > +                               tx_sgl_len = 0;
> > +                               tx_sgl = sg_next(tx_sgl);
> > +                               continue;
> > +                       }
> > +               }
> > +
> > +               rx_sgl_len = 0;
> > +               tx_sgl_len = 0;
> > +
> > +               if (rx_sgl)
> > +                       rx_sgl = sg_next(rx_sgl);
> > +               if (tx_sgl)
> > +                       tx_sgl = sg_next(tx_sgl);
> > +       }
> > +
> > +       /* spi disable dma */
> > +       cmd = readl(mdata->base + SPI_CMD_REG);
> > +       cmd &= ~SPI_CMD_TX_DMA_MASK;
> > +       cmd &= ~SPI_CMD_RX_DMA_MASK;
> > +       writel(cmd, mdata->base + SPI_CMD_REG);
> 
> I think there is an unprepare_transfer_hardware() callback for this
> that will be called when the message queue is empty.
> 

I will support fifo mode transfer on next version. I think it should
enable/disable rx/tx dma enable-bit in every spi_transfer, since in a
spi message, it maybe transfer by dma or fifo mode.
A prepare_transfer_hardware()/unprepare_transfer_hardware() callback is
for a spi_message.

> > +
> > +       return ret;
> > +}
> > +
> > +static bool mtk_spi_can_dma(struct spi_master *master,
> > +                           struct spi_device *spi,
> > +                           struct spi_transfer *xfer)
> > +{
> > +       return true;
> 
> I haven't really investigated how this is supposed to work, but I
> think we need a dma_chan to do proper dma.
> I think for the first version of this driver, we might as well return
> false here, and use FIFO mode to handle.
> 

Ohmm, I will support fifo mode on next version.

> > +}
> > +
> > +static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
> > +{
> > +       struct mtk_spi_ddata *mdata = dev_id;
> > +       u32 reg_val;
> > +
> > +       reg_val = readl(mdata->base + SPI_STATUS0_REG);
> > +       if (reg_val & 0x2)
> > +               mdata->state = MTK_SPI_PAUSED;
> > +       else
> > +               mdata->state = MTK_SPI_IDLE;
> > +
> > +       complete(&mdata->done);
> 
> Rather than waking up the main thread, to configure the next
> scatterlist, perhaps we can just use the interrupt handler to walk the
> sg list (ie if reg_val & 0x2).
> "When the last scatterlist has been sent (reg_val & 0x1), we can then
> call spi_finalize_current_transfer().
> In this way, we can remove the loop from transfer_one(), return 1 from
> transfer_one() and remove the driver-specific completion
> "mdata->done".
> 

OK, I will implement this way.

> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int mtk_spi_probe(struct platform_device *pdev)
> > +{
> > +       struct spi_master *master;
> > +       struct mtk_spi_ddata *mdata;
> > +       const struct of_device_id *of_id;
> > +       struct resource *res;
> > +       int     ret;
> > +
> > +       master = spi_alloc_master(&pdev->dev, sizeof(struct mtk_spi_ddata));
> 
> master = spi_alloc_master(dev, sizeof *mdata)
> 

OK, I will fix it.

> > +       if (!master) {
> > +               dev_err(&pdev->dev, "failed to alloc spi master\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       pm_runtime_set_active(&pdev->dev);
> > +       pm_runtime_enable(&pdev->dev);
> 
> Why set_active?  I think we probably don't need to turn on the SPI
> clocks until the first SPI transaction.
> In any case, move this to the end of mtk_spi_probe(), after we are
> sure we aren't going to return an error.
> 

ok, I will fix it.

> > +
> > +       master->auto_runtime_pm = true;
> > +       master->dev.of_node = pdev->dev.of_node;
> 
> I believe spi_alloc_master() actually sets pdev->dev as master's parent device.
> Why do you need to copy its of_node to master->dev?
> 

Yes, spi_alloc_master() sets pdev->dev as master's parent device.
master->dev.parent = get_device(dev);
But it doesn't set master->dev = pdev->dev, I think master should know
device_node of this device.

> > +       master->bus_num = pdev->id;
> > +       master->num_chipselect = 1;
> 
> This is the default, so not technically needed.
> 

OK, I will remove it.

> > +       master->mode_bits = SPI_CPOL | SPI_CPHA;
> > +
> > +       mdata = spi_master_get_devdata(master);
> > +       memset(mdata, 0, sizeof(struct mtk_spi_ddata));
> 
> This memset() is not necessary.  spi_alloc_master() will zero init this for us.
> 

OK, I will remove it.

> > +
> > +       mdata->master = master;
> 
> This pointer back to master should not be needed.  I think in all
> cases we will given master, and want to extract mdata, not the other
> way around.
> 

OK, I will remove it.

> > +       mdata->dev = &pdev->dev;
> 
> This mdata->dev should not be needed; Just use master->dev.
> 
OK, I will fix it.

> > +
> > +       master->set_cs = mtk_spi_set_cs;
> > +       master->prepare_message = mtk_spi_prepare_message;
> > +       master->transfer_one = mtk_spi_transfer_one;
> > +       master->can_dma = mtk_spi_can_dma;
> > +
> > +       of_id = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
> > +       if (!of_id) {
> > +               dev_err(&pdev->dev, "failed to probe of_node\n");
> > +               ret = -EINVAL;
> > +               goto err;
> > +       }
> > +
> > +       mdata->platform_compat = (unsigned long)of_id->data;
> > +
> > +       if (mdata->platform_compat & COMPAT_MT8173) {
> > +               ret = of_property_read_u32(pdev->dev.of_node, "pad-select",
> > +                                          &mdata->pad_sel);
> > +               if (ret) {
> > +                       dev_err(&pdev->dev, "failed to read pad select: %d\n",
> > +                               ret);
> > +                       goto err;
> > +               }
> > +
> > +               if (mdata->pad_sel > MT8173_MAX_PAD_SEL) {
> > +                       dev_err(&pdev->dev, "wrong pad-select: %u\n",
> > +                               mdata->pad_sel);
> > +                       ret = -EINVAL;
> > +                       goto err;
> > +               }
> > +       }
> > +
> > +       platform_set_drvdata(pdev, master);
> > +       init_completion(&mdata->done);
> > +
> > +       mdata->clk = devm_clk_get(&pdev->dev, "main");
> > +       if (IS_ERR(mdata->clk)) {
> > +               ret = PTR_ERR(mdata->clk);
> > +               dev_err(&pdev->dev, "failed to get clock: %d\n", ret);
> > +               goto err;
> > +       }
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res) {
> > +               ret = -ENODEV;
> > +               dev_err(&pdev->dev, "failed to determine base address\n");
> > +               goto err;
> > +       }
> > +
> > +       mdata->base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(mdata->base)) {
> > +               ret = PTR_ERR(mdata->base);
> > +               goto err;
> > +       }
> > +
> > +       ret = platform_get_irq(pdev, 0);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "failed to get irq (%d)\n", ret);
> > +               goto err;
> > +       }
> > +
> > +       mdata->irq = ret;
> > +
> > +       if (!pdev->dev.dma_mask)
> > +               pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> > +
> > +       ret = clk_prepare_enable(mdata->clk);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "failed to enable clock (%d)\n", ret);
> > +               goto err;
> > +       }
> > +
> > +       ret = devm_request_irq(&pdev->dev, mdata->irq, mtk_spi_interrupt,
> > +                              IRQF_TRIGGER_NONE, dev_name(&pdev->dev), mdata);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to register irq (%d)\n", ret);
> > +               goto err_disable_clk;
> > +       }
> > +
> > +       ret = devm_spi_register_master(&pdev->dev, master);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
> > +err_disable_clk:
> 
> Don't use a goto to jump into the middle of a block like this.
> Add the err handling labels after a "return 0;", like this:
> 

OK, I will fix it.

>    return 0;
>  err_disable_clk:
>    clk_disable_unprepare(mdata->clk);
>  err_put_master:
>    spi_master_put(master);
>    kfree(master);
>    return ret;
> 
> > +               clk_disable_unprepare(mdata->clk);
> > +err:
> > +               spi_master_put(master);
> 
> On add failure, must also:
>    kfree(master);
> 

On failure, master is kfree by spi_master_release(), and
spi_master_release() is registered in spi_master_class, I think it need
not to kfree(master) in mtk spi driver.

> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int mtk_spi_remove(struct platform_device *pdev)
> > +{
> > +       struct spi_master *master = platform_get_drvdata(pdev);
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       pm_runtime_disable(&pdev->dev);
> > +
> > +       mtk_spi_reset(mdata);
> > +       clk_disable_unprepare(mdata->clk);
> > +       spi_master_put(master);
> > +
> > +       return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int mtk_spi_suspend(struct device *dev)
> > +{
> > +       int ret = 0;
> > +       struct spi_master *master = dev_get_drvdata(dev);
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       ret = spi_master_suspend(master);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (!pm_runtime_suspended(dev))
> > +               clk_disable_unprepare(mdata->clk);
> > +
> > +       return ret;
> > +}
> > +
> > +static int mtk_spi_resume(struct device *dev)
> > +{
> > +       int ret = 0;
> > +       struct spi_master *master = dev_get_drvdata(dev);
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       if (!pm_runtime_suspended(dev)) {
> > +               ret = clk_prepare_enable(mdata->clk);
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +
> > +       return spi_master_resume(master);
> 
> If this fails, you should disable the clock if it was just enabled.
> 

OK, I will fix it.

> Ok, enough for now!
> 
> Thanks,
> -Dan
> 
> > +}
> > +#endif /* CONFIG_PM_SLEEP */
> > +
> > +#ifdef CONFIG_PM
> > +static int mtk_spi_runtime_suspend(struct device *dev)
> > +{
> > +       struct spi_master *master = dev_get_drvdata(dev);
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       clk_disable_unprepare(mdata->clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static int mtk_spi_runtime_resume(struct device *dev)
> > +{
> > +       struct spi_master *master = dev_get_drvdata(dev);
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       return clk_prepare_enable(mdata->clk);
> > +}
> > +#endif /* CONFIG_PM */
> > +
> > +static const struct dev_pm_ops mtk_spi_pm = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(mtk_spi_suspend, mtk_spi_resume)
> > +       SET_RUNTIME_PM_OPS(mtk_spi_runtime_suspend,
> > +                          mtk_spi_runtime_resume, NULL)
> > +};
> > +
> > +struct platform_driver mtk_spi_driver = {
> > +       .driver = {
> > +               .name = "mtk-spi",
> > +               .pm     = &mtk_spi_pm,
> > +               .of_match_table = mtk_spi_of_match,
> > +       },
> > +       .probe = mtk_spi_probe,
> > +       .remove = mtk_spi_remove,
> > +};
> > +
> > +module_platform_driver(mtk_spi_driver);
> > +
> > +MODULE_DESCRIPTION("MTK SPI Controller driver");
> > +MODULE_AUTHOR("Leilk Liu <leilk.liu@mediatek.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform: mtk_spi");
> > --
> > 1.8.1.1.dirty
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
