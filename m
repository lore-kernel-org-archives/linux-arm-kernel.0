From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Mon, 9 Jul 2012 09:05:53 +0200
Subject: [PATCH] mmc: atmel-mci: modify CLKDIV displaying in debugfs
In-Reply-To: <1341569511-11340-1-git-send-email-nicolas.ferre@atmel.com>
References: <1341569511-11340-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4FFA82D1.5080904@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/06/2012 12:11 PM, Nicolas Ferre a ?crit :
> Modify clock division displaying in debugfs for matching
> the new CLKDIV,CLKODD user interface arrangement.
> Is using the has_odd_clk_div property to choose the proper format.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>


Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks.

> ---
>   drivers/mmc/host/atmel-mci.c |   12 +++++++++---
>   1 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 1fe20cd..9c5daa2 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -396,11 +396,17 @@ static int atmci_regs_show(struct seq_file *s, void *v)
>   	clk_disable(host->mck);
>   	spin_unlock_bh(&host->lock);
>
> -	seq_printf(s, "MR:\t0x%08x%s%s CLKDIV=%u\n",
> +	seq_printf(s, "MR:\t0x%08x%s%s ",
>   			buf[ATMCI_MR / 4],
>   			buf[ATMCI_MR / 4] & ATMCI_MR_RDPROOF ? " RDPROOF" : "",
> -			buf[ATMCI_MR / 4] & ATMCI_MR_WRPROOF ? " WRPROOF" : "",
> -			buf[ATMCI_MR / 4] & 0xff);
> +			buf[ATMCI_MR / 4] & ATMCI_MR_WRPROOF ? " WRPROOF" : "");
> +	if (host->caps.has_odd_clk_div)
> +		seq_printf(s, "{CLKDIV,CLKODD}=%u\n",
> +				((buf[ATMCI_MR / 4] & 0xff) << 1)
> +				| ((buf[ATMCI_MR / 4] >> 16) & 1));
> +	else
> +		seq_printf(s, "CLKDIV=%u\n",
> +				(buf[ATMCI_MR / 4] & 0xff));
>   	seq_printf(s, "DTOR:\t0x%08x\n", buf[ATMCI_DTOR / 4]);
>   	seq_printf(s, "SDCR:\t0x%08x\n", buf[ATMCI_SDCR / 4]);
>   	seq_printf(s, "ARGR:\t0x%08x\n", buf[ATMCI_ARGR / 4]);
>
