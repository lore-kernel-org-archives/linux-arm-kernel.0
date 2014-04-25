From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Apr 2014 14:15:30 +0100
Subject: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
 compliant with UHS-1
In-Reply-To: <20140425130849.GB15179@pengutronix.de>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk>
 <20140425123820.GA15179@pengutronix.de>
 <20140425124945.GM26756@n2100.arm.linux.org.uk>
 <20140425130849.GB15179@pengutronix.de>
Message-ID: <20140425131529.GN26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 03:08:49PM +0200, Markus Pargmann wrote:
> I just tried the different parts of the patch. Without the following
> change, emmc works:
> 
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1507,12 +1507,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>  			host->ops->set_clock(host, host->clock);
>  		}
>  
> -
> -		/* Reset SD Clock Enable */
> -		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -		clk &= ~SDHCI_CLOCK_CARD_EN;
> -		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -

So the bit which stops us violating the SD spec stops eMMC from working...
that's... just great.

Okay, I'll look deeper at this and see what can be done, but I suspect it
will turn out to require more patches and be more invasive.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
