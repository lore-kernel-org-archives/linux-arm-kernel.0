From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Wed, 8 Oct 2014 16:58:32 +0530
Subject: [PATCH] mmc: dw_mmc: Reset DMA before enabling IDMAC
In-Reply-To: <1412618020-22278-1-git-send-email-sonnyrao@chromium.org>
References: <1412618020-22278-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <CAGOxZ53bviLbuA27=1QjNUgxA_WMMP-6siV=DajuN8iSqsasMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sonny/Doug,

On Mon, Oct 6, 2014 at 11:23 PM, Sonny Rao <sonnyrao@chromium.org> wrote:
> We've already got a reset of DMA after it's done.  Add one before we
> start DMA too.  This fixes a data corruption on Rockchip SoCs which
> will get bad data when doing a DMA transfer after doing a PIO transfer.
>
> We tested this on an Exynos 5800 with HS200 and didn't notice any
> difference in sequential read throughput.
>
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 69f0cc6..2b5401e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -83,6 +83,7 @@ struct idmac_desc {
>  #endif /* CONFIG_MMC_DW_IDMAC */
>
>  static bool dw_mci_reset(struct dw_mci *host);
> +static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>
>  #if defined(CONFIG_DEBUG_FS)
>  static int dw_mci_req_show(struct seq_file *s, void *v)
> @@ -448,6 +449,9 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>
>         dw_mci_translate_sglist(host, host->data, sg_len);
>
> +       /* Make sure to reset DMA in case we did PIO before this */
> +       dw_mci_ctrl_reset(host, SDMMC_CTRL_DMA_RESET);
> +
Though this is good to do, but this does not look complete to me.
dw_mmc data book does mention that " It is recommended that the host
issue reset to DMA interface by setting DMA_RESET bit of the CTRL
register and then issue a IDMAC software reset."
The above lines are from 'Transmission and reception with internal
DMA' section of the data book.
My suggestion here to add dw_mci_idmac_reset() call after this above change.

What is the controller version used in your case?
>         /* Select IDMAC interface */
>         temp = mci_readl(host, CTRL);
>         temp |= SDMMC_CTRL_USE_IDMAC;
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
