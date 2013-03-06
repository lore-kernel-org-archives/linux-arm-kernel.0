From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 6 Mar 2013 14:44:36 +0530
Subject: [PATCH 15/23] spi: s3c64xx: move to generic dmaengine API
In-Reply-To: <1362505353-8873-16-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <1362505353-8873-16-git-send-email-arnd@arndb.de>
Message-ID: <CAAgF-BcshDixZdtUHsaiiw5ZPPhTDLwDKE1=DH1196bx6i3DOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Mar 5, 2013 at 11:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The spi-s3c64xx uses a Samsung proprietary interface for
> talking to the DMA engine, which does not work with
> multiplatform kernels. Since the driver can also operate
> in PIO mode without any DMA, older platforms that do
> not support the DMA engine API will still work, although
> slower.
>
> The conversion was rather mechanical, since the samsung
> interface is just a shallow wrapper around the dmaengine
> interface.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/plat-samsung/devs.c              |  10 +++
>  drivers/spi/spi-s3c64xx.c                 | 107 ++++++++++++++----------------
>  include/linux/platform_data/spi-s3c64xx.h |   3 +
>  3 files changed, 62 insertions(+), 58 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index 76209c9..58fb02a 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -10,6 +10,7 @@
>   * published by the Free Software Foundation.
>  */
>
> +#include <linux/amba/pl330.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
> @@ -1551,6 +1552,9 @@ void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
>         pd.num_cs = num_cs;
>         pd.src_clk_nr = src_clk_nr;
>         pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
> +#ifdef CONFIG_PL330_DMA
> +       pd.filter = pl330_filter;
> +#endif
>
>         s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
>  }
> @@ -1589,6 +1593,9 @@ void __init s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
>         pd.num_cs = num_cs;
>         pd.src_clk_nr = src_clk_nr;
>         pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi1_cfg_gpio;
> +#ifdef CONFIG_PL330_DMA
> +       pd.filter = pl330_filter;
> +#endif
>
>         s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi1);
>  }
> @@ -1627,6 +1634,9 @@ void __init s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
>         pd.num_cs = num_cs;
>         pd.src_clk_nr = src_clk_nr;
>         pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi2_cfg_gpio;
> +#ifdef CONFIG_PL330_DMA
> +       pd.filter = pl330_filter;
> +#endif
>
>         s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi2);
>  }
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index e862ab8..9be07a6 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -22,8 +22,10 @@
>  #include <linux/workqueue.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/amba/pl330.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
> @@ -31,7 +33,6 @@
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>
> -#include <mach/dma.h>
>  #include <linux/platform_data/spi-s3c64xx.h>
>
>  #define MAX_SPI_PORTS          3
> @@ -131,9 +132,9 @@
>  #define TXBUSY    (1<<3)
>
>  struct s3c64xx_spi_dma_data {
> -       unsigned                ch;
> +       struct dma_chan *ch;
>         enum dma_transfer_direction direction;
> -       enum dma_ch     dmach;
> +       unsigned int request;
>  };
>
>  /**
> @@ -195,16 +196,11 @@ struct s3c64xx_spi_driver_data {
>         unsigned                        cur_speed;
>         struct s3c64xx_spi_dma_data     rx_dma;
>         struct s3c64xx_spi_dma_data     tx_dma;
> -       struct samsung_dma_ops          *ops;
>         struct s3c64xx_spi_port_config  *port_conf;
>         unsigned int                    port_id;
>         unsigned long                   gpios[4];
>  };
>
> -static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
> -       .name = "samsung-spi-dma",
> -};
> -
>  static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>  {
>         void __iomem *regs = sdd->regs;
> @@ -285,50 +281,42 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>                                         unsigned len, dma_addr_t buf)
>  {
>         struct s3c64xx_spi_driver_data *sdd;
> -       struct samsung_dma_prep info;
> -       struct samsung_dma_config config;
> +       struct dma_slave_config config;
> +       struct scatterlist sg;
> +       struct dma_async_tx_descriptor *desc;
>
>         if (dma->direction == DMA_DEV_TO_MEM) {
>                 sdd = container_of((void *)dma,
>                         struct s3c64xx_spi_driver_data, rx_dma);
> -               config.direction = sdd->rx_dma.direction;
> -               config.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
> -               config.width = sdd->cur_bpw / 8;
> -               sdd->ops->config(sdd->rx_dma.ch, &config);
> +               config.direction = dma->direction;
> +               config.src_addr = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
> +               config.src_addr_width = sdd->cur_bpw / 8;
> +               config.src_maxburst = 1;
> +               dmaengine_slave_config(dma->ch, &config);
>         } else {
>                 sdd = container_of((void *)dma,
>                         struct s3c64xx_spi_driver_data, tx_dma);
> -               config.direction =  sdd->tx_dma.direction;
> -               config.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
> -               config.width = sdd->cur_bpw / 8;
> -               sdd->ops->config(sdd->tx_dma.ch, &config);
> +               config.direction = dma->direction;
> +               config.dst_addr = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
> +               config.dst_addr_width = sdd->cur_bpw / 8;
> +               config.dst_maxburst = 1;
> +               dmaengine_slave_config(dma->ch, &config);
>         }
>
> -       info.cap = DMA_SLAVE;
> -       info.len = len;
> -       info.fp = s3c64xx_spi_dmacb;
> -       info.fp_param = dma;
> -       info.direction = dma->direction;
> -       info.buf = buf;
> +       sg_init_table(&sg, 1);
> +       sg_dma_len(&sg) = len;
> +       sg_set_page(&sg, pfn_to_page(PFN_DOWN(buf)),
> +                   len, offset_in_page(buf));
> +       sg_dma_address(&sg) = buf;
>
> -       sdd->ops->prepare(dma->ch, &info);
> -       sdd->ops->trigger(dma->ch);
> -}
> +       desc = dmaengine_prep_slave_sg(dma->ch,
> +               &sg, 1, dma->direction, DMA_PREP_INTERRUPT);
>
> -static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
> -{
> -       struct samsung_dma_req req;
> -       struct device *dev = &sdd->pdev->dev;
> +       desc->callback = s3c64xx_spi_dmacb;
> +       desc->callback_param = dma;
>
> -       sdd->ops = samsung_dma_get_ops();
> -
> -       req.cap = DMA_SLAVE;
> -       req.client = &s3c64xx_spi_dma_client;
> -
> -       sdd->rx_dma.ch = sdd->ops->request(sdd->rx_dma.dmach, &req, dev, "rx");
> -       sdd->tx_dma.ch = sdd->ops->request(sdd->tx_dma.dmach, &req, dev, "tx");
> -
> -       return 1;
> +       dmaengine_submit(desc);
> +       dma_async_issue_pending(dma->ch);
>  }
>
>  static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
> @@ -713,9 +701,9 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
>                 }
>
>                 /* Polling method for xfers not bigger than FIFO capacity */
> -               if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
> -                       use_dma = 0;
> -               else
> +               use_dma = 0;
> +               if (sdd->rx_dma.ch && sdd->tx_dma.ch &&
> +                   (xfer->len > ((FIFO_LVL_MASK(sdd) >> 1) + 1)))
>                         use_dma = 1;
>
>                 spin_lock_irqsave(&sdd->lock, flags);
> @@ -750,10 +738,10 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
>                         if (use_dma) {
>                                 if (xfer->tx_buf != NULL
>                                                 && (sdd->state & TXBUSY))
> -                                       sdd->ops->stop(sdd->tx_dma.ch);
> +                                       dmaengine_terminate_all(sdd->tx_dma.ch);
>                                 if (xfer->rx_buf != NULL
>                                                 && (sdd->state & RXBUSY))
> -                                       sdd->ops->stop(sdd->rx_dma.ch);
> +                                       dmaengine_terminate_all(sdd->rx_dma.ch);
>                         }
>
>                         goto out;
> @@ -793,11 +781,18 @@ out:
>  static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
>  {
>         struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
> +       dma_filter_fn filter = sdd->cntrlr_info->filter;
> +       struct device *dev = &sdd->pdev->dev;
> +       dma_cap_mask_t mask;
>
> -       /* Acquire DMA channels */
> -       while (!acquire_dma(sdd))
> -               usleep_range(10000, 11000);
> +       dma_cap_zero(mask);
> +       dma_cap_set(DMA_SLAVE, mask);
>
> +       /* Acquire DMA channels */
> +       sdd->rx_dma.ch = dma_request_slave_channel_compat(mask, filter,
> +                               (void*)sdd->rx_dma.request, dev, "rx");
> +       sdd->tx_dma.ch = dma_request_slave_channel_compat(mask, filter,
> +                               (void*)sdd->tx_dma.request, dev, "tx");
>         pm_runtime_get_sync(&sdd->pdev->dev);
>
>         return 0;
> @@ -808,11 +803,10 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
>         struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
>
>         /* Free DMA channels */
> -       sdd->ops->release(sdd->rx_dma.ch, &s3c64xx_spi_dma_client);
> -       sdd->ops->release(sdd->tx_dma.ch, &s3c64xx_spi_dma_client);
> +       dma_release_channel(sdd->rx_dma.ch);
> +       dma_release_channel(sdd->tx_dma.ch);
>
>         pm_runtime_put(&sdd->pdev->dev);
> -
>         return 0;
>  }
>
> @@ -1149,7 +1143,6 @@ static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
>  static int s3c64xx_spi_probe(struct platform_device *pdev)
>  {
>         struct resource *mem_res;
> -       struct resource *res;
>         struct s3c64xx_spi_driver_data *sdd;
>         struct s3c64xx_spi_info *sci = pdev->dev.platform_data;
>         struct spi_master *master;
> @@ -1207,15 +1200,15 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>         }
>
>         sdd->cur_bpw = 8;
> -
>         if (!sdd->pdev->dev.of_node) {
> +               struct resource *res;
>                 res = platform_get_resource(pdev, IORESOURCE_DMA,  0);
>                 if (!res) {
>                         dev_err(&pdev->dev, "Unable to get SPI tx dma "
>                                         "resource\n");
>                         return -ENXIO;
>                 }
> -               sdd->tx_dma.dmach = res->start;
> +               sdd->tx_dma.request = res->start;
>
>                 res = platform_get_resource(pdev, IORESOURCE_DMA,  1);
>                 if (!res) {
> @@ -1223,12 +1216,11 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>                                         "resource\n");
>                         return -ENXIO;
>                 }
> -               sdd->rx_dma.dmach = res->start;
> +               sdd->rx_dma.request = res->start;
>         }
>
>         sdd->tx_dma.direction = DMA_MEM_TO_DEV;
>         sdd->rx_dma.direction = DMA_DEV_TO_MEM;
> -
>         master->dev.of_node = pdev->dev.of_node;
>         master->bus_num = sdd->port_id;
>         master->setup = s3c64xx_spi_setup;
> @@ -1314,8 +1306,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>                                         sdd->port_id, master->num_chipselect);
>         dev_dbg(&pdev->dev, "\tIOmem=[0x%x-0x%x]\tDMA=[Rx-%d, Tx-%d]\n",
>                                         mem_res->end, mem_res->start,
> -                                       sdd->rx_dma.dmach, sdd->tx_dma.dmach);
> -
> +                                       sdd->rx_dma.request, sdd->tx_dma.request);
>         pm_runtime_enable(&pdev->dev);
>
>         return 0;
> diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
> index ceba18d..8447f63 100644
> --- a/include/linux/platform_data/spi-s3c64xx.h
> +++ b/include/linux/platform_data/spi-s3c64xx.h
> @@ -11,6 +11,8 @@
>  #ifndef __S3C64XX_PLAT_SPI_H
>  #define __S3C64XX_PLAT_SPI_H
>
> +#include <linux/dmaengine.h>
> +
>  struct platform_device;
>
>  /**
> @@ -38,6 +40,7 @@ struct s3c64xx_spi_info {
>         int src_clk_nr;
>         int num_cs;
>         int (*cfg_gpio)(void);
> +       dma_filter_fn filter;
>  };
>

This one also tested on exynos5250. It's working fine.

Thanks
Padma
>  /**
> --
> 1.8.1.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
