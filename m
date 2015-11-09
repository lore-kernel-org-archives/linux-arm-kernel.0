From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 9 Nov 2015 14:23:05 +0100
Subject: [PATCH 1/2] mmc: sdhci: set bus voltage before enabling bus power
In-Reply-To: <1446825570-30029-2-git-send-email-ludovic.desroches@atmel.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
 <1446825570-30029-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151109132305.GC15706@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 04:59:29PM +0100, Ludovic Desroches wrote:
> When there is a vmmc regulator, only SD Bus Power is set to 1 in the
> Power Control Register. It means SD Bus Voltage Select field is set to 0
> that is a reserved value. The SD Host Controller specification says:
> 'SD Bus Power: Before setting this bit, the SD Host Driver shall set SD
> Bus Voltage Select.' and 'If the Host Driver selects an unsupported
> voltage in the SD B?us Voltage Select field, the Host Controller may
> ignore writes to SD Bus Power and keep its value at zero."
> 
> Having an external regulator means the SD Bus Voltage Select is useless
> but if the Host Controller strictly follows the specification then we
> need to set a valid value.

Ulf,

What is your opinion about this patch?

If the 'no regulator found' message is turned in debug message, I can get
rid of my vmmc regulator but I really think that writing only
SDHCI_POWER_ON is opposite to the sdhci spec. I would say that not
setting the bus voltage is a quirk!

Regards

Ludovic

> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/mmc/host/sdhci.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ac97b46..0cfd7b2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1278,13 +1278,6 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  		spin_unlock_irq(&host->lock);
>  		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>  		spin_lock_irq(&host->lock);
> -
> -		if (mode != MMC_POWER_OFF)
> -			sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
> -		else
> -			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> -
> -		return;
>  	}
>  
>  	if (mode != MMC_POWER_OFF) {
> -- 
> 2.5.0
> 
