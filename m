From: adrian.hunter@intel.com (Adrian Hunter)
Date: Thu, 2 Mar 2017 16:19:27 +0200
Subject: [PATCH 2/9] mmc: sdhci: add a callback for signal voltage
 switching
In-Reply-To: <1488448050-7574-3-git-send-email-yangbo.lu@nxp.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
 <1488448050-7574-3-git-send-email-yangbo.lu@nxp.com>
Message-ID: <bf18ad90-e622-1b9f-d6f7-0becbe57ea76@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/17 11:47, Yangbo Lu wrote:
> Add a callback for signal voltage switching to let host driver
> switch signal voltage in its own way.

That is not how we do things now.  Please just replace the host operation
instead e.g.

host->mmc_host_ops.start_signal_voltage_switch =
				esdhc_signal_voltage_switch;



> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  drivers/mmc/host/sdhci.c | 6 ++++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6fdd7a7..3c9a924 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1852,6 +1852,12 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>  
> +	if (host->ops->start_signal_voltage_switch) {
> +		ret = host->ops->start_signal_voltage_switch(
> +					host, ios->signal_voltage);
> +		return ret;
> +	}
> +
>  	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  
>  	switch (ios->signal_voltage) {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index edf3adf..04af687 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -566,6 +566,8 @@ struct sdhci_ops {
>  					 struct mmc_card *card,
>  					 unsigned int max_dtr, int host_drv,
>  					 int card_drv, int *drv_type);
> +	int	(*start_signal_voltage_switch)(struct sdhci_host *host,
> +					       unsigned char signal_voltage);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 
