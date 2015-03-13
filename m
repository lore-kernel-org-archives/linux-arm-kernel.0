From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 13 Mar 2015 20:30:22 +0900
Subject: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command
 errors
In-Reply-To: <1426002490-2014-1-git-send-email-dianders@chromium.org>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
Message-ID: <5502CA4E.9060401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Doug.

On 03/11/2015 12:48 AM, Doug Anderson wrote:
> The dw_mmc driver enables HLE errors as part of DW_MCI_ERROR_FLAGS but
> nothing in the interrupt handler actually handles them and ACKs them.
> That means that if we ever get an HLE error we'll just keep getting
> interrupts and we'll wedge things.
> 
> We really don't expect HLE errors but if we ever get them we shouldn't
> silently ignore them.
> 
> Note that I have seen HLE errors while constantly ejecting and
> inserting cards (ejecting while inserting, etc).

Right, It is occurred when card inserting/ejecting.(This case is the case of removable card.)
Did you test with eMMC? We needs to consider how control HLE error.
But I think this patch can't solve all of HLE problem.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Note that this works together with the patch I sent up yesterday (the
> CMD 11 timer).  I would have sent the two together except that I had
> local printouts (and ACKing of HLE) and didn't realize that this was
> also required for a full solution.
> 
>  drivers/mmc/host/dw_mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 47dfd0e..294edc9c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -44,11 +44,11 @@
>  /* Common flag combinations */
>  #define DW_MCI_DATA_ERROR_FLAGS	(SDMMC_INT_DRTO | SDMMC_INT_DCRC | \
>  				 SDMMC_INT_HTO | SDMMC_INT_SBE  | \
> -				 SDMMC_INT_EBE)
> +				 SDMMC_INT_EBE | SDMMC_INT_HLE)
>  #define DW_MCI_CMD_ERROR_FLAGS	(SDMMC_INT_RTO | SDMMC_INT_RCRC | \
> -				 SDMMC_INT_RESP_ERR)
> +				 SDMMC_INT_RESP_ERR | SDMMC_INT_HLE)
>  #define DW_MCI_ERROR_FLAGS	(DW_MCI_DATA_ERROR_FLAGS | \
> -				 DW_MCI_CMD_ERROR_FLAGS  | SDMMC_INT_HLE)
> +				 DW_MCI_CMD_ERROR_FLAGS)
>  #define DW_MCI_SEND_STATUS	1
>  #define DW_MCI_RECV_STATUS	2
>  #define DW_MCI_DMA_THRESHOLD	16
> 
