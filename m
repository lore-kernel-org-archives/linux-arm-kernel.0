From: adrian.hunter@intel.com (Adrian Hunter)
Date: Wed, 22 Mar 2017 16:49:38 +0200
Subject: [PATCH v6 06/14] mmc: sdhci: Export sdhci_enable_sdio_irq() from
 sdhci.c
In-Reply-To: <43d7894cb56bd69d7980cea12b12d56f509f4797.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <43d7894cb56bd69d7980cea12b12d56f509f4797.1487091464.git-series.gregory.clement@free-electrons.com>
Message-ID: <ff0c74a4-00c3-6eea-9427-bdd5412a2c07@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/02/17 19:01, Gregory CLEMENT wrote:
> From: Hu Ziji <huziji@marvell.com>
> 
> Export sdhci_enable_sdio_irq() from sdhci.c.
> Thus vendor SDHC driver can implement its specific SDIO irq
> control.
> 
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d2338dc362f4..9a4fda81ff81 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1824,7 +1824,7 @@ static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
>  	}
>  }
>  
> -static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	unsigned long flags;
> @@ -1838,6 +1838,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  	sdhci_enable_sdio_irq_nolock(host, enable);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_enable_sdio_irq);
>  
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index e4a07543a12b..609783364941 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -694,6 +694,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);
> +void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
>  
>  #ifdef CONFIG_PM
>  extern int sdhci_suspend_host(struct sdhci_host *host);
> 
