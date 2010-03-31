From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 31 Mar 2010 14:38:56 +0200
Subject: [PATCH 1/3] ARM: MXC: mxcmmc: misc cleanups
In-Reply-To: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
References: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
Message-ID: <20100331123856.GW2241@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, Mar 30, 2010 at 08:31:59PM +0200, Daniel Mack wrote:
> Add some more debug information and fix a couple of coding style things
> in mxcmmc.c.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Volker Ernst <volker.ernst@txtr.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/mmc/host/mxcmmc.c |   28 +++++++++++++++++-----------
>  1 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 2df9041..21037ff 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -151,6 +151,8 @@ static void mxcmci_softreset(struct mxcmci_host *host)
>  {
>  	int i;
>  
> +	dev_dbg(mmc_dev(host->mmc), "mxcmci_softreset\n");
> +
>  	/* reset sequence */
>  	writew(STR_STP_CLK_RESET, host->base + MMC_REG_STR_STP_CLK);
>  	writew(STR_STP_CLK_RESET | STR_STP_CLK_START_CLK,
> @@ -290,21 +292,29 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
>  		dev_dbg(mmc_dev(host->mmc), "request failed. status: 0x%08x\n",
>  				stat);
>  		if (stat & STATUS_CRC_READ_ERR) {
> +			dev_err(mmc_dev(host->mmc), "%s: -EILSEQ\n", __func__);
>  			data->error = -EILSEQ;
>  		} else if (stat & STATUS_CRC_WRITE_ERR) {
>  			u32 err_code = (stat >> 9) & 0x3;
> -			if (err_code == 2) /* No CRC response */
> +			if (err_code == 2) { /* No CRC response */
> +				dev_err(mmc_dev(host->mmc),
> +					"%s: No CRC -ETIMEDOUT\n", __func__);
>  				data->error = -ETIMEDOUT;
> -			else
> +			} else {
> +				dev_err(mmc_dev(host->mmc),
> +					"%s: -EILSEQ\n", __func__);
>  				data->error = -EILSEQ;
> +			}
>  		} else if (stat & STATUS_TIME_OUT_READ) {
> +			dev_err(mmc_dev(host->mmc),
> +				"%s: read -ETIMEDOUT\n", __func__);
>  			data->error = -ETIMEDOUT;
>  		} else {
> +			dev_err(mmc_dev(host->mmc), "%s: -EIO\n", __func__);

Do we really want to have these messages with dev_err? In the subject
you are talking about debug output.

>  			data->error = -EIO;
>  		}
> -	} else {
> +	} else
>  		data->bytes_xfered = host->datasize;
> -	}

Documentation/CodingStyle says that if braces are used in one branch of
a conditional then they should be used in both branches.
I personally don't care much about this statement but I think we should
leave it as is. Otherwise some day someone wants to change it back
according to the coding style.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
