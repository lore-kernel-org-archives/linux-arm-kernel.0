From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Feb 2011 11:06:24 +0000
Subject: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
In-Reply-To: <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
	<1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
Message-ID: <20110221110624.GK14495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 05:54:55PM +0800, Richard Zhao wrote:
> +	if (host->quirks & SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO) {
> +		if (readl(host->ioaddr + SDHCI_VENDOR_SPEC) & 0x2)
> +			writel(readl(host->ioaddr + SDHCI_VENDOR_SPEC) & ~0x2,
> +					host->ioaddr + SDHCI_VENDOR_SPEC);

Is it necessary to read the register twice, or would:

		u32 val = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
		if (val & 0x02)
			writel(val & ~0x02, host->ioaddr + SDHCI_VENDOR_SPEC);

be clearer and more obvious?
