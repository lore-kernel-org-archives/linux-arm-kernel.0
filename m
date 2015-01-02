From: dianders@chromium.org (Doug Anderson)
Date: Fri, 2 Jan 2015 15:07:20 -0800
Subject: [PATCH v3 1/3] mmc: dw_mmc: fix the max_blk_count in IDMAC
In-Reply-To: <1419250324-11743-2-git-send-email-alim.akhtar@samsung.com>
References: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
 <1419250324-11743-2-git-send-email-alim.akhtar@samsung.com>
Message-ID: <CAD=FV=WQkkEM1aMPNX6oeKC4Bf2-D8z8uwf6z4btcdxiCpSvJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alim,

On Mon, Dec 22, 2014 at 4:12 AM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> From: Seungwon Jeon <tgih.jun@samsung.com>
>
> Even though 1MB is reserved for descriptor table in IDMAC,
> the dw_mmc host driver is allowed to receive only maximum
> 128KB block length in one request. This is caused by setting
> improper max_blk_count. It needs to be e adjusted so that
> descriptor table is used fully. It is found that the performance
> is improved with the increased the max_blk_count.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 64ea042..a1b80e5 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2332,9 +2332,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  #ifdef CONFIG_MMC_DW_IDMAC
>                 mmc->max_segs = host->ring_size;
>                 mmc->max_blk_size = 65536;
> -               mmc->max_blk_count = host->ring_size;
>                 mmc->max_seg_size = 0x1000;
> -               mmc->max_req_size = mmc->max_seg_size * mmc->max_blk_count;
> +               mmc->max_req_size = mmc->max_seg_size * host->ring_size;
> +               mmc->max_blk_count = mmc->max_req_size / 512;

The numbers are a little different than the ones you and Sonny arrived
at about a year ago at
<https://chromium-review.googlesource.com/#/c/176488/>

You end up with the same max_req_size I think, but it looks as if
max_blk_count is 0x800 in your series and ix 0xffff in the one from a
year ago.  Do you have any explanation for why it is max_req_size /
512?

-Doug
