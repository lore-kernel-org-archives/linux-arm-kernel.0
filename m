From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 12 Aug 2010 13:54:46 -0600
Subject: [PATCH v2] spi: add spi_tegra driver
In-Reply-To: <1281574023-25160-1-git-send-email-konkers@android.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<1281574023-25160-1-git-send-email-konkers@android.com>
Message-ID: <AANLkTim4nL+Re=qc55CGS+ksq+ACtGe=vqOeGQ3HbQWM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Erik,

Thanks for the quick respin.  I've got some more comments below, most
of them minor, but there are some questions about the locking model.
I don't see any problem with me picking this driver up into my
next-spi tree once the .26 merge window closes.

g.

On Wed, Aug 11, 2010 at 6:47 PM, Erik Gilling <konkers@android.com> wrote:

Missing patch description.  Give reviewers and future readers some
more details about what hardware this patch adds support for.

> v2 changes:
> ?from Thierry Reding:
> ? ?* add "select TEGRA_SYSTEM_DMA" to Kconfig
> ?from Grant Likely:
> ? ?* add oneline description to header
> ? ?* inline references to DRIVER_NAME
> ? ?* inline references to BUSY_TIMEOUT
> ? ?* open coded bytes_per_word()
> ? ?* spi_readl/writel -> spi_tegra_readl/writel
> ? ?* move transfer validation to spi_tegra_transfer
> ? ?* don't request_mem_region iomem as platform bus does that for us
> ? ?* __exit -> __devexit
>
> Signed-off-by: Erik Gilling <konkers@android.com>
> Cc: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>

> ---
> ?drivers/spi/Kconfig ? ? | ? ?7 +
> ?drivers/spi/Makefile ? ?| ? ?1 +
> ?drivers/spi/spi_tegra.c | ?638 +++++++++++++++++++++++++++++++++++++++++++++++
> ?3 files changed, 646 insertions(+), 0 deletions(-)
> ?create mode 100644 drivers/spi/spi_tegra.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 91c2f4f..9fdb309 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -298,6 +298,13 @@ config SPI_STMP3XXX
> ? ? ? ?help
> ? ? ? ? ?SPI driver for Freescale STMP37xx/378x SoC SSP interface
>
> +config SPI_TEGRA
> + ? ? ? tristate "Nvidia Tegra SPI controller"
> + ? ? ? depends on ARCH_TEGRA
> + ? ? ? select TEGRA_SYSTEM_DMA
> + ? ? ? help
> + ? ? ? ? SPI driver for NVidia Tegra SoCs
> +
> ?config SPI_TXX9
> ? ? ? ?tristate "Toshiba TXx9 SPI controller"
> ? ? ? ?depends on GENERIC_GPIO && CPU_TX49XX
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index e9cbd18..b6573d8 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_SPI_PPC4xx) ? ? ? ? ? ? ?+= spi_ppc4xx.o
> ?obj-$(CONFIG_SPI_S3C24XX_GPIO) ? ? ? ? += spi_s3c24xx_gpio.o
> ?obj-$(CONFIG_SPI_S3C24XX) ? ? ? ? ? ? ?+= spi_s3c24xx_hw.o
> ?obj-$(CONFIG_SPI_S3C64XX) ? ? ? ? ? ? ?+= spi_s3c64xx.o
> +obj-$(CONFIG_SPI_TEGRA) ? ? ? ? ? ? ? ? ? ? ? ?+= spi_tegra.o
> ?obj-$(CONFIG_SPI_TXX9) ? ? ? ? ? ? ? ? += spi_txx9.o
> ?obj-$(CONFIG_SPI_XILINX) ? ? ? ? ? ? ? += xilinx_spi.o
> ?obj-$(CONFIG_SPI_XILINX_OF) ? ? ? ? ? ?+= xilinx_spi_of.o
> diff --git a/drivers/spi/spi_tegra.c b/drivers/spi/spi_tegra.c
> new file mode 100644
> index 0000000..5afb7a7
> --- /dev/null
> +++ b/drivers/spi/spi_tegra.c
> @@ -0,0 +1,638 @@
> +/*
> + * Driver for Nvidia TEGRA spi controller.
> + *
> + * Copyright (C) 2010 Google, Inc.
> + *
> + * Author:
> + * ? ? Erik Gilling <konkers@android.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#undef DEBUG

Still need to trim this #undef

> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +
> +#include <linux/spi/spi.h>
> +
> +#include <mach/dma.h>
> +
> +#define SLINK_COMMAND ? ? ? ? ?0x000
> +#define ? BIT_LENGTH(x) ? ? ? ? ? ? ? ? ? ? ? ?(((x) & 0x1f) << 0)
> +#define ? WORD_SIZE(x) ? ? ? ? ? ? ? ? (((x) & 0x1f) << 5)
> +#define ? BOTH_EN ? ? ? ? ? ? ? ? ? ? ?(1 << 10)
> +#define ? CS_SW ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(1 << 11)
> +#define ? CS_VALUE ? ? ? ? ? ? ? ? ? ? (1 << 12)
> +#define ? CS_POLARITY ? ? ? ? ? ? ? ? ?(1 << 13)
> +#define ? IDLE_SDA_DRIVE_LOW ? ? ? ? ? (0 << 16)
> +#define ? IDLE_SDA_DRIVE_HIGH ? ? ? ? ?(1 << 16)
> +#define ? IDLE_SDA_PULL_LOW ? ? ? ? ? ?(2 << 16)
> +#define ? IDLE_SDA_PULL_HIGH ? ? ? ? ? (3 << 16)
> +#define ? IDLE_SDA_MASK ? ? ? ? ? ? ? ? ? ? ? ?(3 << 16)
> +#define ? CS_POLARITY1 ? ? ? ? ? ? ? ? (1 << 20)
> +#define ? CK_SDA ? ? ? ? ? ? ? ? ? ? ? (1 << 21)
> +#define ? CS_POLARITY2 ? ? ? ? ? ? ? ? (1 << 22)
> +#define ? CS_POLARITY3 ? ? ? ? ? ? ? ? (1 << 23)
> +#define ? IDLE_SCLK_DRIVE_LOW ? ? ? ? ?(0 << 24)
> +#define ? IDLE_SCLK_DRIVE_HIGH ? ? ? ? (1 << 24)
> +#define ? IDLE_SCLK_PULL_LOW ? ? ? ? ? (2 << 24)
> +#define ? IDLE_SCLK_PULL_HIGH ? ? ? ? ?(3 << 24)
> +#define ? IDLE_SCLK_MASK ? ? ? ? ? ? ? (3 << 24)
> +#define ? M_S ? ? ? ? ? ? ? ? ? ? ? ? ?(1 << 28)
> +#define ? WAIT ? ? ? ? ? ? ? ? ? ? ? ? (1 << 29)
> +#define ? GO ? ? ? ? ? ? ? ? ? ? ? ? ? (1 << 30)
> +#define ? ENB ? ? ? ? ? ? ? ? ? ? ? ? ?(1 << 31)

It's a good idea to prefix all these register #defines with something
driver specific to avoid the possibility of collisions with the global
namespace.

> +
> +#define SLINK_COMMAND2 ? ? ? ? 0x004
> +#define ? LSBFE ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(1 << 0)
> +#define ? SSOE ? ? ? ? ? ? ? ? ? ? ? ? (1 << 1)
> +#define ? SPIE ? ? ? ? ? ? ? ? ? ? ? ? (1 << 4)
> +#define ? BIDIROE ? ? ? ? ? ? ? ? ? ? ?(1 << 6)
> +#define ? MODFEN ? ? ? ? ? ? ? ? ? ? ? (1 << 7)
> +#define ? INT_SIZE(x) ? ? ? ? ? ? ? ? ?(((x) & 0x1f) << 8)
> +#define ? CS_ACTIVE_BETWEEN ? ? ? ? ? ?(1 << 17)
> +#define ? SS_EN_CS(x) ? ? ? ? ? ? ? ? ?(((x) & 0x3) << 18)
> +#define ? SS_SETUP(x) ? ? ? ? ? ? ? ? ?(((x) & 0x3) << 20)
> +#define ? FIFO_REFILLS_0 ? ? ? ? ? ? ? (0 << 22)
> +#define ? FIFO_REFILLS_1 ? ? ? ? ? ? ? (1 << 22)
> +#define ? FIFO_REFILLS_2 ? ? ? ? ? ? ? (2 << 22)
> +#define ? FIFO_REFILLS_3 ? ? ? ? ? ? ? (3 << 22)
> +#define ? FIFO_REFILLS_MASK ? ? ? ? ? ?(3 << 22)
> +#define ? WAIT_PACK_INT(x) ? ? ? ? ? ? (((x) & 0x7) << 26)
> +#define ? SPC0 ? ? ? ? ? ? ? ? ? ? ? ? (1 << 29)
> +#define ? TXEN ? ? ? ? ? ? ? ? ? ? ? ? (1 << 30)
> +#define ? RXEN ? ? ? ? ? ? ? ? ? ? ? ? (1 << 31)
> +
> +#define SLINK_STATUS ? ? ? ? ? 0x008
> +#define ? COUNT(val) ? ? ? ? ? ? ? ? ? (((val) >> 0) & 0x1f)
> +#define ? WORD(val) ? ? ? ? ? ? ? ? ? ?(((val) >> 5) & 0x1f)
> +#define ? BLK_CNT(val) ? ? ? ? ? ? ? ? (((val) >> 0) & 0xffff)
> +#define ? MODF ? ? ? ? ? ? ? ? ? ? ? ? (1 << 16)
> +#define ? RX_UNF ? ? ? ? ? ? ? ? ? ? ? (1 << 18)
> +#define ? TX_OVF ? ? ? ? ? ? ? ? ? ? ? (1 << 19)
> +#define ? TX_FULL ? ? ? ? ? ? ? ? ? ? ?(1 << 20)
> +#define ? TX_EMPTY ? ? ? ? ? ? ? ? ? ? (1 << 21)
> +#define ? RX_FULL ? ? ? ? ? ? ? ? ? ? ?(1 << 22)
> +#define ? RX_EMPTY ? ? ? ? ? ? ? ? ? ? (1 << 23)
> +#define ? TX_UNF ? ? ? ? ? ? ? ? ? ? ? (1 << 24)
> +#define ? RX_OVF ? ? ? ? ? ? ? ? ? ? ? (1 << 25)
> +#define ? TX_FLUSH ? ? ? ? ? ? ? ? ? ? (1 << 26)
> +#define ? RX_FLUSH ? ? ? ? ? ? ? ? ? ? (1 << 27)
> +#define ? SCLK ? ? ? ? ? ? ? ? ? ? ? ? (1 << 28)
> +#define ? ERR ? ? ? ? ? ? ? ? ? ? ? ? ?(1 << 29)
> +#define ? RDY ? ? ? ? ? ? ? ? ? ? ? ? ?(1 << 30)
> +#define ? BSY ? ? ? ? ? ? ? ? ? ? ? ? ?(1 << 31)
> +
> +#define SLINK_MAS_DATA ? ? ? ? 0x010
> +#define SLINK_SLAVE_DATA ? ? ? 0x014
> +
> +#define SLINK_DMA_CTL ? ? ? ? ?0x018
> +#define ? DMA_BLOCK_SIZE(x) ? ? ? ? ? ?(((x) & 0xffff) << 0)
> +#define ? TX_TRIG_1 ? ? ? ? ? ? ? ? ? ?(0 << 16)
> +#define ? TX_TRIG_4 ? ? ? ? ? ? ? ? ? ?(1 << 16)
> +#define ? TX_TRIG_8 ? ? ? ? ? ? ? ? ? ?(2 << 16)
> +#define ? TX_TRIG_16 ? ? ? ? ? ? ? ? ? (3 << 16)
> +#define ? TX_TRIG_MASK ? ? ? ? ? ? ? ? (3 << 16)
> +#define ? RX_TRIG_1 ? ? ? ? ? ? ? ? ? ?(0 << 18)
> +#define ? RX_TRIG_4 ? ? ? ? ? ? ? ? ? ?(1 << 18)
> +#define ? RX_TRIG_8 ? ? ? ? ? ? ? ? ? ?(2 << 18)
> +#define ? RX_TRIG_16 ? ? ? ? ? ? ? ? ? (3 << 18)
> +#define ? RX_TRIG_MASK ? ? ? ? ? ? ? ? (3 << 18)
> +#define ? PACKED ? ? ? ? ? ? ? ? ? ? ? (1 << 20)
> +#define ? PACK_SIZE_4 ? ? ? ? ? ? ? ? ?(0 << 21)
> +#define ? PACK_SIZE_8 ? ? ? ? ? ? ? ? ?(1 << 21)
> +#define ? PACK_SIZE_16 ? ? ? ? ? ? ? ? (2 << 21)
> +#define ? PACK_SIZE_32 ? ? ? ? ? ? ? ? (3 << 21)
> +#define ? PACK_SIZE_MASK ? ? ? ? ? ? ? (3 << 21)
> +#define ? IE_TXC ? ? ? ? ? ? ? ? ? ? ? (1 << 26)
> +#define ? IE_RXC ? ? ? ? ? ? ? ? ? ? ? (1 << 27)
> +#define ? DMA_EN ? ? ? ? ? ? ? ? ? ? ? (1 << 31)
> +
> +#define SLINK_STATUS2 ? ? ? ? ?0x01c
> +#define ? TX_FIFO_EMPTY_COUNT(val) ? ? (((val) & 0x3f) >> 0)
> +#define ? RX_FIFO_FULL_COUNT(val) ? ? ?(((val) & 0x3f) >> 16)
> +
> +#define SLINK_TX_FIFO ? ? ? ? ?0x100
> +#define SLINK_RX_FIFO ? ? ? ? ?0x180
> +
> +static const unsigned long spi_tegra_req_sels[] = {
> + ? ? ? TEGRA_DMA_REQ_SEL_SL2B1,
> + ? ? ? TEGRA_DMA_REQ_SEL_SL2B2,
> + ? ? ? TEGRA_DMA_REQ_SEL_SL2B3,
> + ? ? ? TEGRA_DMA_REQ_SEL_SL2B4,
> +};
> +
> +static inline unsigned bytes_per_word(u8 bits)
> +{
> + ? ? ? WARN_ON((bits < 1) || bits > 32);
> + ? ? ? if (bits <= 8)
> + ? ? ? ? ? ? ? return 1;
> + ? ? ? else if (bits <= 16)
> + ? ? ? ? ? ? ? return 2;
> + ? ? ? else if (bits <= 24)
> + ? ? ? ? ? ? ? return 3;
> + ? ? ? else
> + ? ? ? ? ? ? ? return 4;
> +}

No longer used, can be removed.

> +
> +#define BB_LEN ? ? ? ? ? ? ? ? 32
> +
> +struct spi_tegra_data {
> + ? ? ? struct spi_master ? ? ? *master;
> + ? ? ? struct platform_device ?*pdev;
> + ? ? ? spinlock_t ? ? ? ? ? ? ?lock;
> +
> + ? ? ? struct clk ? ? ? ? ? ? ?*clk;
> + ? ? ? void __iomem ? ? ? ? ? ?*base;
> + ? ? ? unsigned long ? ? ? ? ? phys;
> +
> + ? ? ? u32 ? ? ? ? ? ? ? ? ? ? cur_speed;
> +
> + ? ? ? struct list_head ? ? ? ?queue;
> + ? ? ? struct spi_transfer ? ? *cur;
> + ? ? ? unsigned ? ? ? ? ? ? ? ?cur_pos;
> + ? ? ? unsigned ? ? ? ? ? ? ? ?cur_len;
> + ? ? ? unsigned ? ? ? ? ? ? ? ?cur_bytes_per_word;
> +
> + ? ? ? /* The tegra spi controller has a bug which causes the first word
> + ? ? ? ?* in PIO transactions to be garbage. ?Since packed DMA transactions
> + ? ? ? ?* require transfers to be 4 byte aligned we need a bounce buffer
> + ? ? ? ?* for the generic case.
> + ? ? ? ?*/
> + ? ? ? struct tegra_dma_req ? ?rx_dma_req;
> + ? ? ? struct tegra_dma_channel *rx_dma;
> + ? ? ? u32 ? ? ? ? ? ? ? ? ? ? *rx_bb;
> + ? ? ? dma_addr_t ? ? ? ? ? ? ?rx_bb_phys;
> +};
> +
> +
> +static unsigned long spi_tegra_readl(struct spi_tegra_data *tspi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned long reg)
> +{
> + ? ? ? return readl(tspi->base + reg);
> +}

static inline

> +
> +static void spi_tegra_writel(struct spi_tegra_data *tspi, unsigned long val,
> + ? ? ? ? ? ? ? ? ? ? ?unsigned long reg)
> +{
> + ? ? ? writel(val, tspi->base + reg);
> +}

ditto

> +
> +static void spi_tegra_go(struct spi_tegra_data *tspi)
> +{
> + ? ? ? unsigned long val;
> +
> + ? ? ? wmb();
> +
> + ? ? ? val = spi_tegra_readl(tspi, SLINK_DMA_CTL);
> + ? ? ? val &= ~DMA_BLOCK_SIZE(~0) & ~DMA_EN;
> + ? ? ? val |= DMA_BLOCK_SIZE(tspi->rx_dma_req.size / 4 - 1);
> + ? ? ? spi_tegra_writel(tspi, val, SLINK_DMA_CTL);
> +
> + ? ? ? tegra_dma_enqueue_req(tspi->rx_dma, &tspi->rx_dma_req);
> +
> + ? ? ? val |= DMA_EN;
> + ? ? ? spi_tegra_writel(tspi, val, SLINK_DMA_CTL);
> +}
> +
> +static unsigned spi_tegra_fill_tx_fifo(struct spi_tegra_data *tspi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_transfer *t)
> +{
> + ? ? ? unsigned len = min(t->len - tspi->cur_pos, BB_LEN *
> + ? ? ? ? ? ? ? ? ? ? ? ? ?tspi->cur_bytes_per_word);
> + ? ? ? u8 *tx_buf = (u8 *)t->tx_buf + tspi->cur_pos;
> + ? ? ? int i, j;
> + ? ? ? unsigned long val;
> +
> + ? ? ? val = spi_tegra_readl(tspi, SLINK_COMMAND);
> + ? ? ? val &= ~WORD_SIZE(~0);
> + ? ? ? val |= WORD_SIZE(len / tspi->cur_bytes_per_word - 1);
> + ? ? ? spi_tegra_writel(tspi, val, SLINK_COMMAND);
> +
> + ? ? ? for (i = 0; i < len; i += tspi->cur_bytes_per_word) {
> + ? ? ? ? ? ? ? val = 0;
> + ? ? ? ? ? ? ? for (j = 0; j < tspi->cur_bytes_per_word; j++)
> + ? ? ? ? ? ? ? ? ? ? ? val |= tx_buf[i + j] << j * 8;
> +
> + ? ? ? ? ? ? ? spi_tegra_writel(tspi, val, SLINK_TX_FIFO);
> + ? ? ? }
> +
> + ? ? ? tspi->rx_dma_req.size = len / tspi->cur_bytes_per_word * 4;
> +
> + ? ? ? return len;
> +}
> +
> +static unsigned spi_tegra_drain_rx_fifo(struct spi_tegra_data *tspi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_transfer *t)
> +{
> + ? ? ? unsigned len = tspi->cur_len;
> + ? ? ? u8 *rx_buf = (u8 *)t->rx_buf + tspi->cur_pos;
> + ? ? ? int i, j;
> + ? ? ? unsigned long val;
> +
> + ? ? ? for (i = 0; i < len; i += tspi->cur_bytes_per_word) {
> + ? ? ? ? ? ? ? val = tspi->rx_bb[i / tspi->cur_bytes_per_word];
> + ? ? ? ? ? ? ? for (j = 0; j < tspi->cur_bytes_per_word; j++)
> + ? ? ? ? ? ? ? ? ? ? ? rx_buf[i + j] = (val >> (j * 8)) & 0xff;
> + ? ? ? }
> +
> + ? ? ? return len;
> +}
> +
> +static void spi_tegra_start_transfer(struct spi_device *spi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_transfer *t)
> +{
> + ? ? ? struct spi_tegra_data *tspi = spi_master_get_devdata(spi->master);
> + ? ? ? u32 speed;
> + ? ? ? u8 bits_per_word;
> + ? ? ? unsigned long val;
> +
> + ? ? ? speed = t->speed_hz ? t->speed_hz : spi->max_speed_hz;
> + ? ? ? bits_per_word = t->bits_per_word ? t->bits_per_word ?:
> + ? ? ? ? ? ? ? spi->bits_per_word;
> +
> + ? ? ? tspi->cur_bytes_per_word = (bits_per_word - 1) / 8 + 1;
> +
> + ? ? ? if (speed != tspi->cur_speed)
> + ? ? ? ? ? ? ? clk_set_rate(tspi->clk, speed);
> +
> + ? ? ? if (tspi->cur_speed == 0)
> + ? ? ? ? ? ? ? clk_enable(tspi->clk);
> +
> + ? ? ? tspi->cur_speed = speed;
> +
> + ? ? ? val = spi_tegra_readl(tspi, SLINK_COMMAND2);
> + ? ? ? if (t->rx_buf)
> + ? ? ? ? ? ? ? val |= RXEN;
> + ? ? ? else
> + ? ? ? ? ? ? ? val &= ~RXEN;
> +
> + ? ? ? if (t->tx_buf)
> + ? ? ? ? ? ? ? val |= TXEN;
> + ? ? ? else
> + ? ? ? ? ? ? ? val &= ~TXEN;
> +
> + ? ? ? val &= ~SS_EN_CS(~0);
> + ? ? ? val |= SS_EN_CS(spi->chip_select);
> + ? ? ? val |= SPIE;

Nit: This would be more concise:

+ ? ? ? val &= ~(SS_EN_CS(~0) | RXEN | TXEN);
+ ? ? ? if (t->rx_buf)
+ ? ? ? ? ? ? ? val |= RXEN;
+ ? ? ? if (t->tx_buf)
+ ? ? ? ? ? ? ? val |= TXEN;
+ ? ? ? val |= SS_EN_CS(spi->chip_select);
+ ? ? ? val |= SPIE;


> +
> + ? ? ? spi_tegra_writel(tspi, val, SLINK_COMMAND2);
> +
> + ? ? ? val = spi_tegra_readl(tspi, SLINK_COMMAND);
> + ? ? ? val &= ~BIT_LENGTH(~0);
> + ? ? ? val |= BIT_LENGTH(bits_per_word - 1);
> +
> + ? ? ? /* FIXME: should probably control CS manually so that we can be sure
> + ? ? ? ?* it does not go low between transfer and to support delay_usecs
> + ? ? ? ?* correctly.
> + ? ? ? ?*/
> + ? ? ? val &= ~IDLE_SCLK_MASK & ~CK_SDA & ~CS_SW;
> +
> + ? ? ? if (spi->mode & SPI_CPHA)
> + ? ? ? ? ? ? ? val |= CK_SDA;
> +
> + ? ? ? if (spi->mode & SPI_CPOL)
> + ? ? ? ? ? ? ? val |= IDLE_SCLK_DRIVE_HIGH;
> + ? ? ? else
> + ? ? ? ? ? ? ? val |= IDLE_SCLK_DRIVE_LOW;

nit: IDLE_SCLK_DRIVE_LOW == 0.  The driver will be more concise if the
above 2 lines are dropped.
> +
> + ? ? ? val |= M_S;
> +
> + ? ? ? spi_tegra_writel(tspi, val, SLINK_COMMAND);

The read/modify/write register blocks are quite common.  Would it be
clearer and more concise to have a spi_tegra_clrsetbits() static
inline?

> +
> + ? ? ? spi_tegra_writel(tspi, RX_FLUSH | TX_FLUSH, SLINK_STATUS);
> +
> + ? ? ? tspi->cur = t;
> + ? ? ? tspi->cur_pos = 0;
> + ? ? ? tspi->cur_len = spi_tegra_fill_tx_fifo(tspi, t);
> +
> + ? ? ? spi_tegra_go(tspi);
> +}
> +
> +static void spi_tegra_start_message(struct spi_device *spi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_message *m)
> +{
> + ? ? ? struct spi_transfer *t;
> +
> + ? ? ? m->actual_length = 0;
> +
> + ? ? ? t = list_first_entry(&m->transfers, struct spi_transfer, transfer_list);
> + ? ? ? spi_tegra_start_transfer(spi, t);
> +}
> +
> +static void tegra_spi_rx_dma_complete(struct tegra_dma_req *req)
> +{
> + ? ? ? struct spi_tegra_data *tspi = req->dev;
> + ? ? ? unsigned long flags;
> + ? ? ? struct spi_message *m;
> + ? ? ? struct spi_device *spi;
> + ? ? ? int complete = 0;
> + ? ? ? int timeout = 0;
> + ? ? ? unsigned long val;
> +
> + ? ? ? /* the SPI controller may come back with both the BSY and RDY bits
> + ? ? ? ?* set. ?In this case we need to wait for the BSY bit to clear so
> + ? ? ? ?* that we are sure the DMA is finished. ?1000 reads was empirically
> + ? ? ? ?* determined to be long enough.
> + ? ? ? ?*/
> + ? ? ? while (timeout++ < 1000) {
> + ? ? ? ? ? ? ? if (!(spi_tegra_readl(tspi, SLINK_STATUS) & BSY))
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? }

What happens if the BSY bit is still set when the loop exits?

> +
> + ? ? ? val = spi_tegra_readl(tspi, SLINK_STATUS);
> + ? ? ? val |= RDY;
> + ? ? ? spi_tegra_writel(tspi, val, SLINK_STATUS);

The spin lock isn't held at this point.  Will that make this
read-modify-write operation risky?

> +
> + ? ? ? spin_lock_irqsave(&tspi->lock, flags);

Is there any condition/event which could cause the spi controller to
go busy before obtaining the spinlock?

> +
> + ? ? ? m = list_first_entry(&tspi->queue, struct spi_message, queue);
> + ? ? ? spi = m->state;
> +
> + ? ? ? tspi->cur_pos += spi_tegra_drain_rx_fifo(tspi, tspi->cur);
> + ? ? ? m->actual_length += tspi->cur_pos;
> +
> + ? ? ? if (tspi->cur_pos < tspi->cur->len) {
> + ? ? ? ? ? ? ? tspi->cur_len = spi_tegra_fill_tx_fifo(tspi, tspi->cur);
> + ? ? ? ? ? ? ? spi_tegra_go(tspi);
> + ? ? ? } else if (!list_is_last(&tspi->cur->transfer_list,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&m->transfers)) {
> + ? ? ? ? ? ? ? tspi->cur = ?list_first_entry(&tspi->cur->transfer_list,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_transfer,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? transfer_list);
> + ? ? ? ? ? ? ? spi_tegra_start_transfer(spi, tspi->cur);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? complete = 1;
> + ? ? ? }
> +
> + ? ? ? if (complete) {

Looks like the above else clause is the only thing that can set
complete.  You could delete the above three lines to get the same
behaviour.

> + ? ? ? ? ? ? ? list_del(&m->queue);
> +
> + ? ? ? ? ? ? ? m->status = 0;
> + ? ? ? ? ? ? ? m->complete(m->context);
> +
> + ? ? ? ? ? ? ? if (!list_empty(&tspi->queue)) {
> + ? ? ? ? ? ? ? ? ? ? ? m = list_first_entry(&tspi->queue, struct spi_message,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?queue);
> + ? ? ? ? ? ? ? ? ? ? ? spi = m->state;
> + ? ? ? ? ? ? ? ? ? ? ? spi_tegra_start_message(spi, m);
> + ? ? ? ? ? ? ? } else {
> + ? ? ? ? ? ? ? ? ? ? ? clk_disable(tspi->clk);
> + ? ? ? ? ? ? ? ? ? ? ? tspi->cur_speed = 0;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> + ? ? ? spin_unlock_irqrestore(&tspi->lock, flags);
> +}
> +
> +static int spi_tegra_setup(struct spi_device *spi)
> +{
> + ? ? ? struct spi_tegra_data *tspi = spi_master_get_devdata(spi->master);
> + ? ? ? unsigned long cs_bit;
> + ? ? ? unsigned long val;
> + ? ? ? unsigned long flags;
> +
> + ? ? ? dev_dbg(&spi->dev, "setup %d bpw, %scpol, %scpha, %dHz\n",
> + ? ? ? ? ? ? ? spi->bits_per_word,
> + ? ? ? ? ? ? ? spi->mode & SPI_CPOL ? "" : "~",
> + ? ? ? ? ? ? ? spi->mode & SPI_CPHA ? "" : "~",
> + ? ? ? ? ? ? ? spi->max_speed_hz);
> +
> +
> + ? ? ? switch (spi->chip_select) {
> + ? ? ? case 0:
> + ? ? ? ? ? ? ? cs_bit = CS_POLARITY;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case 1:
> + ? ? ? ? ? ? ? cs_bit = CS_POLARITY1;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case 2:
> + ? ? ? ? ? ? ? cs_bit = CS_POLARITY2;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case 4:
> + ? ? ? ? ? ? ? cs_bit = CS_POLARITY3;
> + ? ? ? ? ? ? ? break;

CS_POLARITY is named a little oddly as it seems to indicate the bit,
not the polarity of the bit.  Would this better be named
CS_BIT0..CS_BIT3?

> +
> + ? ? ? default:
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? spin_lock_irqsave(&tspi->lock, flags);
> +
> + ? ? ? val = spi_tegra_readl(tspi, SLINK_COMMAND);
> + ? ? ? if (spi->mode & SPI_CS_HIGH)
> + ? ? ? ? ? ? ? val |= cs_bit;
> + ? ? ? else
> + ? ? ? ? ? ? ? val &= ~cs_bit;
> + ? ? ? spi_tegra_writel(tspi, val, SLINK_COMMAND);
> +
> + ? ? ? spin_unlock_irqrestore(&tspi->lock, flags);
> +
> + ? ? ? return 0;
> +}
> +
> +static int spi_tegra_transfer(struct spi_device *spi, struct spi_message *m)
> +{
> + ? ? ? struct spi_tegra_data *tspi = spi_master_get_devdata(spi->master);
> + ? ? ? struct spi_transfer *t;
> + ? ? ? unsigned long flags;
> + ? ? ? int was_empty;
> +
> + ? ? ? if (list_empty(&m->transfers) || !m->complete)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? list_for_each_entry(t, &m->transfers, transfer_list) {
> + ? ? ? ? ? ? ? if (t->bits_per_word < 0 || t->bits_per_word > 32)
> + ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? ? ? ? ? if (t->len == 0)
> + ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? ? ? ? ? if (!t->rx_buf && !t->tx_buf)
> + ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? m->state = spi;
> +
> + ? ? ? spin_lock_irqsave(&tspi->lock, flags);
> + ? ? ? was_empty = list_empty(&tspi->queue);
> + ? ? ? list_add_tail(&m->queue, &tspi->queue);
> +
> + ? ? ? if (was_empty)
> + ? ? ? ? ? ? ? spi_tegra_start_message(spi, m);
> +
> + ? ? ? spin_unlock_irqrestore(&tspi->lock, flags);
> +
> + ? ? ? return 0;
> +}
> +
> +static void spi_tegra_cleanup(struct spi_device *spi)
> +{
> + ? ? ? dev_dbg(&spi->dev, "cleanup\n");
> +}
> +
> +static int __init spi_tegra_probe(struct platform_device *pdev)
> +{
> + ? ? ? struct spi_master ? ? ? *master;
> + ? ? ? struct spi_tegra_data ? *tspi;
> + ? ? ? struct resource ? ? ? ? *r;
> + ? ? ? int ret;
> +
> + ? ? ? master = spi_alloc_master(&pdev->dev, sizeof *tspi);
> + ? ? ? if (master == NULL) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "master allocation failed\n");
> + ? ? ? ? ? ? ? return -ENOMEM;
> + ? ? ? }
> +
> + ? ? ? /* the spi->mode bits understood by this driver: */
> + ? ? ? master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +
> + ? ? ? if (pdev->id != -1)
> + ? ? ? ? ? ? ? master->bus_num = pdev->id;
> +
> + ? ? ? master->setup = spi_tegra_setup;
> + ? ? ? master->transfer = spi_tegra_transfer;
> + ? ? ? master->cleanup = spi_tegra_cleanup;
> + ? ? ? master->num_chipselect = 4;
> +
> + ? ? ? dev_set_drvdata(&pdev->dev, master);
> + ? ? ? tspi = spi_master_get_devdata(master);
> + ? ? ? tspi->master = master;
> + ? ? ? tspi->pdev = pdev;
> + ? ? ? spin_lock_init(&tspi->lock);
> +
> + ? ? ? r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + ? ? ? if (r == NULL) {
> + ? ? ? ? ? ? ? ret = -ENODEV;
> + ? ? ? ? ? ? ? goto err0;
> + ? ? ? }
> +
> + ? ? ? tspi->phys = r->start;
> + ? ? ? tspi->base = ioremap(r->start, r->end - r->start + 1);
> + ? ? ? if (!tspi->base) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "can't ioremap iomem\n");
> + ? ? ? ? ? ? ? ret = -ENOMEM;
> + ? ? ? ? ? ? ? goto err1;
> + ? ? ? }
> +
> + ? ? ? tspi->clk = clk_get(&pdev->dev, NULL);
> + ? ? ? if (IS_ERR_OR_NULL(tspi->clk)) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "can not get clock\n");
> + ? ? ? ? ? ? ? ret = PTR_ERR(tspi->clk);
> + ? ? ? ? ? ? ? goto err2;
> + ? ? ? }
> +
> + ? ? ? INIT_LIST_HEAD(&tspi->queue);
> +
> + ? ? ? tspi->rx_dma = tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT);
> + ? ? ? if (IS_ERR(tspi->rx_dma)) {

As an aside, and commenting on the tegra DMA api... Is the IS_ERR()
pattern in the tegra_dma_allocate_channel() return really a good idea
here?  Personally I find that pattern isn't very useful, especially
when the results is either "yes, allocated" or "no, not-alocated", and
it is very easy to write code that tests the wrong thing on the return
value because the compiler cannot catch it.  In other words, if it
isn't vital to return a specific error code, the using the PTR_ERR()
pattern adds unnecessary risk to the code because developers are used
to seeing and writing this pattern:

tspi->rx_dma = tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT);
if (!tspi->rx_dma)
	return -ENOMEM;

The compiler won't catch it if the return value is an PTR_ERR.

(I know that some subsystems make heavy use of it, particularly
filesystems and the block layer which do need to return specific error
codes to userspace.  My argument is that the specific error code is
probably irrelevant when allocating DMA channels)

> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "can not allocate rx dma channel\n");
> + ? ? ? ? ? ? ? ret = PTR_ERR(tspi->rx_dma);
> + ? ? ? ? ? ? ? goto err3;
> + ? ? ? }
> +
> + ? ? ? tspi->rx_bb = dma_alloc_coherent(&pdev->dev, sizeof(u32) * BB_LEN,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&tspi->rx_bb_phys, GFP_KERNEL);
> + ? ? ? if (!tspi->rx_bb) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "can not allocate rx bounce buffer\n");
> + ? ? ? ? ? ? ? ret = -ENOMEM;
> + ? ? ? ? ? ? ? goto err4;
> + ? ? ? }
> +
> + ? ? ? tspi->rx_dma_req.complete = tegra_spi_rx_dma_complete;
> + ? ? ? tspi->rx_dma_req.to_memory = 1;
> + ? ? ? tspi->rx_dma_req.dest_addr = tspi->rx_bb_phys;
> + ? ? ? tspi->rx_dma_req.dest_bus_width = 32;
> + ? ? ? tspi->rx_dma_req.source_addr = tspi->phys + SLINK_RX_FIFO;
> + ? ? ? tspi->rx_dma_req.source_bus_width = 32;
> + ? ? ? tspi->rx_dma_req.source_wrap = 4;
> + ? ? ? tspi->rx_dma_req.req_sel = spi_tegra_req_sels[pdev->id];
> + ? ? ? tspi->rx_dma_req.dev = tspi;
> +
> + ? ? ? ret = spi_register_master(master);
> +
> + ? ? ? if (ret < 0)
> + ? ? ? ? ? ? ? goto err5;
> +
> + ? ? ? return ret;
> +
> +err5:
> + ? ? ? dma_free_coherent(&pdev->dev, sizeof(u32) * BB_LEN,
> + ? ? ? ? ? ? ? ? ? ? ? ? tspi->rx_bb, tspi->rx_bb_phys);
> +err4:
> + ? ? ? tegra_dma_free_channel(tspi->rx_dma);
> +err3:
> + ? ? ? clk_put(tspi->clk);
> +err2:
> + ? ? ? iounmap(tspi->base);
> +err1:
> + ? ? ? release_mem_region(r->start, (r->end - r->start) + 1);

Since this version doesn't request_mem_region(), this release is
dangling.  (However, as rmk pointed out the request_mem_region() was
completely fine and the driver should continue to use it.  Sorry for
the noise).

> +err0:
> + ? ? ? spi_master_put(master);
> + ? ? ? return ret;
> +}
> +
> +static int __devexit spi_tegra_remove(struct platform_device *pdev)
> +{
> + ? ? ? struct spi_master ? ? ? *master;
> + ? ? ? struct spi_tegra_data ? *tspi;
> +
> + ? ? ? master = dev_get_drvdata(&pdev->dev);
> + ? ? ? tspi = spi_master_get_devdata(master);
> +
> + ? ? ? tegra_dma_free_channel(tspi->rx_dma);
> +
> + ? ? ? dma_free_coherent(&pdev->dev, sizeof(u32) * BB_LEN,
> + ? ? ? ? ? ? ? ? ? ? ? ? tspi->rx_bb, tspi->rx_bb_phys);
> +
> + ? ? ? clk_put(tspi->clk);
> + ? ? ? iounmap(tspi->base);
> +
> + ? ? ? spi_master_put(master);
> +
> + ? ? ? return 0;
> +}
> +
> +MODULE_ALIAS("platform:spi_tegra");
> +
> +static struct platform_driver spi_tegra_driver = {
> + ? ? ? .driver = {
> + ? ? ? ? ? ? ? .name = ? ? ? ? "spi_tegra",
> + ? ? ? ? ? ? ? .owner = ? ? ? ?THIS_MODULE,
> + ? ? ? },
> + ? ? ? .remove = ? ? ? __devexit_p(spi_tegra_remove),
> +};
> +
> +static int __init spi_tegra_init(void)
> +{
> + ? ? ? return platform_driver_probe(&spi_tegra_driver, spi_tegra_probe);
> +}
> +subsys_initcall(spi_tegra_init);

Unless there is a specific reason that this driver needs to be
initialized earlier, it should use the module_init() call.  In which
case the reason it is initialized early should be documented with a
comment.  (for reference: 4 of the mainlined spi bus drivers use
subsys_initcall() whereas 30 of them use module_init()..  1 uses
device_initcall() which is the same as module_init.  None of the ones
using subsys_initcall() give a reason why.)

g.
