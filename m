From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Feb 2018 12:47:41 +0530
Subject: [PATCH v2 11/16] mmc: sdhci: Program a relatively accurate SW
 timeout value
In-Reply-To: <20180205125029.21570-12-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-12-kishon@ti.com>
Message-ID: <aa30bb13-7271-a426-f606-59f21961806f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 05 February 2018 06:20 PM, Kishon Vijay Abraham I wrote:
> sdhci has a 10 second timeout to catch devices that stop responding.
> Instead of programming 10 second arbitrary value, calculate the total time
> it would take for the entire transfer to happen and program the timeout
> value accordingly.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 46 +++++++++++++++++++++++++++++++++++++++-------
>  drivers/mmc/host/sdhci.h | 10 ++++++++++
>  2 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0489572d1892..d52f9e7eabe2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -673,6 +673,37 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  	}
>  }
>  
> +static void sdhci_calc_sw_timeout(struct sdhci_host *host,
> +				  struct mmc_command *cmd,
> +				  unsigned int target_timeout)
> +{
> +	struct mmc_data *data = cmd->data;
> +	struct mmc_host *mmc = host->mmc;
> +	unsigned long long transfer_time;
> +	struct mmc_ios *ios = &mmc->ios;
> +	unsigned char bus_width = ios->bus_width;

This should have been 1 << ios->bus_width.

-Kishon
