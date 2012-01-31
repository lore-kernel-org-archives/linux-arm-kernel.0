From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 31 Jan 2012 15:06:43 +0800
Subject: [PATCH v2 RESEND] SPI: add CSR SiRFprimaII SPI controller driver
In-Reply-To: <20120130184457.GM28397@ponder.secretlab.ca>
References: <1323851007-29838-1-git-send-email-Barry.Song@csr.com>
 <20120130184457.GM28397@ponder.secretlab.ca>
Message-ID: <CAGsJ_4y72w8EZet72h6T-xBoD4ZFwKm0xSnhCJ=r2P4Q7emx2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Grant,
Thanks!

2012/1/31 Grant Likely <grant.likely@secretlab.ca>:
> On Wed, Dec 14, 2011 at 04:23:27PM +0800, Barry Song wrote:
>> From: Zhiwu Song <zhiwu.song@csr.com>
>>
>> CSR SiRFprimaII has two SPIs (SPI0 and SPI1). Features:
>> * Master and slave modes
>> * 8-/12-/16-/32-bit data unit
>> * 256 bytes receive data FIFO and 256 bytes transmit data FIFO
>> * Multi-unit frame
>> * Configurable SPI_EN (chip select pin) active state
>> * Configurable SPI_CLK polarity
>> * Configurable SPI_CLK phase
>> * Configurable MSB/LSB first
>>
>> Signed-off-by: Zhiwu Song <zhiwu.song@csr.com>
>> Signed-off-by: Barry Song <Barry.Song@csr.com>
>
> Hi Barry,
>
> Comments below. ?Most are minor, but there are a few things
> that need to be fixed before I can pick up this patch.
>
> g.
>
>> ---
>> ?-v2:
>> ? fix bundle of minor issues Wolfram Sang pointed out;
>> ? use Wolfram Sang's new devm_request_and_ioremap() api, refer to:
>> ? ? https://lkml.org/lkml/2011/10/25/226
>>
>> ?drivers/spi/Kconfig ? ? ? ? ?| ? ?7 +
>> ?drivers/spi/Makefile ? ? ? ? | ? ?1 +
>> ?drivers/spi/spi-sirf.c ? ? ? | ?627 ++++++++++++++++++++++++++++++++++++++++++
>> ?include/linux/spi/spi-sirf.h | ? 27 ++
>> ?4 files changed, 662 insertions(+), 0 deletions(-)
>> ?create mode 100644 drivers/spi/spi-sirf.c
>> ?create mode 100644 include/linux/spi/spi-sirf.h
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index a1fd73d..3dccd54 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -325,6 +325,13 @@ config SPI_SH_SCI
>> ? ? ? help
>> ? ? ? ? SPI driver for SuperH SCI blocks.
>>
>> +config SPI_SIRF
>> + ? ? ? ?tristate "CSR SiRFprimaII SPI controller"
>> + ? ? depends on ARCH_PRIMA2
>> + ? ? select SPI_BITBANG
>> + ? ? help
>> + ? ? ? SPI driver for CSR SiRFprimaII SoCs
>> +
>> ?config SPI_STMP3XXX
>> ? ? ? tristate "Freescale STMP37xx/378x SPI/SSP controller"
>> ? ? ? depends on ARCH_STMP3XXX && SPI_MASTER
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index 61c3261..e919846 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -51,6 +51,7 @@ obj-$(CONFIG_SPI_S3C64XX) ? ? ? ? ? += spi-s3c64xx.o
>> ?obj-$(CONFIG_SPI_SH) ? ? ? ? ? ? ? ? += spi-sh.o
>> ?obj-$(CONFIG_SPI_SH_MSIOF) ? ? ? ? ? += spi-sh-msiof.o
>> ?obj-$(CONFIG_SPI_SH_SCI) ? ? ? ? ? ? += spi-sh-sci.o
>> +obj-$(CONFIG_SPI_SIRF) ? ? ? ? ? ? ? += spi-sirf.o
>> ?obj-$(CONFIG_SPI_STMP3XXX) ? ? ? ? ? += spi-stmp.o
>> ?obj-$(CONFIG_SPI_TEGRA) ? ? ? ? ? ? ? ? ? ? ?+= spi-tegra.o
>> ?obj-$(CONFIG_SPI_TI_SSP) ? ? ? ? ? ? += spi-ti-ssp.o
>> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
>> new file mode 100644
>> index 0000000..fc38e97
>> --- /dev/null
>> +++ b/drivers/spi/spi-sirf.c
>> @@ -0,0 +1,627 @@
>> +/*
>> + * SPI bus driver for CSR SiRFprimaII
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/bitops.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/spi/spi_bitbang.h>
>> +#include <linux/pinctrl/pinmux.h>
>> +#include <linux/spi/spi-sirf.h>
>> +
>> +#define DRIVER_NAME "sirfsoc_spi"
>> +
>> +#define SPI_CTRL ? ? ? ? ? ? 0x0000 ?/* SPI controller configuration register */
>> +#define SPI_CMD ? ? ? ? ? ? ? ? ? ? ?0x0004 ?/* SPI command register */
>> +#define SPI_TX_RX_EN ? ? ? ? 0x0008 ?/* SPI interface transfer enable register */
>> +#define SPI_INT_EN ? ? ? ? ? 0x000C ?/* SPI interrupt enable register */
>> +#define SPI_INT_STATUS ? ? ? ? ? ? ? 0x0010 ?/* SPI interrupt register */
>> +#define SPI_TX_DMA_IO_CTRL ? 0x0100 ?/* SPI TXFIFO DMA/IO register */
>> +#define SPI_TX_DMA_IO_LEN ? ?0x0104 ?/* SPI transmit data length register */
>> +#define SPI_TXFIFO_CTRL ? ? ? ? ? ? ?0x0108 ?/* SPI TXFIFO control register */
>> +#define SPI_TXFIFO_LEVEL_CHK 0x010C ?/* SPI TXFIFO check level register */
>> +#define SPI_TXFIFO_OP ? ? ? ? ? ? ? ?0x0110 ?/* SPI TXFIFO operation register */
>> +#define SPI_TXFIFO_STATUS ? ?0x0114 ?/* SPI TXFIFO status register */
>> +#define SPI_TXFIFO_DATA ? ? ? ? ? ? ?0x0118 ?/* SPI TXFIFO bottom */
>> +#define SPI_RX_DMA_IO_CTRL ? 0x0120 ?/* SPI RXFIFO DMA/IO register */
>> +#define SPI_RX_DMA_IO_LEN ? ?0x0124 ?/* SPI receive length register */
>> +#define SPI_RXFIFO_CTRL ? ? ? ? ? ? ?0x0128 ?/* SPI RXFIFO control register */
>> +#define SPI_RXFIFO_LEVEL_CHK 0x012C ?/* SPI RXFIFO check level register */
>> +#define SPI_RXFIFO_OP ? ? ? ? ? ? ? ?0x0130 ?/* SPI RXFIFO operation register */
>> +#define SPI_RXFIFO_STATUS ? ?0x0134 ?/* SPI RXFIFO status register */
>> +#define SPI_RXFIFO_DATA ? ? ? ? ? ? ?0x0138 ?/* SPI RXFIFO bottom */
>> +#define SLV_RX_SAMPLE_MODE ? 0x0140 ?/* Rx sample mode when slave mode */
>> +#define DUMMY_DELAY_CTRL ? ? 0x0144 ?/* Control reg when insert dummy delay */
>> +
>> +/* SPI CTRL register defines */
>> +#define SLV_MODE ? ? ? ? ? ? BIT(16)
>> +#define CMD_MODE ? ? ? ? ? ? BIT(17)
>> +#define CS_IO_OUT ? ? ? ? ? ?BIT(18)
>> +#define CS_IO_MODE ? ? ? ? ? BIT(19)
>> +#define CLK_IDLE_STAT ? ? ? ? ? ? ? ?BIT(20)
>> +#define CS_IDLE_STAT ? ? ? ? BIT(21)
>> +#define TRAN_MSB ? ? ? ? ? ? BIT(22)
>> +#define DRV_POS_EDGE ? ? ? ? BIT(23)
>> +#define CS_HOLD_TIME ? ? ? ? BIT(24)
>> +#define CLK_SAMPLE_MODE ? ? ? ? ? ? ?BIT(25)
>> +#define TRAN_DAT_FORMAT_8 ? ?(0 << 26)
>> +#define TRAN_DAT_FORMAT_12 ? (1 << 26)
>> +#define TRAN_DAT_FORMAT_16 ? (2 << 26)
>> +#define TRAN_DAT_FORMAT_32 ? (3 << 26)
>> +#define CMD_BYTE_NUM(x) ? ? ? ? ? ? ?((x & 3) << 28)
>> +#define ENA_AUTO_CLR ? ? ? ? BIT(30)
>> +#define MUL_DAT_MODE ? ? ? ? BIT(31)
>> +
>> +/* Interrupt Enable */
>> +#define RX_DONE_INT_EN ? ? ? ? ? ? ? BIT(0)
>> +#define TX_DONE_INT_EN ? ? ? ? ? ? ? BIT(1)
>> +#define RX_OFLOW_INT_EN ? ? ? ? ? ? ?BIT(2)
>> +#define TX_UFLOW_INT_EN ? ? ? ? ? ? ?BIT(3)
>> +#define RX_IO_DMA_INT_EN ? ? BIT(4)
>> +#define TX_IO_DMA_INT_EN ? ? BIT(5)
>> +#define RXFIFO_FULL_INT_EN ? BIT(6)
>> +#define TXFIFO_EMPTY_INT_EN ?BIT(7)
>> +#define RXFIFO_THD_INT_EN ? ?BIT(8)
>> +#define TXFIFO_THD_INT_EN ? ?BIT(9)
>> +#define FRM_END_INT_EN ? ? ? ? ? ? ? BIT(10)
>> +
>> +#define INT_MASK_ALL ? ? ? ? 0x1FFF
>> +
>> +/* Interrupt status */
>> +#define RX_DONE ? ? ? ? ? ? ? ? ? ? ?BIT(0)
>> +#define TX_DONE ? ? ? ? ? ? ? ? ? ? ?BIT(1)
>> +#define RX_OFLOW ? ? ? ? ? ? BIT(2)
>> +#define TX_UFLOW ? ? ? ? ? ? BIT(3)
>> +#define DMA_IO_RX_DONE ? ? ? ? ? ? ? BIT(4)
>> +#define DMA_IO_TX_DONE ? ? ? ? ? ? ? BIT(5)
>> +#define RXFIFO_FULL ? ? ? ? ?BIT(6)
>> +#define TXFIFO_EMPTY ? ? ? ? BIT(7)
>> +#define RXFIFO_THD_REACH ? ? BIT(8)
>> +#define TXFIFO_THD_REACH ? ? BIT(9)
>> +#define FRM_END ? ? ? ? ? ? ? ? ? ? ?BIT(10)
>> +
>> +/* TX RX enable */
>> +#define SPI_RX_EN ? ? ? ? ? ?BIT(0)
>> +#define SPI_TX_EN ? ? ? ? ? ?BIT(1)
>> +#define SPI_CMD_TX_EN ? ? ? ? ? ? ? ?BIT(2)
>> +
>> +#define IO_MODE_SEL ? ? ? ? ?BIT(0)
>> +#define RX_DMA_FLUSH ? ? ? ? BIT(2)
>> +
>> +/* FIFO OPs */
>> +#define FIFO_RESET ? ? ? ? ? BIT(0)
>> +#define FIFO_START ? ? ? ? ? BIT(1)
>> +
>> +/* FIFO CTRL */
>> +#define FIFO_WIDTH_BYTE ? ? ? ? ? ? ?(0 << 0)
>> +#define FIFO_WIDTH_WORD ? ? ? ? ? ? ?(1 << 0)
>> +#define FIFO_WIDTH_DWORD ? ? (2 << 0)
>> +
>> +/* FIFO Status */
>> +#define ? ? ?FIFO_LEVEL_MASK ? ? ? ? 0xFF
>> +#define FIFO_FULL ? ? ? ? ? ?BIT(8)
>> +#define FIFO_EMPTY ? ? ? ? ? BIT(9)
>> +
>> +/* 256 bytes rx/tx FIFO */
>> +#define FIFO_SIZE ? ? ? ? ? ?256
>> +#define DATA_FRAME_LEN_MAX ? (64 * 1024)
>> +
>> +#define FIFO_SC(x) ? ? ? ? ? ((x) & 0x3F)
>> +#define FIFO_LC(x) ? ? ? ? ? (((x) & 0x3F) << 10)
>> +#define FIFO_HC(x) ? ? ? ? ? (((x) & 0x3F) << 20)
>> +#define FIFO_THD(x) ? ? ? ? ?(((x) & 0xFF) << 2)
>
> These are a lot of #defines; most of which are unused, and they aren't
> prefixed with something like "SIRFSOC_". ?That's just asking for
> collisions with the global namespace. ?Trim the unused ones and add a
> prefix to the rest of them.

agree.

>
>> +
>> +struct sirfsoc_spi {
>> + ? ? struct spi_bitbang bitbang;
>> + ? ? struct completion done;
>> +
>> + ? ? u32 irq;
>> + ? ? void __iomem *base;
>> + ? ? u32 ctrl_freq; ?/* SPI controller clock speed */
...
>> +
>> +static void spi_sirfsoc_tasklet_tx(unsigned long arg)
>> +{
>> + ? ? struct sirfsoc_spi *sspi = (struct sirfsoc_spi *)arg;
>> + ? ? u32 word = 0;
>> +
>> + ? ? /* Fill Tx FIFO while there are left words to be transmitted */
>> + ? ? while (!((readl(sspi->base + SPI_TXFIFO_STATUS) & FIFO_FULL))
>> + ? ? ? ? ? ?&& sspi->left_tx_cnt) {
>> + ? ? ? ? ? ? if (sspi->tx)
>> + ? ? ? ? ? ? ? ? ? ? word = sspi->pop_tx_word(sspi);
>> + ? ? ? ? ? ? writel(word, sspi->base + SPI_TXFIFO_DATA);
>> + ? ? ? ? ? ? sspi->left_tx_cnt--;
>> + ? ? }
>> +}
>> +
>> +static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
>> +{
>> + ? ? struct sirfsoc_spi *sspi = dev_id;
>> + ? ? u32 spi_stat = readl(sspi->base + SPI_INT_STATUS);
>> + ? ? u32 word = 0;
>> +
>> + ? ? writel(spi_stat, sspi->base + SPI_INT_STATUS);
>> +
>> + ? ? /* Error Conditions */
>> + ? ? if (spi_stat & RX_OFLOW || spi_stat & TX_UFLOW) {
>> + ? ? ? ? ? ? complete(&sspi->done);
>> + ? ? ? ? ? ? writel(0x0, sspi->base + SPI_INT_EN);
>> + ? ? }
>> +
>> + ? ? if (spi_stat & FRM_END) {
>> + ? ? ? ? ? ? while (!((readl(sspi->base + SPI_RXFIFO_STATUS)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? & FIFO_EMPTY)) && sspi->left_rx_cnt) {
>> + ? ? ? ? ? ? ? ? ? ? word = readl(sspi->base + SPI_RXFIFO_DATA);
>> + ? ? ? ? ? ? ? ? ? ? if (sspi->rx)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? sspi->enq_rx_word(word, sspi);
>> +
>> + ? ? ? ? ? ? ? ? ? ? sspi->left_rx_cnt--;
>> + ? ? ? ? ? ? }
>
> I'm not rejecting the patch over this, but this code is inefficient
> since it results in a function call for each and every word transfer.
> It would be more efficient to code the readl() into each of the
> transfer functions. ?Same goes for the pop_tx_word()

i suppose you mean moving readl() to enq_rx_word() and moving writel()
to pop_tx_word(), i am ok.

>> +
>> +static int __devinit spi_sirfsoc_probe(struct platform_device *dev)
>
> Nit: Use "*pdev" instead of pdev. ?Makes it easier to tell when the
> code is referencing a struct platform_device instead of struct device.
>

agree.

>> +{
>> + ? ? struct sirfsoc_spi *sspi;
>> + ? ? struct spi_master *master;
>> + ? ? struct resource *mem_res;
>> + ? ? int ret;
>> +
>> + ? ? master = spi_alloc_master(&dev->dev, sizeof(*sspi));
>> + ? ? if (master == NULL) {
>> + ? ? ? ? ? ? dev_err(&dev->dev, "Unable to allocate SPI master\n");
>> + ? ? ? ? ? ? return -ENOMEM;
>> + ? ? }
>> + ? ? platform_set_drvdata(dev, master);
>> + ? ? sspi = spi_master_get_devdata(master);
>> +
>> + ? ? mem_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>> + ? ? if (mem_res == NULL) {
>> + ? ? ? ? ? ? dev_err(&dev->dev, "Unable to get IO resource\n");
>> + ? ? ? ? ? ? ret = -ENOMEM;
>> + ? ? ? ? ? ? goto free_master;
>> + ? ? }
>> +
>> + ? ? sspi->base = devm_request_and_ioremap(&dev->dev, mem_res);
>> + ? ? if (sspi->base == NULL) {
>> + ? ? ? ? ? ? dev_err(&dev->dev, "IO remap failed!\n");
>> + ? ? ? ? ? ? ret = -ENOMEM;
>> + ? ? ? ? ? ? goto free_master;
>> + ? ? }
>
> ... This is a common pattern. ?It would be nice to have a
> platform_devm_request_and_ioremap() helper. ?Bonus points if you
> implement one, but I won't reject the patch over that.

ok. i will launch platform_devm_request_and_ioremap() helper.

>
>> +
>> + ? ? if (of_property_read_u32(dev->dev.of_node, "cell-index", &dev->id)) {
>> + ? ? ? ? ? ? dev_err(&dev->dev, "Fail to get index\n");
>> + ? ? ? ? ? ? ret = -ENODEV;
>> + ? ? ? ? ? ? goto free_master;
>> + ? ? }
>
> This looks like a bad binding. ?Why do you want to use 'cell-index'?
> The pdev->id really shouldn't matter since when using the device tree
> the spi bus number is expected to be dynamically assigned.

ok.
>
>> + ? ? writel(FIFO_START, sspi->base + SPI_TXFIFO_OP);
>> + ? ? writel(0, sspi->base + DUMMY_DELAY_CTRL); ? ? ? /* We are not using dummy delay between command and data */
>
> Nit: line longer than 80 chars; this just looks ugly

ok. move to

  /* We are not using dummy delay between command and data */
writel(0, sspi->base + DUMMY_DELAY_CTRL);

>
>> +
>> + ? ? ret = spi_bitbang_start(&sspi->bitbang);
>> + ? ? if (ret != 0)
>
> Nit: if (!ret)
>

ok

>> +
>> +static const struct of_device_id spi_sirfsoc_of_match[] = {
>> + ? ? { .compatible = "sirf,prima2-spi", },
>> + ? ? {}
>
> Need documentation for this new "sirf,prima2-spi" binding in
> Documentation/devicetree/bindings.

ok.

>
>> +};
>> +MODULE_DEVICE_TABLE(of, sirfsoc_spi_of_match);
>> +
>> +static struct platform_driver spi_sirfsoc_driver = {
>> + ? ? .driver = {
>> + ? ? ? ? ? ? .name = DRIVER_NAME,
>> + ? ? ? ? ? ? .owner = THIS_MODULE,
>> +#ifdef CONFIG_PM
>> + ? ? ? ? ? ? .pm ? ? = &spi_sirfsoc_pm_ops,
>> +#endif
>> + ? ? ? ? ? ? .of_match_table = spi_sirfsoc_of_match,
>> + ? ? },
>> + ? ? .probe = spi_sirfsoc_probe,
>> + ? ? .remove = __devexit_p(spi_sirfsoc_remove),
>> +};
>> +module_platform_driver(spi_sirfsoc_driver);
>> +
>> +MODULE_DESCRIPTION("SiRF SoC SPI master driver");
>> +MODULE_AUTHOR("Zhiwu Song <Zhiwu.Song@csr.com>, "
>> + ? ? ? ? ? ? "Barry Song <Baohua.Song@csr.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/spi/spi-sirf.h b/include/linux/spi/spi-sirf.h
>> new file mode 100644
>> index 0000000..0e647b0
>> --- /dev/null
>> +++ b/include/linux/spi/spi-sirf.h
>> @@ -0,0 +1,27 @@
>> +/*
>> + * include/linux/spi/spi_sirfsoc.h
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#ifndef __SIRFSOC_SPI_H__
>> +#define __SIRFSOC_SPI_H__
>> +
>> +struct sirfsoc_spi_ctrldata {
>> + ? ? int cs_type;
>> + ? ? void (*chip_select) (void);
>> + ? ? void (*chip_deselect) (void);
>> + ? ? int cs_hold_clk;
>> +};
>
> How is this used? ?I see only one reference to sirfsoc_spi_ctrldata in
> the driver code, and nowhere where the pointer is set. ?It isn't
> something that can be set by the spi_device driver because
> controller_data is intended to be private to the spi bus driver.

that was planned to set in arch/arm/mach-prima2 by capturing
BUS_NOTIFY_ADD_DEVICE notifier and binding a sirfsoc_spi_ctrldata to a
new registerred spi_device.
the chipselect might be HW_CTRL(only one cs pin), might be GPIO or it
might be from another MCU, so the plan was implementing different cs
callbacks in mach-prima2.

>
> g.
>

Thanks
barry
