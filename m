From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 04 Jul 2016 17:15:25 +0200
Subject: [PATCH v3 1/2] clk: exynos5433: do not use CLK_IGNORE_UNUSED for
 SPI clocks
In-Reply-To: <20160704102614.GD1257@jack.zhora.eu>
References: <1467270911-10971-1-git-send-email-andi.shyti@samsung.com>
 <1467270911-10971-2-git-send-email-andi.shyti@samsung.com>
 <577A2EFF.2010306@samsung.com> <20160704102614.GD1257@jack.zhora.eu>
Message-ID: <577A7D8D.8070004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2016 12:26 PM, Andi Shyti wrote:
 
> The single clock lines are not configured in the exynos5433 dts,
> but in the drivers/clk/samsung/clk-exynos5433.c file and it's the
> only place where we can set the flags.

I meant we could amend which clocks are specified at the SPI bus device
DT nodes and change handling of clocks in the spi-s3c64xx driver to model
everything properly and get it all working.
 
>> What is an exact problem here, are you perhaps testing suspend to RAM?
>> I tested my sound support patches on top of v4.7-rc1 and everything
>> seemed to work well, I didn't notice any issues with the audio codec
>> which was the only slave on the SPI 1 bus.
> 
> Yes, because the audio codec is on SPI1 and its bus line
> (spi_busclk0) is CLK_SCLK_SPI1_PERIC while the CLK_SCLK_SPI1 is
> set as CLK_IGNORE_UNUSED.

That's true, looking at a downstream kernel I see that there is just plain 
div clock specified for spi_busclk0 (DIVsclk_spi1_b), i.e. SCLK_SPI1_PERIC 
and SCLK_SPI1 don't get disabled in s3c64xx_spi_config().
It seems SCLK_SPI1 in CMU_PERIC need to be kept enabled while accessing 
the SPI controller's registers.

>> Doesn't it help when you specify CLK_SCLK_SPI1 as the second clock
>> ("spi_busclk0") of the spi_1 bus controller instead of
>> CLK_SCLK_SPI0_PERIC? CLK_SCLK_SPI0_PERIC seem to be parent of
>> CLK_SCLK_SPI1 so the enable state would be propagated.
> 
> nope! :(
> 
> For some reasons, if you set in the DTS as spi_busclk0 the
> CLK_SCLK_SPI1 from cmu_peric you get a synchronus abort in the
> s3c64xx_spi_config (the first read performed on the device).

Indeed, I also observed that, after removing CLK_IGNORE_UNUSED from 
the CLK_SCLK_SPI1 clock. 

After discussion with Krzysztof and Andrzej I came up with a patch as below 
where there is no aborts, the sound works and clocks are not kept always 
enabled:

root at localhost:~# cat /sys/kernel/debug/clk/clk_summary | grep spi1
 ioclk_spi1_clk_in                        0            0    50000000          0 0  
    sclk_ioclk_spi1                       0            0    50000000          0 0  
          pclk_isp_spi1                   0            0     6000000          0 0  
    mout_sclk_isp_spi1_user               0            0    24000000          0 0  
       sclk_isp_spi1                      0            0    24000000          0 0  
    mout_sclk_spi1                        0            0    24000000          0 0  
       div_sclk_spi1_a                    0            0     3000000          0 0  
          div_sclk_spi1_b                 0            0     3000000          0 0  
             sclk_spi1_peric              0            0     3000000          0 0  
                sclk_spi1                 0            0     3000000          0 0  
    mout_sclk_isp_spi1                    0            0    24000000          0 0  
       div_sclk_isp_spi1_a                0            0     3000000          0 0  
          div_sclk_isp_spi1_b             0            0       25000          0 0  
             sclk_isp_spi1_cam1           0            0       25000          0 0  
                      pclk_spi1           0            0    66666667          0 0  

I'm not yet 100% sure if it is a correct approach, the downstream kernel uses
"global-per-IP" gate clocks (ENABLE_IP_PERIC? registers), that gate all clocks 
to a given IP block and those clocks are not defined in mainline at all, but 
it seems we just need to amend the SPI controller driver to not be disabling
sdd->src_clk clock before accessing registers. 
Or maybe to pass only DIVsclk_spi?_b as spi_busclk0 in DT nodes and add 
SCLK_SPI0 from CMU_PERIC as a third SPI device clock for exynos5433.

-----------8<------------
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 8e124fc..f444c66 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -617,8 +617,13 @@
                        dma-names = "tx", "rx";
                        #address-cells = <1>;
                        #size-cells = <0>;
+#if 0
                        clocks = <&cmu_peric CLK_PCLK_SPI1>,
                                 <&cmu_top CLK_SCLK_SPI1_PERIC>;
+#else
+                       clocks = <&cmu_peric CLK_PCLK_SPI1>,
+                                <&cmu_peric CLK_SCLK_SPI1>;
+#endif
                        clock-names = "spi", "spi_busclk0";
                        samsung,spi-src-clk = <0>;
                        pinctrl-names = "default";
diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index e3cc935..61d5643 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -1675,7 +1675,7 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
        GATE(CLK_SCLK_SPI2, "sclk_spi2", "sclk_spi2_peric", ENABLE_SCLK_PERIC,
                        5, CLK_SET_RATE_PARENT, 0),
        GATE(CLK_SCLK_SPI1, "sclk_spi1", "sclk_spi1_peric", ENABLE_SCLK_PERIC,
-                       4, CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
+                       4, CLK_SET_RATE_PARENT, 0),
        GATE(CLK_SCLK_SPI0, "sclk_spi0", "sclk_spi0_peric", ENABLE_SCLK_PERIC,
                        3, CLK_SET_RATE_PARENT, 0),
        GATE(CLK_SCLK_UART2, "sclk_uart2", "sclk_uart2_peric",
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 5a76a50..2cb965c 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -578,7 +578,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
        /* Disable Clock */
        if (sdd->port_conf->clk_from_cmu) {
-               clk_disable_unprepare(sdd->src_clk);
+               /* clk_disable_unprepare(sdd->src_clk); */
        } else {
                val = readl(regs + S3C64XX_SPI_CLK_CFG);
                val &= ~S3C64XX_SPI_ENCLK_ENABLE;
@@ -626,7 +626,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
                /* There is half-multiplier before the SPI */
                clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
                /* Enable Clock */
-               clk_prepare_enable(sdd->src_clk);
+               /* clk_prepare_enable(sdd->src_clk); */
        } else {
                /* Configure Clock */
                val = readl(regs + S3C64XX_SPI_CLK_CFG);
-----------8<------------
