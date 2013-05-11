From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 10 May 2013 22:28:22 -0600
Subject: [PATCH] ARM: mmc: bcm281xx SDHCI driver
In-Reply-To: <1368078942-31265-1-git-send-email-csd@broadcom.com>
References: <1368078942-31265-1-git-send-email-csd@broadcom.com>
Message-ID: <518DC8E6.5000606@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2013 11:55 PM, Christian Daudt wrote:
> Add SDHCI driver for the Broadcom 281xx SoCs. Also
> add bindings for it into bcm281xx dts files.
> Still missing:
>  - power managemement

> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c

> +	/*
> +	 * Back-to-Back register write needs a delay of 1ms at bootup (min 10uS)
> +	 * Back-to-Back writes to same register needs delay when SD bus clock
> +	 * is very low w.r.t AHB clock, mainly during boot-time and during card
> +	 * insert-removal.
> +	 */
> +	udelay(1000);
> +	sdhci_writel(host, val, KONA_SDHOST_CORECTRL);

This sounds very similar to the workaround in
drivers/mmc/host/sdhci-bcm2835.c. Is this the same IP block supported by
that driver? Perhaps not, since bcm2835 apparently needs other WARs such
as always using 32-bit IO and hence needing custom read/write w/b
functions to do read-modify-write which isn't here?
