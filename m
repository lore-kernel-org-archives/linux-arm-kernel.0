From: svenkatr@ti.com (S, Venkatraman)
Date: Fri, 2 Sep 2011 00:49:21 +0530
Subject: [PATCH] mmc: omap_hsmmc: DMA unmap only once in case of MMC error
In-Reply-To: <1314569323-6886-1-git-send-email-per.forlin@linaro.org>
References: <1314569323-6886-1-git-send-email-per.forlin@linaro.org>
Message-ID: <CANfBPZ-azGV0H7asRHD5+vdFjCkrx=E2Oypnrk_SW9K5+DwTLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 3:38 AM, Per Forlin <per.forlin@linaro.org> wrote:
> Reported by Russell King:
> ------------
> mmcblk0: error -84 transferring data, sector 149201, nr 64,
> cmd response 0x900, card status 0xb00
> mmcblk0: retrying using single block read
>
> WARNING: at /home/rmk/git/linux-2.6-rmk/lib/dma-debug.c:811 check_unmap
> omap_hsmmc omap_hsmmc.0: DMA-API: device driver tries to free DMA memory
> it has not allocated [device address=0x0000000080933000] [size=20480 bytes]
> -------------
>
> In case of an error dma_unmap() is issued in omap_hsmmc_dma_cleanup()
> and then again in omap_hsmmc_post_req(). Resolve this by clearing the
> host_cookie to indicate there is no DMA mapped memory to unmap.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> Bug fix on 3.1-rc3
>
> ?drivers/mmc/host/omap_hsmmc.c | ? ?7 +++++--
> ?1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 21e4a79..31d9817 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1011,6 +1011,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
> ? ? ? ? ? ? ? ? ? ? ? ?host->data->sg_len,
> ? ? ? ? ? ? ? ? ? ? ? ?omap_hsmmc_get_dma_dir(host, host->data));
> ? ? ? ? ? ? ? ?omap_free_dma(dma_ch);
> + ? ? ? ? ? ? ? host->data->host_cookie = 0;
> ? ? ? ?}
> ? ? ? ?host->data = NULL;
> ?}
> @@ -1576,8 +1577,10 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
> ? ? ? ?struct mmc_data *data = mrq->data;
>
> ? ? ? ?if (host->use_dma) {
> - ? ? ? ? ? ? ? dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ?omap_hsmmc_get_dma_dir(host, data));
> + ? ? ? ? ? ? ? if (data->host_cookie)
> + ? ? ? ? ? ? ? ? ? ? ? dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?data->sg_len,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?omap_hsmmc_get_dma_dir(host, data));
> ? ? ? ? ? ? ? ?data->host_cookie = 0;
> ? ? ? ?}
> ?}
> --
> 1.7.4.1
>
>

I just posted a patch [1] which just consolidates all unmapping to
just post_req.
This would obviously prevent double unmapping, and keeps all the related
dma operations at a single place. Let me know if that works better.

[1]: http://marc.info/?l=linux-mmc&m=131490406920616&w=2
