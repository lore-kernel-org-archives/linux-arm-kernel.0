From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 19 Nov 2014 11:31:13 +0100
Subject: [PATCH] mmc: mvsdio: Work around broken TX DMA
In-Reply-To: <1415830208-1888-1-git-send-email-andrew@lunn.ch>
References: <1415830208-1888-1-git-send-email-andrew@lunn.ch>
Message-ID: <CAPDyKFos__44CdPUxAT1R=+81ohuZWHAN83HCv6-BD6QWksF0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2014 23:10, Andrew Lunn <andrew@lunn.ch> wrote:
> In order to use the mvsdio driver for sdio, it has been necessary to
> use a module parameter to disable DMA so to force PIO is used. It is
> then possible to use wireless LAN devices like mwifiex found on
> topkick and mirabox. However, accessing an MMC SD card does work with
> DMA.
>
> Investigation has shown that MMC block device accesses are always
> aligned to 64 byte boundaries, where as transfers from mwifiex are
> rarely more than word aligned. It has also been determined that card
> to host transfers work with DMA for SDIO devices, but host to card
> transfers with DMA have problems.
>
> This patch extends the current checks for buffers which are not word
> aligned or multiple of words. All host to card transfers which are not
> 64 byte aligned are now also performed via PIO. This should not affect
> the performance of SD cards, but allow sdio devices to work out of the
> box, and they are likely to be more efficient since DMA will be used
> for card to host transfers.
>
> Tested on mirabox for wifi via mwifiex
> Tested on 370 RD for file systems on an SD card.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mvsdio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 6b4c5ad3b393..4f8618f4522d 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -111,10 +111,15 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>         mvsd_write(MVSD_BLK_COUNT, data->blocks);
>         mvsd_write(MVSD_BLK_SIZE, data->blksz);
>
> -       if (nodma || (data->blksz | data->sg->offset) & 3) {
> +       if (nodma || (data->blksz | data->sg->offset) & 3 ||
> +           ((!(data->flags & MMC_DATA_READ) && data->sg->offset & 0x3f))) {
>                 /*
>                  * We cannot do DMA on a buffer which offset or size
>                  * is not aligned on a 4-byte boundary.
> +                *
> +                * It also appears the host to card DMA can corrupt
> +                * data when the buffer is not aligned on a 64 byte
> +                * boundary.
>                  */
>                 host->pio_size = data->blocks * data->blksz;
>                 host->pio_ptr = sg_virt(data->sg);
> --
> 2.1.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
