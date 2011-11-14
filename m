From: stefan.xk.nilsson@stericsson.com (Stefan Nilsson XK)
Date: Mon, 14 Nov 2011 17:38:58 +0100
Subject: [PATCH] mmc: mmci: Fix PIO read for small SDIO packets
In-Reply-To: <1319618727-16969-1-git-send-email-stefan.xk.nilsson@stericsson.com>
References: <1319618727-16969-1-git-send-email-stefan.xk.nilsson@stericsson.com>
Message-ID: <4EC14422.90901@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any comments on this new version of this patch?
Can it be merged?

Best Regards

Stefan Nilsson

On 10/26/2011 10:45 AM, Stefan NILSSON9 wrote:
> Corrects a bug in MMCI host driver which silently causes
> small reads (<  4 bytes as only used in SDIO) from PL-18X to fail.
>
> Signed-off-by: Stefan Nilsson XK<stefan.xk.nilsson@stericsson.com>
> Signed-off-by: Ulf Hansson<ulf.hansson@stericsson.com>
> Acked-by: Linus Walleij<linus.walleij@linaro.org>
> ---
>   drivers/mmc/host/mmci.c |   13 ++++++++++++-
>   1 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 56e9a41..5c3a517 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -776,7 +776,18 @@ static int mmci_pio_read(struct mmci_host *host, char *buffer, unsigned int rema
>   		if (count<= 0)
>   			break;
>
> -		readsl(base + MMCIFIFO, ptr, count>>  2);
> +		/*
> +		 * SDIO especially may want to send something that is
> +		 * not divisible by 4 (as opposed to card sectors
> +		 * etc). Therefore make sure to to always read the last bytes
> +		 * while only doing full 32-bit reads towards the FIFO.
> +		 */
> +		if (count<  4) {
> +			unsigned char buf[4];
> +			readsl(base + MMCIFIFO, buf, 1);
> +			memcpy(ptr, buf, count);
> +		} else
> +			readsl(base + MMCIFIFO, ptr, count>>  2);
>
>   		ptr += count;
>   		remain -= count;
