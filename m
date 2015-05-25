From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 25 May 2015 08:58:02 +0200
Subject: [PATCH 1/2] mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
In-Reply-To: <4011290915a42fce8b9c19d59f3ca9c3289a6817.1432491958.git.hramrach@gmail.com>
References: <cover.1432491958.git.hramrach@gmail.com>
 <4011290915a42fce8b9c19d59f3ca9c3289a6817.1432491958.git.hramrach@gmail.com>
Message-ID: <5562C7FA.4050905@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24-05-15 20:07, Michal Suchanek wrote:
> The 250ms timeout is too short.
>
> On my system enabling the oclk takes under 50ms and disabling slightly
> over 100ms when idle. Under load disabling the clock can take over
> 350ms.
>
> This does not make mmc clock gating look like good option to have on
> sunxi but the system should not crash with mmc clock gating enabled
> nonetheless.
>
> This patch sets the timeout to 750ms and adds debug prints which show
> how long enabling/disabling the clock took so more data can be collected
> from other systems.
>
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>

Looks good: Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/mmc/host/sunxi-mmc.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 4d3e1ff..7cdeecd 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -595,7 +595,7 @@ static irqreturn_t sunxi_mmc_handle_manual_stop(int irq, void *dev_id)
>
>   static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>   {
> -	unsigned long expire = jiffies + msecs_to_jiffies(250);
> +	unsigned long start, end;
>   	u32 rval;
>
>   	rval = mmc_readl(host, REG_CLKCR);
> @@ -604,6 +604,8 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>   	if (oclk_en)
>   		rval |= SDXC_CARD_CLOCK_ON;
>
> +	start = jiffies;
> +	end = start + msecs_to_jiffies(750);
>   	mmc_writel(host, REG_CLKCR, rval);
>
>   	rval = SDXC_START | SDXC_UPCLK_ONLY | SDXC_WAIT_PRE_OVER;
> @@ -611,15 +613,29 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>
>   	do {
>   		rval = mmc_readl(host, REG_CMDR);
> -	} while (time_before(jiffies, expire) && (rval & SDXC_START));
> +	} while (time_before(jiffies, end) && (rval & SDXC_START));
> +	end = jiffies;
>
>   	/* clear irq status bits set by the command */
>   	mmc_writel(host, REG_RINTR,
>   		   mmc_readl(host, REG_RINTR) & ~SDXC_SDIO_INTERRUPT);
>
>   	if (rval & SDXC_START) {
> -		dev_err(mmc_dev(host->mmc), "fatal err update clk timeout\n");
> +		dev_err(mmc_dev(host->mmc),
> +			"fatal err update oclk timeout. Could not %s in %ims.\n",
> +			oclk_en ? "enable" : "disable",
> +			jiffies_to_msecs(end-start));
>   		return -EIO;
> +	} else {
> +		int msecs = jiffies_to_msecs(end-start);
> +		const char *ing = oclk_en ? "enabling" : "disabling";
> +
> +		if ((msecs > 150) || (oclk_en && (msecs > 50)))
> +			dev_warn(mmc_dev(host->mmc),
> +				 "%s oclk took %ims", ing, msecs);
> +		else
> +			dev_dbg(mmc_dev(host->mmc),
> +				 "%s oclk took %ims", ing, msecs);
>   	}
>
>   	return 0;
>
