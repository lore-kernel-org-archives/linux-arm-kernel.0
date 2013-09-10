From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 Sep 2013 10:04:22 +0200
Subject: [PATCH] mmc: atmel-mci: fix oops in atmci_tasklet_func
In-Reply-To: <1378740719-25164-1-git-send-email-ludovic.desroches@atmel.com>
References: <1378740719-25164-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <522ED286.4030305@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2013 17:31, ludovic.desroches at atmel.com :
> From: Rodolfo Giometti <giometti@enneenne.com>
>
> In some cases, a NULL pointer dereference happens because data is NULL when
> STATE_END_REQUEST case is reached in atmci_tasklet_func.
>
> Cc: <stable@vger.kernel.org> #3.9+
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye.

> ---
>   drivers/mmc/host/atmel-mci.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index e9ea2fc..78d7e47 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1792,12 +1792,14 @@ static void atmci_tasklet_func(unsigned long priv)
>   			if (unlikely(status)) {
>   				host->stop_transfer(host);
>   				host->data = NULL;
> -				if (status & ATMCI_DTOE) {
> -					data->error = -ETIMEDOUT;
> -				} else if (status & ATMCI_DCRCE) {
> -					data->error = -EILSEQ;
> -				} else {
> -					data->error = -EIO;
> +				if (data) {
> +					if (status & ATMCI_DTOE) {
> +						data->error = -ETIMEDOUT;
> +					} else if (status & ATMCI_DCRCE) {
> +						data->error = -EILSEQ;
> +					} else {
> +						data->error = -EIO;
> +					}
>   				}
>   			}
>
>


-- 
Nicolas Ferre
