From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 20 Apr 2011 09:58:48 +0200
Subject: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
In-Reply-To: <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <BANLkTikGEUj-J2kOcd3gjVAtGhm+88DJKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2011 18:33, Shawn Guo <shawn.guo@linaro.org> wrote:
> pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
> If not calling pre_req() before mxs_mmc_request(), request()
> will prepare the cache just like it did it before.
> It is optional to use pre_req() and post_req().
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> ?drivers/mmc/host/mxs-mmc.c | ? 75 ++++++++++++++++++++++++++++++++++++++++++--
> ?1 files changed, 72 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 99d39a6..63c2ae2 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -137,6 +137,10 @@
>
> ?#define SSP_PIO_NUM ? ?3
>
> +struct mxs_mmc_next {
> + ? ? ? s32 cookie;
> +};
> +
> ?struct mxs_mmc_host {
> ? ? ? ?struct mmc_host ? ? ? ? ? ? ? ? *mmc;
> ? ? ? ?struct mmc_request ? ? ? ? ? ? ?*mrq;
> @@ -154,6 +158,7 @@ struct mxs_mmc_host {
> ? ? ? ?struct mxs_dma_data ? ? ? ? ? ? dma_data;
> ? ? ? ?unsigned int ? ? ? ? ? ? ? ? ? ?dma_dir;
> ? ? ? ?u32 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ssp_pio_words[SSP_PIO_NUM];
> + ? ? ? struct mxs_mmc_next ? ? ? ? ? ? next_data;
>
> ? ? ? ?unsigned int ? ? ? ? ? ? ? ? ? ?version;
> ? ? ? ?unsigned char ? ? ? ? ? ? ? ? ? bus_width;
> @@ -302,6 +307,31 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
> ? ? ? ?return IRQ_HANDLED;
> ?}
>
> +static int mxs_mmc_prep_dma_data(struct mxs_mmc_host *host,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct mmc_data *data,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct mxs_mmc_next *next)
> +{
> + ? ? ? if (!next && data->host_cookie &&
> + ? ? ? ? ? data->host_cookie != host->next_data.cookie) {
> + ? ? ? ? ? ? ? printk(KERN_WARNING "[%s] invalid cookie: data->host_cookie %d"
> + ? ? ? ? ? ? ? ? ? ? ?" host->next_data.cookie %d\n",
> + ? ? ? ? ? ? ? ? ? ? ?__func__, data->host_cookie, host->next_data.cookie);
> + ? ? ? ? ? ? ? data->host_cookie = 0;
> + ? ? ? }
> +
> + ? ? ? /* Check if next job is already prepared */
> + ? ? ? if (next || (!next && data->host_cookie != host->next_data.cookie))
> + ? ? ? ? ? ? ? if (dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(data->flags & MMC_DATA_WRITE) ?
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?DMA_TO_DEVICE : DMA_FROM_DEVICE) == 0)
> + ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? if (next)
> + ? ? ? ? ? ? ? data->host_cookie = ++next->cookie < 0 ? 1 : next->cookie;
> +
> + ? ? ? return 0;
> +}
> +
> ?static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
> ? ? ? ?struct mxs_mmc_host *host, unsigned int append)
> ?{
> @@ -312,8 +342,8 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
>
> ? ? ? ?if (data) {
> ? ? ? ? ? ? ? ?/* data */
> - ? ? ? ? ? ? ? dma_map_sg(mmc_dev(host->mmc), data->sg,
> - ? ? ? ? ? ? ? ? ? ? ? ? ?data->sg_len, host->dma_dir);
> + ? ? ? ? ? ? ? if (mxs_mmc_prep_dma_data(host, data, NULL))
> + ? ? ? ? ? ? ? ? ? ? ? return NULL;
> ? ? ? ? ? ? ? ?sgl = data->sg;
> ? ? ? ? ? ? ? ?sg_len = data->sg_len;
> ? ? ? ?} else {
> @@ -328,9 +358,11 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
> ? ? ? ? ? ? ? ?desc->callback = mxs_mmc_dma_irq_callback;
> ? ? ? ? ? ? ? ?desc->callback_param = host;
> ? ? ? ?} else {
> - ? ? ? ? ? ? ? if (data)
> + ? ? ? ? ? ? ? if (data) {
> ? ? ? ? ? ? ? ? ? ? ? ?dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? data->sg_len, host->dma_dir);
> + ? ? ? ? ? ? ? ? ? ? ? data->host_cookie = 0;
> + ? ? ? ? ? ? ? }
When is dma_unmap_sg called? If host_cookie is set dma_unmap() should
only be called from post_req.
My guess is
+ if (data && !data->host_cookie) {
It looks like only dma_map is run in parallel with transfer but not
dma_unmap. This may explain the numbers.
