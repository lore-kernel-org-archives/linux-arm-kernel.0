From: leilk.liu@mediatek.com (lei liu)
Date: Thu, 13 Aug 2015 14:29:24 +0800
Subject: [v5,2/3] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <CANMq1KBNz7u0XHQBwmJjLbXyT0twxnfFJ7Hn1Cp8HmnKdOdduw@mail.gmail.com>
References: <1438931991-17044-3-git-send-email-leilk.liu@mediatek.com>
 <CANMq1KBNz7u0XHQBwmJjLbXyT0twxnfFJ7Hn1Cp8HmnKdOdduw@mail.gmail.com>
Message-ID: <1439447364.21454.44.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> 
> Since you are using readl/writel, please import linux/io.h as well (it
> is implicitly imported by spi/spi.h, but better be safe...)
> 
OK, I'll fix it.

> > +#include <linux/ioport.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>

> > +
> > +#define SPI_CMD_ACT_OFFSET                0
> > +#define SPI_CMD_RESUME_OFFSET             1
> > +#define SPI_CMD_CPHA_OFFSET               8
> > +#define SPI_CMD_CPOL_OFFSET               9
> > +#define SPI_CMD_TXMSBF_OFFSET             12
> > +#define SPI_CMD_RXMSBF_OFFSET             13
> > +#define SPI_CMD_RX_ENDIAN_OFFSET          14
> > +#define SPI_CMD_TX_ENDIAN_OFFSET          15
> 
> It feels error-prone that you are defining these offsets here, then
> redefining the bits just below.
> 
> Looking at the code, I think it's better if you remove these
> SPI_CMD_*_OFFSET defines, and only use the BIT(x) defines below.
> 
OK, I will remove those defines.

> > +#define SPI_CMD_RST                  BIT(2)
> > +#define SPI_CMD_PAUSE_EN             BIT(4)
> > +#define SPI_CMD_DEASSERT             BIT(5)
> > +#define SPI_CMD_CPHA                 BIT(8)
> > +#define SPI_CMD_CPOL                 BIT(9)
> > +#define SPI_CMD_RX_DMA               BIT(10)
> > +#define SPI_CMD_TX_DMA               BIT(11)
> > +#define SPI_CMD_TXMSBF               BIT(12)
> > +#define SPI_CMD_RXMSBF               BIT(13)
> > +#define SPI_CMD_RX_ENDIAN            BIT(14)
> > +#define SPI_CMD_TX_ENDIAN            BIT(15)
> > +#define SPI_CMD_FINISH_IE            BIT(16)
> > +#define SPI_CMD_PAUSE_IE             BIT(17)
> > +

> > +
> > +struct mtk_spi_compatible {
> > +       u32 need_pad_sel;
> > +       u32 must_tx;
> 
> Since the quirks are true/false, define these as bool, and remove
> MTK_SPI_QUIRK_PAD_SELECT/MTK_SPI_QUIRK_MUST_TX. Move the comment here
> too.
> 
OK. I will fix it.

> > +};
> > +

> > +static const struct mtk_spi_compatible mt6589_compat = {
> > +       .need_pad_sel = 0,
> > +       .must_tx = 0,
> > +};
> > +
> > +static const struct mtk_spi_compatible mt8135_compat = {
> > +       .need_pad_sel = 0,
> > +       .must_tx = 0,
> > +};
> 
> You don't need to set these explicitly to 0/false.
> 
OK, I will fix it.

> > +
> > +static const struct mtk_spi_compatible mt8173_compat = {
> > +       .need_pad_sel = MTK_SPI_QUIRK_PAD_SELECT,
> > +       .must_tx = MTK_SPI_QUIRK_MUST_TX,
> 
> Then you can set those as "true".
> 
OK, I will fix it.

> > +};
> > +
> > +/*
> > + * A piece of default chip info unless the platform
> > + * supplies it.
> > + */
> > +static const struct mtk_chip_config mtk_default_chip_info = {
> > +       .rx_mlsb = 1,
> > +       .tx_mlsb = 1,
> > +       .tx_endian = 0,
> > +       .rx_endian = 0,
> > +};
> > +

> > +
> > +       trans = list_first_entry(&msg->transfers, struct spi_transfer,
> > +                                transfer_list);
> > +       if (trans->cs_change == 0) {
> 
> !trans->cs_change
> 
OK, I  will fix it.

> > +               mdata->state = MTK_SPI_IDLE;
> > +               mtk_spi_reset(mdata);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int mtk_spi_unprepare_hardware(struct spi_master *master)
> > +{
> > +       struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +
> > +       clk_disable_unprepare(mdata->spi_clk);
> > +
> > +       return 0;
> > +}
> 
> In this case, prepare_hardware/unprepare_hardware is redundant with
> pm_runtime (apart from the cs_change check, possibly).
> 
> If PM_RUNTIME is disabled, leave the clock enabled all the time, if
> not enable/disable in pm_runtime functions (as you already do)
> 
> See https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/commit/?id=db91841b58f9ad0ecbb81ed0fa496c3a1b67fd63
> "spi/omap100k: Convert to runtime PM" for an example (it's one of the
> last driver that used prepare/unprepare calls, and got converted to
> pm_runtime)
> 
OK, I'll fix it.

> > +static int mtk_spi_prepare_message(struct spi_master *master,
> > +                                  struct spi_message *msg)
> > +{
> > +       u32 reg_val;
> > +       u8 cpha, cpol;
> > +       struct mtk_chip_config *chip_config;
> > +       struct spi_device *spi = msg->spi;
> > +       struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +
> > +       cpha = spi->mode & SPI_CPHA ? 1 : 0;
> > +       cpol = spi->mode & SPI_CPOL ? 1 : 0;
> > +
> > +       reg_val = readl(mdata->base + SPI_CMD_REG);
> > +       reg_val &= ~(SPI_CMD_CPHA | SPI_CMD_CPOL);
> > +       reg_val |= (cpha << SPI_CMD_CPHA_OFFSET);
> > +       reg_val |= (cpol << SPI_CMD_CPOL_OFFSET);
> 
> This can actually be simplified a bit by using
> SPI_CMD_CPHA/SPI_CMD_CPOL instead.
> 
OK, I will fix it.

> > +       writel(reg_val, mdata->base + SPI_CMD_REG);
> > +

> > +
> > +static void mtk_spi_prepare_transfer(struct spi_master *master,
> > +                                    struct spi_transfer *xfer)
> > +{
> > +       u32 spi_clk_hz, div, high_time, low_time, holdtime,
> > +           setuptime, cs_idletime, reg_val = 0;
> > +       struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +
> > +       spi_clk_hz = clk_get_rate(mdata->spi_clk);
> > +       if (xfer->speed_hz < spi_clk_hz / 2)
> > +               div = DIV_ROUND_UP(spi_clk_hz, xfer->speed_hz);
> > +       else
> > +               div = 1;
> > +
> > +       high_time = (div + 1) / 2;
> > +       low_time = (div + 1) / 2;
> > +       holdtime = (div + 1) / 2 * 2;
> > +       setuptime = (div + 1) / 2 * 2;
> > +       cs_idletime = (div + 1) / 2 * 2;
> 
> Why setting variables with the exact same value? Can you do with just 2?
> 
OK, I'll fix it.

> > +       reg_val |= (((high_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
> > +       reg_val |= (((low_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
> > +       reg_val |= (((holdtime - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
> > +       reg_val |= (((setuptime - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
> 
> Not sure of the details, but can you guarantee this will never
> overflow? I.e. can div be larger than 256?
> 
If xfer->speed_hz is too small, maybe div may be larger than 256, but
0xff will mask div here, so I think it doesn't matter.


> > +       writel(reg_val, mdata->base + SPI_CFG0_REG);
> > +
> > +       reg_val = readl(mdata->base + SPI_CFG1_REG);
> > +       reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
> > +       reg_val |= (((cs_idletime - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
> > +       writel(reg_val, mdata->base + SPI_CFG1_REG);
> > +}
> > +
> > +static void mtk_spi_setup_packet(struct spi_master *master)
> > +{
> > +       u32 packet_size, packet_loop, reg_val;
> > +       struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +
> > +       packet_size = min_t(unsigned, mdata->xfer_len, MTK_SPI_PACKET_SIZE);
> 
> u32 instead of unsigned.
OK, I will fix it.

> 
> > +       packet_loop = mdata->xfer_len / packet_size;
> > +
> > +       reg_val = readl(mdata->base + SPI_CFG1_REG);
> > +       reg_val &= ~(SPI_CFG1_PACKET_LENGTH_MASK + SPI_CFG1_PACKET_LOOP_MASK);
> 
> Use |, not +.
OK, I will fix it.

> 
> > +       reg_val |= (packet_size - 1) << SPI_CFG1_PACKET_LENGTH_OFFSET;
> > +       reg_val |= (packet_loop - 1) << SPI_CFG1_PACKET_LOOP_OFFSET;
> 
> Can packet_loop be >256?
> 
packet_loop can never be >256. If packet_loop=256, the xfer_len will be
256*1024 bytes. It's not possible because packet_loop is from
mdata->xfer_len / packet_size, mdata->xfer_len is from sg_dma_len(). 

> > +       writel(reg_val, mdata->base + SPI_CFG1_REG);
> > +}
> > +
> > +static void mtk_spi_enable_transfer(struct spi_master *master)
> > +{
> > +       int cmd;
> 
> u32
> 
OK. I will fix it.

> > +       struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +
> > +       cmd = readl(mdata->base + SPI_CMD_REG);
> > +       if (mdata->state == MTK_SPI_IDLE)
> > +               cmd |= 1 << SPI_CMD_ACT_OFFSET;
> > +       else
> > +               cmd |= 1 << SPI_CMD_RESUME_OFFSET;
> > +       writel(cmd, mdata->base + SPI_CMD_REG);
> > +}
> > +
> > +static int mtk_spi_get_mult_delta(int xfer_len)
> 
> xfer_len is a u32, so should be mult_delta.
> 
OK, I'll fix it.

> > +{
> > +       int mult_delta;
> > +
> > +       if (xfer_len > MTK_SPI_PACKET_SIZE)
> > +               mult_delta = xfer_len % MTK_SPI_PACKET_SIZE;
> > +       else
> > +               mult_delta = 0;
> > +
> > +       return mult_delta;
> > +}
> > +
> > +static void mtk_spi_update_mdata_len(struct spi_master *master)
> > +{
> > +       int mult_delta;
> > +       struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +
> > +       if (mdata->tx_sgl_len && mdata->rx_sgl_len) {
> > +               if (mdata->tx_sgl_len > mdata->rx_sgl_len) {
> > +                       mult_delta = mtk_spi_get_mult_delta(mdata->rx_sgl_len);
> > +                       mdata->xfer_len = mdata->rx_sgl_len - mult_delta;
> > +                       mdata->rx_sgl_len = mult_delta;
> > +                       mdata->tx_sgl_len -= mdata->xfer_len;
> > +               } else {
> > +                       mult_delta = mtk_spi_get_mult_delta(mdata->tx_sgl_len);
> > +                       mdata->xfer_len = mdata->tx_sgl_len - mult_delta;
> > +                       mdata->tx_sgl_len = mult_delta;
> > +                       mdata->rx_sgl_len -= mdata->xfer_len;
> > +               }
> > +       } else if (mdata->tx_sgl_len) {
> > +               mult_delta = mtk_spi_get_mult_delta(mdata->tx_sgl_len);
> > +               mdata->xfer_len = mdata->tx_sgl_len - mult_delta;
> > +               mdata->tx_sgl_len = mult_delta;
> > +       } else if (mdata->rx_sgl_len) {
> > +               mult_delta = mtk_spi_get_mult_delta(mdata->rx_sgl_len);
> > +               mdata->xfer_len = mdata->rx_sgl_len - mult_delta;
> > +               mdata->rx_sgl_len = mult_delta;
> > +       }
> > +}
> > +
> > +static void mtk_spi_setup_dma_addr(struct spi_master *master,
> > +                                  struct spi_transfer *xfer)
> > +{
> > +       struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +
> > +       if (mdata->tx_sgl)
> > +               writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
> > +       if (mdata->rx_sgl)
> > +               writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
> > +}
> > +
> > +static int mtk_spi_fifo_transfer(struct spi_master *master,
> > +                                struct spi_device *spi,
> > +                                struct spi_transfer *xfer)
> > +{
> > +       int cnt, i;
> > +       struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +
> > +       mdata->cur_transfer = xfer;
> > +       mdata->xfer_len = xfer->len;
> > +       mtk_spi_prepare_transfer(master, xfer);
> > +       mtk_spi_setup_packet(master);
> > +
> > +       if (xfer->len % 4)
> > +               cnt = xfer->len / 4 + 1;
> > +       else
> > +               cnt = xfer->len / 4;
> > +
> > +       for (i = 0; i < cnt; i++)
> > +               writel(*((u32 *)xfer->tx_buf + i),
> 
> This will access past the end of tx_buf if len%4 > 0.

SPI_TX_DATA_REG requires write 4 bytes once. If len%4 > 0, this just
reads more data from dram(xfer->tx_buf) to register, and that spi hw
only tranfer length according to xfer->len, so I think it doesn't
matter.

> > +                      mdata->base + SPI_TX_DATA_REG);
> > +
> > +       mtk_spi_enable_transfer(master);
> > +
> > +       return 1;
> > +}
> > +
> > +static int mtk_spi_dma_transfer(struct spi_master *master,
> > +                               struct spi_device *spi,
> > +                               struct spi_transfer *xfer)
> > +{
> > +       int cmd;
> > +       struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +
> > +       mdata->tx_sgl = NULL;
> > +       mdata->rx_sgl = NULL;
> > +       mdata->tx_sgl_len = 0;
> > +       mdata->rx_sgl_len = 0;
> > +       mdata->cur_transfer = xfer;
> > +
> > +       mtk_spi_prepare_transfer(master, xfer);
> > +
> > +       cmd = readl(mdata->base + SPI_CMD_REG);
> > +       if (xfer->tx_buf)
> > +               cmd |= SPI_CMD_TX_DMA;
> > +       if (xfer->rx_buf)
> > +               cmd |= SPI_CMD_RX_DMA;
> > +       writel(cmd, mdata->base + SPI_CMD_REG);
> > +
> > +       if (xfer->tx_buf)
> > +               mdata->tx_sgl = xfer->tx_sg.sgl;
> > +       if (xfer->rx_buf)
> > +               mdata->rx_sgl = xfer->rx_sg.sgl;
> > +
> > +       if (mdata->tx_sgl) {
> > +               xfer->tx_dma = sg_dma_address(mdata->tx_sgl);
> > +               mdata->tx_sgl_len = sg_dma_len(mdata->tx_sgl);
> > +       }
> > +       if (mdata->rx_sgl) {
> > +               xfer->rx_dma = sg_dma_address(mdata->rx_sgl);
> > +               mdata->rx_sgl_len = sg_dma_len(mdata->rx_sgl);
> > +       }
> > +
> > +       mtk_spi_update_mdata_len(master);
> > +       mtk_spi_setup_packet(master);
> > +       mtk_spi_setup_dma_addr(master, xfer);
> > +       mtk_spi_enable_transfer(master);
> > +
> > +       return 1;
> > +}
> > +
> > +static int mtk_spi_transfer_one(struct spi_master *master,
> > +                               struct spi_device *spi,
> > +                               struct spi_transfer *xfer)
> > +{
> > +       if (master->can_dma(master, spi, xfer))
> > +               return mtk_spi_dma_transfer(master, spi, xfer);
> > +       else
> > +               return mtk_spi_fifo_transfer(master, spi, xfer);
> > +}
> > +
> > +static bool mtk_spi_can_dma(struct spi_master *master,
> > +                           struct spi_device *spi,
> > +                           struct spi_transfer *xfer)
> > +{
> > +       return xfer->len > MTK_SPI_MAX_FIFO_SIZE;
> > +}
> > +
> > +static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
> > +{
> > +       u32 cmd, reg_val, i;
> > +       struct spi_master *master = dev_id;
> > +       struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +       struct spi_transfer *trans = mdata->cur_transfer;
> > +
> > +       reg_val = readl(mdata->base + SPI_STATUS0_REG);
> > +       if (reg_val & 0x2)
> 
> define 0x2?

OK. I will fix it.

> > +               mdata->state = MTK_SPI_PAUSED;
> > +       else
> > +               mdata->state = MTK_SPI_IDLE;
> > +
> > +       if (!master->can_dma(master, master->cur_msg->spi, trans)) {
> > +               /* xfer len is not N*4 bytes every time in a transfer,
> > +                * but SPI_RX_DATA_REG must reads 4 bytes once,
> > +                * so rx buffer byte by byte.
> > +                */
> > +               if (trans->rx_buf) {
> > +                       for (i = 0; i < mdata->xfer_len; i++) {
> > +                               if (i % 4 == 0)
> > +                                       reg_val =
> > +                                       readl(mdata->base + SPI_RX_DATA_REG);
> 
> Strange indentation. Might be better to put readl on the same line,
> and SPI_RX_DATA_REG on the next one.

OK. I will fix it.

> > +                               *((u8 *)(trans->rx_buf + i)) =
> > +                                       (reg_val >> ((i % 4) * 8)) & 0xff;
> 
> This feels a bit awkward... Also, & 0xff is not needed.
> 
OK, I will fix it.

> > +
> > +static int mtk_spi_probe(struct platform_device *pdev)
> > +{
> > +       struct spi_master *master;
> > +       struct mtk_spi *mdata;
> > +       const struct of_device_id *of_id;
> > +       struct resource *res;
> > +       int     irq, ret;
> 
> Space, not tab, between int and irq.
> 
OK. I will fix it.

> > +
> > +       master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
> > +       if (!master) {
> > +               dev_err(&pdev->dev, "failed to alloc spi master\n");
