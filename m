From: marek.vasut@gmail.com (=?UTF-8?B?TWFyZWsgVmHFoXV0?=)
Date: Tue, 9 Oct 2012 17:42:14 +0200
Subject: [PATCH] mmc: mxs: fix build regression from mismerge
In-Reply-To: <201210091537.23659.arnd@arndb.de>
References: <201210091537.23659.arnd@arndb.de>
Message-ID: <CAMqi2ZPvgu8M4F_fW01v5N6USn8=QP9brdMAEL34v_y69t8pbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I sent a patch for that already, Chris was cced on it recently by Shawn
too. (Sorry for top posting, Android mail client)
Dne 9.10.2012 17:39 "Arnd Bergmann" <arnd@arndb.de> napsal(a):

> From all I can tell, the patches
>
> fc108d24 "mmc: mxs-mmc: fix deadlock caused by recursion loop"
> 829c1bf4 "mmc: spi: Pull out parts shared between MMC and SPI"
>
> came in through separate branches and cause this build error when
> combined.
>
> drivers/mmc/host/mxs-mmc.c: In function 'mxs_mmc_enable_sdio_irq':
> drivers/mmc/host/mxs-mmc.c:527:78: error: 'struct mxs_mmc_host' has no
> member named 'base'
> drivers/mmc/host/mxs-mmc.c:527:95: error: 'struct mxs_mmc_host' has no
> member named 'devid'
>
> This does the obvious missing change.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Attila Kinali <attila@kinali.ch>
> Cc: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index bb4c2bf..80d1e6d 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -525,7 +525,7 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host
> *mmc, int enable)
>                 writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
>                        ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
>                 writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
> -                      host->base + HW_SSP_CTRL1(host) +
> STMP_OFFSET_REG_SET);
> +                      ssp->base + HW_SSP_CTRL1(ssp) +
> STMP_OFFSET_REG_SET);
>         } else {
>                 writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
>                        ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121009/2cf2c1ab/attachment-0001.html>
