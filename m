From: svenkatr@ti.com (S, Venkatraman)
Date: Thu, 16 Jun 2011 18:46:58 +0530
Subject: [PATCH v4 02/12] omap_hsmmc: use original sg_len for dma_unmap_sg
In-Reply-To: <1306360653-6196-3-git-send-email-per.forlin@linaro.org>
References: <1306360653-6196-1-git-send-email-per.forlin@linaro.org>
	<1306360653-6196-3-git-send-email-per.forlin@linaro.org>
Message-ID: <BANLkTinWzJ22NrVGofSNvgOcQePD1BKAuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 3:27 AM, Per Forlin <per.forlin@linaro.org> wrote:
> Don't use the returned sg_len from dma_map_sg() as inparameter
> to dma_unmap_sg(). Use the original sg_len for both dma_map_sg
> and dma_unmap_sg.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> ?drivers/mmc/host/omap_hsmmc.c | ? ?5 +++--
> ?1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 259ece0..ad3731a 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -959,7 +959,8 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
> ? ? ? ?spin_unlock(&host->irq_lock);
>
> ? ? ? ?if (host->use_dma && dma_ch != -1) {
> - ? ? ? ? ? ? ? dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
> + ? ? ? ? ? ? ? dma_unmap_sg(mmc_dev(host->mmc), host->data->sg,
> + ? ? ? ? ? ? ? ? ? ? ? host->data->sg_len,
> ? ? ? ? ? ? ? ? ? ? ? ?omap_hsmmc_get_dma_dir(host, host->data));
> ? ? ? ? ? ? ? ?omap_free_dma(dma_ch);
> ? ? ? ?}
> @@ -1343,7 +1344,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
> ? ? ? ? ? ? ? ?return;
> ? ? ? ?}
>
> - ? ? ? dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
> + ? ? ? dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> ? ? ? ? ? ? ? ?omap_hsmmc_get_dma_dir(host, data));
>
> ? ? ? ?req_in_progress = host->req_in_progress;
> --
> 1.7.4.1
>

Reviewed-by: Venkatraman S <svenkatr@ti.com>

Perhaps this doesn't belong to $FEATURE and can be posted as a separate patch ?
Thanks,
Venkat.
