From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 06 Jul 2016 12:40:58 +0200
Subject: [PATCH v3 1/2] clk: exynos5433: do not use CLK_IGNORE_UNUSED for
 SPI clocks
In-Reply-To: <20160706045108.GD23620@samsunx.samsung>
References: <1467270911-10971-1-git-send-email-andi.shyti@samsung.com>
 <1467270911-10971-2-git-send-email-andi.shyti@samsung.com>
 <577A2EFF.2010306@samsung.com> <20160704102614.GD1257@jack.zhora.eu>
 <CGME20160704151537epcas1p42a74c53ebb4227da9a30c25e250f0c5a@epcas1p4.samsung.com>
 <577A7D8D.8070004@samsung.com> <20160706045108.GD23620@samsunx.samsung>
Message-ID: <577CE03A.3090603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016 06:51 AM, Andi Shyti wrote:
> 
> I don't see anything wrong on the above. We could make it as:

> @@ -640,13 +639,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>  
>         writel(val, regs + S3C64XX_SPI_MODE_CFG);
>  
> -       if (sdd->port_conf->clk_from_cmu) {
> -               /* Configure Clock */
> -               /* There is half-multiplier before the SPI */
> -               clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
> -               /* Enable Clock */
> -               clk_prepare_enable(sdd->src_clk);

clk_set_rate() call needs to stay, we can only remove clk_prepare_enable().

> -       } else {
> +       if (!sdd->port_conf->clk_from_cmu) {
>                 /* Configure Clock */
>                 val = readl(regs + S3C64XX_SPI_CLK_CFG);
>                 val &= ~S3C64XX_SPI_PSR_MASK;
> 
>> I meant we could amend which clocks are specified at the SPI bus device
>> DT nodes and change handling of clocks in the spi-s3c64xx driver to model
>> everything properly and get it all working.
> 
> I think that if the clock comes from the cmu it's not necessary
> to disable it. I would like to avoid adding DTS properties
> because we have the clock disabling inherited from old code which
> it might not be required at all (in our tests, indeed it works).

OK, anyway we already need to amend exynos5433.dtsi file to change
the "spi_busclk0" clock specifier.

I agree we can get rid of the clock gating in s3c64xx_spi_config() 
function, it should not do any harm and will help in getting rid 
of the bus access exceptions.

In general PCLK should be enough for accessing register of the controller,
one hypothesis is that automatic clock gating may be disabling PCLK
when it sees SCLK inactive.

I tested on exynos4412 trats2 board a large firmware file upload over 
SPI and didn't notice any bad side effects with above 
clk_disable_unprepare()/clk_prepare_enable() calls commented out.
