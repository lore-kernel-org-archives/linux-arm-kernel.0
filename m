From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Jan 2015 11:03:03 +0000
Subject: [PATCH v2 2/7] mmc: sdhci-pxav3: Fix Armada 38x controller's
 caps according to erratum ERR-7878951
In-Reply-To: <1422010594-1735-3-git-send-email-gregory.clement@free-electrons.com>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
 <1422010594-1735-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150123110303.GD23493@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +	/*
> +	 * According to erratum 'ERR-7878951' Armada 38x SDHCI
> +	 * controller has different capabilities than the ones shown
> +	 * in its registers
> +	 */
> +	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +	if (of_get_property(np, "no-1-8-v", NULL)) {

Please use of_property_read_bool(np, "no-1-8-v")

> +		host->caps &= ~SDHCI_CAN_VDD_180;
> +		host->mmc->caps &= ~MMC_CAP_1_8V_DDR;

Is SDHCI_CAN_VDD_330 always set elsewhere in this case?

> +	} else
> +		host->caps &= ~SDHCI_CAN_VDD_330;

If one branch in an if-else pair is braced, both sides should be (as
Documentation/CodingStyle says). Please brace the else case.

Thanks,
Mark.
