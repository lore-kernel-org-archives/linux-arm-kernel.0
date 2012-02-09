From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 09 Feb 2012 10:05:51 +0100
Subject: [PATCH] mmc: atmel-mci: save and restore sdioirq when soft reset
 is performed
In-Reply-To: <1328784929-24174-1-git-send-email-ludovic.desroches@atmel.com>
References: <1328721759-10124-1-git-send-email-ludovic.desroches@atmel.com>
 <1328784929-24174-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <4F338C6F.9030802@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2012 11:55 AM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Sometimes a software reset is needed. Then some registers are saved and
> restored but the interrupt mask register is missing. It causes issues
> with sdio devices whose interrupts are masked after reset.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Chris, can you please queue this patch in a "fixes" branch?

Thanks, best regards,

> Cc: stable at vger.kernel.org
> ---
>  drivers/mmc/host/atmel-mci.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 09ac13b..dfa5dd9 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -965,11 +965,14 @@ static void atmci_start_request(struct atmel_mci *host,
>  	host->data_status = 0;
>  
>  	if (host->need_reset) {
> +		iflags = atmci_readl(host, ATMCI_IMR);
> +		iflags &= (ATMCI_SDIOIRQA | ATMCI_SDIOIRQB);
>  		atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
>  		atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
>  		atmci_writel(host, ATMCI_MR, host->mode_reg);
>  		if (host->caps.has_cfg_reg)
>  			atmci_writel(host, ATMCI_CFG, host->cfg_reg);
> +		atmci_writel(host, ATMCI_IER, iflags);
>  		host->need_reset = false;
>  	}
>  	atmci_writel(host, ATMCI_SDCR, slot->sdc_reg);


-- 
Nicolas Ferre
