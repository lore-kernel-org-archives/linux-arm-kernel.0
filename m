From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 May 2013 16:25:36 +0200
Subject: [PATCH V3 2/3] ARM: mmc: bcm281xx SDHCI driver
In-Reply-To: <1369790016-13270-2-git-send-email-csd@broadcom.com>
References: <1369790016-13270-1-git-send-email-csd@broadcom.com>
 <1369790016-13270-2-git-send-email-csd@broadcom.com>
Message-ID: <201305291625.37068.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 May 2013, Christian Daudt wrote:
> +static int sdhci_bcm_kona_sd_reset(struct sdhci_host *host)
> +{

> +	/*
> +	 * Back-to-Back register write needs a delay of 1ms at bootup (min 10uS)
> +	 * Back-to-Back writes to same register needs delay when SD bus clock
> +	 * is very low w.r.t AHB clock, mainly during boot-time and during card
> +	 * insert-removal.
> +	 */
> +	mdelay(1);
> +	sdhci_writel(host, val, KONA_SDHOST_CORECTRL);

This is now called always without spinlocks held and interrupts enabled,
so it should really be msleep() not mdelay().

> +static void sdhci_bcm_kona_sd_init(struct sdhci_host *host)
> +{
> +	unsigned int val;
> +
> +	/* enable the interrupt from the IP core */
> +	val = sdhci_readl(host, KONA_SDHOST_COREIMR);
> +	val |= KONA_SDHOST_IP;
> +	sdhci_writel(host, val, KONA_SDHOST_COREIMR);
> +
> +	/* Enable the AHB clock gating module to the host */
> +	val = sdhci_readl(host, KONA_SDHOST_CORECTRL);
> +	val |= KONA_SDHOST_EN;
> +
> +	/*
> +	 * Back-to-Back register write needs a delay of 1ms at bootup (min 10uS)
> +	 * Back-to-Back writes to same register needs delay when SD bus clock
> +	 * is very low w.r.t AHB clock, mainly during boot-time and during card
> +	 * insert-removal.
> +	 */
> +	mdelay(1);
> +	sdhci_writel(host, val, KONA_SDHOST_CORECTRL);
> +}

Same here.

Looks good aside from that.

	Arnd
