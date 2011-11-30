From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Nov 2011 22:21:39 +0000
Subject: [PATCH] mmc: mmci: Fixup error handling for dma
In-Reply-To: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
References: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20111130222139.GW9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 03:51:26PM +0100, Ulf Hansson wrote:
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e900f51..62ad649 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -761,8 +761,12 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>  	}
>  
>  	if (!cmd->data || cmd->error) {
> -		if (host->data)
> +		if (host->data) {
> +			/* Terminate the DMA transfer */
> +			if (dma_inprogress(host))
> +				mmci_dma_data_error(host);

Doesn't this leave the DMA buffers mapped?
