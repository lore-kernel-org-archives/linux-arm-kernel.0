From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Dec 2014 22:37:01 +0100
Subject: [PATCH 3/9] ARM: versatile: add DT based PCI detection
In-Reply-To: <1419967718-26909-4-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <1419967718-26909-4-git-send-email-robherring2@gmail.com>
Message-ID: <13417872.31IhE1RbAx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 December 2014 13:28:32 Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Disable the Versatile PCI DT node when no PCI backplane is detected. This
> will prevent the Versatile PCI driver from probing when PCI is not
> populated.

Can you explain why the check is done in platform code instead of the PCI
driver probe function itself?

> +	/* Check if PCI backplane is detected */
> +	val = __raw_readl(base + VERSATILE_SYS_PCICTL_OFFSET);
> +	if (val & 1)
> +		goto err;

Using __raw_readl prevents this from working with big-endian kernels, so just
use readl here.

	Arnd
