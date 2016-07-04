From: andi@etezian.org (Andi Shyti)
Date: Mon, 4 Jul 2016 19:26:14 +0900
Subject: [PATCH v3 1/2] clk: exynos5433: do not use CLK_IGNORE_UNUSED for
 SPI clocks
In-Reply-To: <577A2EFF.2010306@samsung.com>
References: <1467270911-10971-1-git-send-email-andi.shyti@samsung.com>
 <1467270911-10971-2-git-send-email-andi.shyti@samsung.com>
 <577A2EFF.2010306@samsung.com>
Message-ID: <20160704102614.GD1257@jack.zhora.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

> >  	GATE(CLK_SCLK_SPI1, "sclk_spi1", "sclk_spi1_peric", ENABLE_SCLK_PERIC,
> > -			4, CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
> > +			4, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT, 0),
> 
> As Tomasz pointed out, this should be addressed in the driver/dts,
> we shouldn't be patching board configurations into a per-SoC driver.
> Other boards may want to keep this clock disabled.

The single clock lines are not configured in the exynos5433 dts,
but in the drivers/clk/samsung/clk-exynos5433.c file and it's the
only place where we can set the flags.

> What is an exact problem here, are you perhaps testing suspend to RAM?
> I tested my sound support patches on top of v4.7-rc1 and everything
> seemed to work well, I didn't notice any issues with the audio codec
> which was the only slave on the SPI 1 bus.

Yes, because the audio codec is on SPI1 and its bus line
(spi_busclk0) is CLK_SCLK_SPI1_PERIC while the CLK_SCLK_SPI1 is
set as CLK_IGNORE_UNUSED.

> Doesn't it help when you specify CLK_SCLK_SPI1 as the second clock
> ("spi_busclk0") of the spi_1 bus controller instead of
> CLK_SCLK_SPI0_PERIC? CLK_SCLK_SPI0_PERIC seem to be parent of
> CLK_SCLK_SPI1 so the enable state would be propagated.

nope! :(

For some reasons, if you set in the DTS as spi_busclk0 the
CLK_SCLK_SPI1 from cmu_peric you get a synchronus abort in the
s3c64xx_spi_config (the first read performed on the device).

Andi
