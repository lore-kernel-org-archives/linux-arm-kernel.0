From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Fri, 6 Jul 2012 12:04:33 +0200
Subject: [PATCH] mmc: atmel-mci: fix incorrect setting of host->data to
 NULL
In-Reply-To: <1341568713-8869-1-git-send-email-nicolas.ferre@atmel.com>
References: <1341568713-8869-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4FF6B831.5060005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/06/2012 11:58 AM, Nicolas Ferre a ?crit :
> Setting host->data to NULL is incorrect sequence in STATE_SENDING_STOP
> state of FSM: This early setting leads to the skip of dma_unmap_sg()
> in atmci_dma_cleanup() which is a bug.
>
> Idea taken form dw_mmc by Seungwon Jeon.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> ---
>   drivers/mmc/host/atmel-mci.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 78e5326..2ce109d 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1860,7 +1860,6 @@ static void atmci_tasklet_func(unsigned long priv)
>
>   			dev_dbg(&host->pdev->dev, "FSM: cmd ready\n");
>   			host->cmd = NULL;
> -			host->data = NULL;
>   			data->bytes_xfered = data->blocks * data->blksz;
>   			data->error = 0;
>   			atmci_command_complete(host, mrq->stop);
> @@ -1874,6 +1873,7 @@ static void atmci_tasklet_func(unsigned long priv)
>   				atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
>   				state = STATE_WAITING_NOTBUSY;
>   			}
> +			host->data = NULL;
>   			break;
>
>   		case STATE_END_REQUEST:
>
