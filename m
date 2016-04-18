From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 18 Apr 2016 15:47:25 +0200
Subject: [PATCH v5 2/4] mmc: meson: Add driver for the SD/MMC host found
 on Amlogic Meson SoCs
In-Reply-To: <1456596108-1406-3-git-send-email-carlo@caione.org>
References: <1456596108-1406-1-git-send-email-carlo@caione.org>
 <1456596108-1406-3-git-send-email-carlo@caione.org>
Message-ID: <CAPDyKFqrmpeRASDhBrY0nqhKGEfKw0B6tuP57xPJO0iKuXVb2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2016 at 19:01, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> Add a driver for the SD/MMC host found on the Amlogic Meson SoCs. This
> is an MMC controller which provides an interface between the application
> processor and various memory cards. It supports the SD specification
> v2.0 and the eMMC specification v4.41.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Sorry for the delay.

Apparently this slipped through my mmc mail filters, as I think you
forgotten to post this to linux-mmc.

[...]

> +static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct meson_mmc_host *host = mmc_priv(mmc);
> +       struct mmc_command *cmd = mrq->cmd;
> +       struct mmc_data *data = mrq->data;
> +       unsigned long flags;
> +       int ret;
> +
> +       spin_lock_irqsave(&host->lock, flags);

I would advise you to re-visit the deployment of the locking in this
driver. It doesn't seem correct.

For example, keeping IRQ disabled while mapping DMA buffers isn't a
good idea, as it may cause the IRQs to be disabled for quite a while.

> +
> +       if (host->error) {
> +               cmd->error = host->error;
> +               spin_unlock_irqrestore(&host->lock, flags);
> +               mmc_request_done(mmc, mrq);
> +               return;
> +       }
> +
> +       if (data) {
> +               ret = meson_mmc_map_dma(host, data, data->flags);
> +               if (ret < 0) {
> +                       dev_err(mmc_dev(mmc), "map DMA failed\n");
> +                       cmd->error = ret;
> +                       data->error = ret;
> +                       spin_unlock_irqrestore(&host->lock, flags);
> +                       mmc_request_done(mmc, mrq);
> +                       return;
> +               }
> +               writel(sg_dma_address(data->sg), host->base + SDIO_ADDR);
> +       }
> +
> +       host->mrq = mrq;
> +       meson_mmc_start_cmd(mmc, mrq->cmd);
> +
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       schedule_delayed_work(&host->timeout_work, host->timeout);
> +}
> +
> +static irqreturn_t meson_mmc_irq(int irq, void *data)
> +{
> +       struct meson_mmc_host *host = (void *) data;
> +       struct mmc_request *mrq = host->mrq;
> +       u32 irqs;
> +
> +       irqs = readl(host->base + SDIO_IRQS);
> +       if (mrq && (irqs & REG_IRQS_CMD_INT))
> +               return IRQ_WAKE_THREAD;

As you don't use the IRQF_ONESHOT flag, this hard IRQ handler may be
invoked while the threaded handler runs.

Although, I don't see any protection of the host->mrq pointer etc,
don't you need that?

> +
> +       return IRQ_HANDLED;
> +}
> +
> +void meson_mmc_read_response(struct meson_mmc_host *host)
> +{
> +       struct mmc_command *cmd = host->mrq->cmd;
> +       u32 mult;
> +       int i, resp[4] = { 0 };
> +
> +       mult = readl(host->base + SDIO_MULT);
> +       mult |= REG_MULT_WR_RD_OUT_IND;
> +       mult &= ~(REG_MULT_RD_INDEX_M << REG_MULT_RD_INDEX_S);
> +       writel(mult, host->base + SDIO_MULT);
> +
> +       if (cmd->flags & MMC_RSP_136) {
> +               for (i = 0; i <= 3; i++)
> +                       resp[3 - i] = readl(host->base + SDIO_ARGU);
> +               cmd->resp[0] = (resp[0] << 8) | ((resp[1] >> 24) & 0xff);
> +               cmd->resp[1] = (resp[1] << 8) | ((resp[2] >> 24) & 0xff);
> +               cmd->resp[2] = (resp[2] << 8) | ((resp[3] >> 24) & 0xff);
> +               cmd->resp[3] = (resp[3] << 8);
> +       } else if (cmd->flags & MMC_RSP_PRESENT) {
> +               cmd->resp[0] = readl(host->base + SDIO_ARGU);
> +       }
> +}
> +
> +static irqreturn_t meson_mmc_irq_thread(int irq, void *irq_data)
> +{
> +       struct meson_mmc_host *host = (void *) irq_data;
> +       struct mmc_data *data;
> +       unsigned long flags;
> +       struct mmc_request *mrq;
> +       u32 irqs, send;
> +
> +       cancel_delayed_work_sync(&host->timeout_work);
> +       spin_lock_irqsave(&host->lock, flags);

You are disabling IRQs during the entire execution of this threaded
IRQ handler, that's not a good behaviour as it may be disabled for
quite a while.

Although, perhaps you do this to avoid needing to protect host->mrq in
the hard IRQ handler!?

> +
> +       mrq = host->mrq;
> +       data = mrq->data;
> +
> +       if (!mrq) {
> +               spin_unlock_irqrestore(&host->lock, flags);
> +               return IRQ_HANDLED;
> +       }
> +
> +       if (host->cmd_is_stop)
> +               goto out;
> +
> +       irqs = readl(host->base + SDIO_IRQS);
> +       send = readl(host->base + SDIO_SEND);
> +
> +       mrq->cmd->error = 0;
> +
> +       if (!data) {
> +               if (!((irqs & REG_IRQS_RESP_CRC7) ||
> +                     (send & REG_SEND_RESP_NO_CRC7)))
> +                       mrq->cmd->error = -EILSEQ;
> +               else
> +                       meson_mmc_read_response(host);
> +       } else {
> +               if (!((irqs & REG_IRQS_RD_CRC16) ||
> +                     (irqs & REG_IRQS_WR_CRC16))) {
> +                       mrq->cmd->error = -EILSEQ;
> +               } else {
> +                       data->bytes_xfered = data->blksz * data->blocks;
> +                       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +                                    ((data->flags & MMC_DATA_READ) ?
> +                                    DMA_FROM_DEVICE : DMA_TO_DEVICE));
> +               }
> +       }
> +
> +       if (mrq->stop) {
> +               host->cmd_is_stop = true;
> +               meson_mmc_start_cmd(host->mmc, mrq->stop);
> +               spin_unlock_irqrestore(&host->lock, flags);
> +               return IRQ_HANDLED;
> +       }
> +
> +out:
> +       host->cmd_is_stop = false;
> +       host->mrq = NULL;
> +       spin_unlock_irqrestore(&host->lock, flags);
> +       mmc_request_done(host->mmc, mrq);
> +
> +       return IRQ_HANDLED;
> +}
> +

[...]

> +static int meson_mmc_probe(struct platform_device *pdev)
> +{
> +       struct mmc_host *mmc;
> +       struct meson_mmc_host *host;
> +       struct pinctrl *pinctrl;
> +       struct resource *res;
> +       int ret, irq;
> +       u32 port;
> +
> +       mmc = mmc_alloc_host(sizeof(struct meson_mmc_host), &pdev->dev);
> +       if (!mmc) {
> +               dev_err(&pdev->dev, "mmc alloc host failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       host = mmc_priv(mmc);
> +       host->mmc = mmc;
> +       host->timeout = msecs_to_jiffies(10000);
> +       host->port = 0;
> +
> +       if (!of_property_read_u32(pdev->dev.of_node, "meson,sd-port", &port))
> +               host->port = port;
> +
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       host->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(host->base)) {
> +               ret = PTR_ERR(host->base);
> +               goto error_free_host;
> +       }
> +
> +       irq = platform_get_irq(pdev, 0);
> +       ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
> +                                       meson_mmc_irq_thread, 0, "meson_mmc",

Is the IRQs level or edge triggered? In other words, will the hard IRQ
handler miss IRQs if you use IRQF_ONESHOT?

> +                                       host);
> +       if (ret)
> +               goto error_free_host;
> +
> +       host->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(host->clk)) {
> +               ret = PTR_ERR(host->clk);
> +               goto error_free_host;
> +       }
> +
> +       ret = clk_prepare_enable(host->clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Enable clk error %d\n", ret);
> +               goto error_free_host;
> +       }
> +
> +       /* we do not support scatter lists in hardware */
> +       mmc->max_segs = 1;
> +       mmc->max_req_size = SDIO_BOUNCE_REQ_SIZE;
> +       mmc->max_seg_size = mmc->max_req_size;
> +       mmc->max_blk_count = 256;
> +       mmc->max_blk_size = mmc->max_req_size / mmc->max_blk_count;
> +       mmc->f_min = 300000;
> +       mmc->f_max = 50000000;
> +       mmc->caps |= MMC_CAP_4_BIT_DATA;
> +       mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
> +       mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +       mmc->ocr_avail = MMC_VDD_33_34;
> +       mmc->ops = &meson_mmc_ops;
> +
> +       spin_lock_init(&host->lock);
> +
> +       INIT_DELAYED_WORK(&host->timeout_work, meson_mmc_timeout);
> +
> +       pinctrl = devm_pinctrl_get(&pdev->dev);
> +       if (IS_ERR(pinctrl)) {
> +               ret = PTR_ERR(pinctrl);
> +               goto error;
> +       }
> +
> +       ret = mmc_of_parse(mmc);
> +       if (ret)
> +               goto error;
> +
> +       platform_set_drvdata(pdev, mmc);
> +
> +       ret = mmc_add_host(mmc);
> +       if (ret)
> +               goto error;
> +
> +       dev_info(&pdev->dev, "base:0x%p irq:%u port:%u\n",
> +                host->base, irq, host->port);
> +
> +       return 0;
> +
> +error:
> +       clk_disable_unprepare(host->clk);
> +error_free_host:
> +       mmc_free_host(mmc);
> +
> +       return ret;
> +}
> +

[...]

Kind regards
Uffe
