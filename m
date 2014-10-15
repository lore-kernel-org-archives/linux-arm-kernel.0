From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 15 Oct 2014 21:32:39 +0300
Subject: [PATCH 08/20] mmc: host: pxamci: switch over to dmaengine use
In-Reply-To: <1375889649-14638-9-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-9-git-send-email-zonque@gmail.com>
Message-ID: <CA+E=qVe5zRoR8qVa_gyJu+qpuGHFmqoGvEHowcu_hXR01GBzTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Wed, Aug 7, 2013 at 6:33 PM, Daniel Mack <zonque@gmail.com> wrote:
> Successfully testes on a PXA3xx board.

I know it could be a bit late, but I tested your pxa-dma-3.15 branch
rebased against 3.17 on pxa270 device,
and unfortunatelly pxamci driver doesn't work well.

It complains like this:

[    4.586118] mmc0: DMA error on rx channel
[    4.586471] mmc0: status: 1
[    4.587340] mmcblk0: error -5 transferring data, sector 1586251, nr
8, cmd response 0x900, card status 0xb00

status == 1, it's DMA_IN_PROGRESS, so I guess it's mmp_pdma bug, it
calls callback without calling dma_cookie_complete on appropriate
cookie? Any ideas how to fix it?

Regards,
Vasily

>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/mmc/host/pxamci.c | 188 +++++++++++++++++++++++++---------------------
>  1 file changed, 102 insertions(+), 86 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 2c5a91b..7aa97eb 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -22,7 +22,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma/mmp-pdma.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/mmc/host.h>
> @@ -37,7 +39,6 @@
>  #include <asm/sizes.h>
>
>  #include <mach/hardware.h>
> -#include <mach/dma.h>
>  #include <linux/platform_data/mmc-pxamci.h>
>
>  #include "pxamci.h"
> @@ -58,7 +59,6 @@ struct pxamci_host {
>         struct clk              *clk;
>         unsigned long           clkrate;
>         int                     irq;
> -       int                     dma;
>         unsigned int            clkrt;
>         unsigned int            cmdat;
>         unsigned int            imask;
> @@ -69,8 +69,10 @@ struct pxamci_host {
>         struct mmc_command      *cmd;
>         struct mmc_data         *data;
>
> +       struct dma_chan         *dma_chan_rx;
> +       struct dma_chan         *dma_chan_tx;
> +       dma_cookie_t            dma_cookie;
>         dma_addr_t              sg_dma;
> -       struct pxa_dma_desc     *sg_cpu;
>         unsigned int            dma_len;
>
>         unsigned int            dma_dir;
> @@ -173,14 +175,18 @@ static void pxamci_disable_irq(struct pxamci_host *host, unsigned int mask)
>         spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> +static void pxamci_dma_irq(void *param);
> +
>  static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
>  {
> +       struct dma_async_tx_descriptor *tx;
> +       enum dma_data_direction direction;
> +       struct dma_slave_config config;
> +       struct dma_chan *chan;
>         unsigned int nob = data->blocks;
>         unsigned long long clks;
>         unsigned int timeout;
> -       bool dalgn = 0;
> -       u32 dcmd;
> -       int i;
> +       int ret;
>
>         host->data = data;
>
> @@ -195,54 +201,46 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
>         timeout = (unsigned int)clks + (data->timeout_clks << host->clkrt);
>         writel((timeout + 255) / 256, host->base + MMC_RDTO);
>
> +       memset(&config, 0, sizeof(config));
> +       config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +       config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +       config.src_addr = host->res->start + MMC_RXFIFO;
> +       config.dst_addr = host->res->start + MMC_TXFIFO;
> +       config.src_maxburst = 32;
> +       config.dst_maxburst = 32;
> +
>         if (data->flags & MMC_DATA_READ) {
>                 host->dma_dir = DMA_FROM_DEVICE;
> -               dcmd = DCMD_INCTRGADDR | DCMD_FLOWSRC;
> -               DRCMR(host->dma_drcmrtx) = 0;
> -               DRCMR(host->dma_drcmrrx) = host->dma | DRCMR_MAPVLD;
> +               direction = DMA_DEV_TO_MEM;
> +               chan = host->dma_chan_rx;
>         } else {
>                 host->dma_dir = DMA_TO_DEVICE;
> -               dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
> -               DRCMR(host->dma_drcmrrx) = 0;
> -               DRCMR(host->dma_drcmrtx) = host->dma | DRCMR_MAPVLD;
> +               direction = DMA_MEM_TO_DEV;
> +               chan = host->dma_chan_tx;
>         }
>
> -       dcmd |= DCMD_BURST32 | DCMD_WIDTH1;
> +       config.direction = direction;
> +
> +       ret = dmaengine_slave_config(chan, &config);
> +       if (ret < 0) {
> +               dev_err(mmc_dev(host->mmc), "dma slave config failed\n");
> +               return;
> +       }
>
> -       host->dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +       host->dma_len = dma_map_sg(chan->device->dev, data->sg, data->sg_len,
>                                    host->dma_dir);
>
> -       for (i = 0; i < host->dma_len; i++) {
> -               unsigned int length = sg_dma_len(&data->sg[i]);
> -               host->sg_cpu[i].dcmd = dcmd | length;
> -               if (length & 31 && !(data->flags & MMC_DATA_READ))
> -                       host->sg_cpu[i].dcmd |= DCMD_ENDIRQEN;
> -               /* Not aligned to 8-byte boundary? */
> -               if (sg_dma_address(&data->sg[i]) & 0x7)
> -                       dalgn = 1;
> -               if (data->flags & MMC_DATA_READ) {
> -                       host->sg_cpu[i].dsadr = host->res->start + MMC_RXFIFO;
> -                       host->sg_cpu[i].dtadr = sg_dma_address(&data->sg[i]);
> -               } else {
> -                       host->sg_cpu[i].dsadr = sg_dma_address(&data->sg[i]);
> -                       host->sg_cpu[i].dtadr = host->res->start + MMC_TXFIFO;
> -               }
> -               host->sg_cpu[i].ddadr = host->sg_dma + (i + 1) *
> -                                       sizeof(struct pxa_dma_desc);
> +       tx = dmaengine_prep_slave_sg(chan, data->sg, host->dma_len, direction,
> +                                    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +       if (!tx) {
> +               dev_err(mmc_dev(host->mmc), "prep_slave_sg() failed\n");
> +               return;
>         }
> -       host->sg_cpu[host->dma_len - 1].ddadr = DDADR_STOP;
> -       wmb();
>
> -       /*
> -        * The PXA27x DMA controller encounters overhead when working with
> -        * unaligned (to 8-byte boundaries) data, so switch on byte alignment
> -        * mode only if we have unaligned data.
> -        */
> -       if (dalgn)
> -               DALGN |= (1 << host->dma);
> -       else
> -               DALGN &= ~(1 << host->dma);
> -       DDADR(host->dma) = host->sg_dma;
> +       tx->callback = pxamci_dma_irq;
> +       tx->callback_param = host;
> +
> +       host->dma_cookie = dmaengine_submit(tx);
>
>         /*
>          * workaround for erratum #91:
> @@ -251,7 +249,7 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
>          * before starting DMA.
>          */
>         if (!cpu_is_pxa27x() || data->flags & MMC_DATA_READ)
> -               DCSR(host->dma) = DCSR_RUN;
> +               dma_async_issue_pending(chan);
>  }
>
>  static void pxamci_start_cmd(struct pxamci_host *host, struct mmc_command *cmd, unsigned int cmdat)
> @@ -343,7 +341,7 @@ static int pxamci_cmd_done(struct pxamci_host *host, unsigned int stat)
>                  * enable DMA late
>                  */
>                 if (cpu_is_pxa27x() && host->data->flags & MMC_DATA_WRITE)
> -                       DCSR(host->dma) = DCSR_RUN;
> +                       dma_async_issue_pending(host->dma_chan_tx);
>         } else {
>                 pxamci_finish_request(host, host->mrq);
>         }
> @@ -358,9 +356,8 @@ static int pxamci_data_done(struct pxamci_host *host, unsigned int stat)
>         if (!data)
>                 return 0;
>
> -       DCSR(host->dma) = 0;
> -       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> -                    host->dma_dir);
> +       dma_unmap_sg(host->dma_chan_rx->device->dev,
> +                    data->sg, data->sg_len, host->dma_dir);
>
>         if (stat & STAT_READ_TIME_OUT)
>                 data->error = -ETIMEDOUT;
> @@ -552,17 +549,25 @@ static const struct mmc_host_ops pxamci_ops = {
>         .enable_sdio_irq        = pxamci_enable_sdio_irq,
>  };
>
> -static void pxamci_dma_irq(int dma, void *devid)
> +static void pxamci_dma_irq(void *param)
>  {
> -       struct pxamci_host *host = devid;
> -       int dcsr = DCSR(dma);
> -       DCSR(dma) = dcsr & ~DCSR_STOPIRQEN;
> +       struct pxamci_host *host = param;
> +       struct dma_tx_state state;
> +       enum dma_status status;
> +       struct dma_chan *chan;
>
> -       if (dcsr & DCSR_ENDINTR) {
> +       if (host->data->flags & MMC_DATA_READ)
> +               chan = host->dma_chan_rx;
> +       else
> +               chan = host->dma_chan_tx;
> +
> +       status = dmaengine_tx_status(chan, host->dma_cookie, &state);
> +
> +       if (likely(status == DMA_SUCCESS)) {
>                 writel(BUF_PART_FULL, host->base + MMC_PRTBUF);
>         } else {
> -               pr_err("%s: DMA error on channel %d (DCSR=%#x)\n",
> -                      mmc_hostname(host->mmc), dma, dcsr);
> +               pr_err("%s: DMA error on %s channel\n", mmc_hostname(host->mmc),
> +                       host->data->flags & MMC_DATA_READ ? "rx" : "tx");
>                 host->data->error = -EIO;
>                 pxamci_data_done(host, 0);
>         }
> @@ -626,6 +631,7 @@ static int pxamci_probe(struct platform_device *pdev)
>         struct pxamci_host *host = NULL;
>         struct resource *r, *dmarx, *dmatx;
>         int ret, irq, gpio_cd = -1, gpio_ro = -1, gpio_power = -1;
> +       dma_cap_mask_t mask;
>
>         ret = pxamci_of_init(pdev);
>         if (ret)
> @@ -671,7 +677,6 @@ static int pxamci_probe(struct platform_device *pdev)
>
>         host = mmc_priv(mmc);
>         host->mmc = mmc;
> -       host->dma = -1;
>         host->pdata = pdev->dev.platform_data;
>         host->clkrt = CLKRT_OFF;
>
> @@ -702,12 +707,6 @@ static int pxamci_probe(struct platform_device *pdev)
>                                      MMC_CAP_SD_HIGHSPEED;
>         }
>
> -       host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE, &host->sg_dma, GFP_KERNEL);
> -       if (!host->sg_cpu) {
> -               ret = -ENOMEM;
> -               goto out;
> -       }
> -
>         spin_lock_init(&host->lock);
>         host->res = r;
>         host->irq = irq;
> @@ -728,32 +727,50 @@ static int pxamci_probe(struct platform_device *pdev)
>         writel(64, host->base + MMC_RESTO);
>         writel(host->imask, host->base + MMC_I_MASK);
>
> -       host->dma = pxa_request_dma(DRIVER_NAME, DMA_PRIO_LOW,
> -                                   pxamci_dma_irq, host);
> -       if (host->dma < 0) {
> -               ret = -EBUSY;
> -               goto out;
> -       }
> -
>         ret = request_irq(host->irq, pxamci_irq, 0, DRIVER_NAME, host);
>         if (ret)
>                 goto out;
>
>         platform_set_drvdata(pdev, mmc);
>
> -       dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -       if (!dmarx) {
> -               ret = -ENXIO;
> +       if (!pdev->dev.of_node) {
> +               dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> +               if (!dmarx) {
> +                       ret = -ENXIO;
> +                       goto out;
> +               }
> +               host->dma_drcmrrx = dmarx->start;
> +
> +               dmatx = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> +               if (!dmatx) {
> +                       ret = -ENXIO;
> +                       goto out;
> +               }
> +               host->dma_drcmrtx = dmatx->start;
> +       }
> +
> +       dma_cap_zero(mask);
> +       dma_cap_set(DMA_SLAVE, mask);
> +
> +       host->dma_chan_rx =
> +               dma_request_slave_channel_compat(mask, mmp_pdma_filter_fn,
> +                                                &host->dma_drcmrrx,
> +                                                &pdev->dev, "rx");
> +       if (host->dma_chan_rx == NULL) {
> +               dev_err(&pdev->dev, "unable to request rx dma channel\n");
> +               ret = -ENODEV;
>                 goto out;
>         }
> -       host->dma_drcmrrx = dmarx->start;
>
> -       dmatx = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> -       if (!dmatx) {
> -               ret = -ENXIO;
> +       host->dma_chan_tx =
> +               dma_request_slave_channel_compat(mask, mmp_pdma_filter_fn,
> +                                                &host->dma_drcmrtx,
> +                                                &pdev->dev, "tx");
> +       if (host->dma_chan_tx == NULL) {
> +               dev_err(&pdev->dev, "unable to request tx dma channel\n");
> +               ret = -ENODEV;
>                 goto out;
>         }
> -       host->dma_drcmrtx = dmatx->start;
>
>         if (host->pdata) {
>                 gpio_cd = host->pdata->gpio_card_detect;
> @@ -814,12 +831,12 @@ err_gpio_ro:
>         gpio_free(gpio_power);
>   out:
>         if (host) {
> -               if (host->dma >= 0)
> -                       pxa_free_dma(host->dma);
> +               if (host->dma_chan_rx)
> +                       dma_release_channel(host->dma_chan_rx);
> +               if (host->dma_chan_tx)
> +                       dma_release_channel(host->dma_chan_tx);
>                 if (host->base)
>                         iounmap(host->base);
> -               if (host->sg_cpu)
> -                       dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>                 if (host->clk)
>                         clk_put(host->clk);
>         }
> @@ -863,13 +880,12 @@ static int pxamci_remove(struct platform_device *pdev)
>                        END_CMD_RES|PRG_DONE|DATA_TRAN_DONE,
>                        host->base + MMC_I_MASK);
>
> -               DRCMR(host->dma_drcmrrx) = 0;
> -               DRCMR(host->dma_drcmrtx) = 0;
> -
>                 free_irq(host->irq, host);
> -               pxa_free_dma(host->dma);
> +               dmaengine_terminate_all(host->dma_chan_rx);
> +               dmaengine_terminate_all(host->dma_chan_tx);
> +               dma_release_channel(host->dma_chan_rx);
> +               dma_release_channel(host->dma_chan_tx);
>                 iounmap(host->base);
> -               dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>
>                 clk_put(host->clk);
>
> --
> 1.8.3.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
