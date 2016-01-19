From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2016 17:57:58 +0000
Subject: [LINUX PATCH 1/5] mmc: Workaround for the issue in auto tuning
 mode.
In-Reply-To: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Message-ID: <20160119175757.GR19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 07:47:31PM +0530, P L Sai Krishna wrote:
> +void arasan_tune_sdclk(struct sdhci_host *host)

static?

> +{
> +	unsigned int clock;
> +
> +	clock = host->clock;

Maybe combine the above two lines:

	unsigned int clock = host->clock;

?

> +
> +	/*
> +	 * As per controller erratum, program the SDCLK Frequency
> +	 * Select of clock control register with a value, say
> +	 * clock/2. Wait for the Internal clock stable and program
> +	 * the desired frequency.
> +	 */
> +	host->ops->set_clock(host, clock/2);

The comment above says "wait for the internal clock stable" - I see
no wait in here.  Does the code actually conform with the comment?

Please also use "clock / 2" as per coding style, thanks

> +
> +	host->ops->set_clock(host, host->clock);

Maybe replace host->clock with clock?

> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d622435..8b064cd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2043,6 +2043,11 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		err = -EIO;
>  	}
>  
> +	if ((host->quirks2 & SDHCI_QUIRK2_BROKEN_TUNING) &&
> +		(tuning_loop_counter >= 0) && (ctrl & SDHCI_CTRL_TUNED_CLK)) {
> +		host->ops->tune_clk(host);
> +	}

Do we need this "SDHCI_QUIRK2_BROKEN_TUNING" quirk at all?  What's wrong
with:

	if (host->ops->tune_clk && tuning_loop_counter >= 0 &&
	    ctrl & SDHCI_CTRL_TUNED_CLK)
		host->ops->tune_clk(host);

here?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
