From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Dec 2012 16:21:32 +0000
Subject: [PATCH] mmc: mmci: Gate the clock when freq is 0
In-Reply-To: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
References: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121221162132.GI14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 04:50:21PM +0100, Ulf Hansson wrote:
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index edc3e9b..bf07823 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1147,6 +1147,15 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		}
>  	}
>  
> +	/*
> +	 * If clock = 0 and the block needs a certain value in the clreg
> +	 * to function, we need to gate the clock by removing MCI_PWR_ON.
> +	 * This is a special case for ST Micro variants, since the power
> +	 * register in the ARM legacy case is used for powering the cards.

I wish you'd stop using "legacy" when talking about the ARM primecell.
How can it be legacy when ARMs current development boards still use this
primecell?

> +	 */
> +	if (!ios->clock && variant->clkreg)
> +		pwr &= ~MCI_PWR_ON;

This is horrid.  You're overloading the clkreg default value with another
meaning here - "if we have any bits set in the default value for the
MCICLOCK register, the MCIPOWER register has special meanings for the
power control bits".

When you think about it as I've described it above, do you think this is
an acceptable solution to this problem?
