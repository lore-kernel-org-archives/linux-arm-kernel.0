From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Jul 2011 11:28:09 +0300
Subject: [PATCH V4] MMC: PM: add suspend/resume in atmel-mci
In-Reply-To: <1309944696-6415-1-git-send-email-nicolas.ferre@atmel.com>
References: <4E11B57B.4040000@atmel.com>
	<1309944696-6415-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20110706082808.GF10729@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 06, 2011 at 11:31:36AM +0200, Nicolas Ferre wrote:
> Take care of slots while going to suspend state.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> @@ -1878,10 +1879,72 @@ static int __exit atmci_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int atmci_suspend(struct device *dev)
> +{
> +	struct atmel_mci *host = dev_get_drvdata(dev);
> +	int i;
> +
> +	 for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
> +		struct atmel_mci_slot *slot = host->slot[i];
> +		int ret;
> +
> +		if (!slot)
> +			continue;
> +		ret = mmc_suspend_host(slot->mmc);
> +		if (ret < 0) {
> +			while (--i >= 0) {
> +				slot = host->slot[i];
> +				if (slot
> +				&& test_bit(ATMCI_SUSPENDED, &slot->flags)) {
> +					mmc_resume_host(host->slot[i]->mmc);
> +					clear_bit(ATMCI_SUSPENDED, &slot->flags);
> +				}
> +			}
> +			return ret;
> +		} else {
> +			set_bit(ATMCI_SUSPENDED, &slot->flags);
> +		}

just one small nitpicking which you can ignore if you like, but you
don't really need the else branch here. If you fall into if (ret < 0)
you will return early anyway, so you can save two lines and an
indentation level :-p

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110706/74a3c1a9/attachment-0001.sig>
