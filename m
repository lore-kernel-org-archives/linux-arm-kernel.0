From: balbi@ti.com (Felipe Balbi)
Date: Wed, 29 Jun 2011 19:01:11 +0300
Subject: [PATCH 1/2] MMC: PM: add suspend/resume in atmel-mci
In-Reply-To: <1ef60c032bc39531302c1603bfcb841d2d437ccc.1309366360.git.nicolas.ferre@atmel.com>
References: <1ef60c032bc39531302c1603bfcb841d2d437ccc.1309366360.git.nicolas.ferre@atmel.com>
Message-ID: <20110629160110.GD2760@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 29, 2011 at 06:54:19PM +0200, Nicolas Ferre wrote:
> Take care of slots while going to suspend state.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mmc/host/atmel-mci.c |   51 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 51 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index aa8039f..c414ebe 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1878,8 +1878,59 @@ static int __exit atmci_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int atmci_suspend(struct platform_device *pdev, pm_message_t mesg)
> +{
> +	struct atmel_mci *host = platform_get_drvdata(pdev);
> +	struct atmel_mci_slot *slot;
> +	int i, ret;
> +
> +	 for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
> +		slot = host->slot[i];
> +		if (!slot)
> +			continue;
> +		ret = mmc_suspend_host(slot->mmc);
> +		if (ret < 0) {
> +			while (--i >= 0) {
> +				slot = host->slot[i];
> +				if (slot)
> +					mmc_resume_host(host->slot[i]->mmc);
> +			}
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int atmci_resume(struct platform_device *pdev)
> +{
> +	struct atmel_mci *host = platform_get_drvdata(pdev);
> +	struct atmel_mci_slot *slot;
> +	int i, ret;
> +
> +	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
> +		slot = host->slot[i];
> +		if (!slot)
> +			continue;
> +		ret = mmc_resume_host(slot->mmc);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +#else
> +#define atmci_suspend	NULL
> +#define atmci_resume	NULL
> +#endif
> +
> +
> +
>  static struct platform_driver atmci_driver = {
>  	.remove		= __exit_p(atmci_remove),
> +	.suspend	= atmci_suspend,
> +	.resume		= atmci_resume,

should this be using dev_pm_ops instead ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110629/849f5c6e/attachment.sig>
