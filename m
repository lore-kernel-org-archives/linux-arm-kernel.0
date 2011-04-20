From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 20 Apr 2011 16:17:00 +0800
Subject: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
In-Reply-To: <BANLkTikGEUj-J2kOcd3gjVAtGhm+88DJKQ@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
	<BANLkTikGEUj-J2kOcd3gjVAtGhm+88DJKQ@mail.gmail.com>
Message-ID: <20110420081700.GA1517@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 09:58:48AM +0200, Per Forlin wrote:
> > ?static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
> > ? ? ? ?struct mxs_mmc_host *host, unsigned int append)
> > ?{
> > @@ -312,8 +342,8 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
> >
> > ? ? ? ?if (data) {
> > ? ? ? ? ? ? ? ?/* data */
> > - ? ? ? ? ? ? ? dma_map_sg(mmc_dev(host->mmc), data->sg,
> > - ? ? ? ? ? ? ? ? ? ? ? ? ?data->sg_len, host->dma_dir);
> > + ? ? ? ? ? ? ? if (mxs_mmc_prep_dma_data(host, data, NULL))
> > + ? ? ? ? ? ? ? ? ? ? ? return NULL;
> > ? ? ? ? ? ? ? ?sgl = data->sg;
> > ? ? ? ? ? ? ? ?sg_len = data->sg_len;
> > ? ? ? ?} else {
> > @@ -328,9 +358,11 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
> > ? ? ? ? ? ? ? ?desc->callback = mxs_mmc_dma_irq_callback;
> > ? ? ? ? ? ? ? ?desc->callback_param = host;
> > ? ? ? ?} else {
> > - ? ? ? ? ? ? ? if (data)
> > + ? ? ? ? ? ? ? if (data) {
> > ? ? ? ? ? ? ? ? ? ? ? ?dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? data->sg_len, host->dma_dir);
> > + ? ? ? ? ? ? ? ? ? ? ? data->host_cookie = 0;
> > + ? ? ? ? ? ? ? }
> When is dma_unmap_sg called? If host_cookie is set dma_unmap() should
> only be called from post_req.
> My guess is
> + if (data && !data->host_cookie) {
> It looks like only dma_map is run in parallel with transfer but not
> dma_unmap. This may explain the numbers.

Good catch.  I forgot patching mxs_mmc_request_done where dma_unmap_sg
is called.  Will correct and retest ...

-- 
Regards,
Shawn
