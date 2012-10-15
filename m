From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Oct 2012 14:20:29 +0000
Subject: [PATCH 1/2] mmc: core: Support all MMC capabilities when booting
 from Device Tree
In-Reply-To: <1350306959-5843-1-git-send-email-lee.jones@linaro.org>
References: <1350306959-5843-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201210151420.29930.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 October 2012, Lee Jones wrote:
> Capabilities are an important part of the MMC subsystem. Much
> supported functionality would be lost if we didn't provide the
> same level of support when booting Device Tree as we currently
> do when the subsystem is passed capabilities via platform data.
> This patch supplies this support with one simple call to a
> DT parsing function.

We already document all the commonly used properties
in Documentation/devicetree/bindings/mmc/mmc.txt

Please don't add any duplicates or those that are not used
so far.

> +	if(of_property_read_bool(np, "mmc-cap-4-bit-data"))
> +		*caps |= MMC_CAP_4_BIT_DATA;

see "bus-width" property.

> +	if(of_property_read_bool(np, "mmc-cap-mmc-highspeed"))
> +		*caps |= MMC_CAP_MMC_HIGHSPEED;
> +	if(of_property_read_bool(np, "mmc-cap-sd-highspeed"))
> +		*caps |= MMC_CAP_SD_HIGHSPEED;

implied by "max-frequency" property.

> +	if(of_property_read_bool(np, "mmc-cap-sdio-irq"))
> +		*caps |= MMC_CAP_SDIO_IRQ;

implied by presence of SDIO irq property.

> +	if(of_property_read_bool(np, "mmc-cap-spi"))
> +		*caps |= MMC_CAP_SPI;

Only used by the mmc_spi driver, can be hardcoded there.

> +	if(of_property_read_bool(np, "mmc-cap-needs-poll"))
> +		*caps |= MMC_CAP_NEEDS_POLL;

implied by absence of irqs property.

> +	if(of_property_read_bool(np, "mmc-cap-8-bit-data"))
> +		*caps |= MMC_CAP_8_BIT_DATA;

see "bus-width" property.

> +	if(of_property_read_bool(np, "mmc-cap-nonremovable"))
> +		*caps |= MMC_CAP_NONREMOVABLE;

see "non-removable property.

> +	if(of_property_read_bool(np, "mmc-cap-wait-while-busy"))
> +		*caps |= MMC_CAP_WAIT_WHILE_BUSY;

This seems to be a linux device driver specific quirk that doesn't
belong into a hardware description.

> +	if(of_property_read_bool(np, "mmc-cap-erase"))
> +		*caps |= MMC_CAP_ERASE;

driver specific.

> ...

and so on. What are you actually missing in the properties that
are already there?

	Arnd
