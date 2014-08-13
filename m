From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Aug 2014 17:57:07 +0200
Subject: [PATCH v3] mmc: implement Driver Stage Register handling
In-Reply-To: <1407944656-14592-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1407944656-14592-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140813155707.GP5134@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Aug 13, 2014 at 05:44:16PM +0200, Uwe Kleine-K?nig wrote:
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index f51b5ba3bbea..37ed493d8030 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -93,6 +93,27 @@ int mmc_deselect_cards(struct mmc_host *host)
>  	return _mmc_select_card(host, NULL);
>  }
>  
> +/*
> + * Write the value specified in the device tree or board code into the optional
> + * 16 bit Driver Stage Register. This can be used to tune raise/fall times and
> + * drive strength of the DAT and CMD outputs. The actual meaning of a given
> + * value is hardware dependant.
> + * The presence of the DSR register can be determined from the CSD register,
> + * bit 76.
> + */
> +int mmc_set_dsr(struct mmc_host *host)
> +{
> +	int err;
The line declaring err can and should be dropped. I found that during my
tests, but failed to change this in the patch before sending it out.

If you consider applying my patch, please fix this up. If not I will
take this as an opportunity to remind you in a few days with a v4 :-)

Uwe

> +	struct mmc_command cmd = {0};
> +
> +	cmd.opcode = MMC_SET_DSR;
> +
> +	cmd.arg = ((u32)host->dsr << 16) | 0xffff;
> +	cmd.flags = MMC_RSP_NONE | MMC_CMD_AC;
> +
> +	return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +}
> +

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
