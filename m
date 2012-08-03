From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 3 Aug 2012 10:46:06 -0300
Subject: [PATCH 06/10 V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120803153815.758dc064@skate>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
 <1343076052-27312-7-git-send-email-marex@denx.de>
 <20120803153815.758dc064@skate>
Message-ID: <CAOMZO5AQs1NzJBogcLPcKtY=QSaxpDmzUTvpfScY7P10FEoMJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 3, 2012 at 10:38 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

>
> It sounds really strange to manipulate WAIT_FOR_CMD and WAIT_FOR_IRQ
> bits to adjust the chip select, and when reading the driver, it seemed
> suspicious to me. After going through the datasheet, indeed those bits
> are the appropriate one to select between the SS0, SS1 and SS2 chip
> selects, but I find the code not really obvious. Would it be possible
> to make it more obvious either by adding or comment or doing something
> like:
>
> /* Should be put in some header file */
> #define BM_SSP_CTRL0_SPI_CS_BITS (20)
>
> +static void mxs_spi_set_cs(struct mxs_spi *spi, unsigned cs)
> +{
> +       struct mxs_ssp *ssp = &spi->ssp;
> +
> +       writel(0x3 << BM_SSP_CTRL0_SPI_CS_BITS,
> +              ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> +       writel(cs,
> +              ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
> +}

I agree with Thomas.

In U-boot I did the following in order to be able to select the
different chip selects:
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=148ca64f327a89ef77e84756f5d351af33e59b64

Thanks,

Fabio Estevam
