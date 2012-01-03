From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Jan 2012 21:11:59 +0000
Subject: [GIT PULL] Samsung devel-dma for v3.3
In-Reply-To: <037401ccc8e7$e5671380$b0353a80$%kim@samsung.com>
References: <037401ccc8e7$e5671380$b0353a80$%kim@samsung.com>
Message-ID: <201201032111.59603.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 January 2012, Kukjin Kim wrote:
> Hi Arnd and Olof,
> 
> Please pull Samsung devel-dma for v3.3 from following:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next-samsung-devel-dma
> 
> Its major feature is including merge of pl330 driver into drivers/dma/ and
> got the ack from Vinod Koul and Linus Walleij and some dma development for
> Samsung stuff.
> 
> As a note, since having dependency with Vinod's slave-dma/next (dma tree)
> and next-samsung-dt1 branch which has been sent to you for arm-soc/next/dt,
> that has been provided based on slave-dma/next tree and next-samsung-dt1.
> 
> If any problems, please let me know.

Pulled into a new next/drivers2 branch so I can send the other drivers
early but delay this until the dma-slave branch is merged, if necessary.

There were some conflicts between imx changes that went into the dma-slave
tree and those that went into arm-soc. Sascha, Shawn: can you have a look
to make sure the resolution below is correct?

Thanks,

	Arnd

diff --cc arch/arm/mach-exynos/clock.c
index da50b1a,5185a25..62e260e
--- a/arch/arm/mach-exynos/clock.c
+++ b/arch/arm/mach-exynos/clock.c
@@@ -1322,15 -1308,9 +1330,16 @@@ static struct clk_lookup exynos4_clk_lo
        CLKDEV_INIT("exynos4210-uart.1", "clk_uart_baud0", &clk_sclk_uart1.clk),
        CLKDEV_INIT("exynos4210-uart.2", "clk_uart_baud0", &clk_sclk_uart2.clk),
        CLKDEV_INIT("exynos4210-uart.3", "clk_uart_baud0", &clk_sclk_uart3.clk),
 +      CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
 +      CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
 +      CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
 +      CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
        CLKDEV_INIT("dma-pl330.0", "apb_pclk", &clk_pdma0),
        CLKDEV_INIT("dma-pl330.1", "apb_pclk", &clk_pdma1),
+       CLKDEV_INIT("dma-pl330.2", "apb_pclk", &clk_mdma1),
 +      CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &clk_sclk_spi0.clk),
 +      CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk0", &clk_sclk_spi1.clk),
 +      CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk0", &clk_sclk_spi2.clk),
  };
  
  static int xtal_rate;
diff --cc drivers/dma/mxs-dma.c
index fc903c0,493af2f..b06cd4c
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@@ -578,9 -554,9 +554,9 @@@ static int __init mxs_dma_init(struct m
  {
        int ret;
  
 -      ret = clk_enable(mxs_dma->clk);
 +      ret = clk_prepare_enable(mxs_dma->clk);
        if (ret)
-               goto err_out;
+               return ret;
  
        ret = mxs_reset_block(mxs_dma->base);
        if (ret)
@@@ -604,11 -580,8 +580,8 @@@
        writel(MXS_DMA_CHANNELS_MASK << MXS_DMA_CHANNELS,
                mxs_dma->base + HW_APBHX_CTRL1 + MXS_SET_ADDR);
  
-       clk_disable_unprepare(mxs_dma->clk);
- 
-       return 0;
- 
  err_out:
 -      clk_disable(mxs_dma->clk);
++      clk_disable_unprepare(mxs_dma->clk);
        return ret;
  }
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -124,7 +124,7 @@ config MV_XOR
 
 config MX3_IPU
        bool "MX3x Image Processing Unit support"
-       depends on SOC_IMX31 ||<C2><A0>SOC_IMX35
+       depends on ARCH_MXC
        select DMA_ENGINE
        default y
 	       help
@@ -194,33 +201,32 @@ config PL330_DMA
 config IMX_SDMA
        tristate "i.MX SDMA support"
-       depends on ARCH_MX25 || SOC_IMX31 ||<C2><A0>SOC_IMX35 || ARCH_MX5
+       depends on ARCH_MXC
        select DMA_ENGINE
        help
          Support the i.MX SDMA engine. This engine is integrated into
-         Freescale i.MX25/31/35/51 chips.
+         Freescale i.MX25/31/35/51/53 chips.
 
 config IMX_DMA
        tristate "i.MX DMA support"
