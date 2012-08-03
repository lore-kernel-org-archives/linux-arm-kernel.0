From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 3 Aug 2012 15:38:15 +0200
Subject: [PATCH 06/10 V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <1343076052-27312-7-git-send-email-marex@denx.de>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
 <1343076052-27312-7-git-send-email-marex@denx.de>
Message-ID: <20120803153815.758dc064@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek,

Le Mon, 23 Jul 2012 22:40:48 +0200,
Marek Vasut <marex@denx.de> a ?crit :

> +static uint32_t mxs_spi_cs_to_reg(unsigned cs)
> +{
> +	uint32_t select = 0;
> +
> +	if (cs & 1)
> +		select |= BM_SSP_CTRL0_WAIT_FOR_CMD;
> +	if (cs & 2)
> +		select |= BM_SSP_CTRL0_WAIT_FOR_IRQ;
> +
> +	return select;
> +}

It sounds really strange to manipulate WAIT_FOR_CMD and WAIT_FOR_IRQ
bits to adjust the chip select, and when reading the driver, it seemed
suspicious to me. After going through the datasheet, indeed those bits
are the appropriate one to select between the SS0, SS1 and SS2 chip
selects, but I find the code not really obvious. Would it be possible
to make it more obvious either by adding or comment or doing something
like:

/* Should be put in some header file */
#define BM_SSP_CTRL0_SPI_CS_BITS (20)

+static void mxs_spi_set_cs(struct mxs_spi *spi, unsigned cs)
+{
+	struct mxs_ssp *ssp = &spi->ssp;
+
+	writel(0x3 << BM_SSP_CTRL0_SPI_CS_BITS,
+              ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
+	writel(cs,
+              ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
+}

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
