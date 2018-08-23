From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 23 Aug 2018 12:43:40 +0200
Subject: [PATCH v3 4/6] mmc: uniphier-sd: add UniPhier SD/eMMC controller
 driver
In-Reply-To: <1534999460-15111-5-git-send-email-yamada.masahiro@socionext.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <1534999460-15111-5-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAPDyKFoW=wuYZw+VV6TncLgtMbFdvJCfYOzL8xg7x2WimqNN2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +static void uniphier_sd_external_dma_request(struct tmio_mmc_host *host,
> +                                            struct tmio_mmc_data *pdata)
> +{
> +       struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
> +       struct dma_chan *chan;
> +
> +       chan = dma_request_chan(mmc_dev(host->mmc), "rx-tx");
> +       if (IS_ERR(chan)) {
> +               dev_warn(mmc_dev(host->mmc),
> +                        "failed to request DMA channel. falling back to PIO\n");
> +               return; /* just use PIO even for -EPROBE_DEFER */
> +       }
> +
> +       /* this driver uses a single channel for both RX an TX */
> +       priv->chan = chan;
> +       host->chan_rx = chan;
> +       host->chan_tx = chan;
> +
> +       tasklet_init(&host->dma_issue, uniphier_sd_external_dma_issue,
> +                    (unsigned long)host);

Isn't it time to get rid of tasklets for tmio?

No worries, I don't require that to be changed prior $subject patch,
however using threaded IRQs is a justified modernization for the tmio
variants.

[...]

Kind regards
Uffe
