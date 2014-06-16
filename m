From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jun 2014 11:46:16 +0100
Subject: [PATCH 23/38] mmc: sdhci: convert sdhci_set_uhs_signaling()
 into a library function
In-Reply-To: <E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk>
Message-ID: <20140616104615.GA10701@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 08:08:07PM +0100, Russell King wrote:
> @@ -1507,25 +1529,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>  			host->ops->set_clock(host, host->clock);
>  		}
>  
> -		if (host->ops->set_uhs_signaling)
> -			host->ops->set_uhs_signaling(host, ios->timing);
> -		else {
> -			ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> -			/* Select Bus Speed Mode for host */
> -			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> -			if ((ios->timing == MMC_TIMING_MMC_HS200) ||
> -			    (ios->timing == MMC_TIMING_UHS_SDR104))
> -				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> -			else if (ios->timing == MMC_TIMING_UHS_SDR12)
> -				ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> -			else if (ios->timing == MMC_TIMING_UHS_SDR25)
> -				ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
> -			else if (ios->timing == MMC_TIMING_UHS_SDR50)
> -				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> -			else if (ios->timing == MMC_TIMING_UHS_DDR50)
> -				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> -			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> -		}
> +		host->ops->set_uhs_signaling(host, ios->timing);
>  
>  		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
>  				((ios->timing == MMC_TIMING_UHS_SDR12) ||

Whoever decided to poorly pick these patches up against my will has
slightly messed this patch up - whereas my original patch left the
code correctly formatted, when whoever applied this patch did so, they
left an additional blank line in the above.

The other thing I'd ask is that the MMC people learn C precedence
rules, and realise that it's not necessary (and actively harmful)
to add additional parenthesis around simple if() conditions.  Testing
for timing being one of two values does not need anything more than
one set of parenthesis - it does not need if ((a == b) || (a == c)) -
if (a == b || a == c) does just fine, and is less confusing when
encountering more complex statements, such as:

	if ((((a == b) || (a == c)) && ((d > a) || (d < c))) || (z == f))

compared with:

	if (((a == b || a == c) && (d > a || d < c)) || z == f)

With the former "style", I normally end up having to pull the file into
the editor, and rewrite the damned statement to work out what the
grouping is, because the excessive use of parenthesis is detrimental to
readability.  Don't do it.  Learn the C precedence rules and keep code
readable.

-- 
FTTC broadband for 0.8mile line: now@9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
